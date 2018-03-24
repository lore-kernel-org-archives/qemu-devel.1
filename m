Received: from eggs.gnu.org ([2001:4830:134:3::10]:35200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ezX13-00060N-LE
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 20:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ezX10-0003A3-Hr
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 20:26:37 -0400
Date: Sat, 24 Mar 2018 11:24:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180324002429.GV3905@umbus.fritz.box>
References: <20180323143202.28879-1-lvivier@redhat.com>
	<20180323143202.28879-6-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qa1NXTiqN6KSzHv0"
Content-Disposition: inline
In-Reply-To: <20180323143202.28879-6-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Remove unnecessary variables for
 function return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>


--qa1NXTiqN6KSzHv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 03:32:02PM +0100, Laurent Vivier wrote:
> Re-run Coccinelle script scripts/coccinelle/return_directly.cocci
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

ppc part
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  accel/tcg/translate-all.c                          |  5 +-
>  block/quorum.c                                     |  6 +--
>  hw/arm/exynos4210.c                                |  6 +--
>  hw/block/vhost-user-blk.c                          |  5 +-
>  hw/hppa/dino.c                                     |  5 +-
>  hw/misc/mos6522.c                                  |  8 +---
>  hw/net/ftgmac100.c                                 |  5 +-
>  hw/ppc/pnv_lpc.c                                   | 16 ++-----
>  io/net-listener.c                                  |  6 +--
>  target/i386/hax-darwin.c                           | 10 ++--
>  target/mips/dsp_helper.c                           | 15 ++----
>  target/xtensa/core-dc232b/xtensa-modules.c         | 56 ++++++----------=
------
>  target/xtensa/core-dc233c/xtensa-modules.c         | 56 ++++++----------=
------
>  target/xtensa/core-de212/xtensa-modules.c          | 48 +++++-----------=
---
>  target/xtensa/core-fsf/xtensa-modules.c            | 32 ++++---------
>  .../xtensa/core-sample_controller/xtensa-modules.c | 24 +++-------
>  target/xtensa/translate.c                          |  7 +--
>  tests/m48t59-test.c                                |  6 +--
>  tests/test-thread-pool.c                           |  6 +--
>  util/uri.c                                         |  5 +-
>  20 files changed, 79 insertions(+), 248 deletions(-)
>=20
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5ad1b919bc..55d822d410 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -644,11 +644,8 @@ static inline void *alloc_code_gen_buffer(void)
>  static inline void *alloc_code_gen_buffer(void)
>  {
>      size_t size =3D tcg_ctx->code_gen_buffer_size;
> -    void *buf;
> -
> -    buf =3D VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
> +    return VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
>                          PAGE_EXECUTE_READWRITE);
> -    return buf;
>  }
>  #else
>  static inline void *alloc_code_gen_buffer(void)
> diff --git a/block/quorum.c b/block/quorum.c
> index 14333c18aa..304442ef65 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -608,7 +608,7 @@ static void read_quorum_children_entry(void *opaque)
>  static int read_quorum_children(QuorumAIOCB *acb)
>  {
>      BDRVQuorumState *s =3D acb->bs->opaque;
> -    int i, ret;
> +    int i;
> =20
>      acb->children_read =3D s->num_children;
>      for (i =3D 0; i < s->num_children; i++) {
> @@ -643,9 +643,7 @@ static int read_quorum_children(QuorumAIOCB *acb)
>          qemu_coroutine_yield();
>      }
> =20
> -    ret =3D acb->vote_ret;
> -
> -    return ret;
> +    return acb->vote_ret;
>  }
> =20
>  static int read_fifo_child(QuorumAIOCB *acb)
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 06f9d1ffa4..b7463a71ec 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -156,12 +156,8 @@ void exynos4210_write_secondary(ARMCPU *cpu,
> =20
>  static uint64_t exynos4210_calc_affinity(int cpu)
>  {
> -    uint64_t mp_affinity;
> -
>      /* Exynos4210 has 0x9 as cluster ID */
> -    mp_affinity =3D (0x9 << ARM_AFF1_SHIFT) | cpu;
> -
> -    return mp_affinity;
> +    return (0x9 << ARM_AFF1_SHIFT) | cpu;
>  }
> =20
>  Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index f840f07dfe..3f41ca9e26 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -196,7 +196,6 @@ static uint64_t vhost_user_blk_get_features(VirtIODev=
ice *vdev,
>                                              Error **errp)
>  {
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> -    uint64_t get_features;
> =20
>      /* Turn on pre-defined features */
>      virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
> @@ -215,9 +214,7 @@ static uint64_t vhost_user_blk_get_features(VirtIODev=
ice *vdev,
>          virtio_add_feature(&features, VIRTIO_BLK_F_MQ);
>      }
> =20
> -    get_features =3D vhost_get_features(&s->dev, user_feature_bits, feat=
ures);
> -
> -    return get_features;
> +    return vhost_get_features(&s->dev, user_feature_bits, features);
>  }
> =20
>  static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *=
vq)
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index 15aefde09c..c5dcf3104d 100644
> --- a/hw/hppa/dino.c
> +++ b/hw/hppa/dino.c
> @@ -403,13 +403,10 @@ static void dino_set_irq(void *opaque, int irq, int=
 level)
