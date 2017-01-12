Received: from eggs.gnu.org ([2001:4830:134:3::10]:57895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRdYn-0002aH-IR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRdYk-000848-0O
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:28:49 -0500
Received: from [45.249.212.188] (port=2445 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRdYh-0007p2-Hl
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:28:45 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 12 Jan 2017 11:27:49 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA18DDF2@DGGEMA505-MBX.china.huawei.com>
References: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v15 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, Claudio Fontana <Claudio.Fontana@huawei.com>, "Zhoujian
	(jay, Euler)" <jianjay.zhou@huawei.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>

Ping...

Any Comments?

Thanks,
-Gonglei

> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Wednesday, January 04, 2017 6:03 PM
> To: qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org
> Cc: Luonengjun; mst@redhat.com; cornelia.huck@de.ibm.com;
> stefanha@redhat.com; denglingli@chinamobile.com; Jani Kokkonen;
> Ola.Liljedahl@arm.com; Varun.Sethi@freescale.com; xin.zeng@intel.com;
> brian.a.keating@intel.com; liang.j.ma@intel.com; john.griffin@intel.com;
> Huangweidong (C); mike.caraman@nxp.com; agraf@suse.de; Claudio Fontana;
> Zhoujian (jay, Euler); nmorey@kalray.eu; vincent.jardin@6wind.com; Wubin =
(H);
> Shiqing Fan; arei.gonglei@hotmail.com; pasic@linux.vnet.ibm.com; Gonglei
> (Arei)
> Subject: [PATCH v15 0/2] virtio-crypto: virtio crypto device specificatio=
n
>=20
> Changes since v14:
>  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
>  - correct a sentence about dataqueue and controlq in the first paragraph=
.
> [Halil]
>  - change a MAY to MUST about max_dataqueues. [Halil]
>  - add non-session mode support
>    1) add four features for different crypto services to identify wheathe=
r
> support session mode.
>    2) extend virtio_crypto_*_para structures, for example, add the conten=
t of
>      struct virtio_crypto_cipher_session_para into struct
> virtio_crypto_cipher_para.
>    3) use the flag property of struct virtio_crypto_op_header to identify=
 the
>      type of crypto request. Aka Is it a session-based or non-session req=
uest
>=20
> For pervious versions of virtio crypto spec, Pls see:
>=20
> [v14]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html
>=20
> [v13]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html
>=20
> For more information, please see:
>  http://qemu-project.org/Features/VirtioCrypto
>=20
> Please help to review, thanks.
>=20
> Gonglei (2):
>   virtio-crypto: Add virtio crypto device specification
>   virtio-crypto: Add conformance clauses
>=20
>  conformance.tex   |   30 ++
>  content.tex       |    2 +
>  virtio-crypto.tex | 1029
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1061 insertions(+)
>  create mode 100644 virtio-crypto.tex
>=20
> --
> 1.7.12.4
>=20
