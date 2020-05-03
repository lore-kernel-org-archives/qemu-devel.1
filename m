Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A24C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 19:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B773206EB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 19:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKq4OPdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B773206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVJv8-0002Ch-Be
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 15:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVJuW-0001f2-4Q; Sun, 03 May 2020 15:04:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVJuU-0007Yn-H9; Sun, 03 May 2020 15:04:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id d15so18328941wrx.3;
 Sun, 03 May 2020 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=41/IStyiu74sSS/aN+F7TBYubDOeaoaS5GLBPdHLcFI=;
 b=aKq4OPdWqpiAgWySCtJTu0nj9ZvfSWqM+HPdbm9n7mSml8ktbDo59K+NSdRUROwT9Y
 B7mp1Nr/Erhhst3By9oiCII7BNI45itli1LlvNSCWaVAvLT+ibAT5rgGKt9eUG2mUu4r
 JrmMnXpIdz0niLiV8VoB+s3l/df7g0wNrDVBVrWI5++JW0Lezq+dA0/0xhHMwEKEbZIs
 hR/9ydTJloTtl/NJr3GBheBtVve+1MDoj6ydd4I4yRdzIdVmZ3ZoaLuu2mqXPGmDdbrJ
 yDYZQI6nO1bliZiSuxKASSiGjCGxpa5BSQ3A2+GclPn2WuyuksSCbKBxlSlsjknoKGGn
 ADJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=41/IStyiu74sSS/aN+F7TBYubDOeaoaS5GLBPdHLcFI=;
 b=IEeEw85rb98zz/UVlKr5Cg7q2S8dG7rNcXaQV/D1sziIwC3Xu6KwAEqIiGUBJmuB0Q
 WDTIlopjK37tpZR+PghAR0NUyl0PAfGzzTHli27fjrCtJvXtA9eGJyOr9HeB3Euc7SRc
 iOvQdCPw4BjvZtLW50v/1TB+qCETL53vTYny2Z7eGjvB986MVdRHazMknFrY5vsQCHJZ
 4bebUT2NjpRWn0Hrlq03D887DbIBF59iOMAUvA5hO6LWMLLurHL3wBAfH/KMKYMis3vZ
 OcruAlGqNUy2MM17v133JmZctOLjxBky2nQJuLYi9ZeESF8cUrX4zakJn4E9rssGH244
 cyaA==
X-Gm-Message-State: AGi0PuZAy1pH1psQXxSDEQXiI0HyEtslOh8X9aVyNEHQOzqzuh5ff92l
 HHAT1wN8Mk5ZCdoFc0tQPNMQZKiFg7PjC8kBnqU=
X-Google-Smtp-Source: APiQypKVHBS+NXaSXJ/llFw3TFvsp7OLD8sD2dlBPmYU353zmN6OnIeoCUOeDGofWdlmHfE5onw8yzwZTkdDaKQGk+c=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr15106994wrj.329.1588532656614; 
 Sun, 03 May 2020 12:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200503113220.30808-1-f4bug@amsat.org>
 <20200503113220.30808-3-f4bug@amsat.org>
In-Reply-To: <20200503113220.30808-3-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 3 May 2020 21:04:03 +0200
Message-ID: <CAHiYmc6LC7B=Ce9a746emqqGbYCxtacFGd=TRBCzJiktRNWcXg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] linux-user/mmap: Fix Clang 'type-limit-compare'
 warning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +#if TARGET_ABI_BITS < TARGET_LONG_BITS
>          /* Check if address fits target address space */
>          if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {

It would be clearer if "#if  TARGET_LONG_BITS > TARGET_ABI_BITS"
is used, to match the comparison in if() statement.

>              /* Revert mremap() changes */
> @@ -721,6 +722,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>              errno = ENOMEM;
>              host_addr = MAP_FAILED;
>          }
> +#endif /* TARGET_ABI_BITS < TARGET_LONG_BITS */
>      }
>
>      if (host_addr == MAP_FAILED) {
> --
> 2.21.3
>
>

