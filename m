Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77981C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432BC206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIkjGVPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432BC206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsmKu-0001b6-JO
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 08:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jsmJo-0000k6-VX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:03:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38131
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jsmJn-0004JZ-E4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594123402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BYivrO6U99t0k+73WUk6PA6zcdvclvNQegBr55laNiU=;
 b=TIkjGVPFhi9mHPtDc50vkI6B6TVWJrZhZsQldIF6vW3FJ3fV+ayt2jKkbd1nnR8/xlIEFE
 Xt4i/QKTo8PXxdT84MI5bgkGZ3/cO0FcmKQhDGf6bkhFgA7yQkxEUrATVG96VkF2CHd61U
 zxdsd0Oko/S6JjTfAHy8ZK2Ul5cWnWI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394--D481UI4NAqBukkRsznVpA-1; Tue, 07 Jul 2020 08:03:20 -0400
X-MC-Unique: -D481UI4NAqBukkRsznVpA-1
Received: by mail-wr1-f70.google.com with SMTP id w4so46452133wrm.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 05:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BYivrO6U99t0k+73WUk6PA6zcdvclvNQegBr55laNiU=;
 b=K0kIZe2EKghESwOEST/Sj6DqsCw1wE9AA4wvkf++FSBy4duhDzE+PclmOWM3ySDS9N
 5dWfuB8Jn4aOJVKiYJF0KfqOGyrum4dbBAvRT66jjRe/cXI1kREunBPnHTaAClchoNwv
 edk/kItfYCMFQaL4WO1B/ywb36Vls1KGtb8XakJeSHH1U15rWzlYJK91dEQmBXEn16pX
 l+y3UVh1dDwKAZqsj4qwYlUQ1txs01e0Mv8FU+GcdcPBe1lThj27Wn19IiHMboH042Hl
 EBEV7A5lFjCYHttwscAHO9l6pHqk6d6Vn8qD9RVN35sRQq1P6Ga3DJFzM7QCxmagA2i+
 dDZw==
X-Gm-Message-State: AOAM530PuvqIytjdCLczYqMpro/qX0ud84Ek3ov2mVcZ2YgLUd4dgtfM
 hb0bgEcHmdcpahrR9Uk3cxnWI85P/+LcIyOvfVGXI3oaxHvDC3IsJpgxePqNTb9rET4c7IwV/XH
 4Kt8Zg0v+W/MEGaU=
X-Received: by 2002:adf:dc90:: with SMTP id r16mr54119609wrj.264.1594123398458; 
 Tue, 07 Jul 2020 05:03:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGekj2KgwzlBxUV5ydUXSpQgIy4amL1X1CMNuzlhfRUoC74riEEtKHpoLNvTT8yguEti9g6A==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr54119586wrj.264.1594123398208; 
 Tue, 07 Jul 2020 05:03:18 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id b23sm886806wmd.37.2020.07.07.05.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 05:03:17 -0700 (PDT)
Date: Tue, 7 Jul 2020 08:03:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/41] virtio,acpi: features, fixes, cleanups.
Message-ID: <20200707080049-mutt-send-email-mst@kernel.org>
References: <20200704182750.1088103-1-mst@redhat.com>
 <CAFEAcA_LrhvLmbwsSrhHUYZ+z9EZoDZwct+s3xfoaGLyLkOPfg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_LrhvLmbwsSrhHUYZ+z9EZoDZwct+s3xfoaGLyLkOPfg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 07, 2020 at 12:40:38PM +0100, Peter Maydell wrote:
> On Sat, 4 Jul 2020 at 19:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >
> > v2 of the pull, fixing non-Linux builds.
> >
> >
> > The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
> >
> >   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to f7d98068bf7a0913744dd4ac0a28e8c841df2af5:
> >
> >   vhost-vdpa: introduce vhost-vdpa net client (2020-07-04 11:13:50 -0400)
> >
> > ----------------------------------------------------------------
> > virtio,acpi: features, fixes, cleanups.
> >
> > vdpa support
> > virtio-mem support
> > a handy script for disassembling acpi tables
> > misc fixes and cleanups
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> 
> Hi; I'm afraid this fails to build on 32-bit:
> 
> /home/peter.maydell/qemu/hw/virtio/vhost-vdpa.c: In function
> 'vhost_vdpa_dma_map':
> /home/peter.maydell/qemu/hw/virtio/vhost-vdpa.c:48:23: error: cast
> from pointer to integer of different size
> [-Werror=pointer-to-int-cast]
>      msg.iotlb.uaddr = (uint64_t)vaddr;
>                        ^
> 
> This should probably be "= (uintptr_t)vaddr".
> 
> thanks
> -- PMM

Precisely. Sorry about missing this.
I made this change and pushed to the same tag - don't want to spam
the list for a small thing like this. Can you pick this up pls?
Commit 849c48004df0e123b53fe9888770cb4f6eb5e8ab now

-- 
MST


