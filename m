Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46E9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B6120812
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B6120812
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiamd-0003C9-Qe
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jialf-0002is-1W; Tue, 09 Jun 2020 05:42:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6356
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jiald-0003eG-CB; Tue, 09 Jun 2020 05:42:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0599X46L191624; Tue, 9 Jun 2020 05:41:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31j6c8kdt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 05:41:54 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0599XD3b192479;
 Tue, 9 Jun 2020 05:41:53 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31j6c8kdsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 05:41:53 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0599aNM2031685;
 Tue, 9 Jun 2020 09:41:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 31g2s829p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2020 09:41:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0599fmn819333242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2020 09:41:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8841A4057;
 Tue,  9 Jun 2020 09:41:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AEC6A4055;
 Tue,  9 Jun 2020 09:41:48 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.129.89])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2020 09:41:48 +0000 (GMT)
Date: Tue, 9 Jun 2020 11:41:30 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200609114130.0ca9190b.pasic@linux.ibm.com>
In-Reply-To: <20200609084402.35d317ec.cohuck@redhat.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-09_03:2020-06-08,
 2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxscore=0 cotscore=-2147483648 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 05:41:59
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
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jun 2020 08:44:02 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 8 Jun 2020 19:00:45 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> 
> > > I'm also not 100% sure about migration... would it make sense to
> > > discuss all of this in the context of the cross-arch patchset? It seems
> > > power has similar issues.
> > >   
> > 
> > I'm going to definitely have a good look at that. What I think special
> > about s390 is that F_ACCESS_PLATFORM is hurting us because all IO needs
> > to go through ZONE_DMA (this is a problem of the implementation that
> > stemming form a limitation of the DMA API, upstream didn't let me
> > fix it). 
> 
> My understanding is that power runs into similar issues, but I don't
> know much about power, so I might be entirely wrong :)
> 

I will come back to you once I've figured that patch-set out.

[..]

> > > > @@ -874,6 +874,20 @@ static void virtio_ccw_reset(DeviceState *d)
> > > >      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> > > >      VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
> > > >      VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> > > > +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
> > > > +
> > > > +    /*
> > > > +     * An attempt to use a paravirt device without VIRTIO_F_IOMMU_PLATFORM
> > > > +     * in PV, has catastrophic consequences for the VM. Let's force
> > > > +     * VIRTIO_F_IOMMU_PLATFORM not already specified.
> > > > +     */
> > > > +    if (vdev->access_platform_auto && ms->pv) {
> > > > +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > > > +        vdev->access_platform = ON_OFF_AUTO_ON;
> > > > +    } else if (vdev->access_platform_auto) {
> > > > +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > > > +        vdev->access_platform = ON_OFF_AUTO_OFF;
> > > > +    }  
> > > 
> > > If the consequences are so dire, we really should disallow adding a
> > > device of IOMMU_PLATFORM off if pv is on.  
> > 
> > I totally agree. My previous patch didn't have the problem because there
> > we just forced what we need.
> > 
> > > 
> > > (Can we disallow transition to pv if it is off? Maybe with the machine
> > > property approach from the cross-arch patchset?)  
> > 
> > No we can't disallow transition because for hotplug that already
> > happened.
> 
> I mean, can a virtio devices without IOMMU_PLATFORM act as a transition
> blocker (i.e. an attempt by a guest to move to pv would fail?)
>

I don't know. Janosch could answer that, but he is on vacation. Adding
Claudio maybe he can answer. My understanding is, that while it might be
possible, it is ugly at best. The ability to do a transition is
indicated by a CPU model feature. Indicating the feature to the guest and
then failing the transition sounds wrong to me.
 
[..]

> > 
> > Right, this is more about the machine than the transport. I was thinking
> > of a machine hook, but decided to discuss the more basic stuff first
> > (i.e. is it OK to change the property after stuff is realized).
> > 
> > This would already fix the most pressing issue which is virtio-ccw. I
> > didn't even bother checking if virtio-pci works with PV out of the box,
> > or if something needs to be done there. My bet is that it does not work.
> 
> I agree, virtio-pci + pv is unlikely to work. But if at all possible,
> I'd prefer a general solution anyway, as other architectures care about
> virtio-pci.
> 
> 

I'm with you. I hoped to get changing features on the fly approved first
before setting out to solve this. But I will look into it.

Regards,
Halil

