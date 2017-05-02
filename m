Received: from eggs.gnu.org ([2001:4830:134:3::10]:44113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d5flZ-0000rz-NG
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d5flX-0004tg-2Z
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:55:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d5flW-0004t2-NI
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:55:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42LsTiC139783
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 17:55:23 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6xt0j2rw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 17:55:23 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 2 May 2017 22:55:20 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 2 May 2017 23:55:10 +0200
MIME-Version: 1.0
In-Reply-To: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <2cd31ba0-96fc-7ef5-8db5-c656d7819523@linux.vnet.ibm.com>
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
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, wu.wubin@huawei.com, arei.gonglei@hotmail.com, linqiangmin@huawei.com, zhbzg@huawei.com, eety.chen@huawei.com, amy.zhanghuimin@huawei.com, lixiao91@huawei.com


Hi Gonglei!

I've started reviewing but it's going to take some time because
I've missed the previous version (vacation) and v16 was a long
time ago, so I have to re-check and re-learn things.

My first impression is, it reads much better that v16 but still
has some space for improvement.

One idea would be adding some references defining the
crypto services and algorithms. IMHO it would make the
spec a bit rounder, although from pragmatical perspective
I think we can safely assume, that the target audience is able
to figure out the stuff without.

Cheers,
Halil


On 04/22/2017 08:23 AM, Gonglei wrote:
> As a non-native English speaker, I sincerely hope you
> give me more suggestions about English style and/or
> grammar for the spec. Thanks!
> 
> 
> v18 -> v17:
>  - fix many English grammar problems suggested by Stefan, Thanks a lot!
> 
> v17 -> v16:
>  - Some grammar fixes [Stefan, Halil, Michael]
>  - add a section named "Supported crypto services" in order to explain bit
>    numbers and valuse clearly. [Halil, Cornelia]
>  - avoid word reptition [Halil]
>  - rename non-session mode to stateless mode [Halil]
>  - change descriptions for all elements in struct virtio_crypto_config [Halil]
>  - add Halil as a reviewer in the ackonwledgement part, thanks for his work.
>  - other fixes here and there.
> 
> Changes since v15:
>  - use feature bits for non-session mode in order to keep compatibility with
>    pre-existing code. [Halil & Michael]
>  - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control all other
>    non-session mode feature bits.
>  - fix some typos. [Stefan]
>  - introduce struct virtio_crypto_op_data_req_mux to support both session
>    and non-session based crypto operations and keep compatibility with
>    pre-existing code.
> 
> Changes since v14:
>  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
>  - correct a sentence about dataqueue and controlq in the first paragraph. [Halil]
>  - change a MAY to MUST about max_dataqueues. [Halil]
>  - add non-session mode support
>    a) add four features for different crypto services to identify wheather support session mode.
>    b) rewrite some
> 
> For pervious versions of virtio crypto spec, Pls see:
> 
> [v14]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html
> 
> [v13]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html
> 
> For more information, please see:
>  http://qemu-project.org/Features/VirtioCrypto
> 
> 
> Gonglei (2):
>   virtio-crypto: Add virtio crypto device specification
>   virtio-crypto: Add conformance clauses
> 
>  acknowledgements.tex |    2 +
>  conformance.tex      |   29 ++
>  content.tex          |    2 +
>  virtio-crypto.tex    | 1309 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1342 insertions(+)
>  create mode 100644 virtio-crypto.tex
> 
