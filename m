Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A50C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B3220833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJ24IAI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B3220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHzV-0003gJ-1j
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 11:08:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRHyh-0003Mk-2l
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRHyf-00046B-AV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:07:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hRHyZ-0001ul-S0
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:07:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id s17so3831832wru.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=TushoPMqqya4TeyK2db+t7nIHayxDFh0XERkZlVoOqI=;
	b=EJ24IAI4iDJ41r0wX7n2EeplnkhwGVGtd680b7LrSIiuQ7Hp5KQ109YKGrufr77sul
	4bEoIYn5to8QEXgmpaSGFyMR5wIqnY42kuhwttCb9K7VH2NxOn19FnWTCPiL3o6m0inQ
	2uF1Nzzbe1ryrZQPhEYUJ8/ZY00EGlXfBG6/4zdmW/ly9WySAlOcGOPnymK2UvFmRSp9
	LvkdjAnlc7GUCoT15YRcexpvdL5tR1LJ0QK0wHWqelb9NUcjMpjI31EfHm/k5jxmBtTo
	9vH22pK29SxNHPuIZS0EY79LDxFu4MD0F0icl+onha9yjT891jTAZ+DVwNxcrAxsoLfO
	ntug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=TushoPMqqya4TeyK2db+t7nIHayxDFh0XERkZlVoOqI=;
	b=Rj3BwbK20HQ/+j0PbYokFGjZKaMdTkH4IYjofJ5VXOkyfaR3qJRIjAr7bR5XfByYWA
	GFR/7MRenkzc6QtTS571CYkkiGM5WqWcjCe9ETbrp9TPv0vcgAhkdwi8iNCTvhJtuxoo
	5m/fYKPsG9RM5s4WgeXXFxcdNANGZoisxk8Lb84HBjPJkVuFq0c4d9KnOLh97QVPg+lb
	PQ+3u0hXwVG9IVNgAbMqxY+8QgZbiZSetZEWNjiSO6x7E+fYvNaGNCgmnP5XiocmDMWJ
	3KCCMebVYaurIS473GEbJsrK47MfzzBWahv3OepTorv4JRHAqAwAHdmT3HXuCoTowMIF
	fX4w==
X-Gm-Message-State: APjAAAXYyFGf2JN8k5E3zi0u+bmc9aqSNIs+UHaUprfhpczcbibaRX/4
	oxcYL/ayyMJ0jxHiB662/lDRKg==
X-Google-Smtp-Source: APXvYqwMoacX2Ir+70gkjw1vv0OIjB2mgBWz86ioDE8kieJSVn9u+tAjiv8jctwX7SQ1Mqrega28vg==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr29166485wru.212.1558019164605;
	Thu, 16 May 2019 08:06:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	q14sm3195061wrw.60.2019.05.16.08.06.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 16 May 2019 08:06:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1E0801FF87;
	Thu, 16 May 2019 16:06:03 +0100 (BST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-16-cota@braap.org>
	<87tvhyyv9s.fsf@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
In-reply-to: <87tvhyyv9s.fsf@linaro.org>
Date: Thu, 16 May 2019 16:06:03 +0100
Message-ID: <871s0ymobo.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: Re: [Qemu-devel] [RFC v2 15/38] tcg: let plugins instrument memory
 accesses
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Emilio G. Cota <cota@braap.org> writes:
>
>> XXX: store hostaddr from non-i386 TCG backends
>> XXX: what hostaddr to return for I/O accesses?
>> XXX: what hostaddr to return for cross-page accesses?
>
> Just a heads up this patch now clashes with changes that have been made
> to master.
<snip>

Now the softmmu work is in I re-based the series and fixed up these
clashes. You can find my tree at:

  https://github.com/stsquad/qemu/tree/review/plugin-review-v3-rebase

I'm just paging in context and getting back to the review now.

--
Alex Benn=C3=A9e

