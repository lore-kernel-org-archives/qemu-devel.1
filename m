Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5441CC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEA020663
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLJPxke0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEA020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVF8-00055m-PI
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:27:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDVEN-0004kE-D6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDVEM-0003rO-CI
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:26:39 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDVEM-0003qq-3y
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:26:38 -0400
Received: by mail-oi1-x244.google.com with SMTP id t81so10671734oig.10
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=HjWcxPkGku9x/znPE18WC/FKYzVVqNJRTEHZ12NnmyM=;
	b=SLJPxke0aCybzE548ibjkHhA0apgGW+VmXADE/zcDqMsqPyF4JuQaZprdt5KVIs6eH
	1d8eG++zoIBbxjV5E9YjVzyCCi7AQ12ntZvdSFraoYEvvjQWiQKnTW8zLhhphGdjy5AO
	oUA7Kzd4GkQLq3ETcmi4IIH7PPOnPJTv/YtzZ0pa4tFYRaZ/PoYeu3jOV1Elth8UwdFU
	CKjn5heYlKf88JUZDya2hIn1Nk6hELGJ94fhFTx5q/keMeiRuTbl1tDknyw9quc5pegq
	n1PaPPUFEYwQmys5fI5K00lIbZd2JWnOiNeCOBjXMl5jpeSBhSaGBPSve5QCMG7gPCFM
	Kjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=HjWcxPkGku9x/znPE18WC/FKYzVVqNJRTEHZ12NnmyM=;
	b=F3HSZ2r8bBhYtM7BW5IAFTS2jJvVxcMXelTCfuyisvKiO5SksdsNtb23OhinuYsD1r
	8JszaKa17pd12u4G6zO0altfdReqXNCocdabT4DD/Zgv00u/rJGyvCHv2Abb2/MJu6GN
	5OcBMAHVDckYTApyzoCtVDwd1A87zoniHPjl7peneynbO4SWe6/vGFfLMzn9HCkQpnZC
	GVzrqJYZV9ptmHGkbaas6k0GnC0mO0R5MuBzXKT6c/JVvZu5zb1Mmw1OwIuHuv0iU+3/
	MZJgkKoRQnGqlCDCL6tmUsE9IEN2hgdgCrWBvlqPBaEwJ7UZwgmRzOOiNHIl2Gf28B1C
	XITA==
X-Gm-Message-State: APjAAAWMk7IyFJN8gbdr7uLas7/MicpgVXHPVk3D4UgNMcUBIRihhQYx
	Q75IMJjNmtaxGGkTyLaMAfYuvsbe50DpJDmVh5LgUQ==
X-Google-Smtp-Source: APXvYqy6BrWDRGaQfsiHsUr75HzaSRpbFWkf6TO5pEwTp91kmjL8kpY5nf3gN+aM/m7xi4wIpNyVtyiXmx5J8dg6L64=
X-Received: by 2002:aca:e054:: with SMTP id x81mr16019715oig.146.1554733596372;
	Mon, 08 Apr 2019 07:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190408133854.25737-1-ghorges@xiyoulinux.org>
In-Reply-To: <20190408133854.25737-1-ghorges@xiyoulinux.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 15:26:23 +0100
Message-ID:
 <CAFEAcA8F4f9o84MnWPseujJTk58j2ky4pghVGJPZm5BA5MRK-Q@mail.gmail.com>
To: ghorges <ghorges@xiyoulinux.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] Wshadow in
 qemu/linux-user/syscall.c:Changed some variable names
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
Cc: ghorges <1298394633@qq.com>, Riku Voipio <riku.voipio@iki.fi>,
	QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408142623.xVTT1p6uIi_hJdMsiO14m2SMykTs6uGy7Owel_foxWs@z>

On Mon, 8 Apr 2019 at 14:40, ghorges <ghorges@xiyoulinux.org> wrote:
>
> From: ghorges <1298394633@qq.com>
>
> Signed-off-by: ghorges <ghorges@xiyoulinux.org>

Hi; the name in a Signed-off-by: line should generally
be your full name (whatever you would use to sign
legal documents, etc). This looks like maybe it's your
login name or email address instead ?

thanks
-- PMM

