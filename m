Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4039AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE4720678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTdl0fNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE4720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmIC-0007n0-6t
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLmHM-0006in-LK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLmHL-0003KY-Ga
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:20:28 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLmHL-0003K6-3r
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:20:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id x11so2682838otp.6
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x2+nwSjRG6XjsqnAHFP2Vana1pZcaxvgG6B1KaoFv+k=;
 b=vTdl0fNnGhhXTHIm4CgpKMPFbWxw/U51MywzbRux6SomKND9gX35Peex2xtrD4EDtN
 f55Ep6W3yB13eDYkJTSaZ2Dm3puKwYbC+ofZm5KJmDXbV7mUhNrbUXQ1kJ3DEDcNiJae
 W3gYKqRlKhJ1Yo5RoqndC0mGEZafooR54uJUcLHtaBoXKICZ8onD2Y5v3nZqywugEoFD
 ddXGYtihDsOvJrNL3cdvRUfYLBtyCfIt67Ghuv4iGtdZmHthfiBPuxP5ZfH0rFRxy+Ss
 3L/ZP0thbYFIH0z483SdeFRCFmdQNEQTMxUyteH/3cMfAOSB7HRqG4b3mbxr0s+H0U6R
 1qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x2+nwSjRG6XjsqnAHFP2Vana1pZcaxvgG6B1KaoFv+k=;
 b=JQZjWHSo2w6iZ8wdp5b6oFhFjqr1NOSzS7lnHY1lAYiUaQqZBa//Z5JZ/+v0EaQjvJ
 ndPJA3UGQ8u4QLLCRWzDnu7DtUrl3l6mbs1T31lf5pV4JBf13OfGOI0zPi77NIy1QNIl
 jxLVWt3GRc5pyQHgZKmWPRK7ZvVbwfcUUZe/snPk9XJZJPWkPo7Umlr3+31ZNr639mgb
 BjXSBvGB8QOTTvt5y39DsP/ImIOfiErrGZJVo2LHBmzI5Morw48eV4+7SDRfP4Nrst7C
 cmRXENhbFxeLdOVwVV5StyVivgQznkfWpn+Q/wXL9CONcrcmqwpW/hu6e0fOodJgmsjs
 7PkA==
X-Gm-Message-State: AGi0PuYO3pMATWB/ZHDUxv3GgaGVjjnUgFw1jnBt82LgueaAkLH5LJQS
 /jhifNmwrAuluaIIk8a2Eu5WR543pwegaCR3Bi/S1g==
X-Google-Smtp-Source: APiQypIhMj5Pz0erUPm1pjzU3uyMnck4O8rj0UfeCkiHyQ9He4AvZgrPVylSdUsbOTj8lywLRkYhCv/T5je5RvWpfM4=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr1031562ota.221.1586258426249; 
 Tue, 07 Apr 2020 04:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200407111618.17241-1-cfontana@suse.de>
In-Reply-To: <20200407111618.17241-1-cfontana@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 12:20:15 +0100
Message-ID: <CAFEAcA9SYT227B9K7yHcv_J==r4xZ1spUSNzL_bRXUpAjT5QVA@mail.gmail.com>
Subject: Re: [PATCH] configure: check for bison,
 flex before dtc submodule build
To: Claudio Fontana <cfontana@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Alex Bennee <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 12:16, Claudio Fontana <cfontana@suse.de> wrote:
>
> if fdt is required, and the system DTC (libfdt) is not usable,
> check for the dtc submodule requirements before trying to build it,
> and error out with a helpful message in case the dependencies are not met.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Does the dtc module actually need bison/flex, or does it just
print an ugly warning about it? We only want the 'libfdt' part
of dtc, which doesn't need the parser, we don't need to build
the actual dtc compiler.

thanks
-- PMM

