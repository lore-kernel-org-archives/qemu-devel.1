Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5CBC2BB86
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 21:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C0D2084D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 21:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygk6Jn5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C0D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNNoI-0008Up-P0
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 17:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNNnd-0007gh-4M
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 17:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNNnY-00011l-Jt
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 17:36:24 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:44991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNNnY-00011N-FF
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 17:36:20 -0400
Received: by mail-ot1-x329.google.com with SMTP id a49so5343565otc.11
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 14:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AFCX8uBAO5oHaGygn+0Q6IckVy4oHQT1YLexhFgx+3U=;
 b=ygk6Jn5wDiCmU6GWlnqOUFd3Guvx1z22eFNys2tRNl1nnHrCNpsBtVyzsRzMNiW1IF
 Iyaj9yosw8MKoA0SAtZSeczBl1iRlqx4pamrjweQ8Sbczv36a1SA71dcuKaz7Du44yLc
 XD9NKh47MW9pKTn0ij4K5w3s14pWRE7n+H4nktUVbGvRVkBIr2swjwM1I/0yk0VtzTPu
 CxY35L9M2M8UObPBJ90qlqqPeMa1XhG4xAk1y/NOr6h7atLt8gnrNX0mNeoTmiLA0stI
 EXB1r0NmiMUV3j7H8esu5Hph5azXhPqc/HmC263DwS0pOD36OTVD7zWdLKeWa5F+fn4L
 qWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AFCX8uBAO5oHaGygn+0Q6IckVy4oHQT1YLexhFgx+3U=;
 b=Xg7/CJT+XN9Q/dkUcg1o1W7A280hmfMcOFOLQZ45Uee02+1QbrJJVow7WpkpSRECub
 peuULv9NiVygMGLAVPTlVyAhsUSp8grJqFV0N8ZN65aQbVEvMIaMrCCiWjRGr9wL47b4
 W81KVEhFmFEqWgBkMik8lvQ3RN0VJn4yWZym1fTC/slCeJE2JK1+wWqTTsZl6QhxTfP3
 qnR2C5jLwHkiC4s0HbKR4AfMXjt8jMeSoWnwL27Tr4pQ7B8FPt0O5/5vBkYYW6AH6DD0
 xIQAJFxZWPnLccIiz6l7RVW0fnsi1rVj1hBifwyehqFz81vNWh1/J7qavVXkA3c0C/tU
 YOlg==
X-Gm-Message-State: AGi0PuZ2FhxjZe/M0v2mmxDU8g3nMMrEwLD5injeWO7mXjVolt+GfvJB
 CdQ5hVfsst191J11oBEPcV7dMBW4eipWx5encGZt6A==
X-Google-Smtp-Source: APiQypIbOqmW5nXtu9T/VsQrQleLJv440nkvdgivmEL85UW6B1V54dD42S4288LFx5FRh0B6FfdTk1Hz/td9EHR7XkU=
X-Received: by 2002:a4a:a226:: with SMTP id m38mr8938666ool.94.1586640979386; 
 Sat, 11 Apr 2020 14:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200411091453.30371-1-f4bug@amsat.org>
 <20200411091453.30371-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2004111953020.75236@zero.eik.bme.hu>
 <811e2026-963d-e4d6-b90c-2713f9f30404@amsat.org>
In-Reply-To: <811e2026-963d-e4d6-b90c-2713f9f30404@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Apr 2020 22:36:08 +0100
Message-ID: <CAFEAcA-ntHLEJnQ8Sd_c8n8LJmJ0X44VousM-BtNTndXRdf8ew@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 1/2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Apr 2020 at 20:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Buffer overflows are security issues because they allow attacker to
> arbitrarily write data in the process memory, and eventually take
> control of it. When attacker takes control, it can access underlying
> private data.

Note that for QEMU our security boundary is "VMs using KVM"; so
buffer overflows are a security issue in code and devices that
you can use in a KVM setup (including pluggable devices like
PCI devices) but not devices you can only use in a TCG setup
(where they're just bugs, though obviously ones we should
fix sooner rather than later).

thanks
-- PMM

