Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E520C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2CC21852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynhfCd7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2CC21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiytZ-0004Hv-9f
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hiysM-0003hZ-Mf
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hiysK-0005o7-Qt
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:22:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hiysH-0005kE-70
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:21:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id p13so6004720wru.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QI296PO/ZCC15eRNmTvOQ/OuzNs+RIluoZ6T6A4J85M=;
 b=ynhfCd7z/NUjv3nQxTc5ZdsQamJXtslHKp451ltVCVCtuURimPKSEwZOihWtHinla2
 vfvMlqsFWOnaO6RSObwBqaqz4c0KCAEWjzF0fS3mms0WQe8zMcx2vJVZzfpdbWMBX2gx
 keWtoJT/Roi2Qyi4vSedguvBXUnRb+xKCNy0/SgnNia4jyyWiV/i67H+csPf97sIRFRv
 3KKnOAWPrEma90rbgZuoqiGueuHLhheATeetVGCoRYOtIfHwa2boVDMVeFCDHpo3N4Cp
 Q5J8Usvb1TtbnSP05bZCY3o2Uv1wYXorhMfeXLgZBLupheBUrKJDBUpVXanEcYEmnCHX
 VhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QI296PO/ZCC15eRNmTvOQ/OuzNs+RIluoZ6T6A4J85M=;
 b=ICazFvdTKbtQWeijjgsASMIFWZoV1vJXs2X4Baj8duQ3V3Ugc+VfmE8JYHr6NjTYwr
 Unn/SWD2x1XSdUmhGh9MZVbPACohedbn3zz9YhcQ3d/XpPecVHBxWxS/WtLciD8oxKU0
 kI/vz6FTRKKgtgrKtQ9NEd/Y3rabkL599HxKJ7tXy9Hv9d2/X71o7bHxQOCwe+pbZmyS
 KBoYfl2fwQU1hzGAT27eV4DOd8vq52GK0iIJgl5+Xe9XHhfXeInxMg14q8S2mQs3+6KJ
 WG1Sx4mYkknFRi/rq8KrQb1g9vfSTXBXPUNJCnFBMDtyClfFy40HZCYaj0ucAmhulr4d
 SVzg==
X-Gm-Message-State: APjAAAVXY5QeuyKy8PPWw4Qr2AGqUjSrEGJPatVGVcwNLQn/JSl8+3Cz
 wRAB/a3EzEwndRUISvzGOwRv4A==
X-Google-Smtp-Source: APXvYqwvFM2NnwYc6DGDqD0QarWTJ6g8nXB2Hi+SXYt7GXMw0LyXE07bF/TthDhsHnXZsaLRslss1A==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr34746734wrs.240.1562235715534; 
 Thu, 04 Jul 2019 03:21:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x8sm3478724wmc.5.2019.07.04.03.21.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 03:21:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C7051FF87;
 Thu,  4 Jul 2019 11:21:54 +0100 (BST)
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-2-alex.bennee@linaro.org>
 <927219a5-a56d-bbbe-26ed-ffb8be12f006@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <927219a5-a56d-bbbe-26ed-ffb8be12f006@linaro.org>
Date: Thu, 04 Jul 2019 11:21:54 +0100
Message-ID: <87ef36w14t.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v1 1/4] target/arm: handle M-profile
 semihosting at translate time
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/3/19 5:52 PM, Alex Benn=C3=A9e wrote:
>> +static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
>> +{
>> +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
>> +        semihosting_enabled() &&
>> +#ifndef CONFIG_USER_ONLY
>> +        s->current_el !=3D 0 &&
>> +#endif
>> +        (imm8 =3D=3D 0xab)) {
>
> Extra parenthesis.

The wrapping on imm8 =3D=3D 0xab? Do you want that cleaned up on the other
patches as well?

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e

