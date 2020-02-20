Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F02C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A7A208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p17McKuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A7A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4plo-0007PM-2A
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pjm-0005ol-6d
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pjk-0001Ll-WD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:35:46 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:47007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4pjk-0001L9-Py
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:35:44 -0500
Received: by mail-oi1-x230.google.com with SMTP id a22so28330352oid.13
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g3Q2fkCcFtALG4YlComMunPy5B22O7Kd3mD1z1ByAOo=;
 b=p17McKuk4SBntEB9/h3/rGj0w290mFAxMu1QNUGgm7EngzxPTAGlcWhyq2D/JtluJ/
 SPHce6349p3NTsEA+9oEtlYeuzR6pXqgufeRQ4vcahrlbQcxAOvXQBS0hwbiLTYta4P2
 jvtagr4h4netvD8i16/H4eNUj3Pzi5QHWmfVxFVHIqOY1a+psIzSiNR5Mij1ArxfuVo+
 bDPh78BYwjEn2iWKh6it7dxNm13LDZ7MxwBcKkS4aj8M+HtI3Mf7DdTCWTzWy6KyCZkw
 cw0b1+PlEY8uTOgNnSzxWWvWeO4uW1h/XGSLIpcU4PelDpvLKrxHY/kzPzydDD/vmNp2
 WW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g3Q2fkCcFtALG4YlComMunPy5B22O7Kd3mD1z1ByAOo=;
 b=HDYz9q1G+/UlLzYoIOq6h0E1rMCMyiQaAUvQbDj4OU0rw3unqvaScihFZzmZk/4Wid
 /eIveMQzFhyi9u8RtOG3HJum/XIOjNDeLo7854bn0ec3zYaJJILoG+8UnFKd5xR/pR63
 xyCpfO/jB9BQXlJvGcXy3kKcFLMWfeiMw/pI/OSC/bbfIhpmA0vptshJk44sDCa1UhkY
 Mcvm2KvlHB69N62CW0xwoI5uAIhLshPjQjgXwYWr9CIkTTuH2wNT0AWZrHBkkdipHrQb
 FbChNBijF8GJ1LRE0KooZu/o7KOmKGGX+lOi5KTAs98TT3XHyCr4oG5B1K359GPgAMTi
 OSFw==
X-Gm-Message-State: APjAAAX34qqHzhd2eD8ihcOVhdefCbBHZsNVP2wOk1dkVF1TtBYFjJ2z
 PWXXZVWJcMAOTOvdFbCPwWjl/7j9Q1oV4dvTVI3jWA==
X-Google-Smtp-Source: APXvYqxFCqcIa05VefrONofkmb52EHhLstjavsOyQ8HlOfPI3cLU4hqm5lnxXtn6gx/bq/pJY/qnnclfJaQLI3SV8c4=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2994886oiy.170.1582220143945; 
 Thu, 20 Feb 2020 09:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20200219101612.1033925-1-laurent@vivier.eu>
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:35:33 +0000
Message-ID: <CAFEAcA-gVy=KkOnjo7b4EsaetNKo_CPYA1WFwZYJT1vZVNao9A@mail.gmail.com>
Subject: Re: [PULL 00/17] Trivial branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020 at 10:16, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 6c599282f8ab382fe59f03a6cae755b89561a7b3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-02-15-v2' into staging (2020-02-17 13:32:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to d1cb67841ca213802ee789957188ec87e8b7996d:
>
>   hw/xtensa/xtfpga:fix leak of fdevice tree blob (2020-02-19 10:33:38 +0100)
>
> ----------------------------------------------------------------
> Fix memory leak with fdt
> cosmetic change in code and logs
> update mailmap
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

