Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17341C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E9620685
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGcRCS7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E9620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzkN-000319-7J
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:02:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hIzjE-0002fh-0N
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hIzjA-0006es-JN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:01:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hIzj1-0006Z9-Qe
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:01:02 -0400
Received: by mail-oi1-x242.google.com with SMTP id e5so12066385oii.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=jkrRazVTlUSzDFeSVFyCiA1Z8GYMHO7tlPqGsN2Oc58=;
	b=lGcRCS7qVL0mnf80vTyLY0r+qmpQ0VTtsrQUaJlimhF96F1H89IuhZOIvBI3JCvoQT
	NsNWtqkQVPsA0O0hzOe2cFYxFd5E0Dd+aL02F15y5a0HJrpsytG/O2Oo5RT02+98ofJs
	BmlH7V/fKgiZwTh3XaUu6/hj1ouULh2ToZME2z/eZCsJ4YRs8mxaftWZC7l6Cs0YxW66
	w9Yi8C1o6dPQqHv/lWVcIvMdFSwbY8dSSFOeUL5uzxd9Idq0krjPnNv9Dol/gtnG91LT
	AhtOfWCHHeKJYzWqLW2EUHlfeq8/ZPNKSu7YncLisMXLPfaYJ7QQzhyBmgvppP57vb0i
	NGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=jkrRazVTlUSzDFeSVFyCiA1Z8GYMHO7tlPqGsN2Oc58=;
	b=kc2rSjHlMbVxwgUxw5Wsm+csqr6D4T39X0zg5N7Ho+wovbL/mqmd5KohDfXMHVumIm
	+lsgXpEeCKq1r8CBIr0x62XND368vo5ZcVvaBrpabHkT0WLNVgYlBA00QS+XWg+kFR2G
	N/TfISK7ljxrXhdmtRNk9W2AB+I3oao4yM0lkrSYS1xUpHDUFd+X4DXeSEXhFJ7CjUHz
	MpDAy8dx1sA0L4Upapmn7by92Shlg3hNlHvhhIlGHLSg6SE27EhuygFhntFdFmeCui3K
	cOanR3/QzTXxjl9Fv81pnWCSHYh2TNStgX9xfDFqPCT58OO+eQbcscXtm/I3+6WQUlgL
	SrKw==
X-Gm-Message-State: APjAAAUstewEKj92jZq1l46nuh6S+e+tdLgWn4KLEybVfZyvXELZLbya
	6D12jf+sU0vWmm9lP3q60NCfV1k2VjyYJ1NTY4o=
X-Google-Smtp-Source: APXvYqxPtUuQw0eueaXTdFhY0Yq+xDzmEWjkkcfaXQD77WmfrdiflbjgFHZhH0nShS/TvD0iREX9z42+VR7/bQN4K/U=
X-Received: by 2002:aca:4fc4:: with SMTP id d187mr1748060oib.62.1556042453165; 
	Tue, 23 Apr 2019 11:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190417194821.23017-1-daniel.santos@pobox.com>
In-Reply-To: <20190417194821.23017-1-daniel.santos@pobox.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 23 Apr 2019 20:00:42 +0200
Message-ID:
 <CAL1e-=jNcnCgdQM7+qYM_fArLLUET-KtyHEGDboPK_pXqYu+=g@mail.gmail.com>
To: Daniel Santos <daniel.santos@pobox.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH] mips: Fix "Unexpected FPU mode"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423180042.XKMbC-oU1lkTVLfa9A6Xm-EyMrVnETSUxwD9UPN5Z5I@z>

On Wed, Apr 17, 2019 at 9:50 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>
> In load_elf_binary, struct image_info interp_info is used without being
> properly initialized.  One result is that when the ELF's program header
> doesn't contain an entry for the ABI flags, then the value of the struct
> image_info's fp_abi field is set to whatever happened to be in stack
> memory at the time.
>
> This patch both sanitizes interp_info and initializes fp_abi for
> TARGET_MIPS to MIPS_ABI_FP_UNKNOWN so that when we don't know the FP
> ABI, we don't just blow up.  Currently, this bug is a complete stopper
> for some MIPS binaries.
>
> ***PLEASE NOTE***
> There may be other bugs as a result of struct image_info interp_info
> fields not being properly initialized -- this patch only addresses the
> fp_abi field.  I reccomend somebody who knows the code better than I
> audit this function and the whole of that execution path.
>
> Fixes bug #1825002 and affects 3.1.0 and 4.x, reccomend backporting to
> 3.1.0.
>
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> ---

Daniel, not knowing that you already send this patch, I included it in another
series (with different title and commit message, but the same content):

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03813.html

Please let's track this patch there.

I will change the commit message to bring it closer to the yours version
in the next version of the series, and I will review the patch from MIPS
point of view.

Just advice for the future: Before sending patches to qemu-devel,
check what are maintainers for the applicable code. There is even a
script for that: <qemu-root>/scripts/get_maintainers.pl

There are also other rules and conventiones, and all of them are
mentioned on the page "How to submit a patch" on QEMU web site.

But, in any case, many thanks for discovering and reporting the bug,
and even devising the fix!

Yours,
Aleksandar

>  linux-user/elfload.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..7f09d572a2 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>      char *elf_interpreter = NULL;
>      char *scratch;
>
> +    memset(&interp_info, 0, sizeof(interp_info));
> +#ifdef TARGET_MIPS
> +    interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
> +#endif
> +
>      info->start_mmap = (abi_ulong)ELF_START_MMAP;
>
>      load_elf_image(bprm->filename, bprm->fd, info,
> --
> 2.19.2
>
>

