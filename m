Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7FEC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AAD2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtZLSda+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AAD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46459 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLRo6-0006ke-El
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:24:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRnG-0006S9-DL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRnF-0004iC-9e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:23:30 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRnE-0004hG-Vi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:23:29 -0400
Received: by mail-ot1-x342.google.com with SMTP id r20so10548714otg.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=VK3P3TSIkgQkDd30M9PcGy7Qi6t/aYeb6J578Q2PvmE=;
	b=NtZLSda+NmPm3bX2CLWt3d6rQsqkaDrGU3WgxbpKibBmA2e0qupJ+jogMfNl063aGA
	NzW409EKE0i9qsPf4lWkaKPXYk8CrGFbTQ+9dVRUwHVzYZDyP0cQIySDHnRdfiBa7boH
	rzFK9h69yagZOYVHlUQkGve2DI6Fo1XJik1iFybU+EVsRcuJTy2QMqkFjVdtBdVudUqk
	5O1Lf0zBOIrymTdTZc5F0DDhK7Wc13GcRiEsNSN8JY0MN19KqH/eF9uTzheIn4qvjQmE
	9Ob0qcNiUdisVEwqfazuhA0mL+Zz9tesOS/37ybHP3NME1SsH4inB0aoFwPdYZEvdUEQ
	Fuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=VK3P3TSIkgQkDd30M9PcGy7Qi6t/aYeb6J578Q2PvmE=;
	b=LfLkhezlvZxBrQJ4np22la+N1oCnBHEM58Ii6lkltc/xI4h0J8XEnOOfFi1n5W3ekh
	7HjBPPz+mC6g3pnLiTPUDZ6I/YQvCbM/M8SNmFJGYELoh/y2gyEd91epTbDnSD2ME5O+
	MoTfu+mE6xfk+QSQwRXojSUMWVY4s+5zcfnh8B7lwtA4J4HCo47ChQO/VyhjBG9SUJoZ
	An6+i2WnQY//1RgjccFNFpaUepD6JaCd/vF/gtrXxzM8SBJfi2/AwI1M3Cl18wnUA2R4
	NESUfqFUkpdcgFi4QaiGhxtA3tfTHjojZyP7yjnENgp+t4aARwptsIM++XPIegpQ57o3
	WcRA==
X-Gm-Message-State: APjAAAUf+DJpM5OVhv+L6ER/Ry5juN0pVTzdmsuzyAuXNDerlI565AGU
	HAbs0z/p9+/n4+v9n+1nXSWGyEY76rgaEQhpxdcBqQ==
X-Google-Smtp-Source: APXvYqzEolu02dDUECKgCtizMhIMKPtjNBl/1gVstLf/rC6s/1dsSX0GOZnLKBf176PB2Ze/lXDG7opffR2JUNwuTyk=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr15850254otb.238.1556627007987;
	Tue, 30 Apr 2019 05:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
	<20190223023957.18865-3-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:23:16 +0100
Message-ID:
 <CAFEAcA9C6OU9vE1ST=v7X1u_JvXgX0iBADbqv_Jchj2=xrAnCQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 2/6] target/arm: Define cortex-a73
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430122316.3uSRyBsyaMZ4aQWknIRt6VWbEQ4MqQJmgSFUQVkPQk4@z>

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There are new field definitions, CSV2 and CSV3, that do not yet
> appear in the main ARM ARM.  Define the ID_AA64PF0 versions,

"ID_AA64PFR0"

> since we already define the rest of those bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> --

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

