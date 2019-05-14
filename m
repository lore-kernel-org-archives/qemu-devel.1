Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59DFC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9916B2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smPvRmVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9916B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQaDq-0004x5-Rq
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:24:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQaCS-0004G3-VX
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQaCS-0007sI-4A
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:22:44 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQaCR-0007qW-Sy
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:22:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id i8so15780396oth.10
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=zl8wyqpenVHUaWAQd30NCxFEceaOvBnklZCalzzKtSA=;
	b=smPvRmVZftV8PhkOmD1KNIZ5Xo/27n28xD++twUo1BL2i2MJOmvn9W33ekfxau2Isl
	ZLZAPOGv0a8GlN2uSqD/cMb2+9UoVNDVywBFPaQpYI5FU887H29s3gVgfB0oGVngOIQr
	duAbzT+GR0NlE9aNo9yJlWTEkUzIpffZB5r1bykcdiJ9Xu392ElZ7NskLG4Q91zwtINx
	zs7f5urvsvR+6YeZW4bxq3E/0VWzc2gKG72QBh/VHOfs4CzczYNYtDK0mZ84915uUTEc
	QKxWRkw2RY/UEA62LY1bDsMN24wJdm1fgDiytM36jIx+een6JlVNyBhEszxTJobQUBBs
	V9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=zl8wyqpenVHUaWAQd30NCxFEceaOvBnklZCalzzKtSA=;
	b=ZgUEw4xpueAgQGV8Lw7tSIsxAs4LOV7mx1q9zw9wgzn+qPikHSYl+XZdLVzQv3j8ud
	6hcwrxvRcm6fzGwIvbuQfb3VxAQxbJa+gjRnRFxDOcTTVKjjWeH0lKhskyewj/pOwDEP
	7uTbLTXsmMcruqaepg3Lth0VCJfEynR4RrVutj/UfaXiek6doinbNOJTSQLdpZX5yTae
	d9ntHC9YBa+CnxMKNZMhgIoSIeXBzyv5vsj0RgEUjB2RhQeilgqhKumqSFE2TvttcBIw
	SlS0gwnHkPQUDNATO2HPQ5/sGB+QCPwsfpjVvnhBQYkACYcQqQS+DIkMToZ9uahdfm2E
	pVow==
X-Gm-Message-State: APjAAAV3Iddhv9XyiMzwf3JzowIlo7DYJ82ssPVaHk6s0sNjzO4beLlN
	l0lvAStY+i3/N7EWygR5uv8w9BVD+mJ68iCHcp2Y7g==
X-Google-Smtp-Source: APXvYqzAoorWBkLtkTLE1p+vO62o0/2MaTh4U03whS9uN35+6DYIQh7++c9Ihp9BzR2P5LMbLTdFpfVLX5rlIZl4LRY=
X-Received: by 2002:a9d:3f61:: with SMTP id m88mr20571430otc.147.1557850962050;
	Tue, 14 May 2019 09:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190510185438.29533-1-richard.henderson@linaro.org>
	<20190510185438.29533-4-richard.henderson@linaro.org>
	<CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
	<CAFEAcA-sN6BzQywHUssQqdaiTdSNNS5thnV1VHbKqB2k8K_7-A@mail.gmail.com>
	<CAL1e-=j5EB=Y+3Lc=_bxs4+sEOSZ7pEWFpSzdozz87q7DOs8NA@mail.gmail.com>
In-Reply-To: <CAL1e-=j5EB=Y+3Lc=_bxs4+sEOSZ7pEWFpSzdozz87q7DOs8NA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 May 2019 17:22:30 +0100
Message-ID: <CAFEAcA9X12CF-QEqEX=KRuXxgtcK66b3n7NezGh2b5ruV4Vjqg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL v2 12/27] target/mips: Convert to
 CPUClass::tlb_fill
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 17:05, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> I am not complaining about myself looking at another commit message, but =
have future maintainers and future developers in mind. Their effort needed =
for deciphering commit messages like this one is multiple times larger than=
 putting together a clear, full, and right-on-the-money message by the subm=
itter. The commit messages should be made convenient for their readers, not=
 writters, shouldn't they?

Yeah, good commit messages are important; in the end there
is a judgement call to be made about how much detail is useful.

I think one thing that might have affected our differing
views here is that you were only cc'd on the MIPS-related patch,
so will have been looking at it in isolation. I read the whole
series starting with the initial patches which introduced the
API, so had a fuller context for looking at this patch.
(I think future readers will also be able to acquire that
fuller context easily because they can just look through
the git history for the nearby commit that adds the tlb_fill
method if they want the rationale for the refactoring.)

thanks
-- PMM

