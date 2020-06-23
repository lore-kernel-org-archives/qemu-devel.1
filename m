Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADA9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DD8206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6GxJxy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DD8206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmzl-0003so-52
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnmz1-0003Gk-6x
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:45:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnmyy-0007JS-5p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:45:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id j18so3758531wmi.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=O6U9cm+DbwIGopQQHbmvlPr6pqaJLBQZy/jL4483eDM=;
 b=T6GxJxy7Xsj9keEE3/MUY23MBQETLRkHVxkMDuK/0sYeGlQrrkBoJwfplSMEFGh8AO
 YmU5T0vUFTpBJvkX9wrKjIrBNHxc37NU9MLlqT2u91DIq/NS5mIkid55+QPyf0+8oEbR
 80+8tBYQW6UUDEjLUzYLvhxyw1Lz+NY43gP8tP/3q9vpZ2ZVu/U3JBiUuq7lY9F6oLhG
 2F2LuTR3LBoQ1/iMx0ndMH0+UI5HFlcvTLvlLVhtoZTTI3KtbNv/VWzTHTmden2dWRPt
 wRpGoL8Wx9hUrG4f2p9xY+eFrmfrnYqVILhLMPPySKPm0IRiLe0fvRkUEHU3LvuhM60T
 LWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=O6U9cm+DbwIGopQQHbmvlPr6pqaJLBQZy/jL4483eDM=;
 b=b0vTHYLPRZJQsdIg7yOWlY9t0jDA3rw7B4cY3EKbpFAAhZs4Z1yl/8jcCwMoDuDouu
 Gp1CDtpc3EuPl86qkDLMUvvGYwhwlbX2Uj0FLd2i+txYoh+NI7IcjzRNkpn4Ze11M7SN
 Zx65r/qregNUMI/XkivzRB26jjRbtTSHwpazv44dZbv6KLtiqhb3yvQB90wz/SvgbFYM
 q2FzvLIZANJmy9WdauyDp3R9B6NGi0Cx6bl7S+xOiuNyvQyi95I0Al4Xjiy6/sP5tPWy
 T74S8Ltyu0OzDiubnfqONDmACzgKVClmbxKkIyuGbxfSP3K7MmpUmkStMYLwcT7L84GI
 hJWw==
X-Gm-Message-State: AOAM532BdkvwfxgkYQBzSXWZ68S/bm41NwR1dfdagCKnqPYXNXzksfCd
 gZu6+v/NSUkYjSCJ7myeT+jggA==
X-Google-Smtp-Source: ABdhPJya8NeYJdh0RP8a7bRLKiy5PoJ1n3qkV0xKZtqm8te2yCkrR4Z437mmsiSjjKozSSkGzO2hgQ==
X-Received: by 2002:a1c:1984:: with SMTP id 126mr24002340wmz.147.1592934314419; 
 Tue, 23 Jun 2020 10:45:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 104sm24331369wrl.25.2020.06.23.10.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 10:45:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6066B1FF7E;
 Tue, 23 Jun 2020 18:45:12 +0100 (BST)
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200522023440.26261-26-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 25/25] ppc64: Clean up reginfo handling
In-reply-to: <20200522023440.26261-26-richard.henderson@linaro.org>
Date: Tue, 23 Jun 2020 18:45:12 +0100
Message-ID: <87sgel7k2f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Several of the gp_reg[] elements are not relevant -- e.g. orig r3,
> which is related to system calls.  Omit those from the original
> reginfo_init(), so that any differences are automatically hidden.
>
> Do not only compare bit 4 of CCR -- this register is 32 bits wide
> with 8 cr subfields.  We should compare all of them.
>
> Tidy reginfo_dump() output.  Especially, do not dump the non-
> relevant fields.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I guess this means any traces that exist will need to be redone?

Anyway with your hotfix:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

