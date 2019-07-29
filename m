Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5F3C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC3D214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHFjkf72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC3D214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs3TZ-0006MR-Da
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 07:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45950)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs3Sa-0005kc-3N
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs3SX-0003rt-Gv
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:04:55 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34]:41915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs3SU-0003mn-9O
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:04:52 -0400
Received: by mail-io1-xd34.google.com with SMTP id j5so114831775ioj.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ppt00K4j8Vz+GkS0e9lGuf1CE8Ko7RkCpCMHg+yWkHI=;
 b=eHFjkf72hFP6IyHPEK2jlgjwwuh+Jw+mUGk+ZLjs4XBend0vz71rI0szpvF0PFTNx/
 UkRV8+9PbtgxjvGfS/5z31SyCv2vwG8v8fdK8dGDD7n1YB+b/eFwt7JK+Q0oFjpIMYgf
 lUkF1//lDjddjUAunBUTufrlPv8kcGbW2LS4Ez/3fzqTgh+Jbj/PBpbwd6s+6ARGjAs4
 A5M1byj/xdudY0ONSyG3lmojOdUrOZ0fIwFg68g73WhnSXeKB4gZH4g4lTXBjP/1q17b
 hOFJcVuFpzxkrah9zpFcuhy/2L56U++iWPz5V1kRER5CTOhP8rtYNjZiI5Ol/e3/CSwn
 t8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ppt00K4j8Vz+GkS0e9lGuf1CE8Ko7RkCpCMHg+yWkHI=;
 b=nUMf8ZnfAXR4mC7gjXeb79EQ94MeUE7HR+pyOfChCbchsUyPzC15eHVCyoPP0hWo1i
 Kxeekzx92DHZCf/7JYxKOR5uWZS7dPPzzoCbsWa9ZK9/6oteOqRYNFWHcWqb1Twzcu72
 943wynouBzuMdU0rySMxM8q0quxlzSyy9jYWXKxH5bM9m9eBGnEk2PcVRzo3rRvnGUob
 li/jWoFtuRrMiRkdITmXRP4YfczaaKbBf8CLcBUuYp4XbMIyB8I3sZ0hyjLq1Lrua7zu
 BrZ3S+ziyFCACLex8j6prMbcuMS81muUyDXwHQGoV2lOeogLpya1M1sqPfIPoEXw+e/y
 rSjQ==
X-Gm-Message-State: APjAAAUOmK5JVZjFEK0nCkVWxAl2aX23oQbGCcNgYru5yNLeRvWfe4IO
 vwrUAUHuexkxb4XkiJDiAIUT++ZA+sBQHroOy5qTsa/xWyA=
X-Google-Smtp-Source: APXvYqw0HgLemD8NwX/cirTH3/HkEul4Bl9GjIO5H5+U1LuUHcfEMhbUCiyTofwx0vj3HdZFX68AQnwSrTNu/jprQq4=
X-Received: by 2002:a6b:5103:: with SMTP id f3mr96095250iob.142.1564398288778; 
 Mon, 29 Jul 2019 04:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190728064355.2605-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190728064355.2605-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 12:04:37 +0100
Message-ID: <CAFEAcA_U_HvVYtDGD7UT-1XQ-vVcyVcNgCr6G6i1XGfOdbN40w@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d34
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-4.1 queue 20190728
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 28 Jul 2019 at 07:44, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit fff3159900d2b95613a9cb75fc3703e67a674729:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190726' into staging (2019-07-26 16:23:07 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190728
>
> for you to fetch changes up to 8d216d8c5370495fc416bb8ac573299779867aad:
>
>   xics/kvm: Fix fallback to emulated XICS (2019-07-28 11:50:26 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue (for 4.1) 2019-07-28
>
> Here's a pull request for qemu-4.1, which I hope will be the last from
> the ppc tree.  This applies a couple of last minute fixes for the XIVE
> code.
>
> ----------------------------------------------------------------
> Greg Kurz (2):
>       spapr/irq: Inform the user when falling back to emulated IC
>       xics/kvm: Fix fallback to emulated XICS



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

