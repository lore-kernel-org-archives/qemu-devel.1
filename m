Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70287C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9572081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+hVxrjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9572081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMZ8W-0008F7-BL
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 10:26:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZ7Q-0007fr-LH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZ7P-0006ea-L7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:24:56 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:36454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMZ7P-0006dx-EA
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:24:55 -0400
Received: by mail-oi1-x22c.google.com with SMTP id l203so4562883oia.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=hSC3pAq6i0frW705G4cSNjhd35Ndsez9BTRyfTzshR8=;
	b=L+hVxrjRD22QHj2hlHfuZi57N2IxpeLomfvLKWPGtn/Wm4SmYoyBqSwynwx+T/auxb
	v9Qn8MO8t/7NAtccJ3QGP5tipQXg2/F58wgvVjZFtSQxZtrlfzL+mFvlwJxpNYuFMlrX
	UBndcGD6pcKVc17pu8Lt1lXbMD6A9QLW1Nj10D+Nl3x7YFFtWhxLSir2J8swlYIsNkU6
	OY1rfhEoK/pWDnGxHIeUkNxhsjMzJLoegunA9Y7kPaKPloEksIFEerkutCYitxiHHBCc
	VqRuj6EofWQUG3+xFoC36PTdFTTSmJdYYzD3zbfDNoy+5E+C4k2aEfvsN6V8NwL6rFO/
	X2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=hSC3pAq6i0frW705G4cSNjhd35Ndsez9BTRyfTzshR8=;
	b=OTKXWLMQ6D1IeDq8TzBT36yCuWiWV5grPtabo+gCp0cx/b1U68Ydt4EYGivPW/UqND
	cJuYlNks/3esu0Ks3IpxS4+dS+VoSbuSI8QWsZ8J342afK9RpxiBoViLD+ra6roeXnJ4
	acaZqyU5jsdsBFCHd+rrPOriA8uH6O6nX5ZmRv2JJFuVfwHYB+VuqWTkXVW4SncvN8TV
	BeOz/ONukP8UzQrPpQOhpENoZ8zu24iPM9d8YVWmeIbyL1q0x4O7fx2EnbChDB4MvwR+
	qFD2aTxjhLpLzhgu730TKWpCKdUOnt1vvDYpR+y8n+sOGmoUHm1j8fBwqamqA5EDK2fa
	wY1w==
X-Gm-Message-State: APjAAAUh8BwPQq/7nc5KiMaE5QRqA8KlWpuvAUgJxIKnO0QeprLnIXk4
	D82g9PPBW+Sxs/UAItQ84XTC46Z1CLnirXA8y/Y1SQ==
X-Google-Smtp-Source: APXvYqzql4lclEqA3rP77DhxkrC4SF9U4ro2MyPDvIGWYFOoH/nUacI9AGMyX8wsIN0w3QzaEtHajYKPifmSSyXjYjA=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr6400664oif.98.1556893493222; 
	Fri, 03 May 2019 07:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190503093118.15700-1-lersek@redhat.com>
In-Reply-To: <20190503093118.15700-1-lersek@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 15:24:41 +0100
Message-ID:
 <CAFEAcA8+bnR53GvtNFyPvJKZWufdLSq5DxR33dr_CMLnnsFdpw@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] [PULL 0/2] tests/uefi-test-tools: report the
 SMBIOS entry point structures
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
Cc: Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503142441.ICPpqh21cBscmfOjn8bVOCzplMfVScHuS-cxRUIw2hU@z>

On Fri, 3 May 2019 at 10:33, Laszlo Ersek <lersek@redhat.com> wrote:
>
> No changes relative to the original posting at
> <http://mid.mail-archive.com/20190425104326.12835-1-lersek@redhat.com>,
> except for picking up the review/testing tags (also noted separately on
> each patch).
>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

