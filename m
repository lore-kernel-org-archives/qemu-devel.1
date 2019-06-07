Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0525DC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C477E20868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ag+bclxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C477E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDZT-0007vx-45
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZDW8-0006GY-Uu
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZDW8-0003HE-0w
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:58:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZDW7-0003Dv-8c
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:58:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id z23so1639936wma.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fS3Gd2gHj2AwL5z6/kpqN+7ZdteTF9As4r1HiLW9udE=;
 b=ag+bclxr0Dodq4+XWCaAQpXGuE3W3XhDd3shabhP3iFv6niEXzVKsKaoWzYRtwekBv
 hdNX8fU1VLTJ6q5qksz+rW78iEVQmJ8ZccXJD2jsBc0v4I0cT/opB1V1K2rN3kyTOuLK
 W0qDLctxe1c9ydNCXQ+p4RAtO5Y6/HZ5CdD8TiB7oaYqSGyqB4igo3uKvVJw+HvnLCou
 msaocFlnYDlN7zWdecmKojtqXT3HIe46cG46UzPVP0HbPMJyHF+tMxvChzv40a6unXpA
 WVhAS0Z3z2pvxCrD5qg19KG0Iz2DdVShUIaH3knFRyQX1LX7IqW9qZkowPqZhMxhdo2v
 E9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fS3Gd2gHj2AwL5z6/kpqN+7ZdteTF9As4r1HiLW9udE=;
 b=tOwVOTGIoY/kctbgiJS8cxb0b+ahvFmtN79714YnKNyCh4rjWDDoBr48cGrEYJ/ICD
 HwGn0gR2Bf2KxiuDUmtuOFK9Xjhs/5/s5XwzmV4pvvBATdbT8DT23thPUJWHUuGhWlY1
 rW6yUN9qRpCVdfd0am2Tjka9as7vqmj4UohdF7A0askONdx15tjuJ6e7Y1DPAHr34m7x
 hGP332btTO54rl7wWDI0IJgz3ud6fwpdJPE/af1pFby+fUyqRzyFABPJG0S5hbQzYV2N
 efT9nJT6Sg0B6shpMo4/MvcLbtE5yxS4jdk5lnmUm/fIR0OC1bBVp5NnPwgfyV6RLfQr
 ZNmA==
X-Gm-Message-State: APjAAAUiv87ltbLIWhRwofGCRc6GnAF0swy1HqyjsJqVt7IscWZc/rkZ
 aGe6l9Tn6t2e/o9pHcgdmIzcqg==
X-Google-Smtp-Source: APXvYqz3BcYSGc9b8aE3UKDiW/Y3mmUSrTfUwUn8cK4G9RCWyI+xavDLxZSsxnot6EYGWGX+FP68/g==
X-Received: by 2002:a1c:a387:: with SMTP id m129mr3442839wme.15.1559908721064; 
 Fri, 07 Jun 2019 04:58:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x25sm1115704wmc.36.2019.06.07.04.58.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 04:58:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F8DE1FF87;
 Fri,  7 Jun 2019 12:58:40 +0100 (BST)
References: <20190523204409.21068-1-jan.bobek@gmail.com>
 <878suw194o.fsf@zen.linaroharston>
 <CAFEAcA-EN4cS-T3qKeVdGo6124J6e=7z3kjua5oYyomcw7LB4Q@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA-EN4cS-T3qKeVdGo6124J6e=7z3kjua5oYyomcw7LB4Q@mail.gmail.com>
Date: Fri, 07 Jun 2019 12:58:40 +0100
Message-ID: <87ftolsj2n.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: Re: [Qemu-devel] [RISU v3 00/11] Support for i386/x86_64 with
 vector extensions
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 24 May 2019 at 10:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Jan Bobek <jan.bobek@gmail.com> writes:
>>
>> > This patch series adds support for i386 and x86_64 architectures to
>> > RISU. Notably, vector registers (SSE, AVX, AVX-512) are supported for
>> > verification of the apprentice. This is V3 of the series posted in [1]
>> > and [2].
>>
>> I've sent a patch to enable x86 in the build-all-arches tests script but
>> otherwise I think this series looks good to merge.
>
> Alex: So should I merge this series, or does it need a respin ?

I think this can be merged. I assume there is more to come to actually
generate the patterns but it doesn't break any of the existing stuff and
has at least one test case.

--
Alex Benn=C3=A9e

