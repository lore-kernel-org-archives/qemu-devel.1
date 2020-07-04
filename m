Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FEC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786B420724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iML7Ol+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786B420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnFA-0000Rl-M9
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrn1v-00082z-Se
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:36:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34280
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrn1u-00032G-5u
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oE/PPR0E6nARTK8boCBJKqqJeqCJbIE2MIJ2Y6X62Hk=;
 b=iML7Ol+pVSEm5nGiMrmWNBJEr/DU82RuHRgD5IJb0oCt7mLXMWLN2QdneyF9k74AG7PXnr
 1XGxT5P0Es6vPBiJ9FC3KQF2nKGb4MLg5M3RRKzU89B1OTJHndNtQbs+o89TF0a3TGDIIp
 peDbVWixVuVoP4JZrg2Q0yqVBmBoL6o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Q6MZ1fSDMEWnFcNrNCRa9A-1; Sat, 04 Jul 2020 14:36:47 -0400
X-MC-Unique: Q6MZ1fSDMEWnFcNrNCRa9A-1
Received: by mail-wm1-f69.google.com with SMTP id g138so31395815wme.7
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oE/PPR0E6nARTK8boCBJKqqJeqCJbIE2MIJ2Y6X62Hk=;
 b=P5+ejFZc+lo+X+NS+O4F7h6IYghQKZPHpTV4NVJVejuRSsDKgC8qp651W6Jnk+dYxJ
 6qw4DL9kf0dx0Z/l7uQmcWX8RHtXtwoP17jm8KMrouhRhADILY+a3OfqQnOBwJRgZAso
 jVxzf3EFvKRdtCpheM0j3IFaKbx8ewLhJzMQwGA54tpK1lqrmTfogjQ2hlBegeYkY8GK
 xoMNLcWJi2Z4k7ZMMlO67IcdX4aFngwBp66cPVXNv7MaKlu2+DEOjvFFJl099CpjaEWD
 th05tP4J4FhUAazh1xsm81hsLS4E5w56+2zLt6oKA608z/y1GERoXRT2iUntlTiIlY1U
 CyLQ==
X-Gm-Message-State: AOAM530hRwv1tt8NX68eeuz9hwUBXh1g/1Lh5w5QS/XtF/O1IzlAswvl
 ZZ6azCVA7gwlM4O+BL94LW4iPKCrIjG4ahDRvhtS85W1RMiq3sghu9bCkolrp2X2EAPxyAb3gBZ
 Y0CI7Xnhulmx0gpc=
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr12930317wro.245.1593887806747; 
 Sat, 04 Jul 2020 11:36:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKML8y17U0AoKaZpwd58avTE3kM5CyrkXiimb97wmPAfQQm5C+P5hDIuF8UEERkIKWZYH4ig==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr12930306wro.245.1593887806544; 
 Sat, 04 Jul 2020 11:36:46 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 g14sm17464950wrm.93.2020.07.04.11.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:36:46 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:36:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/41] virtio,acpi: features, fixes, cleanups.
Message-ID: <20200704143553-mutt-send-email-mst@kernel.org>
References: <20200703090252.368694-1-mst@redhat.com>
 <CAFEAcA8gW6yGD_g7LLR9BeuEehtSWb+x3iPvDg+zbVr77cn-pg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8gW6yGD_g7LLR9BeuEehtSWb+x3iPvDg+zbVr77cn-pg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
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

On Sat, Jul 04, 2020 at 03:05:19PM +0100, Peter Maydell wrote:
> On Fri, 3 Jul 2020 at 10:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
> >
> >   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 900ed7043750ae3cdf35c05da66e150a8821c3a0:
> >
> >   vhost-vdpa: introduce vhost-vdpa net client (2020-07-03 04:59:13 -0400)
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
> 
> Hi; this fails to build on OSX and the BSDs:
> 
> In file included from /home/qemu/qemu-test.TcQYno/src/hw/net/vhost_net.c:23:
> /home/qemu/qemu-test.TcQYno/src/linux-headers/linux/vhost.h:14:10:
> fatal error: 'linux/vhost_types.h' file not found
> #include <linux/vhost_types.h>
>          ^~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> thanks
> -- PMM

My bad.  Send v2 fixing that. Thanks!

-- 
MST


