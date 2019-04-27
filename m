Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F2AC43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 20:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825DB2087E
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 20:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Buu5NUVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825DB2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKUDS-0005cO-DY
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 16:46:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKUBv-0004Sf-66
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 16:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKU1r-0004IC-Ak
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 16:34:36 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hKU1r-0004Fk-4z
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 16:34:35 -0400
Received: by mail-ot1-x32e.google.com with SMTP id f23so5513560otl.9
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=I7l4UFdE7EkTEIUUB5xZlIPL15QwDt+c70BJ5J3k/9U=;
	b=Buu5NUVz19H2PuXxdVgTp4jSVGRcPVhhGnEYckizZJhPk84McYorLmn3C+GM0x1buO
	zBtCWmg7ynRTrQWseotZfMnwuobi5OVj+RCNk/9zNtc3M2aCpkUFMwyt0H5oXBEXZykv
	oocmUX8AWGttdnSn3WhM1WdnBjumumwfjydLB5bBmxz+HxdxfhY8SsWRCYsdVGo8yFsh
	1C+Brxh+qbB9I/KwFFPg3bDFRVG4edp0s/b0uxp9TfQMhJassJNVq5J/Nh+kE/OqEGIn
	45LvyR+X71GlHgwPtqg93EZNtdSJJcm6+lKvDig4y1twjcc7ldhrSY4RBjXRdh5HLf8i
	I0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=I7l4UFdE7EkTEIUUB5xZlIPL15QwDt+c70BJ5J3k/9U=;
	b=d2njdmEIzf4lcThFrVKyGGwUIdwkPkXpwokrzThFa9wzu0hjTSdxRj1sICp6NUp34y
	+cnwlgdTNANQo+rSWijE5LVeEDqCovlc9Hq7XBwQ6VOHKqSTxBDOlgpUKCPiGmVhiLNR
	HUGYYwZe8QO/maAWmNR/TCvUR7RNWTlX5nG8zAPTtaTvRcvH6YXuXI7QvfYhK4LpOXIn
	N++oszLLsOCcn7P/YZkXsYDgSZBL/nZzI0/aNl/KIcxx1bYbwHUum+CLIBTAtGKyEAAA
	vz0TIlTeudi+uFC5yh8MLPvp96pmikgbMLBGZm2mFCJYFITI5gBCOv/jK892+X6pqJWA
	mpUQ==
X-Gm-Message-State: APjAAAUgMyyoVC7ha/mt9/jDmP0AugvPVDPd5agBq6CcqeJlYTOYRGs/
	cVqX+79qsdcs55S+4Islmu0tQo8rwMfpPKYybvCzNQ==
X-Google-Smtp-Source: APXvYqx1Lzgl5Gz9PgMjrakFXD0SLGlQjjjlRRA5kzmdeq9Lhb8qCppO/SGojWxbFTcrfVL5JyM8AeeQ26jVxlbvNIU=
X-Received: by 2002:a9d:404:: with SMTP id 4mr31392219otc.352.1556397273077;
	Sat, 27 Apr 2019 13:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190425181342.15360-1-ehabkost@redhat.com>
In-Reply-To: <20190425181342.15360-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Apr 2019 21:34:21 +0100
Message-ID:
 <CAFEAcA9w6LJhGvQR5QWLF3c0d8i=ydcauPV2yZc2wpFNNJrB2Q@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/4] x86 queue, 2019-04-25
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427203421.MM68ufo8Hna9NPpfehCs3HTazKq9dvZCEPR2SQGcxjc@z>

On Thu, 25 Apr 2019 at 19:13, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to a4e0b436f44a4bb47ed4a75b0c05d2547cf12b1c:
>
>   Pass through cache information for TOPOEXT CPUs (2019-04-25 14:52:28 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2019-04-25
>
> * Hygon Dhyana CPU model (Pu Wen)
> * Categorize a few devices in hw/i386 (Ernest Esene)
> * Support host-cache-info on TOPOEXT CPUID leaf (Stanislav Lanci)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

