Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17996C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D021E20775
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D021E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jExJv-0005Up-V4
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 11:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jExJ6-0004yT-Nb
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jExJ4-0001a0-PT
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:42:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13962
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jExJ4-0001ZP-I3
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:42:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JFWPX5153873
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 11:42:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7adgs7r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 11:42:01 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Thu, 19 Mar 2020 15:41:59 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 15:41:55 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02JFfsMP27787664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 15:41:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36559A405C;
 Thu, 19 Mar 2020 15:41:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C18A8A4054;
 Thu, 19 Mar 2020 15:41:53 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.104.230])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 15:41:53 +0000 (GMT)
Date: Thu, 19 Mar 2020 16:40:50 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when
 switching to protected mode
In-Reply-To: <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
 <20200227132402.67a38047.pasic@linux.ibm.com>
 <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031915-4275-0000-0000-000003AF2C14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031915-4276-0000-0000-000038C45AF2
Message-Id: <20200319164050.78a01702.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_05:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003190067
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
Cc: Janosch Frank <frankja@linux.ibm.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 14:54:11 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 27.02.20 13:24, Halil Pasic wrote:
> > On Wed, 26 Feb 2020 16:11:03 +0100
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> > 
> >> On 2/26/20 3:59 PM, David Hildenbrand wrote:
> >>> On 26.02.20 13:20, Janosch Frank wrote:
> >>>> Ballooning in protected VMs can only be done when the guest shares the
> >>>> pages it gives to the host. Hence, until we have a solution for this
> >>>> in the guest kernel, we inhibit ballooning when switching into
> >>>> protected mode and reverse that once we move out of it.
> >>>
> >>> I don't understand what you mean here, sorry. zapping a page will mean
> >>> that a fresh one will be faulted in when accessed. And AFAIK, that means
> >>> it will be encrypted again when needed.
> >>
> >> Yes, as soon as the host alters non-shared memory we'll run into
> >> integrity issues.
> >>
> >>
> >> I've been talking to Halil after I sent this out and it looks like we'll
> >> rather try to automatically enable the IOMMU for all devices when
> >> switching into protected mode. He said that if the IOMMU is set the
> >> balloon code will do an early exit on feature negotiation.
> >>
> > 
> > I have a discussion starter RFC for you.
> > 
> > --------------------------8<----------------------------------------------
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Date: Wed, 26 Feb 2020 16:48:21 +0100
> > Subject: [RFC PATCH 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
> > 
> > The virtio specification tells that the device is to present
> > VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> > device "can only access certain memory addresses with said access
> > specified and/or granted by the platform". This is the case for a
> > protected VM, as the device can access only memory addresses that are in
> > pages that are currently shared (only the guest can share/unsare its
> > page).
> > 
> > No VM however starts out as a protected VM, but some VMs may be
> > converted to protected VMs if the guest decides so.
> > 
> > Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
> > the property iommu_on is a minor disaster. If the correctness of the
> > paravirtualized virtio devices depends (and thus in a sense the
> > correctness of the hypervisor), then the hypervisor should have the last
> > word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or not.
> > 
> > Let's manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatically
> > for virtio-ccw devices, so that we set it before we start the protected
> > configuration, and unset it when our VM is not protected.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> > NOTES:
> > * I wanted to have a discussion starter fast, there are multiple open
> > questions.
> > 
> > * Doing more than one system_resets() is hackish.  We
> > should look into this.
> > 
> > * The user interface implications of this patch are also an ugly can of
> > worms. Needs to be discussed.
> > 
> > * We should consider keeping the original value if !pv and restoring it
> > on pv --> !pv, instead of forcing to unset when leaving pv, and actually
> > not forcing unset when !pv.
> > 
> > * It might make sense to do something like this in virtio core, but I
> >   decided start the discussion with a ccw-only change.
> > 
> > * Maybe we need a machine option that enables this sort of behavior,
> > especially if we decide not to do the conserving/restoring.
> > 
> > * Lightly tested.
> > ---
> >  hw/s390x/s390-virtio-ccw.c |  4 ++--
> >  hw/s390x/virtio-ccw.c      | 13 +++++++++++++
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index 0f4455d1df..996124f152 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -337,7 +337,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
> >          ms->pv = false;
> >      }
> >      migrate_del_blocker(pv_mig_blocker);
> > -    qemu_balloon_inhibit(false);
> > +    subsystem_reset();
> >  }
> >  
> >  static int s390_machine_protect(S390CcwMachineState *ms)
> > @@ -346,7 +346,6 @@ static int s390_machine_protect(S390CcwMachineState *ms)
> >      CPUState *t;
> >      int rc;
> >  
> > -    qemu_balloon_inhibit(true);
> >      if (!pv_mig_blocker) {
> >          error_setg(&pv_mig_blocker,
> >                     "protected VMs are currently not migrateable.");
> > @@ -384,6 +383,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
> >      if (rc) {
> >          goto out_err;
> >      }
> > +    subsystem_reset();
> >      return rc;
> >  
> >  out_err:
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index 13f57e7b67..48bb54f68e 100644
> > --- a/hw/s390x/virtio-ccw.c
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -869,12 +869,24 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
> >      }
> >  }
> >  
> > +static inline void virtio_ccw_pv_enforce_features(VirtIODevice *vdev)
> > +{
> > +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
> > +
> > +    if (ms->pv) {
> > +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > +    } else {
> > +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > +    }
> > +}
> > +
> >  static void virtio_ccw_reset(DeviceState *d)
> >  {
> >      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> >      VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
> >      VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> >  
> > +    virtio_ccw_pv_enforce_features(vdev);
> >      virtio_ccw_reset_virtio(dev, vdev);
> >      if (vdc->parent_reset) {
> >          vdc->parent_reset(d);
> > @@ -1103,6 +1115,7 @@ static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> >      if (dev->max_rev >= 1) {
> >          virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
> >      }
> > +    virtio_ccw_pv_enforce_features(vdev);
> >  }
> >  
> >  /* This is called by virtio-bus just after the device is plugged. */
> > 
> > base-commit: 8665f2475f5999d4c9f33598f1360f0b0797c489
> > 
> 
> I asked this question already to Michael (cc) via a different channel,
> but hare is it again:
> 
> Why does the balloon driver not support VIRTIO_F_IOMMU_PLATFORM? It is
> absolutely not clear to me. The introducing commit mentioned that it
> "bypasses DMA". I fail to see that.
> 
> At least the communication via the SG mechanism should work perfectly
> fine with an IOMMU enabled. So I assume it boils down to the pages that
> we inflate/deflate not being referenced via IOVA?

AFAIU the IOVA/GPA stuff is not the problem here. You have said it
yourself, the SG mechanism would work for balloon out of the box, as it
does for the other virtio devices. 

But VIRTIO_F_ACCESS_PLATFORM (aka VIRTIO_F_IOMMU_PLATFORM)  not presented
means according to Michael that the device has full access to the entire
guest RAM. If VIRTIO_F_ACCESS_PLATFORM is negotiated this may or may not
be the case.

The actual problem is that the pages denoted by the buffer transmitted
via the virtqueue are normally not shared pages. I.e. the hypervisor
can not reuse them (what is the point of balloon inflate). To make this
work, the guest would need to share the pages before saying 'host these
are in my balloon, so you can use them'. This is a piece of logic we
need only if the host/the device does not have full access to the
guest RAM. That is in my opinion why the balloon driver fences
VIRTIO_F_ACCESS_PLATFORM.

Does that make sense?

> 
> I don't think they have to be IOVA addresses. We're neither reading nor
> writing these pages. We really speak about "physical memory in the
> system" when ballooning. Everything else doesn't really make sense.
> There is no need to map/unmap pages we inflate/deflate AFAIKs.
> 
> IMHO, we should not try to piggy-back on VIRTIO_F_IOMMU_PLATFORM here,
> but instead explicitly disable it either in the hypervisor or the guest.
> 

We need a feature bit here. We can say fencing VIRTIO_F_ACCESS_PLATFORM
was a bug, fix that bug, and then invent another 'the guest RAM is
somehow different' feature bit specific to the balloon, and then create
arch hooks in the driver that get active if this feature is negotiated.

I assumed the fact that the balloon driver fences
VIRTIO_F_ACCESS_PLATFORM is not a bug.

> I hope someone can clarify what the real issue with an IOMMU and
> ballooning is, because I'll be having the same "issue" with
virtio-mem.
> 

The issue is not with the IOMMU, the issue is with restricted access
to guest RAM. The definition of VIRTIO_F_ACCESS_PLATFORM is such that we
pretty much know what's up when VIRTIO_F_ACCESS_PLATFORM is not
presented, but VIRTIO_F_ACCESS_PLATFORM presented can mean a couple of
things.

Regards,
Halil