>  static int dino_pci_map_irq(PCIDevice *d, int irq_num)
>  {
>      int slot =3D d->devfn >> 3;
> -    int local_irq;
> =20
>      assert(irq_num >=3D 0 && irq_num <=3D 3);
> =20
> -    local_irq =3D slot & 0x03;
> -
> -    return local_irq;
> +    return slot & 0x03;
>  }
> =20
>  static void dino_set_timer_irq(void *opaque, int irq, int level)
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index 8ad9fc831e..6163cea6ab 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -176,12 +176,8 @@ static void mos6522_set_sr_int(MOS6522State *s)
> =20
>  static uint64_t mos6522_get_counter_value(MOS6522State *s, MOS6522Timer =
*ti)
>  {
> -    uint64_t d;
> -
> -    d =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
> -                 ti->frequency, NANOSECONDS_PER_SECOND);
> -
> -    return d;
> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_tim=
e,
> +                    ti->frequency, NANOSECONDS_PER_SECOND);
>  }
> =20
>  static uint64_t mos6522_get_load_time(MOS6522State *s, MOS6522Timer *ti)
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 704f452067..3300e8ef4a 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -511,7 +511,6 @@ static uint32_t ftgmac100_rxpoll(FTGMAC100State *s)
> =20
>      uint32_t cnt =3D 1024 * FTGMAC100_APTC_RXPOLL_CNT(s->aptcr);
>      uint32_t speed =3D (s->maccr & FTGMAC100_MACCR_FAST_MODE) ? 1 : 0;
> -    uint32_t period;
> =20
>      if (s->aptcr & FTGMAC100_APTC_RXPOLL_TIME_SEL) {
>          cnt <<=3D 4;
> @@ -521,9 +520,7 @@ static uint32_t ftgmac100_rxpoll(FTGMAC100State *s)
>          speed =3D 2;
>      }
> =20
> -    period =3D cnt / div[speed];
> -
> -    return period;
> +    return cnt / div[speed];
>  }
> =20
>  static void ftgmac100_reset(DeviceState *d)
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index c42b4a8f6c..2317d1e62c 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -125,25 +125,17 @@ static int pnv_lpc_dt_xscom(PnvXScomInterface *dev,=
 void *fdt, int xscom_offset)
