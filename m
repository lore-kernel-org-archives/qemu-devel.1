Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA93DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7437D20720
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKvIPowy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7437D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYUG-0004WD-OD
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYKe-0008LB-LR
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:30:56 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:35518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYKb-0005o6-G2
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:30:56 -0400
Received: by mail-ot1-x32d.google.com with SMTP id d4so13152096otk.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6u7fXVYdxMTkzxbjLuLIh00pONDtl0L8b9bjNLLuXQ8=;
 b=zKvIPowyPrHn7wp6bg7qsSeeUd7E30tGN5E3SmT8RjocorHiFfFSqcYqONieltpRxw
 UafpSCzVNFmM75CANgzLlWRLkTHphMKu0nbrS1/NhJjw/jmd4OjmxPGGra4boTR4sZf6
 qYLzawkU0zBdpA72XvK3vdJsqRcsfIGMGKRd2yRkPAVZzvI5f9V+zkcG/Cuh0VV089lg
 3BhZhQkiYVyWymPI3DZgkbEGKWY3GpvRU4W8XlEBt8xH+itTQaNzc1DYYs6U71FLHPNt
 /PQu+e6SgKnezZ6zDgS9Ef32swuhyZmArTbnY64khWBnrqCJ3axOZ1ZaYjjijy/Ma7Hw
 CvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6u7fXVYdxMTkzxbjLuLIh00pONDtl0L8b9bjNLLuXQ8=;
 b=ZS7Nh3g28NpsRw4wY6mdNE7U9ehINdQC5Aa834sdNHxVFSV+cAWCN5pu9R0GTfsdWs
 Lz7w0c2b++uVJv6WwLEeIp48cd9r6FQKmlTbRvkX9wtGEw8DozgjOy9f8Tja1szA+KcR
 p1tpYUrLPR7HQvI4QI6uKc48FQhtQRoglvKHGW8lI2T1iZWCkGXV28EzJZwTtbJZ5Fr3
 caeA8dCplZ0jxGtmTAPcXRlvgBkZ3uQRwQape8CeQYmUdW+sTY0+FMmH6JGXPQBFU6aK
 L4W448bbsKgX1GgK7p6OBB31XpGrRKvgcV2K9u8RUcoSpl3BtW9MLR5lV5whZp+4VfA1
 5UGA==
X-Gm-Message-State: AOAM5319h+spIozECQLgYlu0q0SfncR+1a/HQSvoS1UyR/9dJOfSQDWf
 aAIiWwuL06Rf0rRwMzMGlqfurEng04ld+8+oTcYA4A==
X-Google-Smtp-Source: ABdhPJwkMri13J2CSnh1p2ayLcYA16KLfbK150EfwJypNXrgOBP44rw3F2inYusJSK/hRbSeJJexAXdkukYqz8vJVWo=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr7367037ota.91.1593354652161; 
 Sun, 28 Jun 2020 07:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Jun 2020 15:30:41 +0100
Message-ID: <CAFEAcA-8QejH-sFsP_rmKuYdYbQdYRjrHaNz4vLHzfYiSBCKYA@mail.gmail.com>
Subject: Re: [PULL 00/63] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 22:53, Alistair Francis <alistair.francis@wdc.com> w=
rote:
>
> The following changes since commit 553cf5d7c47bee05a3dec9461c1f8430316d51=
6b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00626' into staging (2020-06-26 18:22:36 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200626-1
>
> for you to fetch changes up to b39d59434ea10649fdb9e0a339c30c76e38c5e17:
>
>   target/riscv: configure and turn on vector extension from command line =
(2020-06-26 14:22:15 -0700)
>
> ----------------------------------------------------------------
> This PR contains two patches to improve PLIC support in QEMU.
>
> The rest of the PR is adding support for the v0.7.1 RISC-V vector
> extensions. This is experimental support as the vector extensions are
> still in a draft state.
>

Hi; I'm afraid this fails to build on PPC64 and s390x (ie
our big-endian hosts):

/home/ubuntu/qemu/target/riscv/vector_helper.c: In function =E2=80=98vext_c=
lear=E2=80=99:
/home/ubuntu/qemu/target/riscv/vector_helper.c: In function =E2=80=98vext_c=
lear=E2=80=99:
/home/ubuntu/qemu/target/riscv/vector_helper.c:154:21: error: invalid
operands to binary & (have =E2=80=98void *=E2=80=99 and =E2=80=98long long =
unsigned int=E2=80=99)
         memset(tail & ~(7ULL), 0, part1);
                     ^
/home/ubuntu/qemu/target/riscv/vector_helper.c:155:27: error: invalid
operands to binary & (have =E2=80=98void *=E2=80=99 and =E2=80=98long long =
unsigned int=E2=80=99)
         memset((tail + 8) & ~(7ULL), 0, part2);
                ~~~~~~~~~~ ^
/home/ubuntu/qemu/target/riscv/vector_helper.c:154:21: error: invalid
operands to binary & (have =E2=80=98void *=E2=80=99 and =E2=80=98long long =
unsigned int=E2=80=99)
         memset(tail & ~(7ULL), 0, part1);
                     ^
/home/ubuntu/qemu/target/riscv/vector_helper.c:155:27: error: invalid
operands to binary & (have =E2=80=98void *=E2=80=99 and =E2=80=98long long =
unsigned int=E2=80=99)
         memset((tail + 8) & ~(7ULL), 0, part2);
                ~~~~~~~~~~ ^
/home/ubuntu/qemu/rules.mak:69: recipe for target
'target/riscv/vector_helper.o' failed


thanks
-- PMM

