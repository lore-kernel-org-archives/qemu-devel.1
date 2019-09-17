Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06848C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A032171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A032171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHQP-0001Ro-0O
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan.streetman@canonical.com>) id 1iAHPe-0000ng-2O
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan.streetman@canonical.com>) id 1iAHPc-0007Rh-QN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:37:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
 id 1iAHPc-0007RT-LI
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:37:12 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dan.streetman@canonical.com>) id 1iAHPb-0000ke-GB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:37:11 +0000
Received: by mail-io1-f70.google.com with SMTP id w8so3176521iod.21
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 10:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Epua/xMq8f6aVEnr9HY05++l6qAElp/isFMFGxNBBao=;
 b=asZdl1zVx30LSJHeeIsVAmFC6sySSjObBcl8vg21O5oBPass3vu8Q/zvpN6Kfqm8t5
 aObWbi5vfvUJsUbychEWx3TdZj2ZeR2m7emYRvILU+ydq3UzZyknboky6+4NLdHSA/EA
 g2CLJz3dBglXi8tcB3EyHDXH6O5rBQx5pkFcP6J0vbew/Ecix+niGkGryCdLtJmzMp1i
 LpMSOKnba6Sug1czGXZ/H1k4s2PeNtxSfL7GbOov3a/vp4QxI7lC/hUQ5s14ywKIFEJP
 ihxxh6liUf3oeOV7DpewTmwjBTuWwzy9aalKELAlrU8m4CfLjlUSJkZqY6RAkNhK2/xI
 UzzQ==
X-Gm-Message-State: APjAAAWg6TtIt0SaND3JqsrFAplZzGGmliQnwuY3WLgMmjl7F70F8ywh
 j1PVnvDxgu9nF9E/jEvsglqXCVcQyWiXc44pzfymWxt1vzbw407S62/n2jer1icXh9tOfuWP2JP
 ZisJmwyVP2wSGHC05p50xQINFZP0zjqJnJp+EUIzFhtFKThAt
X-Received: by 2002:a6b:6110:: with SMTP id v16mr5108256iob.199.1568741830442; 
 Tue, 17 Sep 2019 10:37:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPoyzZFuCeR6YA9tNJyC3xzN7W4jG7BYaKCpnU0oR8vbVl9O/odjvuXaWKWXDwVCbiBwl9pgU1e5j+o62+kW0=
X-Received: by 2002:a6b:6110:: with SMTP id v16mr5108221iob.199.1568741830026; 
 Tue, 17 Sep 2019 10:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190917172422.5134-1-dan.streetman@canonical.com>
In-Reply-To: <20190917172422.5134-1-dan.streetman@canonical.com>
From: Dan Streetman <dan.streetman@canonical.com>
Date: Tue, 17 Sep 2019 13:36:33 -0400
Message-ID: <CAOZ2QJNrEYoHme=O4H4H7PdfAMobqzFDpcdNZwZn6q-cSTTJrw@mail.gmail.com>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
Subject: Re: [Qemu-devel] [PATCH] hw/arm: set machine 'virt' as default
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 1:24 PM Dan Streetman
<dan.streetman@canonical.com> wrote:
>
> From: Dan Streetman <ddstreet@canonical.com>
>
> There is currently no default machine type for arm so one must be specified
> with --machine.  This sets the 'virt' machine type as default.

just to clarify why anyone would care if there's a default or not, in
case it's not clear, I have a bit more reasoning here:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1844357

Specifically for my use case, I'm enabling systemd's unit tests to run
on Ubuntu testbeds for different archs (x86_64, i386, ppc64el, arm64,
s390x) and arm64 is the only arch where we need to specify a machine
type; all the rest have a default machine type that works fine.  I'd
prefer if we didn't have to specify a machine type for any of the
archs.

For reference, this is the systemd PR to enable use of qemu for all
the archs we have testbeds for:
https://github.com/systemd/systemd/pull/13409

>
> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d74538b021..e9fe888ca2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -78,6 +78,7 @@
>          mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
>          if (latest) { \
>              mc->alias = "virt"; \
> +            mc->is_default = 1; \
>          } \
>      } \
>      static const TypeInfo machvirt_##major##_##minor##_info = { \
> --
> 2.20.1
>

