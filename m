Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F01C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E89C20780
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG5ulUJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E89C20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcJf-0005OM-UK
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqcJ9-0004y2-00
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:57:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqcJ7-0004nc-7C
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:57:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so23720692wrn.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+nVhX7NB8wrnS9Nqox5TTJZx8RmFdgWv4sx0QvDxxFo=;
 b=cG5ulUJ0e/WSzASkDW53WR2D4hF+dgHY3+Ay+RDhMKpFFsWYgqUuRZoxrW1kX8g7/s
 U4IQ6dxsBnDAQ9ImWyAtKGxnK5QKknKeQpPOL3hE+MwI5F40lGQ0Xva4s/FFxapM+uC3
 N3YKgHomczrd1yV2aGcLG1kGgO3olqGukEacEFIp+TWWFtC9MkNXBLSaBP1tGlZWeMgW
 U1M5u425bwWcN+C/OkK2pMEhkbolsOSiyvtGPH+7s2He7lWWDnAY71CfhLyybcye+Lcd
 rffb+Ro6Va+yHm9o7d0LjQdp18OsR83t1ra+mjJKHt7baT/gkDwojuKxUoQPni0txMoT
 xcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+nVhX7NB8wrnS9Nqox5TTJZx8RmFdgWv4sx0QvDxxFo=;
 b=mpPy/0jcvJByxBFbwKp/w3TZI0O1OIeJTyA50GlNB16H+TmgYHS55BSBukqSx9Y3c7
 7ozi15MBML1arHmp87P7hW8EHsamZ+BJ127g4EyP5xD4Ruq33Dlu3LEWeesnRl2wYGlm
 Eq+LRvZkw7dM9W+5L2EJcBRrfR5MnE6MolWq6KOACQaDgevc3HSFNCJorJ57O+u3twAU
 82+nUWYVVgId3rQ0ZVvt7gsGtfpaIWF0ufGJ0b9CvSri2zCv7alsObOBnZg6ilkfOwm5
 E8/Bq3fuxrfGAKG7hjjEmdMJaOM1cg3mquu5bMWsLxwFZ7dqJ1NyHhpxeR5KK4h4uaho
 BiQA==
X-Gm-Message-State: AOAM530sIBzwRd3rgjPjU2TB5VbKfVoXd8Edv3/qIWJ04Hu7b6dwG2/0
 kJWovR6cfNxdulYYN/XbI+g/dY4w4d/R2x7xLJYbgg==
X-Google-Smtp-Source: ABdhPJzY8HpiDaGDsTfGYKJ6Yqh3yJHXWmEZ3OUYVpowt6rdtqDHzs8TF5bd5tZb1Sr4NyGzqGB7QZFEn/Nsq6FVOhg=
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr3531336wru.147.1593608262755; 
 Wed, 01 Jul 2020 05:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
 <20200620133207.26849-3-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200620133207.26849-3-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 1 Jul 2020 08:57:30 -0400
Message-ID: <CAHiYmc4UsWEwxxXJn1i0ebgjwXKf5R_ntq5+qebqEr791UPy1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpatch: Change occurences of 'kernel' to 'qemu'
 in user messages
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 20, 2020 at 9:32 AM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> It is odd that we inform user that, for example, his current working
> directory is not kernel root, when, in face, we mean qemu root.
>
> Replace that and few other similar odd user messages.
>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---

Paolo, Stefan, Michael,

Are some of you willing to select this patch for your queues?

I could include it in my mips queue, scheduled to be sent soon, but I
certainly don't want to be seen intruding into someone else's area.

Truly yours, Aleksandar

>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c760c5a4a9..f46c18e413 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -49,7 +49,7 @@ Version: $V
>
>  Options:
>    -q, --quiet                quiet
> -  --no-tree                  run without a kernel tree
> +  --no-tree                  run without a qemu tree
>    --no-signoff               do not check for 'Signed-off-by' line
>    --patch                    treat FILE as patchfile
>    --branch                   treat args as GIT revision list
> @@ -57,7 +57,7 @@ Options:
>    --terse                    one line per report
>    -f, --file                 treat FILE as regular source file
>    --strict                   fail if only warnings are found
> -  --root=PATH                PATH to the kernel tree root
> +  --root=PATH                PATH to the qemu tree root
>    --no-summary               suppress the per-file summary
>    --mailback                 only produce a report in case of warnings/errors
>    --summary-file             include the filename in summary
> @@ -203,7 +203,7 @@ if ($tree) {
>         }
>
>         if (!defined $root) {
> -               print "Must be run from the top-level dir. of a kernel tree\n";
> +               print "Must be run from the top-level dir. of a qemu tree\n";
>                 exit(2);
>         }
>  }
> --
> 2.20.1
>

