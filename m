Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F897C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439B420825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDskvpC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439B420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNxP0-0001g2-Jp
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:32:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNxO0-0001Jl-Ss
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNxNz-0005FJ-V1
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:31:48 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNxNz-0005F9-N3
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:31:47 -0400
Received: by mail-ot1-x32d.google.com with SMTP id i8so4667495oth.10
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3Oi/VrW6UUP1HbJz5SFWY9wgNAI4T16D/tXANEj6fSE=;
	b=kDskvpC7EMUQ15yOZmMWTx7iQYpeW4KN45KSknxKDyCDJEMcUs+JQYc31ZnITihyQx
	VHKnLMla/Q55AIt5FxIFPE7X05OBlhrk8Ev4oOOYZViQwTRbuvboZ8Npyt9TtfQm5SSj
	bzREN6PA/b0zkw0qr7dX6Bp6kyjRYUgidkYuZ4aPLFQNDXmGKI+1Ail9bmazY9RYhBO0
	Nwz7Ew+CqTPW4jZpjD+bQiDWqfMFD9zPIhsspu4ieJlSQe2l9HRq79UJx8CByIPqySl1
	hHAbstafW/VJVDCYvNWRbry3vAbNi2iiZKWPI2RHei6Mhz613qPECZzMA1c1ylCmcyVI
	h9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3Oi/VrW6UUP1HbJz5SFWY9wgNAI4T16D/tXANEj6fSE=;
	b=pysXhhSnehzUisCUcqURK4BphGgKX1P4FYKfmWkVJ2QCMfNocu5TtWTsIpbnkT3G17
	PeqCYHu41nGCLiix5iwY01G5EpX+SljfJvQecuCcwIyjqHYQVG+uuBndTOaaMfGLc0oX
	7eOVJS/MnVGsMwmnJxK76GerJlD6/g5Y+AqMRGvnoolzMml37JsJmMgr8HaDXBBllkEc
	bcOEOLrX6Szt7YWOafU6xDQB/LEpuCiPYlP4tGUuY7oWK0SHMZPt0p3a5m5RHcvMVqdN
	kjhm/Bdd2nrqqvNqjTYhM1hpRM458FnaIGevXsIG24r0ljGXncV7l59jUrxyTswF6vcO
	PrEg==
X-Gm-Message-State: APjAAAXgj17mt/lBths0ImUQrFK031NBeqdnv8tr+Za8o94tzJMW3OFc
	uW3ki2zfM3/fI2exh9+78xA2+aW82Bcqi/J7F6Dd8A==
X-Google-Smtp-Source: APXvYqxzkyZ98S8F065BqVel3HiseC+RlMyITmRY3NTQo+chZYHkWjSsqido9peSuDzANIOQi2aDPAuuxzBLsy935mQ=
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr3580912otp.151.1557225106706; 
	Tue, 07 May 2019 03:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190504124113.13137-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190504124113.13137-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2019 11:31:35 +0100
Message-ID: <CAFEAcA_y6-n4WvHSasYVsOOG7-=rjdUm84k4g28BtyDYsdwoBg@mail.gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32d
Subject: Re: [Qemu-devel] [PULL 0/1] Update slirp submodule
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 May 2019 at 13:41, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 52ec9dcc1ed5609674e7b52198c18207bb193548:
>
>   Update slirp submodule (2019-05-04 14:38:05 +0200)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 52ec9dcc1ed5609674e7b52198c18207bb193548:
>
>   Update slirp submodule (2019-05-04 14:38:05 +0200)
>
> ----------------------------------------------------------------
> Update slirp submodule
>
> To fix Windows on ARM.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

