Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55866C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185262072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K49RXmN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185262072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkwg-0004kJ-7b
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkup-0002jy-Eb
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkuk-0005Xq-Et
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:03:55 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCkuj-0005Ty-6y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:03:50 -0400
Received: by mail-oi1-x244.google.com with SMTP id y71so9429885oia.7
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yJKUVM/F7YoJrPfZOmqZuyP7n37uZRy29RxD4C3UWUE=;
 b=K49RXmN8bTkQyxST+AflvQVp6PBGGmAOL5TVW0pOUYvojmmM/chylVNLkC+RAUtL5I
 6aYcxM6wtf/8tKatztudkBR7vez/iOEOZ3WVM6oFUjcOkQaBTkOekAxIPpPpRDZOGEQ9
 KyJdOKww0M7nRYi4yOkUeW/85iLGN4UwUpRdP6CDui4WZ3a0SFXOddLDxGK0jhBTtOYB
 TcwlVEtpWdoBDAngrYk6DvPf3Q6oZrxUJPSMlpwF3dpmcogKg+NjJAdu2mOGPfrVhRuZ
 3kNojJ19nM+/R4Ot7taTNa0MIjk1mk46De5ELagu+7qanWAxdzIMXJiIIj9xMIkQm4nE
 cZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yJKUVM/F7YoJrPfZOmqZuyP7n37uZRy29RxD4C3UWUE=;
 b=FGb234caSp3mKwFwiXLLrpkosuAsD0uTcAs3bq4UJG3+TQ4oLM5q4ZGJefyzp6HSqE
 5YDiKQXZr5xuvPUSsVLdyPzCGmIMSTcNKLWPca2V2i48Uur/WlA1tejjuBkY8xOdfdPV
 T1DJJOl5eBBoXBxySlhcnaDDnuEQ4BYbGmFWXqELj7IULwnr/2BNEsy9REyU1aNt1YxP
 RsS9PyXNZC0Y+Wgq2Q5NWH2kkOvUEQBrcsXDTPs9t+xOR0nJ2gTReXeE75U7g5LnVkbF
 tcBPzexwWyzx0MOgaJaHpCSN/0IFW5EKLyVn7KMJpw+ZeXbk/jVE8Asmqc3rFvKRZqAx
 NA4Q==
X-Gm-Message-State: ANhLgQ3lLYf5lSjMGbMmHvTN1MAdZUE+DhqgIDbim2wCqG7XTm8/7kjH
 xmdJ9KHrp6LYk4ALea3oLz+J/N3kP7G7xFmkOz2W5A==
X-Google-Smtp-Source: ADFU+vufQz3QmK1l/WG3eg7xxxIcyRtvb5dZiM1ns/LcJ1H+jQzHhp7YTLCQqQ+otDRDYqMAoZP81T2cp0BZ33S/Cp8=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr6822951oic.48.1584108228052; 
 Fri, 13 Mar 2020 07:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <2159383.tmy0LfLZHX@basile.remlab.net>
In-Reply-To: <2159383.tmy0LfLZHX@basile.remlab.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 14:03:36 +0000
Message-ID: <CAFEAcA_nGY4_UQ7jMdxuZXR=_rpVZVCAMX+UzEoFtSpcCVy9Dg@mail.gmail.com>
Subject: Re: [RFC] [PATCH 0/5] ARMv8.5-MemTag disassembly
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 13:59, R=C3=A9mi Denis-Courmont <remi@remlab.net> wr=
ote:
>
>         Hello,
>
> The following changes since commit d4f7d56759f7c75270c13d5f3f5f736a955892=
9c:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00312' into staging (2020-03-12 17:34:34 +0000)
>
> adds support for the ARM MTE compatibility subset (which does not seem to=
 have
> an official name) to QEMU user mode and system mode on "max" CPU. This
> corresponds to MTE =3D=3D 1 in the instruction set feature field, and all=
ows
> running code with MTE instructions without actual tag storage.

Hi; how does this interact with Richard's series for MemTag ?
https://patchew.org/QEMU/20200312194219.24406-1-richard.henderson@linaro.or=
g/

Also, your subject seems odd -- your patches don't touch the
disassembler, only the translator.

thnaks
-- PMM

