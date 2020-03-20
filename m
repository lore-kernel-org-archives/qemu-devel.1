Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD444C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC1C20767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC1C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMd2-0004Ya-Lp
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jFMcD-0003VR-6x
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jFMcB-0000pM-8r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:43:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50704
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jFMcB-0000pA-37
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:43:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02KIXjvU105459
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 14:43:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu7dcb4m7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 14:43:26 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Fri, 20 Mar 2020 18:43:24 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 20 Mar 2020 18:43:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02KIhJ8p31261048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2020 18:43:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58482AE051;
 Fri, 20 Mar 2020 18:43:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6B28AE045;
 Fri, 20 Mar 2020 18:43:18 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.114.57])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2020 18:43:18 +0000 (GMT)
Date: Fri, 20 Mar 2020 19:43:17 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when
 switching to protected mode
In-Reply-To: <d7d91f47-19d3-06cf-879c-c9556a924a2f@redhat.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
 <20200227132402.67a38047.pasic@linux.ibm.com>
 <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
 <20200319164050.78a01702.pasic@linux.ibm.com>
 <d7d91f47-19d3-06cf-879c-c9556a924a2f@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032018-0020-0000-0000-000003B7EE18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032018-0021-0000-0000-0000221061D2
Message-Id: <20200320194317.1cf36b00.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-20_06:2020-03-20,
 2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 18:31:11 +0100
David Hildenbrand <david@redhat.com> wrote:

> [...]
> 
> >>
> >> I asked this question already to Michael (cc) via a different
> >> channel, but hare is it again:
> >>
> >> Why does the balloon driver not support VIRTIO_F_IOMMU_PLATFORM? It
> >> is absolutely not clear to me. The introducing commit mentioned
> >> that it "bypasses DMA". I fail to see that.
> >>
> >> At least the communication via the SG mechanism should work
> >> perfectly fine with an IOMMU enabled. So I assume it boils down to
> >> the pages that we inflate/deflate not being referenced via IOVA?
> > 
> > AFAIU the IOVA/GPA stuff is not the problem here. You have said it
> > yourself, the SG mechanism would work for balloon out of the box, as
> > it does for the other virtio devices. 
> > 
> > But VIRTIO_F_ACCESS_PLATFORM (aka VIRTIO_F_IOMMU_PLATFORM)  not
> > presented means according to Michael that the device has full access
> > to the entire guest RAM. If VIRTIO_F_ACCESS_PLATFORM is negotiated
> > this may or may not be the case.
> 
> So you say
> 
> "The virtio specification tells that the device is to present
> VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> device "can only access certain memory addresses with said access
> specified and/or granted by the platform"."
> 
> So, AFAIU, *any* virtio device (hypervisor side) has to present this
> flag when PV is enabled. 

Yes, and balloon says bye bye when running in PV mode is only a secondary
objective. I've compiled some references:

"To summarize, the necessary conditions for a hack along these lines
(using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:

  - secure guest mode is enabled - so we know that since we don't share
    most memory regular virtio code won't
    work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM" 
(Michael Tsirkin, https://lkml.org/lkml/2020/2/20/1021)
I.e.: PV but !VIRTIO_F_ACCESS_PLATFORM \implies bugy hypervisor


"If VIRTIO_F_ACCESS_PLATFORM is set then things just work.  If
VIRTIO_F_ACCESS_PLATFORM is clear device is supposed to have access to
all of memory.  You can argue in various ways but it's easier to just
declare a behaviour that violates this a bug."
(Michael Tsirkin, https://lkml.org/lkml/2020/2/21/1626)
This one is about all memory guest, and not just the buffers transfered
via the virtqueue, which surprised me a bit at the beginning. But balloon
actually needs this.

"A device SHOULD offer VIRTIO_F_ACCESS_PLATFORM if its access to memory
is through bus addresses distinct from and translated by the platform to
physical addresses used by the driver, and/or if it can only access
certain memory addresses with said access specified and/or granted by
the platform. A device MAY fail to operate further if
VIRTIO_F_ACCESS_PLATFORM is not accepted. "
(https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-4120002)


> In that regard, your patch makes perfect sense
> (although I am not sure it's a good idea to overwrite these feature
> bits
> - maybe they should be activated on the cmdline permanently instead
> when PV is to be used? (or enable )).

I didn't understand the last part. I believe conserving the user
specified value when not running in PV mode is better than the hard
overwrite I did here. I wanted a discussion starter.

I think the other option (with respect to let QEMU manage this for user,
i.e. what I try to do here) is to fence the conversion if virtio devices
that do not offer VIRTIO_F_ACCESS_PLATFORM are attached; and disallow
hotplug of such devices at some point during the conversion.

I believe that alternative is even uglier.

IMHO we don't want the end user to fiddle with iommu_platform, because
all the 'benefit' he gets from that is possibility to make a mistake.
For example, I got an internal bug report saying virtio is broken with
PV, which boiled down to an overlooked auto generated NIC, which of
course had iommu_platform (VIRTIO_F_ACCESS_PLATFORM) not set.

> 
> > 
> > The actual problem is that the pages denoted by the buffer
> > transmitted via the virtqueue are normally not shared pages. I.e.
> > the hypervisor can not reuse them (what is the point of balloon
> > inflate). To make this work, the guest would need to share the pages
> > before saying 'host these are in my balloon, so you can use them'.
> > This is a piece of logic we
> 
> What exactly would have to be done in the hypervisor to support it?

AFAIK nothing. The guest needs to share the pages, and everything works.
Janosch, can you help me with this one? 

> 
> Assume we have to trigger sharing/unsharing - this sounds like a very
> architecture specific thing?

It is, but any guest having sovereignty about its memory may need
something similar.

> Or is this e.g., doing a map/unmap
> operation like mapping/unmapping the SG?

No this is something different. We need stronger guarantees than the
streaming portion of the DMA API provides. And what we actually want
is not DMA but something very different.

> 
> Right now it sounds to me "we have to do $ARCHSPECIFIC when
> inflating/deflating in the guest", which feels wrong.
> 

It is wrong in a sense. Drivers are mostly supposed to be portable. But
balloon is not a run of the mill device. I don't see any other way to
make this work.

> > need only if the host/the device does not have full access to the
> > guest RAM. That is in my opinion why the balloon driver fences
> > VIRTIO_F_ACCESS_PLATFORM.> Does that make sense?
> 
> Yeah, I understood the "device has to set VIRTIO_F_ACCESS_PLATFORM"
> part. Struggling with the "what can the guest driver actually do" part.
> 

Let me try to reword this. The point of PV is that the guest has
exclusive access to his pages unless the guest decides to share some
of the using a dedicated ultravisor call.

The point of the memballoon is, as far as I understand, to effectively
dynamically manage the guests memory size within given boundaries, and
without requiring memory hotplug. The basic idea is that the pages in
the balloon belong to the host. The host attempting to re-use a
non-shared page of a guest leads to problems. AFAIR the main problem
was that shall we ever want to deflate such a page (make it again
available for guest use) we would need to do an import, and that can
only work if we have the exact same content as when it was exported.
Otherwise integrity check fails as if we had a malicious hypervisor,
that is trying to inject stuff into the guest.

I'm sure Janosch can provide a better explanation.

I really don't see another way, how memory ballooning could work with
something like PV, without the balloon driver relinquishing the guests
ownership of the pages that are going to leave the guest via the balloon.

On that note ccing the AMD SEV people. Balloon is at this point
dysfunctional for them as well. @Tom: Right? If yes what problems need to
be solved so virtio-balloon can work under SEV?

Regards,
Halil 



