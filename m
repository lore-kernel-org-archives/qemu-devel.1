Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0467AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E982173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPyu6NnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E982173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2WXj-00072s-12
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2WWt-0006Pd-6e
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2WWs-0001Zq-4z
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:08:39 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2WWr-0001Z2-VJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:08:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id r20so17841325ota.5
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RiAzpzzr3+1GCbXuk+91ty8sppWP/KZ5taFt9exx4G4=;
 b=wPyu6NnXRuSTUEkm9B4QtgKVsNYdpoc6qZz32I7f9JZzd6Tm9drReixh6FgvvrNbMf
 TYwUiRnG4bsoVXXf5E0HUZDlEGF10U0Wu82pRcypCX7vtSnBe00E2Vn6uvezCMTuj/51
 9ifJ3Aj8Ml4lny1cvOZvmKNlzxsoL4O2SWmjNAAZqr4jhta1V/t+tJo3r8yo3uOM5TY9
 gjK5Gc9K/hGGB5qVHLQQ6rLeR0xw8dgWk0P9VyuDfhWvuvNScj8JhF4aGq5H0KtxdQYY
 lKd/lUzNwykt+ga8+dYMWpQn1dQo76DE7a5vH5e6wMKCUwSvn+9RSIY+SWZ0809ActtH
 RGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RiAzpzzr3+1GCbXuk+91ty8sppWP/KZ5taFt9exx4G4=;
 b=bdBJv8waK+od39zn5lTopRNWIcJc2p1aGVbkkgiylg7RlleMEJyCkt0hMJUBXMrrBw
 O6/wejxKzqik8XYQzEFBA1+ydA0Bdc6QQor7yBEvfwgd0OOt6Hwd4P+mQnb2TdIMlTkI
 1tWCNQbO0KI2WtNIbkNcWO61kNKecuvC47Pm24mVUh+j3Nl+J4Ku1US2A3iBd1MR6DU9
 YoR/1AC2jpl0IiwM+mYBAnixwk9k8sJ/DKJuDmxwitiz3f9nYcfUUep1wrwIL01xWn0O
 WY2oJKbdmYKyH4mNoLvaMnihW8F+Z7+ToJsY5gX/aukStd/92PNxybyX6haj4dfjyTQf
 aS/g==
X-Gm-Message-State: APjAAAW0sEdVRIBLoHk7Wi2IqgNoZKv0xOCQUp/xLUulVDL3DLPaIHi6
 goHA2jv+o9G7xl9A31TFoRxhk7wzaykQLw1g80wB+N+qHh0=
X-Google-Smtp-Source: APXvYqxDXObk3zt8G4+hwfjhUM0epWIF3JOOu1BDQ9KDpKtXZ276Mv9cO32ZAGE30iVXXSKo3tZ37LHnhkuUIMU07rM=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr2224889oti.91.1566893317285; 
 Tue, 27 Aug 2019 01:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <CADgy-2vznasvwaUwNSi96Sy=ucPC=-3e=O9irqc5DSpV_uhWUg@mail.gmail.com>
 <abf5f3b6-7c05-a85b-051f-9905b8f50041@vivier.eu>
 <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>
In-Reply-To: <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 09:08:26 +0100
Message-ID: <CAFEAcA_9G9WVhqozgJb1zUxkf_botd-Wq_=X26U3JdwCtMu4+g@mail.gmail.com>
To: Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Marlies Ruck <marlies.ruck@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Aug 2019 at 22:10, Josh Kunz <jkz@google.com> wrote:
> That said, overall, fixing the SIGRTMIN+1 issue using a more-generic sign=
al-multiplexing mechanism doesn't seem *that* much better to me. It adds a =
lot of complexity, and only saves a single signal (assuming glibc doesn't a=
dd more reserved signals). The "big win" is additional emulation features, =
like those introduced in MUX patch (being able to utilize signals outside o=
f the host range). If having those features in QEMU warrants the additional=
 complexity, then re-working this patch on-top of that infrastructure seems=
 like a good idea.

It has the huge advantage that it doesn't break existing working
binaries. That's the main reason we've never applied the 'just
swap another couple of signals' patch. The other possible
approach for avoiding binary breakage would be to silently
ignore attempts to set handlers for the signals QEMU uses,
rather than failing them. I'm not sure what fallout that
might have, though...

thanks
-- PMM

