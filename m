Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB850C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939A020862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgIE9zvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939A020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49867 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZLl-0004Zq-TP
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:28:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQZJl-0003P9-4z
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQZJj-00035H-2j
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:26:12 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQZJe-0002zv-Vy
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:26:07 -0400
Received: by mail-oi1-x242.google.com with SMTP id w144so6909156oie.12
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6dokrn76e11GAdbHqcDDfHCeRg6RGjj02fDgKx7ErkE=;
	b=qgIE9zvB0yLPqco9ZtAb+CD8bbtiUrAOXtPoj12pPz4c5Ba5+sezD8dGJyLfKoWH3f
	XQiyVIqqI+UR+B1QM+jxoSuClHdQ+Wvn1PUigljQtGE7qnj8GdnnSdANSnS5Xpy8Nnqi
	eeKgTNl3/Fl6sI8//weQhlqxPV7c8Nm9Yw98If/1KLJ2LGxIElTBC2zlRW6V5YMrAsiO
	3pXk65ilAdStz6iMHO3i5zI3yqQHPR/1+GflJjVsgHXv//PWZj1hRFplOvswyu78Usty
	oHqs4mG44MfxoMSVEyth7ogYJUfc0PB4qLbmBsKAXagtdheCZUCPRcTpJZMsJ4mFqg5b
	DAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=6dokrn76e11GAdbHqcDDfHCeRg6RGjj02fDgKx7ErkE=;
	b=d7xIQaZg/L4g73EdHbvW2M5IU6bfgVt7mT91swWJfUneDp+8cxEA1dbk/SbSwxAniJ
	Kbemotw3xKnAK5HHNhkvYM7Iu4eTLwGKkovwrtaCenlRY8isjedzpA1NrlEipyPPL4Nm
	aaSpPWNqJOQWOzsJc3H/cx6IlohPS0frdaYzk83dwbCHix3heLW7axeYo3ZU3n0g9zZs
	w9kUmRos/D7RH62z9pm2ooPdchbosJfwQecW4YjoxvK0lTemLlne5U8hOYvnj9xyMufL
	yKK3ufsp9CDNh+ioAGLpXixMl0TQddeFa7e/qFbL7xKzGYHnWeslRivmpfyFhA/jVjJ/
	OgMQ==
X-Gm-Message-State: APjAAAWFTPY5AXE5r6tdZh71CPn0t9qI57Td8vYRH7bi/75CqAne0Js+
	09KfJUZdrYrr5zP7QURmCNcK06ryfyNnlmI7rgNK+w==
X-Google-Smtp-Source: APXvYqyRWRsllVunZuRRE0EZa16aX9NqYflNa8hP8UUbWFEMIO09T09zQvcwUcJvr+CZ0082oMrpQ/+WWNwVtMXFhjk=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr3501182oif.98.1557847565460; 
	Tue, 14 May 2019 08:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190510185438.29533-1-richard.henderson@linaro.org>
	<20190510185438.29533-4-richard.henderson@linaro.org>
	<CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
In-Reply-To: <CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 May 2019 16:25:53 +0100
Message-ID: <CAFEAcA-sN6BzQywHUssQqdaiTdSNNS5thnV1VHbKqB2k8K_7-A@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Sat, 11 May 2019 at 14:43, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> This commit message is generally poor, as it explains relatively unimportant logging issue, while not explaining the core of the change.

I think the assumption with this sort of "refactor to change
all instances of an API" change is that you will go and
look at the commit message (or cover letter for the patch
series) that introduces the new API; there's no great need
to repeat the same justification for every commit that
applies the refactoring to each of our dozen or more
guest front-ends.

I'm not sure that wordsmithing a commit message really
justifies rerolling this pull request at this point.

thanks
-- PMM

