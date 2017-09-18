Received: from eggs.gnu.org ([2001:4830:134:3::10]:50969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dtyyx-0001iM-Cm
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dtyyt-0008KF-Dn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:33:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dtyyt-0008JI-3u
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:33:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8IGQpnI062163
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 12:33:08 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2d23ub73-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 12:33:08 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 18 Sep 2017 17:33:05 +0100
References: <1505092362-10544-1-git-send-email-longpeng2@huawei.com>
	<1505092362-10544-2-git-send-email-longpeng2@huawei.com>
	<67d5549e-84de-ee85-00a7-37edc52234c4@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3D9A7B@DGGEMA505-MBX.china.huawei.com>
	<73b9f2a8-6746-593b-4277-3ea757476130@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3D9B61@DGGEMA505-MBX.china.huawei.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310E1111B@SHSMSX103.ccr.corp.intel.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 18 Sep 2017 18:32:57 +0200
MIME-Version: 1.0
In-Reply-To: <82063967A54EF84C8AFCD6BD7F6AD93310E1111B@SHSMSX103.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <e7e10450-806a-00f6-f9d3-65460b692f34@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH REPOST v19 1/2] virtio-crypto: Add virtio
 crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zeng, Xin" <xin.zeng@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Griffin, John" <john.griffin@intel.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "Ma, Liang J" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Keating, Brian A" <brian.a.keating@intel.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>



On 09/18/2017 04:51 PM, Zeng, Xin wrote:
> On Monday, September 18, 2017 9:24 PM, Gonglei (Arei) wrote:
> 
> < > On 09/18/2017 02:13 PM, Gonglei (Arei) wrote:
> < > >> Destroy does not need to specify queue_id. That means session_id's aren't
> < > >> queue scoped from namespace perspective. The question remains what is
> < > >> queue_id good for, and whether a session type op request should be
> < > >> rejected if the the session id originates from a session creation
> < > >> request specifying a different dataqueue (not the dataqueue containing
> < > >> the given request)?
> < > >>
> < > > My original idea about the queue_id is using the queue_id to specify which
> < > > datequeue of the following data requests will be used. But after deep
> < > thinking,
> < > > I find that the queue_id is superfluous, and the current code in QEMU also
> < > > don't use the queue_id value as well. That's because the we can use
> < > session_id
> < > > to find the pervious session information and get the current dataqueue id
> < > > from the used virtqueue .
> < > >
> < > > So maybe we should drop the queue_id this time.
> < > >
> < > >
> < >
> < > Sounds reasonable to me. We can make it reserved and ignored in
> < > the specification. Linux uses it, but it's always set to 0 as we only
> < > support one data-queue (if I'm not wrong). So reserved and must be zero
> < > is an option too.
> < >
> < Makes sense to keeping compatibility.
> < 
> 
> If we always set it to 0, and backend device doesn't specify the queue
> id when creating session, this works only when one data queue is
> supported. But if we want to support multi data queues,
> how does frontend driver know which queue it should use when 
> sending requests to the virt queue? And furthermore, if the data queue 
> id which can be used is determined by backend device, how does 
> guest frontend driver know which queue can be used when operating
> in stateless mode in case multi data queue is supported?

AFAIU you answered your own questions (questions above, answers below). Gonglei
has just stated that he intends to abandon the queue_id.

> So from my point of view, session should only be associated with service
> related information, but not associated with the transport layer information,
> i.e. data queue id in this case. The data queue to be used should be chosen by
> frontend driver. Frontend driver can use any valid data queue to send requests
> to backend device, backend device need to extract the session information
> from the request packet and retrieve the request's session info then handle it 
> correspondingly.

AFAIU that's what we have agreed, basically. I'm not sure about your wording
(for instance I would have said session identifier instead of session information),
but I think we think the same. In short conceptually all configured data queues
are equivalent in the sense that it does not matter on which queue a request is
placed -- modulo capacity.

Halil

> 
> < Thanks,
> < -Gonglei
> 
