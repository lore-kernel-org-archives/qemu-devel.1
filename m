Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACDC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8D5224B0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAcZ9Fco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8D5224B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKlz-0006wa-Bx
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvKlN-0006WX-S3
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:14:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvKlL-0005th-Tl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594732461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UVynx+pYYI8hMOJvagpnjCWGxbTQN18jeq/lFh8gjTk=;
 b=RAcZ9Fcoa/M0cb5hBIM3uTQQmWa8Hsp85xFunQ9lebM3ewrDH6jZuvm/6Z0+Vsu4iAMYv3
 ZUZ4eXqAloNup/eZ04SKIf+t++fRXW+V3uTXRr8SM3pP5eZztPT+Fvevo1OelcCfSPgA2L
 Wntu8Ouipi9mWkm94GK/oLl4Y4yA7Zc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-qM0z7tGXOrKQKX6nxl5CSg-1; Tue, 14 Jul 2020 09:14:19 -0400
X-MC-Unique: qM0z7tGXOrKQKX6nxl5CSg-1
Received: by mail-wm1-f69.google.com with SMTP id c81so3918726wmd.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UVynx+pYYI8hMOJvagpnjCWGxbTQN18jeq/lFh8gjTk=;
 b=IdU/jKZR4BQ3hvWu0kU+Qua8sdUaWmbd/yD+DlhWLm5CUe2pvpXe3Hu9Q286ZFp5mn
 JDehspfOkpf5y0xpLpijmKYETD9J+5HI9/NzP06MTdg88V2HO79bVlqjBo7lorO1vcdy
 DMHHdhn3TNwnbede3LSE0xlM4jJNup0boTnAKxzC1HH1ZgjJssJyZrRDEEZ4P2QEBv8Y
 cYW+euPEaRdaH1kIJhnWmeOE9mbhkjSzysMyhy08Mtl9xTH5DHjlEkrSdNTXwuaryT9E
 6t9thCX+eGOFx0Ryg5RRUCXthgn9gf6zD2MqUYDgcY4wf70idDu5XNXXLNl8pOqlouZf
 7odg==
X-Gm-Message-State: AOAM533avtRrofbDM/AgoXe2jZRXIYc+ZcyRPu0UxNHysJgDfpbM4WrP
 eE2HiKaZ6nao6n7VUpPzkLI+jl2wAiOgF7ptot+Au4xZ9hPTI049qS5pXF14Rur1Ah9XjDmxhiS
 exR47PJKhcS7U0TA=
X-Received: by 2002:a05:6000:46:: with SMTP id
 k6mr5407854wrx.102.1594732458365; 
 Tue, 14 Jul 2020 06:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgIPAEEMwyD06+H+HsCtq4Gj+UVOJim8lL66kgJnsK8MX70Kdt+82xbFaS+cS1sPct26h9Fg==
X-Received: by 2002:a05:6000:46:: with SMTP id
 k6mr5407717wrx.102.1594732457215; 
 Tue, 14 Jul 2020 06:14:17 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id x9sm4444334wmk.45.2020.07.14.06.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:14:16 -0700 (PDT)
Date: Tue, 14 Jul 2020 09:14:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon John <git@the-jedi.co.uk>
Subject: Re: [PATCH v2 for-5.1] acpi-pm-tmr: allow any small-size reads
Message-ID: <20200714091310-mutt-send-email-mst@kernel.org>
References: <36e5f632-8b08-d6bc-0092-e53f42f69ed3@the-jedi.co.uk>
MIME-Version: 1.0
In-Reply-To: <36e5f632-8b08-d6bc-0092-e53f42f69ed3@the-jedi.co.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:06:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 01:51:45PM +0100, Simon John wrote:
> On Tue, 14 Jul 2020 07:10:14 -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 14, 2020 at 01:51:13PM +0300, Michael Tokarev wrote:
> > > As found in LP#1886318, MacOS Catalina performs 2-byte reads
> > > on the acpi timer address space while the spec says it should
> > > be 4-byte. Allow any small reads.
> > > 
> > > Reported-By: Simon John <git@the-jedi.co.uk>
> > > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > 
> > Simon's explanation about the history is good to have here,
> > and I guess Fixes tags (both what you found and what Simon found)
> > can't hurt either. I would CC stable too.
> > 
> > Simon do you have the time to iterate on this patch or would
> > you rather have Michael do it?
> 
> Sorry, I seem to not be getting all of these emails but trying to watch the
> list archive.
> 
> I just tested Michael's v2 patch and it works fine:
> 
> static const MemoryRegionOps acpi_pm_tmr_ops = {
>     .read = acpi_pm_tmr_read,
>     .write = acpi_pm_tmr_write,
>     .impl.min_access_size = 4,
>     .valid.min_access_size = 1,
>     .valid.max_access_size = 4,
>     .endianness = DEVICE_LITTLE_ENDIAN,
> };
> 
> I'm happy for Michael to proceed with the patch, he's mentioned me and
> linked to the launchpad bug where the history is.
> 
> Regards.
> 
> -- 
> Simon John

Great, thanks!
Michael so I think the patch is fine, just some nitpicking
about commit log and comments. If you can address and repost,
that would be awesome!

-- 
MST


