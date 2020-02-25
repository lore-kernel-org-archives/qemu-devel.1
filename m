Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28560C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB592082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkAf4wU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB592082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6eDW-0008RG-2a
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6eCa-0007nT-HM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6eCZ-00040K-EU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:41:00 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6eCZ-0003zO-AE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:40:59 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so145891oic.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pb+/U7imqyjzXMGZ86kKJoVY+oZrtOAWihXbdJqs4gY=;
 b=TkAf4wU3xzXpOmr3fN46lsAYoFvvcMGIMXblkykfUQVM32bVxlcSwTme3DJM9ANJYr
 jw8GSz7cyNdQxefp0/pgD0ly8yxzXBId0+o5pHbKNU3bwk7b31ssisUlTvYjkuIM+BOF
 n/HhTIsMgsnlEy7ACJSAlaz43GHhCQhg9aqMOm/eA7PgLd5+3j3LX2TTeUTZFxmq8xGs
 3n79Ir3U5jLJrlqLOra1ooVhjI/yCEdwd2W2qPxkCK7xiPRep9S55iLczSR9GBAdMXsH
 xTKQg/DIMstZhGIGNZ7ZV3Cpjv0Ss3urNBB4X6qGMnERNDpOMxC/YBbu7z/DvTFkeDOr
 cgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pb+/U7imqyjzXMGZ86kKJoVY+oZrtOAWihXbdJqs4gY=;
 b=cA0V1FRACLPlu/pDFfZr+A9mv3WKWBTcEr8OwX8jKszIeR+WvKc0ijOrvmcNJ5efoh
 j9sqOunuOc1xxNq0CPXSH/mxiRytFFuIgFbgKseEYUGVtxGDtsVwq/giT8W/0adPuKYD
 zLzcTKv0XAN0tBQsdZuRriBzKGEV0MA6YxPdZpuo0leFv53e0LC6oe7Vjr9S27DanISG
 QeoeGA1HAy7eCU4dySYgw7w6QNZrYWPjM/CRyaemQjE7+KjqTUdXvO5zaVyWho4Po536
 UwO5nWgVVqTTxNPHUypKKd9EoleNiJQTRGIBB6WFfy0zl+YfLcJ0XeYTCFa7VCydXwyb
 51pQ==
X-Gm-Message-State: APjAAAUW/v+fQlraLk7iH0UtjoS+0612iY+QpKa0i7gPef0AsNCORGfF
 5XJ9cTnVSWsySMawf5hDzxrcKIDU7At1/9xSgWc3XQ==
X-Google-Smtp-Source: APXvYqyxLH3ixPo5/xSy3tI+Slktvvx9v2UnuK/P+7c42Jen6zJOByxJzZNM3eftt3faLKoaDDwa2LKCxk5gm0L2x/4=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr50497oif.163.1582652458251; 
 Tue, 25 Feb 2020 09:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20200224222232.13807-1-richard.henderson@linaro.org>
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 17:40:47 +0000
Message-ID: <CAFEAcA_EgToSVs5CqZAwMog=-ZT=-BSNWCgC3+9+jqvvG6m+Rw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] target/arm: vfp feature and decodetree cleanup
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020 at 22:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The main goal of the patchset is to move the ARM_FEATURE_VFP test from
> outside of the disas_vfp_insn() to inside each of the trans_* functions,
> so that we get the proper ISA check for each case.  At the end of that,
> it is easy to eliminate all of the remaining tests vs ARM_FEATURE_VFP*
> in favor of the preferred ISAR tests.  Finally, there are a couple of
> cleanups to vfp.decode to make things a bit more legible.
>
> Changes for v2:
>   * Replace aa32_simd_r16 by aa32_vfp_simd.
>   * Add aa64_fp_simd, aa32_vfp.
>   * Improve aa64 has_vfp/has_neon check.
>   * Fix some "any" tests.
>

I've dropped patch 5 and applied the rest to target-arm.next.

thanks
-- PMM

