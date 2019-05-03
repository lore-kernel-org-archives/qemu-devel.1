Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA1CC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A9520651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j45t+Aea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A9520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMapC-0008IO-Md
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:14:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMamt-0006eq-QR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMams-0005Oy-Pd
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMams-0005OH-IR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:11:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so8526211wrs.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=RsbaU/qSHBLSdbY0VXpWlSIxl4BnyahNu6U+YDIcOho=;
	b=j45t+AeaL4j+xzl0qluqQVcr5zD81N6R//u2/YLw5RkM4GDOveNiSSmSuztxG5xwc+
	E9XCwV+pVWPjhfMcMjSBj1IkNt5ZHEny80fDlCWHZW4hX/XLf7JmGuJDg5hf5Z9cYyjW
	/LiNziVTT9j0DE0SIVHAusUQlOtorgyJUjob111FlfLBJ7kRQHh0dliSAYVcJlT8righ
	CotQWin99iMu2teYiQ+BiyKaXgJxKu4YczthCkIUpEP76YQmNss51hi2681uo23loAi+
	S0oo5hT7/zMdR1ipiRABT96OUDDsamzvL4tiYABM8dn4SPUQJdVM6F1xjRkV7D5IjtDo
	nv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=RsbaU/qSHBLSdbY0VXpWlSIxl4BnyahNu6U+YDIcOho=;
	b=EwnKJ5yGntgsenNCiqFExogGGpkZ2VEHegaTIO2b9z+KUaF3n/lES1Uf8fumn4mqPc
	JeZCZpgHtm5uNVzgsm188Dih1gPj2YhFEheJVEjFqhehjbcEQDtGdFKO12x7poNuCs8L
	6NqhlW8MhZskFwyb0SlKU5py1MAXeGTJX98qVzGbSY81UcvTYoGUghogafLQFalHqIwe
	0/9pHxb8O4nMrZINGFH0wp3uxiSNJvK7EGjUBKkfPAiJSMCMZNc5jip+GAQ9AeLlDT4k
	kNfjeqYkijEe+jyoKeFHZRWPq9b9s/e/YXKM5LXeDFgi6ph+KOX2m3ekGkTV8wa6u2Gj
	NKWA==
X-Gm-Message-State: APjAAAUIGEWhtGm/S6hkK4T2hTJtfrW9ICRANAaAQiRAeFIGk+AsCtvc
	KQe0TYsLxYa8dvJ6c1o6j9bYKw==
X-Google-Smtp-Source: APXvYqzCZFVB//yX72guqk+EMv25COaGHuz/jY1tay1HKcrHF3WVjJnAn3itHx2H29gSDs1PdawkJg==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr7522804wrq.183.1556899909221; 
	Fri, 03 May 2019 09:11:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h24sm3451217wmb.40.2019.05.03.09.11.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 09:11:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 44C7A1FF87;
	Fri,  3 May 2019 17:11:48 +0100 (BST)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190502143409.59600-1-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 17:11:48 +0100
Message-ID: <87ef5f4iwr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH RFC v8 00/12] Add RX archtecture support
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503161148.ckxlg6NyvPopNvKh1MUHD1_e3TGvbCnVuMo31rKA6Zc@z>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> Hello.
> This patch series is added Renesas RX target emulation.

I think the series is almost there - it's mostly just nits and clean
build fixes to sort out now. If you run the branch through CI you will
see where things fail to build.

However once that is all sorted it should be good for merging. I guess
Richard would merge it until we can get your key signed so you can
submit your own PRs:

  https://wiki.qemu.org/KeySigningParty

--
Alex Benn=C3=A9e

