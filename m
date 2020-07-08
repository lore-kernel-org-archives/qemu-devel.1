Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C454CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D22B206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9ghhUwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D22B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIxg-0001Kx-Q7
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtIrU-0005g6-UP
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:48:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42523
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtIrS-0004cK-M7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594248497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pKVHCXlZTjIMREE5P/Tiro94AC+MkeW88RwdRl8MPJ0=;
 b=S9ghhUwOvDf4cQovRZGLKQavW/18Eu0p/fsPEQtZWbPRFIzrV0eWNTOayaeAusq/d9DXgk
 TTtgnR3bOodWAYl8Z88Hyw7aQTLohFu7FddRlUY6XNYbrdAprB7DMLEsfqP5HPujBhTiQS
 T3NspqeDH8ftLBaGzjarwxBpGQ3IRYk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-_Gfhi6_BPhOTQMK7QwT9wg-1; Wed, 08 Jul 2020 02:45:53 -0400
X-MC-Unique: _Gfhi6_BPhOTQMK7QwT9wg-1
Received: by mail-wr1-f69.google.com with SMTP id s16so38058710wrv.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 23:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pKVHCXlZTjIMREE5P/Tiro94AC+MkeW88RwdRl8MPJ0=;
 b=YcUFw5vjXyTf7XkgCQzVLdodpnmE1em2SuaeDdo1acNIzZ6SA38QU7T1nbqXpt90yV
 MyhyI0OeRg8A8/1h+eM/SkoQEGkys74xEiGvqneUEEyj4fvbqcbcYk0VhOxIG7DgMX2W
 mjjGGobLd5zY4ubaGWUPn2cLfOFnVXIXT+2nJLtNCR0rXt5MFWYvPxC5/MHDUjd0D/jI
 i6bk3pBnbq9d+NtAm2zoAt333DwkfYn0eVNiJdwTKYCxYgjemD7E7KotZGFpF0l41B1q
 rP0zGHOkkVwIdV/YVEild3w0aZGeXdGsxg1kHemoxPszlhT6drKsSFXjFRQCHH6K1Hqo
 ncDg==
X-Gm-Message-State: AOAM533FOvZ3b3+/1xmBZElCue19UrjPhKuVoaK43cJxeJGLGece/YEA
 O41Xdm6MeXxTE5tgfXbe40E6zAYdcIDCepYo7R+apuy6D9x/jj8Ny+S4JMEyNG0mRejgthxtfJ0
 SfjHiyXE5u+v7MuQ=
X-Received: by 2002:a05:600c:2483:: with SMTP id
 3mr7654815wms.120.1594190752254; 
 Tue, 07 Jul 2020 23:45:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6JuoUb2eFyyPVJiuoRu5tFSrwTeuXAvi0XiQcqj/EkG0TdQFAIaEf4w9QCrwMqhl3vT6oWQ==
X-Received: by 2002:a05:600c:2483:: with SMTP id
 3mr7654800wms.120.1594190752042; 
 Tue, 07 Jul 2020 23:45:52 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 b62sm4550803wmh.38.2020.07.07.23.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 23:45:51 -0700 (PDT)
Date: Wed, 8 Jul 2020 02:45:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/41] virtio,acpi: features, fixes, cleanups.
Message-ID: <20200708024528-mutt-send-email-mst@kernel.org>
References: <20200704182750.1088103-1-mst@redhat.com>
 <CAFEAcA_LrhvLmbwsSrhHUYZ+z9EZoDZwct+s3xfoaGLyLkOPfg@mail.gmail.com>
 <20200707080049-mutt-send-email-mst@kernel.org>
 <CAFEAcA_th3hhXcnyt2qV+rQNV1PgF62B5+=sEWzJKfHYj2=ooQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_th3hhXcnyt2qV+rQNV1PgF62B5+=sEWzJKfHYj2=ooQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 07, 2020 at 06:50:55PM +0100, Peter Maydell wrote:
> On Tue, 7 Jul 2020 at 13:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jul 07, 2020 at 12:40:38PM +0100, Peter Maydell wrote:
> > > On Sat, 4 Jul 2020 at 19:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > >
> > > > v2 of the pull, fixing non-Linux builds.
> > > >
> > > >
> > > > The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
> > > >
> > > >   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > > >
> > > > for you to fetch changes up to f7d98068bf7a0913744dd4ac0a28e8c841df2af5:
> > > >
> > > >   vhost-vdpa: introduce vhost-vdpa net client (2020-07-04 11:13:50 -0400)
> > > >
> > > > ----------------------------------------------------------------
> > > > virtio,acpi: features, fixes, cleanups.
> > > >
> > > > vdpa support
> > > > virtio-mem support
> > > > a handy script for disassembling acpi tables
> > > > misc fixes and cleanups
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >
> > > > ----------------------------------------------------------------
> > >
> > > Hi; I'm afraid this fails to build on 32-bit:
> > >
> > > /home/peter.maydell/qemu/hw/virtio/vhost-vdpa.c: In function
> > > 'vhost_vdpa_dma_map':
> > > /home/peter.maydell/qemu/hw/virtio/vhost-vdpa.c:48:23: error: cast
> > > from pointer to integer of different size
> > > [-Werror=pointer-to-int-cast]
> > >      msg.iotlb.uaddr = (uint64_t)vaddr;
> > >                        ^
> > >
> > > This should probably be "= (uintptr_t)vaddr".
> > >
> > > thanks
> > > -- PMM
> >
> > Precisely. Sorry about missing this.
> > I made this change and pushed to the same tag - don't want to spam
> > the list for a small thing like this. Can you pick this up pls?
> > Commit 849c48004df0e123b53fe9888770cb4f6eb5e8ab now
> 
> Sure. (You can always just resend a new v2 cover letter without
> all the patches; that's what most people do for minor respins.)

As a reply-to or as a new thread?

> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> for any user-visible changes.
> 
> -- PMM


