Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1072ACA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04D4208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsSlV3I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04D4208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPqn9-0007Jo-Qa
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 12:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPqmG-0006Vb-R6
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPqmF-000819-FC
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:24:56 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:33199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPqmF-0007xL-8R
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:24:55 -0400
Received: by mail-ot1-x32b.google.com with SMTP id u13so2678319ote.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OgTaMiudarUKSLJGx4G3ysIwiLKnmoDo00BAfpegK+M=;
 b=fsSlV3I7turnAwp5cqKNJSv93ft86vnAoqxnw7PB8nbb/8KfQb3Y3n3VMHvdaQe9rM
 xMoh878p9XFCaSRp+J4ubsG1qctBVX4m3QsXwTAnxdNsX8VZjR59ZHahybXyLd45avjx
 Keu1i9xcJLd0FMdi7LN5eooRcN58GFfmWfxoxMpIBvyoyMFt/xcXeRdKSI5UFwkO3EUx
 1MZix2CLaK/DGRMDcHR0TjBHgybI9OkU9I/F4mS57eEzM59QPwu7bUTpjRqbj64hOejo
 MMiINMvIn3joT2bg7SvyV92mlzzAXY5aS5fARjj0iG8x6P3/fvsvm6eaqmVgKiyEYdgj
 S8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OgTaMiudarUKSLJGx4G3ysIwiLKnmoDo00BAfpegK+M=;
 b=j6Yg01x499p/XUH6feniPCGgza29aouR4tA69jo2zMEF+qED6SzD2kES9mA0O1PVNW
 j2TRLi8xzFslL87FU9boi1LBCC3FLYBY9G3CyvHvNbJAyywqLYj1xyOvURi5WuF1aqxl
 Mi3vy2tb1ykek8fr0qnn9cZomNBWYlUzp3D0JFTKwjH1dbhbpBRSZ/1hRRdYSya5bVVo
 glMed/dux4OQmg05QL4lNXlTIvbk+NTJByBb8Vp3f0HxUlcdHgLlVpgmNRct5sBZ4r8I
 KGcbSh5rtCLXdLhfxFA8u+d4fMzdGlLwV7NcpiNltSAksCcqNH2eUmHSscNpZJAvktIm
 WheA==
X-Gm-Message-State: APjAAAXqcLnZo4w7HmG1eOOwVBt54x8G6GxjpnrdBzPPdJo4Kj4bh5kC
 tjL8LBfQAAH8pxura3rn0bJCQ9ZBKr3m5R2zuAaPjw==
X-Google-Smtp-Source: APXvYqz0Vlda90UUH/XyaYiSW7zHzdP76RzPTRMubY7Fxx3qrCTPpS21RL+M4O13ohtHBzCWKT9ZkbuPKbDrrKhtbrU=
X-Received: by 2002:a9d:7385:: with SMTP id j5mr606476otk.135.1572452694235;
 Wed, 30 Oct 2019 09:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191028151501.1920-1-alex.bennee@linaro.org>
In-Reply-To: <20191028151501.1920-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Oct 2019 16:24:42 +0000
Message-ID: <CAFEAcA8UdzZfHcoofYxkXgng8vSp0eywZ5+6VoS-G3_n04g2fQ@mail.gmail.com>
Subject: Re: [PULL v4 for 4.2 00/57] TCG plugins
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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

On Mon, 28 Oct 2019 at 15:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 9bb73502321d46f4d320fa17aa38201445783f=
c4:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-10-28 13:32:40 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-tcg-plugins-281019-4
>
> for you to fetch changes up to 19633df89bfc609569bb693e2e33eb1a68d35e0e:
>
>   travis.yml: enable linux-gcc-debug-tcg cache (2019-10-28 15:12:38 +0000=
)
>
> ----------------------------------------------------------------
> TCG Plugins initial implementation
>
>   - use --enable-plugins @ configure
>   - low impact introspection (-plugin empty.so to measure overhead)
>   - plugins cannot alter guest state
>   - example plugins included in source tree (tests/plugins)
>   - -d plugin to enable plugin output in logs
>   - check-tcg runs extra tests when plugins enabled
>   - documentation in docs/devel/plugins.rst
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

