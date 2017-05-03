Received: from eggs.gnu.org ([2001:4830:134:3::10]:53912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d5nnt-0006lY-Ba
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d5nnq-0008U2-7i
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:30:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d5nnp-0008SW-Bb
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:30:22 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 3 May 2017 06:29:41 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA261766@DGGEMA505-MBX.china.huawei.com>
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<2cd31ba0-96fc-7ef5-8db5-c656d7819523@linux.vnet.ibm.com>
In-Reply-To: <2cd31ba0-96fc-7ef5-8db5-c656d7819523@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v18 0/2] virtio-crypto: virtio
 crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, Linqiangmin <linqiangmin@huawei.com>, Zhbzg <zhbzg@huawei.com>, "Chenshanxi (Eety Chen,
	Euler)" <eety.chen@huawei.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>

Hi Halil,

Nice to see your feedback again :)


> -----Original Message-----
> From: Halil Pasic [mailto:pasic@linux.vnet.ibm.com]
> Sent: Wednesday, May 03, 2017 5:55 AM
> Subject: Re: [virtio-dev] [PATCH v18 0/2] virtio-crypto: virtio crypto de=
vice
> specification
>=20
>=20
> Hi Gonglei!
>=20
> I've started reviewing but it's going to take some time because
> I've missed the previous version (vacation) and v16 was a long
> time ago, so I have to re-check and re-learn things.
>=20
Yeah, it's a hard job.

> My first impression is, it reads much better that v16 but still
> has some space for improvement.
>=20
> One idea would be adding some references defining the
> crypto services and algorithms. IMHO it would make the
> spec a bit rounder, although from pragmatical perspective
> I think we can safely assume, that the target audience is able
> to figure out the stuff without.
>=20
I'm afraid there are too many references then because each algorithm
may have a rfc spec document.


Thanks,
-Gonglei


> Cheers,
> Halil
>=20
>=20
> On 04/22/2017 08:23 AM, Gonglei wrote:
> > As a non-native English speaker, I sincerely hope you
> > give me more suggestions about English style and/or
> > grammar for the spec. Thanks!
> >
> >
> > v18 -> v17:
> >  - fix many English grammar problems suggested by Stefan, Thanks a lot!
> >
> > v17 -> v16:
> >  - Some grammar fixes [Stefan, Halil, Michael]
> >  - add a section named "Supported crypto services" in order to explain =
bit
> >    numbers and valuse clearly. [Halil, Cornelia]
> >  - avoid word reptition [Halil]
> >  - rename non-session mode to stateless mode [Halil]
> >  - change descriptions for all elements in struct virtio_crypto_config =
[Halil]
> >  - add Halil as a reviewer in the ackonwledgement part, thanks for his =
work.
> >  - other fixes here and there.
> >
> > Changes since v15:
> >  - use feature bits for non-session mode in order to keep compatibility=
 with
> >    pre-existing code. [Halil & Michael]
> >  - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control
> all other
> >    non-session mode feature bits.
> >  - fix some typos. [Stefan]
> >  - introduce struct virtio_crypto_op_data_req_mux to support both sessi=
on
> >    and non-session based crypto operations and keep compatibility with
> >    pre-existing code.
> >
> > Changes since v14:
> >  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
> >  - correct a sentence about dataqueue and controlq in the first paragra=
ph.
> [Halil]
> >  - change a MAY to MUST about max_dataqueues. [Halil]
> >  - add non-session mode support
> >    a) add four features for different crypto services to identify wheat=
her
> support session mode.
> >    b) rewrite some
> >
> > For pervious versions of virtio crypto spec, Pls see:
> >
> > [v14]:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html
> >
> > [v13]:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html
> >
> > For more information, please see:
> >  http://qemu-project.org/Features/VirtioCrypto
> >
> >
> > Gonglei (2):
> >   virtio-crypto: Add virtio crypto device specification
> >   virtio-crypto: Add conformance clauses
> >
> >  acknowledgements.tex |    2 +
> >  conformance.tex      |   29 ++
> >  content.tex          |    2 +
> >  virtio-crypto.tex    | 1309
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 1342 insertions(+)
> >  create mode 100644 virtio-crypto.tex
> >
