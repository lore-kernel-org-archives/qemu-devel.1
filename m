Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA7FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF77422CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSLXs3eA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF77422CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eQP-0000mb-8o
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3ePb-0008IV-Q7
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:50:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3ePZ-0007EN-Gb
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:50:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id c15so7481493wrs.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aMd+FmGor1m6cVbEb6BAkwUhmlGzc+FCfZrFk1n+zbw=;
 b=fSLXs3eALMbSNf8mf2TUekjcAUx4Vd7a8tn5RSwFwz1+lhYndfA6Q6d1dXiYj5iEBW
 qc0oOzJKw3qqU+tJgjMUUKcwSH43WU+3dFL5/sY0IBDVnRPlUVHz69EUPFlGeqP+L7Ye
 PMsL686ouMLENvDE90IwJ7x71CqdUzdqyhYbPRqBkb/ijZrEkJXGAYBa2Bg9Z3t7gWr7
 45LQdNLDgIKOBEB2WVBcrNQp3popUn4AlembpEgIhtheNUHV8afFGvRNGWsZ6xhH3sWs
 WBprDUFOuOKiK11CaZ5Ax4uDR4f3gRh2NPcq8a3Py3EdOWRlVarjIad2RfBwHf4RlbbC
 js6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aMd+FmGor1m6cVbEb6BAkwUhmlGzc+FCfZrFk1n+zbw=;
 b=UxUBAKZ8bmi9NfY8LqBIuOEKG26JKtSZD22Zx330omhBYdnQ4ebAACjV0lEFtZZ6e/
 Dx3DTcBgxD3W0wuEDLSPh4HBAWcQdoLkDSkgjBaQOV27w30gRJGWdvxnXvAP6uEMSSWa
 53Q8J/D7/guU50q2AfoaDB/m5Kym8FYsuL2amgirv5N+8xfIid8GKMU5gJ40vAHrK7QV
 56+xPPoJfUD9oa8kXleZEUXqDE6zk6BYd7t6cvHVSe2KebFAkHD4LD3aVlJu880Yw2/K
 CtGuu5Wuib3areO7cesr9CoDQr1Pl/hCGCRTt/EiZ2LjkdNvj/z/2Fj3cB7Y+opYrm2n
 W/gQ==
X-Gm-Message-State: AOAM532jJmbCJ7AA+fD+Ny7pgwzlfO4rtP7JYsElXQD9VqerBSCjq6Lv
 RYBYugWgy3AwRtlYBb11Ak6hfw==
X-Google-Smtp-Source: ABdhPJzDgrXLLIhS66tag+zIuCPaUAKRWcyIc7GFKPx855S1zXTevfG3ggLUmBJ4dLVLTKleUELEow==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr7464995wrs.187.1596714615610; 
 Thu, 06 Aug 2020 04:50:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v12sm6154950wri.47.2020.08.06.04.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 04:50:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5CC11FF7E;
 Thu,  6 Aug 2020 12:50:13 +0100 (BST)
References: <20200806104453.30393-1-peter.maydell@linaro.org>
 <20200806104453.30393-5-peter.maydell@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] target/arm: Use correct FPST for VCMLA, VCADD on fp16
In-reply-to: <20200806104453.30393-5-peter.maydell@linaro.org>
Date: Thu, 06 Aug 2020 12:50:13 +0100
Message-ID: <87d044kn7u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> When we implemented the VCMLA and VCADD insns we put in the
> code to handle fp16, but left it using the standard fp status
> flags. Correct them to use FPST_STD_F16 for fp16 operations.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

