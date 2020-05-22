Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAAEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82CC20663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82CC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcErP-0000TN-SQ
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 17:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jcEqm-0008Q5-DN; Fri, 22 May 2020 17:05:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jcEqk-0002qt-Rq; Fri, 22 May 2020 17:05:04 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04ML1wu7133109; Fri, 22 May 2020 17:04:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mh3b0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 17:04:59 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04ML4wer142717;
 Fri, 22 May 2020 17:04:58 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mh3ayr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 17:04:58 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04ML4uNS000861;
 Fri, 22 May 2020 21:04:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04ams.nl.ibm.com with ESMTP id 313xehra4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 21:04:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04ML4rua54984926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 21:04:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95AD94204C;
 Fri, 22 May 2020 21:04:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F126E4203F;
 Fri, 22 May 2020 21:04:52 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.153.180])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2020 21:04:52 +0000 (GMT)
Date: Fri, 22 May 2020 23:04:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200522230451.632a3787.pasic@linux.ibm.com>
In-Reply-To: <20200520121507-mutt-send-email-mst@kernel.org>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-22_09:2020-05-22,
 2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 15:53:50
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 12:23:24 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, May 15, 2020 at 12:11:55AM +0200, Halil Pasic wrote:
> > The virtio specification tells that the device is to present
> > VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> > device "can only access certain memory addresses with said access
> > specified and/or granted by the platform". This is the case for a
> > protected VMs, as the device can access only memory addresses that are
> > in pages that are currently shared (only the guest can share/unsare its
> > pages).
> > 
> > No VM, however, starts out as a protected VM, but some VMs may be
> > converted to protected VMs if the guest decides so.
> > 
> > Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
> > the property iommu_on is a minor disaster. Since the correctness of the
> > paravirtualized virtio devices depends (and thus in a sense the
> > correctness of the hypervisor) it, then the hypervisor should have the
> > last word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or
> > not.
> 
> So, how about this: switch iommu to on/off/auto.

Many thanks for the reveiw, and sorry about the delay on my side. We
have holidays here in Germany and I was not motivated enough up until
now to check on my mails.


I've actually played  with the thought of switching iommu_platform to 
'on/off/auto', but I didn't find an easy way to do it. I will look
again. This would be the first property of this kind in QEMU, or?

The 'on/off/auto' would be certainly much cleaner form user-interface
perspective. The downsides are that it is more invasive, and more
complicated. I'm afraid that it would also leave more possibilities for
user error.

>  Add a property with a
> reasonable name "allow protected"?  If set allow switch to protected
> memory and also set iommu auto to on by default.  If not set then don't.
>

I think we have "allow protected" already expressed via cpu models. I'm
also not sure how libvirt would react to the idea of a new machine
property for this. You did mean "allow protected" as machine property,
or?

AFAIU "allow protected" would be required for the !PV to PV switch, and
we would have to reject paravirtualized devices with iommu_platform='off'
on VM construction or hotplug (iommu_platform='auto/on' would be fine).

Could you please confirm that I understood this correctly?


> This will come handy for other things like migrating to hosts without
> protected memory support.
> 

This is already covered by cpu model AFAIK.

> 
> Also, virtio now calls this PLATFORM_ACCESS, maybe we should rename
> the property (keeping old one around for compat)?

You mean the like rename 'iommu_platform' to 'platform_access'? I like
the idea, but I'm not sure libvirt will like it as well. Boris any
opinions?

> I feel this will address lots of complaints ...
> 
> > Currently presenting a PV guest with a (paravirtualized) virtio-ccw
> > device has catastrophic consequences for the VM (after the hypervisors
> > access to protected memory). This is especially grave in case of device
> > hotplug (because in this case the guest is more likely to be in the
> > middle of something important).
> > 
> > Let us manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatically
> > for virtio-ccw devices, i.e. force it before we start the protected VM.
> > If the VM should cease to be protected, the original value is restored.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> 
> 
> I don't really understand things fully but it looks like you are
> changing features of a device.  If so this bothers me, resets
> happen at random times while driver is active, and we never
> expect features to change.
>

Changing the device features is IMHO all right because the features can
change only immediately after a system reset and before the first vCPU
is run. That is ensured by two facts.


First, the feature can only change when ms->pv changes. That is on the
first reset after the VM entered or left the "protected virtualization"
mode of operation. And that switch requires a system reset. Because the
PV switch is initiated by the guest, and the guest is rebooted as a
consequence, the guest will never observe the change in features.

By the way, when switching between PV and !PV the features of the
cpu (model) also change.

Second,  virtio_ccw_reset() -- the function that is modified -- does
not get called on a reset that is initiated via the transport. We have
virtio_ccw_reset_virtio() for that.

[..]

> >      VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> > +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
> > +
> > +    /*
> > +     * An attempt to use a paravirt device without
> > VIRTIO_F_IOMMU_PLATFORM
> > +     * in PV, has catastrophic consequences for the VM. Let's force
> > +     * VIRTIO_F_IOMMU_PLATFORM not already specified.
> > +     */
> > +    if (ms->pv && !virtio_host_has_feature(vdev,
> > VIRTIO_F_IOMMU_PLATFORM)) {
> > +        virtio_add_feature(&vdev->host_features,
> > VIRTIO_F_IOMMU_PLATFORM);
> > +        dev->forced_iommu_platform = true;
> > +    } else if (!ms->pv && dev->forced_iommu_platform) {
> > +        virtio_clear_feature(&vdev->host_features,
> > VIRTIO_F_IOMMU_PLATFORM);
> > +        dev->forced_iommu_platform = false;
> > +    }
> >  
> >      virtio_ccw_reset_virtio(dev, vdev);
> >      if (vdc->parent_reset) {
> > diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
> > index 3453aa1f98..34ff7b0b4e 100644
> > --- a/hw/s390x/virtio-ccw.h
> > +++ b/hw/s390x/virtio-ccw.h
> > @@ -99,6 +99,7 @@ struct VirtioCcwDevice {
> >      IndAddr *summary_indicator;
> >      uint64_t ind_bit;
> >      bool force_revision_1;
> > +    bool forced_iommu_platform;
> >  };
> >  
> >  /* The maximum virtio revision we support. */
> > 
> 
> This seems unused. Why is it helpful?
> 

You mean the "base-commit: SHA-1"?

It is what the --base option of git format-patch generates, and it tells
what exact commit the series is based on. Can be useful when it is not
clear against which git subtree was developed, or for comparatively old
series. It hopefully also indicates what code level was tested by the
developer.


Thanks again!

Regards,
Halil

> 
> > base-commit: 0ffd3d64bd1bb8b84950e52159a0062fdab34628
> > -- 
> > 2.17.1
> 


