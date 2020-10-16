Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E041FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A3B20720
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpmRrgdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A3B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTMEz-00065Q-TG
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTMDr-0004xJ-6U
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:40:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTMDo-0006g2-BF
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:40:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so2131388wma.4
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 02:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=huLdxlM2IgmfMclw8EYN3x9z1zofou6ivyUf9IW2PAQ=;
 b=DpmRrgdP6ZNZyy/beJo8PQQrOciI5Q0ARw6rzkgtvRpITqCkVenBlg338iwuyGnZ14
 f3YXy4QlH6EYv12d2upNz/t+uMOMMGspVBsZ+5UXxf3RkxVhNcnFutofIL6rQvEtkGqG
 jJSZiyB3rGi8Y3+AUvrsGTaH2q+j8NMTmDerUVduNofwDPpE5mvLtOi23TylCyq24eL9
 vQ7047uUEFS0LWb6+ar9xtjuLkwgOtu8A70PfltqOtuX3zKkNcSGWgiyk2ojeFimZcEJ
 7NRlFnhK6M/Ops7x8PbkmP11kJWqrgbGxQ+K5uIR8D6Xjks6KO35i1VVMYoKItxATzHV
 nEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=huLdxlM2IgmfMclw8EYN3x9z1zofou6ivyUf9IW2PAQ=;
 b=ddLiTDKqMYoQ8p7d6r1a+zMLU6ukT8aWplZyUdawFdfgVsFyVWfNl0YDsnZYqaPZx1
 /DONowLPHH+N4ihddbYgqG4TjSIaLllM8drjEnBd43OzWg4spgbE4/4a/hWwNtVyQMHb
 MXP7y+VRlM83W5MtsZObEPFCC4BiGof0igP90AbkYCEGvDqtbTemSUZ1QRJqWY06a/8o
 Onu1w6y1LTMXF0UJ184hVy6KQQrIws/BY/ZUuFQVLG3Y2Umu6/xlfB1bTLOrLCUb/XDE
 9VRkHnqxe5TT6GgCmb3M11H570F/gUqJlm2S/3c3hkXxVN6iRopuQfyKbDy31k2E/5zS
 XJzA==
X-Gm-Message-State: AOAM531FLM8+0gaZan3BfNPjeHQb+6LhuH9V4h31oSBt7bx/gcF8nxow
 8M7tt9lZpgLUgsA2D9La8maQEQ==
X-Google-Smtp-Source: ABdhPJw+21eNBx0XLSUBj1J8Tpi+xAGikKBwX8K/mPVIfpMlgb+xrQ79RoeW2vEl8jM9MF/dq4DHGw==
X-Received: by 2002:a05:600c:410e:: with SMTP id
 j14mr2856184wmi.15.1602841222565; 
 Fri, 16 Oct 2020 02:40:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a17sm2847519wra.29.2020.10.16.02.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 02:40:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C1D81FF7E;
 Fri, 16 Oct 2020 10:40:20 +0100 (BST)
References: <20200925152047.709901-1-richard.henderson@linaro.org>
 <20200925152047.709901-4-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 03/10] softfloat: Tidy a * b + inf return
In-reply-to: <20200925152047.709901-4-richard.henderson@linaro.org>
Date: Fri, 16 Oct 2020 10:40:20 +0100
Message-ID: <87k0vqwltn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: bharata@linux.ibm.com, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> No reason to set values in 'a', when we already
> have float_class_inf in 'c', and can flip that sign.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

