Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC2C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96774206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yz3DZz0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96774206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i060r-0001Xe-PY
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i05zd-00006w-VG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i05zc-0002yA-Mz
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:24:17 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i05zb-0002vn-VZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:24:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id q20so5408609otl.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9/XqcEjqZQcCuL55U5xMT+H3aHbvN8Rtmrx1tXl80Ek=;
 b=yz3DZz0JdC2uvCvIGv8fOqN0hk3NGstvZ2WbD6HK1HO2y9guO4CktkZ9JTBskHZrne
 k9x1XWLKjX1/XYsT2gzDyxRMbVIfQNNydU/EAgv5Mg9MZhhIhMJzzicj8+SErrxk5Toh
 OtZxwrvm7+TbajbnEwdYTwisvgmdt2oY6STOKsQKayO2KVhe5nYk274LjFiy4qFPJadE
 3uX33tC402IrM/i1/lJJQbcfuDmB4wiOdlx/unaCKYpd87JwH1lDRBuAl1WoYXpWfwNY
 s1uhj811WwaaR4VBns12tbLhOl2k4dmgSHXtQhKD1T+E8AL75acU60MjbGhUCV9iRyUt
 XJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9/XqcEjqZQcCuL55U5xMT+H3aHbvN8Rtmrx1tXl80Ek=;
 b=XQZ4RetSzG9WjNNOiUfvYTqwR1TaEnB+Je0g06Tn7ffiaSgAXR0cinP/wL5rVsH3KO
 9C5e59AxB4vK0NELl9JR6m9jd8WAF5ZbJNO1LDMQWJ5JUZxviBg09dhRNbx9vfAvLW9e
 Lm0KriWThOt3LGMeZljgDJ0ymExxhegIUOU73CIqO/RQCUsMOK8GwGCF85H59zxX3OqH
 UELKGvYNYqExJ+V7FfawIMIb1w5nHFBG3mfGLM3gqw6oWoYdzZxYnMBKq9BH2Fy/FFaH
 52SzW98nPHCKC0JdM5aaaFrGEWLMOBIB91NKgkDAr3P7+Csgy/crb4Ew3oZpZ+xX8M8p
 bkiA==
X-Gm-Message-State: APjAAAUMfOM1i+96oOdzuKqPH5OrzjQHnhndUtq1hEZNIAJsNdzErNTs
 w9ZPs2yLSYUw838GOQBKA9BU5hiqJk+8s+K36L9Ypg==
X-Google-Smtp-Source: APXvYqxc3wwSjLKgrEPqiV3CUD8/cROw4+Q9UXhZRwUEYU6Onkz7iOWKKUQG04EsQCkOg+eruKFN8BHA8TGSEyaJsL4=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr21414900otf.97.1566314654807; 
 Tue, 20 Aug 2019 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190803210803.5701-1-richard.henderson@linaro.org>
 <20190803210803.5701-3-richard.henderson@linaro.org>
In-Reply-To: <20190803210803.5701-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 16:24:03 +0100
Message-ID: <CAFEAcA9bpnMTo1Z5yi9wGz1T0knqm_TbK8YJgfyW+Xm+T8NrgA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v7 2/6] linux-user: Validate mmap/mprotect
 prot value
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 3 Aug 2019 at 22:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The kernel will return -EINVAL for bits set in the prot argument
> that are unknown or invalid.  Previously we were simply cropping
> out the bits that we care about.
>
> Introduce validate_prot_to_pageflags to perform this check in a
> single place between the two syscalls.  Differentiate between
> the target and host versions of prot.  Compute the qemu internal
> page_flags value at the same time.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