>  static bool opb_read(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
>                       int sz)
>  {
> -    bool success;
> -
>      /* XXX Handle access size limits and FW read caching here */
> -    success =3D !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECI=
FIED,
> -                                data, sz, false);
> -
> -    return success;
> +    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
> +                             data, sz, false);
>  }
> =20
>  static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *dat=
a,
>                        int sz)
>  {
> -    bool success;
> -
>      /* XXX Handle access size limits here */
> -    success =3D !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECI=
FIED,
> -                                data, sz, true);
> -
> -    return success;
> +    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
> +                             data, sz, true);
>  }
> =20
>  #define ECCB_CTL_READ           PPC_BIT(15)
> diff --git a/io/net-listener.c b/io/net-listener.c
> index 555e8acaa4..3317aa6e5f 100644
> --- a/io/net-listener.c
> +++ b/io/net-listener.c
> @@ -25,11 +25,7 @@
> =20
>  QIONetListener *qio_net_listener_new(void)
>  {
> -    QIONetListener *ret;
> -
> -    ret =3D QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
> -
> -    return ret;
> +    return QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
>  }
> =20
>  void qio_net_listener_set_name(QIONetListener *listener,
> diff --git a/target/i386/hax-darwin.c b/target/i386/hax-darwin.c
> index acdde476a0..a5426a6dac 100644
> --- a/target/i386/hax-darwin.c
> +++ b/target/i386/hax-darwin.c
> @@ -257,10 +257,7 @@ int hax_host_setup_vcpu_channel(struct hax_vcpu_stat=
e *vcpu)
> =20
>  int hax_vcpu_run(struct hax_vcpu_state *vcpu)
>  {
> -    int ret;
> -
> -    ret =3D ioctl(vcpu->fd, HAX_VCPU_IOCTL_RUN, NULL);
> -    return ret;
> +    return ioctl(vcpu->fd, HAX_VCPU_IOCTL_RUN, NULL);
>  }
> =20
>  int hax_sync_fpu(CPUArchState *env, struct fx_layout *fl, int set)
> @@ -315,13 +312,12 @@ int hax_sync_vcpu_state(CPUArchState *env, struct v=
cpu_state_t *state, int set)
> =20
>  int hax_inject_interrupt(CPUArchState *env, int vector)
>  {
> -    int ret, fd;
> +    int fd;
> =20
>      fd =3D hax_vcpu_get_fd(env);
>      if (fd <=3D 0) {
>          return -1;
>      }
> =20
> -    ret =3D ioctl(fd, HAX_VCPU_IOCTL_INTERRUPT, &vector);
> -    return ret;
> +    return ioctl(fd, HAX_VCPU_IOCTL_INTERRUPT, &vector);
>  }
> diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
> index f152fea34a..739b69dd45 100644
> --- a/target/mips/dsp_helper.c
> +++ b/target/mips/dsp_helper.c
> @@ -3274,14 +3274,11 @@ target_ulong helper_dextr_l(target_ulong ac, targ=
et_ulong shift,
>                              CPUMIPSState *env)
>  {
>      uint64_t temp[3];
> -    target_ulong result;
> =20
>      shift =3D shift & 0x3F;
> =20
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> -    result =3D (temp[1] << 63) | (temp[0] >> 1);
> -
> -    return result;
> +    return (temp[1] << 63) | (temp[0] >> 1);
>  }
> =20
>  target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
> @@ -3289,7 +3286,6 @@ target_ulong helper_dextr_r_l(target_ulong ac, targ=
et_ulong shift,
>  {
>      uint64_t temp[3];
>      uint32_t temp128;
> -    target_ulong result;
> =20
>      shift =3D shift & 0x3F;
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> @@ -3309,9 +3305,7 @@ target_ulong helper_dextr_r_l(target_ulong ac, targ=
et_ulong shift,
>          set_DSPControl_overflow_flag(1, 23, env);
>      }
> =20
> -    result =3D (temp[1] << 63) | (temp[0] >> 1);
> -
> -    return result;
> +    return (temp[1] << 63) | (temp[0] >> 1);
>  }
> =20
>  target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
> @@ -3319,7 +3313,6 @@ target_ulong helper_dextr_rs_l(target_ulong ac, tar=
get_ulong shift,
>  {
>      uint64_t temp[3];
>      uint32_t temp128;
> -    target_ulong result;
> =20
>      shift =3D shift & 0x3F;
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> @@ -3345,9 +3338,7 @@ target_ulong helper_dextr_rs_l(target_ulong ac, tar=
get_ulong shift,
>          }
>          set_DSPControl_overflow_flag(1, 23, env);
>      }
> -    result =3D (temp[1] << 63) | (temp[0] >> 1);
> -
> -    return result;
> +    return (temp[1] << 63) | (temp[0] >> 1);
>  }
>  #endif
> =20
> diff --git a/target/xtensa/core-dc232b/xtensa-modules.c b/target/xtensa/c=
ore-dc232b/xtensa-modules.c
> index d322c3f52a..164df3b1a4 100644
> --- a/target/xtensa/core-dc232b/xtensa-modules.c
> +++ b/target/xtensa/core-dc232b/xtensa-modules.c
> @@ -1736,9 +1736,7 @@ Operand_arr_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_arr_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1750,9 +1748,7 @@ Operand_ars_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ars_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1764,9 +1760,7 @@ Operand_art_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_art_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1778,9 +1772,7 @@ Operand_ar0_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar0_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -1792,9 +1784,7 @@ Operand_ar4_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar4_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -1806,9 +1796,7 @@ Operand_ar8_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar8_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -1820,9 +1808,7 @@ Operand_ar12_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar12_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -1834,9 +1820,7 @@ Operand_ars_entry_decode (uint32 *valp ATTRIBUTE_UN=
USED)
>  static int
>  Operand_ars_entry_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -2406,9 +2390,7 @@ Operand_mx_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mx_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2436,9 +2418,7 @@ Operand_mw_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mw_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2450,9 +2430,7 @@ Operand_mr0_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mr0_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2464,9 +2442,7 @@ Operand_mr1_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mr1_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2478,9 +2454,7 @@ Operand_mr2_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mr2_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2492,9 +2466,7 @@ Operand_mr3_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mr3_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> diff --git a/target/xtensa/core-dc233c/xtensa-modules.c b/target/xtensa/c=
ore-dc233c/xtensa-modules.c
> index 7c20f82349..0f32f0804a 100644
> --- a/target/xtensa/core-dc233c/xtensa-modules.c
> +++ b/target/xtensa/core-dc233c/xtensa-modules.c
> @@ -1817,9 +1817,7 @@ Operand_arr_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_arr_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1831,9 +1829,7 @@ Operand_ars_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ars_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1845,9 +1841,7 @@ Operand_art_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_art_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1859,9 +1853,7 @@ Operand_ar0_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar0_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -1873,9 +1865,7 @@ Operand_ar4_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar4_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -1887,9 +1877,7 @@ Operand_ar8_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar8_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -1901,9 +1889,7 @@ Operand_ar12_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar12_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -1915,9 +1901,7 @@ Operand_ars_entry_decode (uint32 *valp ATTRIBUTE_UN=
USED)
>  static int
>  Operand_ars_entry_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x1f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x1f) !=3D 0;
>  }
> =20
>  static int
> @@ -2487,9 +2471,7 @@ Operand_mx_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mx_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2517,9 +2499,7 @@ Operand_mw_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mw_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2531,9 +2511,7 @@ Operand_mr0_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mr0_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2545,9 +2523,7 @@ Operand_mr1_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mr1_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2559,9 +2535,7 @@ Operand_mr2_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mr2_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> @@ -2573,9 +2547,7 @@ Operand_mr3_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_mr3_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3) !=3D 0;
>  }
> =20
>  static int
> diff --git a/target/xtensa/core-de212/xtensa-modules.c b/target/xtensa/co=
re-de212/xtensa-modules.c
> index ef7674de3a..480c68d3c6 100644
> --- a/target/xtensa/core-de212/xtensa-modules.c
> +++ b/target/xtensa/core-de212/xtensa-modules.c
> @@ -1798,9 +1798,7 @@ OperandSem_opnd_sem_AR_decode (uint32 *valp ATTRIBU=
TE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1812,9 +1810,7 @@ OperandSem_opnd_sem_AR_0_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_0_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1826,9 +1822,7 @@ OperandSem_opnd_sem_AR_1_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_1_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1840,9 +1834,7 @@ OperandSem_opnd_sem_AR_2_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_2_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1854,9 +1846,7 @@ OperandSem_opnd_sem_AR_3_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_3_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1868,9 +1858,7 @@ OperandSem_opnd_sem_AR_4_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_4_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -2464,9 +2452,7 @@ OperandSem_opnd_sem_MR_decode (uint32 *valp ATTRIBU=
TE_UNUSED)
>  static int
>  OperandSem_opnd_sem_MR_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 4);
> -  return error;
> +  return (*valp >=3D 4);
>  }
> =20
>  static int
> @@ -2478,9 +2464,7 @@ OperandSem_opnd_sem_MR_1_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_MR_1_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 4);
> -  return error;
> +  return (*valp >=3D 4);
>  }
> =20
>  static int
> @@ -2492,9 +2476,7 @@ OperandSem_opnd_sem_MR_2_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_MR_2_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 4);
> -  return error;
> +  return (*valp >=3D 4);
>  }
> =20
>  static int
> @@ -2506,9 +2488,7 @@ OperandSem_opnd_sem_MR_3_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_MR_3_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 4);
> -  return error;
> +  return (*valp >=3D 4);
>  }
> =20
>  static int
> @@ -2520,9 +2500,7 @@ OperandSem_opnd_sem_MR_4_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_MR_4_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 4);
> -  return error;
> +  return (*valp >=3D 4);
>  }
> =20
>  static int
> @@ -2534,9 +2512,7 @@ OperandSem_opnd_sem_MR_5_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_MR_5_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 4);
> -  return error;
> +  return (*valp >=3D 4);
>  }
> =20
>  static int
> diff --git a/target/xtensa/core-fsf/xtensa-modules.c b/target/xtensa/core=
-fsf/xtensa-modules.c
> index f7de2dec15..c32683ff77 100644
> --- a/target/xtensa/core-fsf/xtensa-modules.c
> +++ b/target/xtensa/core-fsf/xtensa-modules.c
> @@ -1379,9 +1379,7 @@ Operand_arr_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_arr_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1393,9 +1391,7 @@ Operand_ars_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ars_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1407,9 +1403,7 @@ Operand_art_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_art_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0xf) !=3D 0;
> -  return error;
> +  return (*valp & ~0xf) !=3D 0;
>  }
> =20
>  static int
> @@ -1421,9 +1415,7 @@ Operand_ar0_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar0_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3f) !=3D 0;
>  }
> =20
>  static int
> @@ -1435,9 +1427,7 @@ Operand_ar4_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar4_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3f) !=3D 0;
>  }
> =20
>  static int
> @@ -1449,9 +1439,7 @@ Operand_ar8_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar8_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3f) !=3D 0;
>  }
> =20
>  static int
> @@ -1463,9 +1451,7 @@ Operand_ar12_decode (uint32 *valp ATTRIBUTE_UNUSED)
>  static int
>  Operand_ar12_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3f) !=3D 0;
>  }
> =20
>  static int
> @@ -1477,9 +1463,7 @@ Operand_ars_entry_decode (uint32 *valp ATTRIBUTE_UN=
USED)
>  static int
>  Operand_ars_entry_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp & ~0x3f) !=3D 0;
> -  return error;
> +  return (*valp & ~0x3f) !=3D 0;
>  }
> =20
>  static int
> diff --git a/target/xtensa/core-sample_controller/xtensa-modules.c b/targ=
et/xtensa/core-sample_controller/xtensa-modules.c
> index fba41b99ae..7e87d216bd 100644
> --- a/target/xtensa/core-sample_controller/xtensa-modules.c
> +++ b/target/xtensa/core-sample_controller/xtensa-modules.c
> @@ -1570,9 +1570,7 @@ OperandSem_opnd_sem_AR_decode (uint32 *valp ATTRIBU=
TE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1584,9 +1582,7 @@ OperandSem_opnd_sem_AR_0_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_0_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1598,9 +1594,7 @@ OperandSem_opnd_sem_AR_1_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_1_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1612,9 +1606,7 @@ OperandSem_opnd_sem_AR_2_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_2_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1626,9 +1618,7 @@ OperandSem_opnd_sem_AR_3_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_3_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> @@ -1640,9 +1630,7 @@ OperandSem_opnd_sem_AR_4_decode (uint32 *valp ATTRI=
BUTE_UNUSED)
>  static int
>  OperandSem_opnd_sem_AR_4_encode (uint32 *valp)
>  {
> -  int error;
> -  error =3D (*valp >=3D 32);
> -  return error;
> +  return (*valp >=3D 32);
>  }
> =20
>  static int
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 4f6d03059f..fd1223e81a 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -1272,11 +1272,8 @@ XtensaOpcodeOps *
>  xtensa_find_opcode_ops(const XtensaOpcodeTranslators *t,
>                         const char *name)
>  {
> -    XtensaOpcodeOps *ops;
> -
> -    ops =3D bsearch(name, t->opcode, t->num_opcodes,
> -                  sizeof(XtensaOpcodeOps), compare_opcode_ops);
> -    return ops;
> +    return bsearch(name, t->opcode, t->num_opcodes,
> +                   sizeof(XtensaOpcodeOps), compare_opcode_ops);
>  }
> =20
>  static void translate_abs(DisasContext *dc, const uint32_t arg[],
> diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
> index 26af7d6e8e..5b695971c7 100644
> --- a/tests/m48t59-test.c
> +++ b/tests/m48t59-test.c
> @@ -256,8 +256,6 @@ static void base_setup(void)
> =20
>  int main(int argc, char **argv)
>  {
> -    int ret;
> -
>      base_setup();
> =20
>      g_test_init(&argc, &argv, NULL);
> @@ -267,7 +265,5 @@ int main(int argc, char **argv)
>          qtest_add_func("/rtc/bcd-check-time", bcd_check_time);
>      }
>      qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
> -    ret =3D g_test_run();
> -
> -    return ret;
> +    return g_test_run();
>  }
> diff --git a/tests/test-thread-pool.c b/tests/test-thread-pool.c
> index 91b4ec5524..9cdccb3a47 100644
> --- a/tests/test-thread-pool.c
> +++ b/tests/test-thread-pool.c
> @@ -224,8 +224,6 @@ static void test_cancel_async(void)
> =20
>  int main(int argc, char **argv)
>  {
> -    int ret;
> -
>      qemu_init_main_loop(&error_abort);
>      ctx =3D qemu_get_current_aio_context();
>      pool =3D aio_get_thread_pool(ctx);
> @@ -238,7 +236,5 @@ int main(int argc, char **argv)
>      g_test_add_func("/thread-pool/cancel", test_cancel);
>      g_test_add_func("/thread-pool/cancel-async", test_cancel_async);
> =20
> -    ret =3D g_test_run();
> -
> -    return ret;
> +    return g_test_run();
>  }
> diff --git a/util/uri.c b/util/uri.c
> index 93ecefdaaf..8624a7ac23 100644
> --- a/util/uri.c
> +++ b/util/uri.c
> @@ -1065,10 +1065,7 @@ URI *uri_parse_raw(const char *str, int raw)
>   */
>  URI *uri_new(void)
>  {
> -    URI *ret;
> -
> -    ret =3D g_new0(URI, 1);
> -    return ret;
> +    return g_new0(URI, 1);
>  }
> =20
>  /**

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qa1NXTiqN6KSzHv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq1mroACgkQbDjKyiDZ
s5JJkxAAiG6Ip0SDY3CZpKLTjLVewcKp8l80jRs4nnPQop57Ubq7q5xgasER8LJw
BHkOGZSq/SaR+92V6b6X6c1RGjwf+Yke7pwnu15mgOZmd0xzbNL7J8DiTR3W7RWS
MoLwD8SENps+0muDWOi0bBNQx18x8iZSfBxFNT+45E5a3mwdpRaGKjtjSpj8VjdB
+4vA/DE0Dp5wlFF3wQwk1DKUbYtKvm7lAJMs7/FIX02xhpSAqglU7EoTP9t2Yjuu
lZYF9X2dV5JraK8iGS5nBObneWvphcomguPUg6CdQlUm6TsnpGk0+G/CP6j5GrZS
Y0jjqSwlhFsS1uGsJ6IoGrIX2UDOtUH+8ujjN/R2BE8QYtj1n34mXypXXede+YSB
4KUxX27LmMZ3aDz/6Ln5iJW3obPVHaCg2P2KX9a+hxk/l+UmB8dN3r5wRSz/pRBX
StyjV6+7LkT6cl6fDmguOjxerhkKQmxtw3WsvJLIRRyVSrCmmnwsjEC3+qWRB9q8
xTxKcOP8WXPL3bGgLy7GKwbbKSbU8cnXZwYokD8VH+Dpu8dsp8WyFaq8Wl/dyOr5
/OuLwpgeaPzIZN0l8TwWBCZEIivWqIAAImRj9FUstSgCPjmN3l0duOYpnF9USQ/t
j5/DJvP92jtwj18kERY/zyD3SgTY6GybUEHLwWXgIHBFOZ+erXI=
=lqh7
-----END PGP SIGNATURE-----

--qa1NXTiqN6KSzHv0--
