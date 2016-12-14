Received: from eggs.gnu.org ([2001:4830:134:3::10]:35170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cH7oB-0002Bc-6L
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cH7o9-0003Gu-TU
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:33:15 -0500
Received: from [45.249.212.187] (port=2498 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cH7o8-0003EI-QO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:33:13 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 14 Dec 2016 11:32:12 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA15FB3F@DGGEMA505-MBX.china.huawei.com>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-3-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA15A07C@DGGEMA505-MBX.china.huawei.com>
	<20161212105407.GA3033@gondor.apana.org.au>
	<20161212234941-mutt-send-email-mst@kernel.org>
	<b55a4666-d71a-352c-8be3-286eef6c5bc0@linux.vnet.ibm.com>
In-Reply-To: <b55a4666-d71a-352c-8be3-286eef6c5bc0@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 2/2] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "davem@davemloft.net" <davem@davemloft.net>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>Cornelia Huck <cornelia.huck@de.ibm.com>

Hi,

>
> Subject: Re: [PATCH v6 2/2] crypto: add virtio-crypto driver
>=20
>=20
>=20
> On 12/12/2016 11:05 PM, Michael S. Tsirkin wrote:
> > On Mon, Dec 12, 2016 at 06:54:07PM +0800, Herbert Xu wrote:
> >> On Mon, Dec 12, 2016 at 06:25:12AM +0000, Gonglei (Arei) wrote:
> >>> Hi, Michael & Herbert
> >>>
> >>> Because the virtio-crypto device emulation had been in QEMU 2.8,
> >>> would you please merge the virtio-crypto driver for 4.10 if no other
> >>> comments? If so, Miachel pls ack and/or review the patch, then
> >>> Herbert will take it (I asked him last week). Thank you!
> >>>
> >>> Ps: Note on 4.10 merge window timing from Linus
> >>>  https://lkml.org/lkml/2016/12/7/506
> >>>
> >>> Dec 23rd is the deadline for 4.10 merge window.
> >>
> >> Sorry but it's too late for 4.10.  It needed to have been in my
> >> tree before the merge window opened to make it for this cycle.
> >>
> >> Cheers,
> >
> >
> > Objections to me merging this? I'm preparing my tree right now.
>=20
> Got this when testing the most recent version on s390x
>=20
> [   20.391074] test 0 (128 bit key, 16 byte blocks): [   20.391078] BUG: =
using
> smp_processor_id() in preemptible [00000000] code: insmod/97
> [   20.391082] caller is virtio_crypto_ablkcipher_setkey+0x44/0x198
> [   20.391085] CPU: 0 PID: 97 Comm: insmod Not tainted
> 4.9.0-02683-gb62a1ab #46
> [   20.391088] Hardware name: IBM              2964 NC9
> 704              (KVM)
> [   20.391405] Stack:
> [   20.391407]        000000000c0eb6d0 000000000c0eb760
> 0000000000000003 0000000000000000
> [   20.391414]        000000000c0eb800 000000000c0eb778
> 000000000c0eb778 0000000000000020
> [   20.391420]        0000000000000000 000000000000000a
> 0000000000000020 000003ff0000000a
> [   20.391426]        000003ff0000000c 000000000c0eb7c8
> 0000000000000000 0000000000000000
> [   20.391432]        0700000000c173c8 00000000001126ba
> 000000000c0eb760 000000000c0eb7b8
> [   20.391439] Call Trace:
> [   20.391442] ([<000000000011259e>] show_trace+0x8e/0xe0)
> [   20.391446]  [<0000000000112670>] show_stack+0x80/0xd8
> [   20.391449]  [<0000000000753ab6>] dump_stack+0x96/0xd8
> [   20.391453]  [<00000000007872e6>]
> check_preemption_disabled+0xfe/0x128
> [   20.391456]  [<0000000000839cc4>]
> virtio_crypto_ablkcipher_setkey+0x44/0x198
> [   20.391459]  [<0000000000705a40>]
> skcipher_setkey_ablkcipher+0x50/0x70
> [   20.391476]  [<000003ff80002a48>] test_skcipher_speed+0x328/0xb98
> [tcrypt]
> [   20.391492]  [<000003ff800063dc>] do_test+0x1c24/0x28e0 [tcrypt]
> [   20.391509]  [<000003ff8001006a>] tcrypt_mod_init+0x6a/0x1000
> [tcrypt]
> [   20.391512]  [<00000000001002cc>] do_one_initcall+0xb4/0x148
> [   20.391515]  [<0000000000298632>] do_init_module+0x7a/0x228
> [   20.391519]  [<00000000001fd380>] load_module+0x2428/0x2de0
> [   20.391522]  [<00000000001fde8a>] SyS_init_module+0x152/0x160
> [   20.391526]  [<00000000009f1306>] system_call+0xd6/0x270
> [   20.391528] no locks held by insmod/97.
>=20
> Gonglei, any idea? Did not look into it myself yet.
>=20
Thanks for report. You must open CONFIG_DEBUG_PREEMPT,
but I didn't do that before. I open some kernel hacking debug switches to t=
est it as well today,
and the following patch can fix it.

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/=
virtio/virtio_crypto_common.h
index 975404b..518dc7ad 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -113,7 +113,13 @@ struct virtio_crypto_request {

 static inline int virtio_crypto_get_current_node(void)
 {
-   return topology_physical_package_id(smp_processor_id());
+   int cpu, node;
+
+   cpu =3D get_cpu();
+   node =3D topology_physical_package_id(cpu);
+   put_cpu();
+
+   return node;
 }

Meanwhile I find aother problem, will fix it in the following V7.

Regards,
-Gonglei
