Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2C8C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6712206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Poq2QcOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6712206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKxd-0002Nb-0Y
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOKwZ-0001UT-Rz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOKwY-0001JN-JR
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:45:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOKwY-0001Iw-Ac
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:45:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id x10so845235oie.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AkfPSPy9W9FIAxm7JRvsw3pq1PzwEFG5B6DYkcdninI=;
 b=Poq2QcObwxIrXNFFFlVf5R7sHELn53c3MjjBITAYNX3b6yQhjOeQRw/x4DmIB9jZN+
 YUUtlLAtiy9gkjf0ZQFsuY4w+Ct1Pn+ALTLddtqYLl4NY0JgqlbU3yfNeWh/4MRbnrpk
 fBBvvED1+nCBiU//CUg8jYUvCEiLZ4Ttyjx3H1dQowkvTs7+uCAyFqr7N+j96YRsYu8B
 lcOSuKfo1i8TSRW40jx1QKMVxIHz2C9Pwrbhb68lU/bcA8XCxwnh0LTt9cb6usFwGBJo
 kHcb0IjNGfp6CjpJy6bh1QwHRHFYsQjeiXbIRJml5BLC3MnB7J2p4ocO59SzzmgdRWHb
 v5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AkfPSPy9W9FIAxm7JRvsw3pq1PzwEFG5B6DYkcdninI=;
 b=sLJ+cyvRngP68o4K5fCzSAwiTJrM69g++4dcbbtW7yeNq0N4FLaERgpI6PKrq5YqCp
 2tQQdklF0Cf3BuUwndRqAJ7001gNkCSU0865CSq3AjK04mNNkhqgEW+A20LDORF9xI9M
 SgdH00tbg98zzl/cuN1X2niPCd2VweE0oZcr9HE6q/4ryNLwGi6748nZjNgpx8rn2eCy
 8DBMI04V5O7PLu1A9iVS3/qvhvxn0cXhfajq7Pi2wNkY1NtRbOiVBWpZjgmetRbreOxi
 oAnG3aG024X8qchT942vC2/FIPYzflj6GAJOr2ZqsT4gMUxvBZUUeB1PvrMR8OrgUB08
 fKJg==
X-Gm-Message-State: AGi0PuYNd9i1ibnQwVDVruROVOJ3BBvBmLisuM+f0+6Rd2kd63KNhNyV
 3Hcfy4EFobwVG2/+SKK8U0y83MawfQEtD1YBLSZDiH1N2NQ=
X-Google-Smtp-Source: APiQypL3dItnKw/IH/U4BFlEoMCO6ItIIWdR8lpksm5vXnEt52P6Rtc7brBSPJlekCmiT8BPEG9ry33kSTUEwC4q6DQ=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr756318oig.48.1586868333386;
 Tue, 14 Apr 2020 05:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <20200411182934.28678-4-peter.maydell@linaro.org>
In-Reply-To: <20200411182934.28678-4-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 13:45:22 +0100
Message-ID: <CAFEAcA-HGkSFYzCyb-NFmoFp=Kiw+NmZ3foA4WteNbRCXy0Nng@mail.gmail.com>
Subject: Re: [PATCH for-5.0? 3/3] kernel-doc: Use c:struct for Sphinx 3.0 and
 later
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Apr 2020 at 19:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The kernel-doc Sphinx plugin and associated script currently emit
> 'c:type' directives for "struct foo" documentation.
>
> Sphinx 3.0 warns about this:
>   /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/exec/memory.h:3: WARNING: Type must be either just a name or a typedef-like declaration.
>   If just a name:
>     Error in declarator or parameters
>     Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
>       struct MemoryListener
>       ------^
>   If typedef-like declaration:
>     Error in declarator or parameters
>     Invalid C declaration: Expected identifier in nested name. [error at 21]
>       struct MemoryListener
>       ---------------------^
>
> because it wants us to use the new-in-3.0 'c:struct' instead.
>
> Plumb the Sphinx version through to the kernel-doc script
> and use it to select 'c:struct' for newer versions than 3.0.
>
> Fixes: LP:1872113
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/sphinx/kerneldoc.py |  1 +
>  scripts/kernel-doc       | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
> index 1159405cb92..3e879402064 100644
> --- a/docs/sphinx/kerneldoc.py
> +++ b/docs/sphinx/kerneldoc.py
> @@ -99,6 +99,7 @@ class KernelDocDirective(Directive):
>                  env.note_dependency(os.path.abspath(f))
>                  cmd += ['-export-file', f]
>
> +        cmd += ['-sphinx-version', sphinx.__version__]

Using sphinx.version() might perhaps be better: it gives you
a tuple of 5 elements rather than a string. OTOH passing the
tuple through to the Perl script without reformulating the
string and re-parsing it in the Perl isn't easy...

thanks
-- PMM

