Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B00C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39178217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYz++ral"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39178217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCI7w-0005L3-1L
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 02:15:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCI75-000517-46
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCI74-0001TD-10
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:14:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hCI73-0001RV-C0
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:14:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id x188so3932003oia.13
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Sfa7A/BS0sWHpIOJHxMtKCoQbarU1kfg4Zi58fPevvQ=;
	b=MYz++ralrDRQiLuJ89FEkBurzdbW1qg6TEu0OfAWWXH1OmiOeFnY5L5aRGISp/1z/X
	ShbChLn6FW05JlWu5myrsUAKZMzyiemvFBXUK4WJI8vg1+TbTsVxEAj2jxFcvyQG9tFF
	Uj6+oKU6aLsbKJoT1vaF/lYZ9vMr7E4+w9qjfsZvbPbt5hTw3mWH9mBm0DtEIFfKx+iw
	++zYwEio/zrqUzVV+Yg4Cp7I85F3chAXLgPzgWLmqDpdeDxzBKVBrZc8QtuqggddckEL
	eZCSxbqXvGmrC3RpvMljguzyeUQuXSL5u7hzRWuwktBE+vilez6x/AsACtjCSKm4Ra7E
	+K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Sfa7A/BS0sWHpIOJHxMtKCoQbarU1kfg4Zi58fPevvQ=;
	b=t7UgsGzRadtRLy84j7rvPV15tXpaRjt+WCS3tr9YnJxHDZmeTOBMEzYPFXEzazHjHN
	8Y1Vk+qHJNjaf72/3NU/KPV5cXXacEFqalmGd9WFlDbJj5pp7D2WQ9IEDTix4JQeldTp
	It24uvKDK7674mI1+a3tBMVzlnUBnM8vg/vR4KJgWyRSnv5phARvkARO+F++Nww9kQPz
	fnSX4gjacrjYq2h80EmEBux0t+F4XchHtwEyYmQuO5J6rxeQy63pMs1RlAjrMC3DFIAU
	hiMZYm6zrK3ekxBrll7xyCnMwYeb5UUHJHX1+5IG6jAR5s6N0ngtXn9EMxLLVb3i7YvE
	ceuw==
X-Gm-Message-State: APjAAAWModzXxihiQJKTRTwu4iIKLWMfkjg4xbKTVXqB1nSxfkF4MHC4
	7lqiq5zW/HOlrf3Wz4PEIsOf3LGaOAGa9+V6XD27TA==
X-Google-Smtp-Source: APXvYqzMH6dtRrHcpdYxdpb/xdyHmV5Ne0ajQ7YlzJhkpY627+R8DFHKhga8LNSMqu1oQyI6DrMrNYIyHSaJP1B6lCo=
X-Received: by 2002:aca:e84c:: with SMTP id f73mr5993605oih.163.1554444844230; 
	Thu, 04 Apr 2019 23:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190405003924.1906-1-palmer@sifive.com>
In-Reply-To: <20190405003924.1906-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2019 13:13:53 +0700
Message-ID:
 <CAFEAcA82u1SNuO-2AvCR8dx6XyyeZnrdWFbhmOvHun7hmxNFZg@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for 4.0-rc3, v2
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405061353.r9r86r0ZKGgmfZr9Q_nXCmoFowRV5SvuTcabUuXW4E0@z>

On Fri, 5 Apr 2019 at 07:39, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The following changes since commit 061b51e9195670e9d190cdec46fabcb3c77763fb:
>
>   Update version for v4.0.0-rc2 release (2019-04-02 17:01:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.0-rc3-v2
>
> for you to fetch changes up to 79bcac250f96ba1d4fdecfdc6e3363c9024703a4:
>
>   riscv: plic: Log guest errors (2019-04-04 16:36:21 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for 4.0-rc3, v2
>
> This patch set contains a pair of tightly coupled PLIC bug fixes:
>
> * We were calculating the PLIC addresses incorrectly.
> * We were installing the wrong number of PLIC interrupts.
>
> The two bugs togther resulted in a mostly-working system, but they're
> impossible to seperate because fixing one bug would result in
> significant breakage.  As a result they're in the same patch.
>
> There is also a cleanup to use qemu_log_mask(LOG_GUEST_ERROR,...) for
> error reporting.
>
> As far as I know these are the last outstanding RISC-V patches for 4.0.
>
> v2 no longer fails "make check" for me... sorry!
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

