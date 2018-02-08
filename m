Received: from eggs.gnu.org ([2001:4830:134:3::10]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ejqh3-0006h8-FZ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ejqh2-0008In-J7
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:13:09 -0500
References: <1518096522-31141-1-git-send-email-sarna@skytechnology.pl>
From: John Snow <jsnow@redhat.com>
Message-ID: <99697561-fc58-fd4c-998a-6f0233783554@redhat.com>
Date: Thu, 8 Feb 2018 13:12:49 -0500
MIME-Version: 1.0
In-Reply-To: <1518096522-31141-1-git-send-email-sarna@skytechnology.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: unify blocksize types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Piotr Sarna <sarna@skytechnology.pl>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, Qemu-block <qemu-block@nongnu.org>

CC qemu-block

On 02/08/2018 08:28 AM, Piotr Sarna wrote:
> BlockSizes structure used in block size probing has uint32_t types
> for logical and physical sizes. These fields are wrongfully assigned
> to uint16_t in BlockConf, which results, among other errors,
> in assigning 0 instead of 65536 (which will be the case in at least
> future LizardFS block device driver among other things).
>=20
> This commit makes BlockConf's physical_block_size and logical_block_siz=
e
> fields uint32_t to avoid inconsistencies.
>=20
> Signed-off-by: Piotr Sarna <sarna@skytechnology.pl>
> ---
>  include/hw/block/block.h     | 4 ++--
>  include/hw/qdev-properties.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index 64b9298..c9e6e27 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -17,8 +17,8 @@
> =20
>  typedef struct BlockConf {
>      BlockBackend *blk;
> -    uint16_t physical_block_size;
> -    uint16_t logical_block_size;
> +    uint32_t physical_block_size;
> +    uint32_t logical_block_size;
>      uint16_t min_io_size;
>      uint32_t opt_io_size;
>      int32_t bootindex;
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.=
h
> index 1d61a35..c68d7bf 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -210,7 +210,7 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar=
;
>  #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
>  #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
>  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceA=
ddress)
>  #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
>=20

--=20
=E2=80=94js
