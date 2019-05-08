Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFBCC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C51204FD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Quqfpkkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C51204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37294 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMhz-0004tk-QS
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:34:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOMh8-0004aU-QK
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOMh7-0003XB-Sx
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:33:14 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:39723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOMh7-0003WL-NF
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:33:13 -0400
Received: by mail-ot1-x32b.google.com with SMTP id o39so18299958ota.6
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=TOPCxf1bApDzD2uiPivTv2wxgULm1JqUWA0wbGQdB2c=;
	b=Quqfpkkv8gYst6d+I7nyjLipb27Wfmpbj6jiBbcw1dRtfmtT1HYv1ZoGr988FeKfel
	Rp9omoBCWoIMOVNifgNXRwbf4tXxUJjODoYKTz0u+Tj8ZcNQ8p9/L+f3WEg5y316+1ci
	cQ+418xNDQbEhxGm+3ICV9VFbJtuUzTT6pWTvOAzoKXEktiyOmIelSGN1Daa+8Ids6C7
	9k/UmLUcgVkEfqlYpFWCowCKk8l68pJKOH2Ew/FRW7Ou4jvt6/vFslbDn6GgwtAqI/Ce
	KTrKTl2Tdwb3bykOoSYUh0itjkJVXwS6Xb7UJXIPReyFPldd+svO8CPQWWHZDzvBUS/a
	TlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=TOPCxf1bApDzD2uiPivTv2wxgULm1JqUWA0wbGQdB2c=;
	b=CL0p8qk1sShQUHRJeXCRdGFpoJw78MoBnkSd+vMnO29jRBr2PWPC9JIW9y4lGXhBVA
	CsxwGUKyUa3Ofb1oQKgwEGJPOrFk85Efo+DhA7dx1X5ps78fL8S3JLSeUHprXhUb1uk3
	J8AzOG3FYxZ4Ghd3LYozHeUHDTf6AAFR54TpxBecMor0Wl86XhG4Ea7WxrpwNZBzkG4V
	LbGDhAwltPyOz25Q0RduL7nwnKOifupBdQivudhlYgGZTjbsP1Ni+/pF+D4M1dtuH8od
	prWmcLQzayhS0H1mfolmySlYuVt+sOlI2dLzoa1xB9EzsIJPzGRB8zhCqO+ykFWtNypL
	Y6GQ==
X-Gm-Message-State: APjAAAUIsQvqIC65QIG8Urptt1zsEguRAMUAQGNyIfgROcTybShDY+fU
	0VfFjwp6elgeZ5/HrcogHpcUto3u7ZSFPBX+U/PLloAG
X-Google-Smtp-Source: APXvYqxaJJzTPdvBYuFmECwsrytLm3/u6NpRrSDBiwZndcs2daGfYL3dq4OoCrUPmfF1XaNOH9E5oI23G2BTvB0lDjo=
X-Received: by 2002:a05:6830:1258:: with SMTP id
	s24mr3946692otp.238.1557322392499; 
	Wed, 08 May 2019 06:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <155731026034.22594.3160504765111033354.malonedeb@chaenomeles.canonical.com>
	<155732093601.13635.15801388089086899054.malone@gac.canonical.com>
In-Reply-To: <155732093601.13635.15801388089086899054.malone@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 May 2019 14:33:00 +0100
Message-ID: <CAFEAcA_rk6i9LXkdJ0_cKcCnR4ijkwSQ3aOT0m=HYnV744U2gg@mail.gmail.com>
To: Bug 1828207 <1828207@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [Bug 1828207] Re: Request to add something like
 "Auth failed from IP" log report for built-in VNC server
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 at 14:23, Daniel Berrange <1828207@bugs.launchpad.net> wrote:
>
> Note that any use of the built-in VNC-auth scheme is always considered a
> security flaw. It should essentially never be used, especially not on
> any public internet facing service, even if fail2ban were able to be
> used.

Should we deprecate-and-remove the feature, then ?

thanks
-- PMM

