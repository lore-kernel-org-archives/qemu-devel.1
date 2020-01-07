Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D13C33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333082081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9FmmKgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333082081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionPI-0008Jw-Qz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iomEw-0001Jb-IK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iomEv-0007HS-6k
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:37:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iomEv-0007Go-0E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:37:33 -0500
Received: by mail-ot1-x341.google.com with SMTP id i15so8215239oto.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t3qwPXT9p7cy8baY/HD1tlyhWXo+nF5zeMf9AINIWe8=;
 b=T9FmmKghVH0A+OKwu3l2SFN19n1GdF+EE+w+6CMq7E2AkZaN+CbG0+lVv1sHq+2c5d
 hsnSGkyX47Gqnd5n8sa8gHUhx7riS03a1f2DsfEkMeSsf3TGVq/gpao2d9uUrN2G2jQj
 xXh+yPzZmgU38R9hGzRgfBUPukqIHyuwDql7tEczbjVobI7j6sAkJhbojzQmT5J8JB/z
 ZC39UYDDeOCMqxlJdh3aYiEhbfLaX2svQIuimlXbS5GewqatzCLdhKZJFqASQw0o9HKw
 AqlI0cP0+a8Di3+lzu9dSz/duij3xcK8yqj/WhD8CRmxpkVsbeUrmzijLWSa0LmuWEhK
 ZkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t3qwPXT9p7cy8baY/HD1tlyhWXo+nF5zeMf9AINIWe8=;
 b=AIcG/G7wtbiDf8is5rEVyytF2ePnxbddgAchh/TXQBwXbJFQgOKpfvS6+7nFdUmsG0
 /qNU86wgOS6taNe6IOBvFHuvUgTEkuXoWfYnHZjhSgpknwD3xa4tmt/5aZYJdNffGJCf
 6FSl553vqGIPE1ouPQLdA1JsTgj4hQ/+fpA9xQAAelwDbeHG4Ixla3oQ894Vf5r/XSqA
 toZveEbPJw5XtstH1MfsZEuuhy0UprHeKZYz9fh5jPun5ZOGdbTiBTfKs9Px0tHU85Q7
 bL3nuWaeJUvBtG0eMaYUaeYL7/JhSvhgtuI4Ovl2xgO4LFkjLCRv8nP3puVpL9II27dy
 Y8Rg==
X-Gm-Message-State: APjAAAXCOmt8kpS5XnVk2TG4QUNI3pnRC5vpoiOD3OC10Hu4IGgFo0f4
 8kFR0V9yu2fHigjBVsCOjrmacMYgy8Wol9slwfsQuiA0Yp4=
X-Google-Smtp-Source: APXvYqz8Xz/RsFiCXx6qhGE89+jJSQl8w9bOQzIBVL+81h+6btmZd2oKVXLUgHcWp71DmLMYW34yU457JeDX/seNjhA=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr46349otq.97.1578393451691; 
 Tue, 07 Jan 2020 02:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-58-danielhb413@gmail.com>
In-Reply-To: <20200106182425.20312-58-danielhb413@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 10:37:20 +0000
Message-ID: <CAFEAcA-c-RGWartF61zGGszs8CFH3TxZyBeKR71Sn+A_0OnDqQ@mail.gmail.com>
Subject: Re: [PATCH v1 57/59] linux-user/syscall.c: fix trailing whitespaces
 and style
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 19:19, Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
>
> There are trailing whitespaces in this file that, if removed
> by a text editor that refuses to let the traiing whitespace
> alone, which happens to be the editor I am using, will cause
> checkpatch.pl to warn about styling problems in the resulting
> patch. This happens because the trailing whitespace lines
> are using a deprecated style.

You should fix your editor to not do this kind of uncommanded edit
(otherwise you'll be spending forever trying to sort out
unasked for changes from patches you write) but the style cleanup
here is reasonable.

> To keep the intended change I wanted to do (remove unneeded
> labels in do_ioctl_blkpg() and do_sendrecvmsg_locked())
> trivial, this patch is another trivial change to fix the
> trailing whitespaces and the code style errors that
> checkpatch.pl warns about. Doing this change beforehand will
> keep the next patch focused just on the label removal changes.

> @@ -1526,10 +1526,11 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
>      abi_ulong target_cmsg_addr;
>      struct target_cmsghdr *target_cmsg, *target_cmsg_start;
>      socklen_t space = 0;
> -
> +
>      msg_controllen = tswapal(target_msgh->msg_controllen);
> -    if (msg_controllen < sizeof (struct target_cmsghdr))
> +    if (msg_controllen < sizeof(struct target_cmsghdr)) {
>          goto the_end;
> +    }
>      target_cmsg_addr = tswapal(target_msgh->msg_control);
>      target_cmsg = lock_user(VERIFY_READ, target_cmsg_addr, msg_controllen, 1);
>      target_cmsg_start = target_cmsg;
> @@ -1610,8 +1611,9 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>      socklen_t space = 0;
>
>      msg_controllen = tswapal(target_msgh->msg_controllen);
> -    if (msg_controllen < sizeof (struct target_cmsghdr))
> +    if (msg_controllen < sizeof(struct target_cmsghdr)) {
>          goto the_end;
> +    }
>      target_cmsg_addr = tswapal(target_msgh->msg_control);
>      target_cmsg = lock_user(VERIFY_WRITE, target_cmsg_addr, msg_controllen, 0);
>      target_cmsg_start = target_cmsg;
> @@ -5592,9 +5594,9 @@ abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr)
>      }
>      unlock_user_struct(target_ldt_info, ptr, 1);
>
> -    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
> +    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
>          ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX)
> -           return -TARGET_EINVAL;
> +        return -TARGET_EINVAL;
>      seg_32bit = ldt_info.flags & 1;
>      contents = (ldt_info.flags >> 1) & 3;
>      read_exec_only = (ldt_info.flags >> 3) & 1;

Doesn't checkpatch complain about not having braces on this if ?

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

