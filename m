Received: from eggs.gnu.org ([2001:4830:134:3::10]:47979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ewsCQ-0004XJ-IE
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ewsCN-0002Oe-DC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:27:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ewsCN-0002OH-9K
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:27:19 -0400
Date: Fri, 16 Mar 2018 18:27:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180316181953-mutt-send-email-mst@kernel.org>
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [v23 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

On Tue, Jan 09, 2018 at 06:05:41PM +0100, Halil Pasic wrote:
> > +\item[\field{max_cipher_key_len}] is the maximum length of cipher key supported by the device.
> 
> I can't find what happens if this limit isn't honored by the driver. Moreover
> reading it is only SHOULD. Is it undefined behavior or should the device reject/fail
> such requests? I think in qemu implementation we fail the request.
> 
> This question is only about niceness. We are already good enough, IMHO:
> since the implementer of the driver can't be sure what is going to happen
> if the driver disregards max_cipher_key_len it is already an implicit
> SHOULD.

I am not sure documenting undefined behaviour is always required.
We certainly do not do this for all other devices.

Reading a field being SHOULD seems reasonable: e.g.
driver might read it once and cache it in memory.

Halil, could you try to split your comments between requirements
for more conformance clauses/clarifications as opposed to
defects where it's wrong and does not match actual or
expected behaviour?

I think spec is better off with some documentation for this
device than none at all like today.

-- 
MST
