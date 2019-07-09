Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C45C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97576214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6638KnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97576214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkldI-00058Z-QJ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hklcq-0004jY-Ru
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hklcp-0006YI-Ri
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:37:24 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hklcn-0006WU-SX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:37:22 -0400
Received: by mail-oi1-x244.google.com with SMTP id m206so14742136oib.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=en7JuXeewC1PJQ+dn18CZPtUz2HVgySyM2WeaGGQfzA=;
 b=i6638KnPqCv9KbxRUa9B5iXhjsG9cHe40m0ry2TVx1scMtwzsDEowXkzJKPw64WG5s
 Q1raZiHbu4bcKmgIE6P9amLTuPNMTvmYzb229oToISge0T2I/9KdFXIh86qUIip/gtJ2
 tqNHr3822uShQhnBujZP4MG/r8VTeWhwGhKyU03aaiuVoGRCDif+L+RxtpTnLL/eS4K9
 lLyFYYH2XysT3n/Ktv1tXmQJiqlSnwuLW060AWv3jBkqXBX2nQkn8Ob3VwoMLsxquQVt
 gv5xoy0YEicHctProoopKITBld9lK1IZIq1E3vztmuKVYGGPyAduWRgYfh5l9r8i1nZ2
 uZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=en7JuXeewC1PJQ+dn18CZPtUz2HVgySyM2WeaGGQfzA=;
 b=htkiA/9P9phLpDyD2OhLTOGoN/yv0jhpp1G4TtIMkGAR3rCpd6m7NRRE7WTZRrEzwX
 S0jtZf/IwPX4SnL6WFVOCeeH/VpADsLFMEWmggJ8zuqFzem1iLK7aMH92tLjdF7x4xxV
 MEuKFlxjnZVGsySW+CK6ORVyfXlK9wyhqiU8z4RP+BCLQDto0Zyc7h7T4X3XHO9Y+51C
 30Ul5EfrsApjJpOC5VJyXTLSnfxq2/p8d/UjoEwXWRTc9MZJJTCr2URiCsof44ZhHQ5v
 aOjmxhwLcGFtz9dO2MapLDt9PvZqot/CenORiccl2INo84xni1ureh6iIoSsCLxwsxHa
 3+nQ==
X-Gm-Message-State: APjAAAWyocGZImBgOeZqdvu1jN4Z+duWrIfLpyw2eToCBRb8nyzOzX+K
 3n75LASAn0C25CvsBLHmbjUIP8202PEijxdlEVX9hA==
X-Google-Smtp-Source: APXvYqxPTenHjCQRzGctS/gh93DJMEIHCAJ5zw4LXPujZMnr1NSXdTM2uEyWJLhNkLtFHTstK5vtjYddGPflHXjRdSg=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr1065721oic.170.1562661439441; 
 Tue, 09 Jul 2019 01:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562611535.git.alistair.francis@wdc.com>
 <mhng-2211c89e-80c2-45d7-a471-ec0c30d871a4@palmer-si-x1e>
In-Reply-To: <mhng-2211c89e-80c2-45d7-a471-ec0c30d871a4@palmer-si-x1e>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 09:37:08 +0100
Message-ID: <CAFEAcA8Bf4Zt4U6p3uMsn8cwv+=7ZHxOt7y2FZzB8TYkyo8AHA@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v1 0/2] RISC-V: Add default OpenSBI ROM
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Jeff Cody <codyprime@gmail.com>,
 Anup Patel <anup@brainfault.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair23@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 at 09:35, Palmer Dabbelt <palmer@sifive.com> wrote:
> I haven't looked at the code yet, but as the last one was fine it's probably
> OK.  My only issue here is the timing: it's after the soft freeze so if I
> understand correctly we're not supposed to take any new features into 4.1.
> That's kind of unfortunate because it's somewhat unobtrusive and super useful.
>
> Peter: would you be OK taking this some time later this week?  I'd want to dig
> through it and then bang on it a bit first.  If not then I'll queue it up for
> 4.2.

The first attempt at putting this into master got onto the list before
freeze, so it's OK. Plus this clearly will only affect users using the
riscv boards, so it's a limited-scope change. So I think we're better
off putting it into 4.1 rather than not, assuming you're happy with
the level of testing it's had.

thanks
-- PMM

