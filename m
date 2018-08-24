Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ftAIx-0003UC-4W
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 07:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ftABN-0002ED-AU
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 07:23:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ftABN-0002Be-3T
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 07:23:13 -0400
Date: Fri, 24 Aug 2018 14:23:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180824142118-mutt-send-email-mst@kernel.org>
References: <1535071416-212072-1-git-send-email-longpeng2@huawei.com>
	<5B7F5688.5080007@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B7F5688.5080007@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v25 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: xin.zeng@intel.com, arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

Is there a github issue? If not pls create one.

On Fri, Aug 24, 2018 at 08:51:20AM +0800, Longpeng (Mike) wrote:
> Hi all,
> 
> The v25 spec has no big change but some typos and grammar fix, I attach the PDF
> for better review.
> 
> If there's no big argument on this version, maybe we can start a ballot in next
> week.
> 
> On 2018/8/24 8:43, Longpeng(Mike) wrote:
> 
> > ---
> > v25 -> v24
> >  - fix some typos and letex grammar.
> > 
> > v24 -> v23
> >  - Some enhancements based on Halil's suggestion. [Halil]
> > 
> > v23 -> v22
> >  - rename MUX_MODE to REVISION_1 [Halil]
> >  - fixed-length paramenters' instead of 'header' and
> >    'variable-length parameters' instead of 'extra parameters' [Halil]
> >  - add guidance about VIRTIO_CRYPTO_FLAG_SESSION_MODE [Halil]
> >  - other fixes. [Longpeng]
> > 
> > v22 -> v21
> >  - fix some typos and grammar fixes [Halil, Stefan]
> >  - reorder names in alphabetical order [Stefan]
> >  - redescribe the date format [Halil]
> > 
> > v21 -> v20
> >  - rename 'queue_id' to 'reserved' [Halil]
> >  - redescribe the format of the structures which using 'union'
> >    in the previous version [Halil]
> > 
> > v20 -> v19
> >  - fix some typos and grammar fixes [Halil]
> >  - make queue_id reserved [Halil]
> >  - remove 'Steps of Operation'
> > 
> > v19 -> v18:
> >  - fix some typos and grammar fixes [Stefan, Halil]
> >  - rename VIRTIO_CRYPTO_F_STATELESS_MODE to VIRTIO_CRYPTO_F_MUX_MODE
> >  - describe the VIRTIO_CRYPTO_STATUS in detial. [Halil]
> >  - refactor and redescribe the controlq/dataq request's format
> >    of mux mode. [Halil]
> >  - other small fixes. [Halil]
> > 
> > v18 -> v17:
> >  - fix many English grammar problems suggested by Stefan, Thanks a lot!
> > 
> > v17 -> v16:
> >  - Some grammar fixes [Stefan, Halil, Michael]
> >  - add a section named "Supported crypto services" in order to explain bit
> >    numbers and valuse clearly. [Halil, Cornelia]
> >  - avoid word reptition [Halil]
> >  - rename non-session mode to stateless mode [Halil]
> >  - change descriptions for all elements in struct virtio_crypto_config [Halil]
> >  - add Halil as a reviewer in the ackonwledgement part, thanks for his work.
> >  - other fixes here and there.
> > 
> > Changes since v15:
> >  - use feature bits for non-session mode in order to keep compatibility with
> >    pre-existing code. [Halil & Michael]
> >  - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control all other
> >    non-session mode feature bits.
> >  - fix some typos. [Stefan]
> >  - introduce struct virtio_crypto_op_data_req_mux to support both session
> >    and non-session based crypto operations and keep compatibility with
> >    pre-existing code.
> > 
> > Changes since v14:
> >  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
> >  - correct a sentence about dataqueue and controlq in the first paragraph. 
> > [Halil]
> >  - change a MAY to MUST about max_dataqueues. [Halil]
> >  - add non-session mode support
> >    a) add four features for different crypto services to identify wheather 
> > support session mode.
> >    b) rewrite some
> > 
> > For pervious versions of virtio crypto spec, Pls see:
> > 
> > [v18]:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg444897.html
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
> > Longpeng(Mike) (2):
> >   virtio-crypto: Add virtio crypto device specification
> >   virtio-crypto: Add conformance clauses
> > 
> >  acknowledgements.tex |    4 +
> >  conformance.tex      |   29 +
> >  content.tex          |    2 +
> >  virtio-crypto.tex    | 1533 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 1568 insertions(+)
> >  create mode 100644 virtio-crypto.tex
> > 
> 
> 
> -- 
> Regards,
> Longpeng(Mike)
