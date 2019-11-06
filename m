Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17503C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63D1214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63D1214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSK39-0002ft-Vn
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSK22-0001VE-JY
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSK20-0001NT-NO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:03:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSK20-0001NB-E4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:03:24 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78A7A7F418
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 12:03:23 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id z64so24768930qkc.15
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 04:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9qjwaYRmzu4AmZHYAnC4B0Oq2Js3YFiVE1ciFBL7XI0=;
 b=rWpftFjcmbQK0c2h9ad2+zwj1Qi5q+Wcr4gjIyyXCxbFrlymPBDCT6pVxfyuHwOwYF
 A8dy0pZFgueuOGjbfUSfPB9+yZJHMNokC8p0BQbmr3xJt/++duMWBnvXGBUrUuwq+75X
 JCQg6C7xmbC5f612H7nKMQKINgA1y0piSSI919N7sLOKDNcScJxmYUgOyoIFPqJGNxZQ
 uvRAT+mQo4IsD7QUd/5SVPd8yGaRhMlQxNDN8dpQgP2oxjQbYBhckfbRtTWnlSprEwfy
 3WMz7OF6JszuuZgzbpbapBPWG3OkqBEXvVCi2c5Eaxu0P+0sc2Izjebndd/AJDxn3PU3
 ZdzQ==
X-Gm-Message-State: APjAAAWHMl8Y5PTqvtwPrY1kvTgveaDLq4Vxp8TM+fepZIF/BfLv0dAC
 /cSv72Zp6UiDAEEsjUKzW+AwPjxk3aXWtmNXQ+fHqDqQ8aF2USTYOtEGLRt0VF9/SESI1GyBAqe
 czJYUSc8RuehocgY=
X-Received: by 2002:a0c:b91f:: with SMTP id u31mr1810346qvf.190.1573041802650; 
 Wed, 06 Nov 2019 04:03:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhkRvjLh5Xzuf8aT+iNetzqou1rOSt/I0J59gX1Y4Uuw6U9YUVdAcWg70ZpLdqoRyuyb8URw==
X-Received: by 2002:a0c:b91f:: with SMTP id u31mr1810328qvf.190.1573041802359; 
 Wed, 06 Nov 2019 04:03:22 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id h20sm4286918qtr.59.2019.11.06.04.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 04:03:21 -0800 (PST)
Date: Wed, 6 Nov 2019 07:03:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Message-ID: <20191106065816-mutt-send-email-mst@kernel.org>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191023172005-mutt-send-email-mst@kernel.org>
 <42b80a75-6ab4-5123-bbf5-eee21c2841ac@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b80a75-6ab4-5123-bbf5-eee21c2841ac@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 11:34:34AM +0000, Denis Lunev wrote:
> On 10/24/19 12:28 AM, Michael S. Tsirkin wrote:
> > On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
> >> From: "Denis V. Lunev" <den@openvz.org>
> >>
> >> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
> >> field reported by SCSI controler. Thus typical sequential read with
> >> 1 MB size results in the following pattern of the IO from the guest:
> >>   8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd]
> >>   8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd]
> >>   8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
> >>   8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
> >>   8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
> >>   8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
> >> The IO was generated by
> >>   dd if=/dev/sda of=/dev/null bs=1024 iflag=direct
> >>
> >> This effectively means that on rotational disks we will observe 3 IOPS
> >> for each 2 MBs processed. This definitely negatively affects both
> >> guest and host IO performance.
> >>
> >> The cure is relatively simple - we should report lengthy scatter-gather
> >> ability of the SCSI controller. Fortunately the situation here is very
> >> good. VirtIO transport layer can accomodate 1024 items in one request
> >> while we are using only 128. This situation is present since almost
> >> very beginning. 2 items are dedicated for request metadata thus we
> >> should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
> >>
> >> The following pattern is observed after the patch:
> >>   8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd]
> >>   8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd]
> >>   8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
> >>   8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
> >> which is much better.
> >>
> >> The dark side of this patch is that we are tweaking guest visible
> >> parameter, though this should be relatively safe as above transport
> >> layer support is present in QEMU/host Linux for a very long time.
> >> The patch adds configurable property for VirtIO SCSI with a new default
> >> and hardcode option for VirtBlock which does not provide good
> >> configurable framework.
> >>
> >> Unfortunately the commit can not be applied as is. For the real cure we
> >> need guest to be fixed to accomodate that queue length, which is done
> >> only in the latest 4.14 kernel. Thus we are going to expose the property
> >> and tweak it on machine type level.
> >>
> >> The problem with the old kernels is that they have
> >> max_segments <= virtqueue_size restriction which cause the guest
> >> crashing in the case of violation.
> > This isn't just in the guests: virtio spec also seems to imply this,
> > or at least be vague on this point.
> >
> > So I think it'll need a feature bit.
> > Doing that in a safe way will also allow being compatible with old guests.
> >
> > The only downside is it's a bit more work as we need to
> > spec this out and add guest support.
> >
> >> To fix the case described above in the old kernels we can increase
> >> virtqueue_size to 256 and max_segments to 254. The pitfall here is
> >> that seabios allows the virtqueue_size-s < 128, however, the seabios
> >> patch extending that value to 256 is pending.
> >
> > And the fix here is just to limit large vq size to virtio 1.0.
> > In that mode it's fine I think:
> >
> >
> >    /* check if the queue is available */
> >    if (vp->use_modern) {
> >        num = vp_read(&vp->common, virtio_pci_common_cfg, queue_size);
> >        if (num > MAX_QUEUE_NUM) {
> >            vp_write(&vp->common, virtio_pci_common_cfg, queue_size,
> >                     MAX_QUEUE_NUM);
> >            num = vp_read(&vp->common, virtio_pci_common_cfg, queue_size);
> >        }
> >    } else {
> >        num = vp_read(&vp->legacy, virtio_pci_legacy, queue_num);
> >    }
> 
> you mean to put the code like this into virtio_pci_realize() inside QEMU?
> 
> If no, can you pls clarify which component should be touched.
> 
> Den

I mean:
 - add an API to change the default queue size
 - add a validate features callback, in there check and for modern
   flag set in features increase the queue size

maybe all this is too much work, we could block this
for transitional devices, but your patch does not do it,
you need to check that legacy is enabled not that modern
is not disabled.



-- 
MST

