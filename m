Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DE7CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D4B20679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D4B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNOZy-0003rZ-3O
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 17:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iNOWd-0006Jw-DP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iNOWa-0007fW-5V
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:50:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iNOWZ-0007eh-SF
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:50:36 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2125369AC
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 21:50:34 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id y10so22809017qti.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 14:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vf2Gujh1D+kIfLyLKSFywI9uwqFrxpfl5qAZxk1EKKQ=;
 b=g5HhSnS1/3pmdMWjSpjLln/KV+/jO10gKKQ4/FRgDzrxr5ghV0mb7IHvD2R3QKberT
 981vaYRF7oCVp/Db6xNhlTvJb8AgwWsJZ1R7zcBiaS2YO49ROWXuy1jACMhB+wnfRPFe
 jDJqP6wzlKBFlPMlc9kzei/rslufnyvfM/QJ8dfNf2ZdPIgPcaZY5M0gUKnJxMtw7zXy
 dKx5WTqY+pT0f2gu8VFgRPEVCUV2wIfJ7ipD8AaNliPAZPPDXm3t3DaHsKfgXexs5d6C
 XQE2vaDVfgJvrnRN0mIbsiJhocNr+XL6nyvbA7F6XMv9Gcgn7JcyPYBA7YPp3mC236rO
 9HUg==
X-Gm-Message-State: APjAAAXknllPy1QZgFMDOjDq8+UezRpwzrtb2TMofJXy2qJ+G8n23s1Z
 XHWu0BwIE0VAJSP5OTYhgQHgDo14GFAL9uZ1jgNoEZt+rG5LAoR/jtHo8a5WAY3SnxEf1My+1l8
 ecPi1nNbAni9fCag=
X-Received: by 2002:ac8:72ce:: with SMTP id o14mr886003qtp.62.1571867433914;
 Wed, 23 Oct 2019 14:50:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmHGOMRePmVhVDbI4mndRio6jgZN0om/ykrr4Z9IGi8om/Xyb7XgfJ+4eU/fi8AgSdPIaR/w==
X-Received: by 2002:ac8:72ce:: with SMTP id o14mr885986qtp.62.1571867433642;
 Wed, 23 Oct 2019 14:50:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 y188sm9917277qke.31.2019.10.23.14.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 14:50:32 -0700 (PDT)
Date: Wed, 23 Oct 2019 17:50:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Message-ID: <20191023174957-mutt-send-email-mst@kernel.org>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191021132455.GH22659@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021132455.GH22659@stefanha-x1.localdomain>
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
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 02:24:55PM +0100, Stefan Hajnoczi wrote:
> On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
> > From: "Denis V. Lunev" <den@openvz.org>
> > 
> > Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
> > field reported by SCSI controler. Thus typical sequential read with
> > 1 MB size results in the following pattern of the IO from the guest:
> >   8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd]
> >   8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd]
> >   8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
> >   8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
> >   8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
> >   8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
> > The IO was generated by
> >   dd if=/dev/sda of=/dev/null bs=1024 iflag=direct
> > 
> > This effectively means that on rotational disks we will observe 3 IOPS
> > for each 2 MBs processed. This definitely negatively affects both
> > guest and host IO performance.
> > 
> > The cure is relatively simple - we should report lengthy scatter-gather
> > ability of the SCSI controller. Fortunately the situation here is very
> > good. VirtIO transport layer can accomodate 1024 items in one request
> > while we are using only 128. This situation is present since almost
> > very beginning. 2 items are dedicated for request metadata thus we
> > should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
> > 
> > The following pattern is observed after the patch:
> >   8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd]
> >   8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd]
> >   8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
> >   8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
> > which is much better.
> > 
> > The dark side of this patch is that we are tweaking guest visible
> > parameter, though this should be relatively safe as above transport
> > layer support is present in QEMU/host Linux for a very long time.
> > The patch adds configurable property for VirtIO SCSI with a new default
> > and hardcode option for VirtBlock which does not provide good
> > configurable framework.
> > 
> > Unfortunately the commit can not be applied as is. For the real cure we
> > need guest to be fixed to accomodate that queue length, which is done
> > only in the latest 4.14 kernel. Thus we are going to expose the property
> > and tweak it on machine type level.
> > 
> > The problem with the old kernels is that they have
> > max_segments <= virtqueue_size restriction which cause the guest
> > crashing in the case of violation.
> > To fix the case described above in the old kernels we can increase
> > virtqueue_size to 256 and max_segments to 254. The pitfall here is
> > that seabios allows the virtqueue_size-s < 128, however, the seabios
> > patch extending that value to 256 is pending.
> 
> If I understand correctly you are relying on Indirect Descriptor support
> in the guest driver in order to exceed the Virtqueue Descriptor Table
> size.
> 
> Unfortunately the "max_segments <= virtqueue_size restriction" is
> required by the VIRTIO 1.1 specification:
> 
>   2.6.5.3.1 Driver Requirements: Indirect Descriptors
> 
>   A driver MUST NOT create a descriptor chain longer than the Queue
>   Size of the device.
> 
> So this idea seems to be in violation of the specification?
> 
> There is a bug in hw/block/virtio-blk.c:virtio_blk_update_config() and
> hw/scsi/virtio-scsi.c:virtio_scsi_get_config():
> 
>   virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
> 
> This number should be the minimum of blk_get_max_iov() and
> virtio_queue_get_num(), minus 2 for the header and footer.
> 
> I looked at the Linux SCSI driver code and it seems each HBA has a
> single max_segments number - it does not vary on a per-device basis.
> This could be a problem if two host block device with different
> max_segments are exposed to the guest through the same virtio-scsi
> controller.  Another bug? :(
> 
> Anyway, if you want ~1024 descriptors you should set Queue Size to 1024.
> I don't see a spec-compliant way of doing it otherwise.  Hopefully I
> have overlooked something and there is a nice way to solve this.
> 
> Stefan



We can extend the spec of course. And we can also
have different vq sizes between legacy and modern
interfaces.

-- 
MST

