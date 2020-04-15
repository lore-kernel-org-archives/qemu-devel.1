Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF23C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC9B2078A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nU9uncTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC9B2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOgyu-000640-JE
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOgy9-0005Zi-Gf
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOgy8-0000Ey-37
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:16:41 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:44635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOgy7-0000CV-He
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:16:39 -0400
Received: by mail-oi1-x233.google.com with SMTP id o25so13218066oic.11
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k8kz9bJV37Ln3f9eInvKRNL++CAULOlqGxa2Dw2VBqg=;
 b=nU9uncTDp35O11HMwS9jQ1cYrbEpZZGqsmiuFoeVJY5RND6Le+elc1tUtpR6t/vTah
 /4BS+br40zeuCgIl6HDsnrMNqQ71Qx90gS892PR3sd/EfJdkiJKP11A/JzrLqETyle/q
 0maP8O6MMkl29u0eH+UO36G2jEOCbmUdA0Ez36pRkDPOSbjQjLKUp8AGhB4Q09AWjMoq
 ew1whTER+ciuchrHWeZKRHWIz5ILt+bc+jmEa77gpzLTegKmWYQ3mofA95hPevdjLq/9
 AGANXrJ5ZEgIW6fBGalHsCwf+dEPtm3rf4Xj8WNGTIkKS0s63ZgzlRcfazfzYssGdJ2x
 /aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k8kz9bJV37Ln3f9eInvKRNL++CAULOlqGxa2Dw2VBqg=;
 b=anIndkPplZhlJqZuxGs4Y39mh75fgHJuLI9w4jQppHToLX09qos4O3DFaZirxSKGnj
 Imf1W0AbuAeC5Mwe/SUyR2xgIFlk6KXOfKXfMzLE9Ntotdfop2TpupcT0r9PCOv7bJ5D
 2Nf+bmMfeFVmJceTmKW5ZZFUw8zX9UNusW+oGYtXsvOrKacfkGOx0ZeIdjZOdGf8JIJN
 n8IXEwmYswxp/puj9CROXs0k3NIKU1QsPorVurQmbYakNTu6JNKTaPf/q0w+ZqPXaOoy
 7tnbqLhEWvKi1NoIVRC8VHAUXW+iTymtms/39RMusZyVdpUHKmrK4gj+AhEa60IVzrIE
 qGRw==
X-Gm-Message-State: AGi0Pub/c7nuL80uGs9R0NT7NWZMdQ128EqwUZ7G0gG2Cv4tYI36BKqw
 OtISJoaqf8AmE914wvR39obuIuMHYlTkgDWeJm/D9w==
X-Google-Smtp-Source: APiQypJ9OiZD0budl6EnnOewO81dt3Pc6cgubBoE5DkrZcDIS4XvEm90CIakV7O08ifmhIc/5OIoR/IW9ntu8IiH7qA=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr4078610oia.146.1586952994669; 
 Wed, 15 Apr 2020 05:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200415104211.9388-1-alex.bennee@linaro.org>
In-Reply-To: <20200415104211.9388-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 13:16:23 +0100
Message-ID: <CAFEAcA9rXku6hjEdFwMuPxZXhftwz2ki_Fig_KxqKNqbwGvP8Q@mail.gmail.com>
Subject: Re: [PULL for 5.0-rc3 0/8] a few small fixes (docker, user,
 pie and gdbstub)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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

On Wed, 15 Apr 2020 at 11:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 2f7cc1fbd6f6655d900ca7f45973b9bd5330c6=
dd:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2020-04-14 20:09:52 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-more-fixes-150420-1
>
> for you to fetch changes up to 377f8f08bebea7cd44617b0ac0a2baf307f5f055:
>
>   gdbstub: Introduce gdb_get_float32() to get 32-bit float registers (202=
0-04-15 11:38:23 +0100)
>
> ----------------------------------------------------------------
> More small fixes for rc3
>
>   - tweak docker FEATURE flags for document building
>   - include sphinx configure check in config.log
>   - disable PIE for Windows builds
>   - fix /proc/self/stat handling
>   - a number of gdbstub fixups following GByteArray conversion
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

