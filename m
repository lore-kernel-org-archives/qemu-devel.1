Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713ABC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FDD20671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtHeoKtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FDD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRLr-0005O0-BD
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbRKu-0004Cz-7B
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:12:52 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:42471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbRKs-0006Km-Vu
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:12:51 -0400
Received: by mail-ej1-x635.google.com with SMTP id se13so4527319ejb.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MVwM5RUvMKCdq73SZ5HDiXc9rjWiYCJFRgda4rr1Nyg=;
 b=rtHeoKtqiKb36IyVDeng1N+XptgCjl+WGG2N0aIrQr1ytQG0y7iVAzB4dqhqzX0QQc
 H9Nk27AAJBK/y/0cgYqG4HTcO3tcWIkVr4yeLzymo097iwnQwSvXN1XZ/DR/ATDUjQQA
 hCwuUtYoSdn/+S6LO3VSf+/pUMbn8Ks2ibOX7UQPkhsYkSZlac6MFo+4L9XCnJ85xKrs
 0FymZI/RWykgNuY5w+BwAujeLGDqg3fHPxa+4krHrVIBcfqmqwSx8SHsJJxV3YoZ4rdU
 xmUHNvwif2lZqN1TUx1xGOW4z+O2E3nt0iFHAaQb9O1W2YuZd4KPwElM8mvYXUokvwlT
 ze6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MVwM5RUvMKCdq73SZ5HDiXc9rjWiYCJFRgda4rr1Nyg=;
 b=d5pMmp4t02za4Vrom8QNfcr5sScfdt0uvD8FWaOaHQHYetCEJdVTXEaJ+94OD662oo
 H2XQydosA6hAz6BwnPM4FZrlqWBSDoxs0Vdj6ii0CAqq5PiJDbFHuJpZFMrG0jGR8hjO
 VKMgAtrGNTIZT5ms9ykiT6XcC4oH9v/SoLz7YqgaeOBG3e1OUn0PH4uTxRk2zyBayAwQ
 /l0+Gfxmi/ow84syiGK7/GcG1rz3xqw2JJSAoyFNUuyMT1KlLFS+5xF+uCnFowwzRTgE
 fFM14o1uUBMw39s/2Y+OU8wJwPZeSn7dwV2A8cHN19nHW1vF6WM0Q9WzuT/wQvY9s1up
 YQDw==
X-Gm-Message-State: AOAM531az2pcMPAAt6BoM4IzjF4cMhQ28JCmJ+st6u/Q5pHeW9Kl2T/r
 iHec1QnL+786hn+/Y0eUhS9czQ==
X-Google-Smtp-Source: ABdhPJwdJFs9euY8qGop7OdjhTGkUJoczPRxREmRx8WbBbAyIrxiYSE2On4I0IxHvFHwT6UTRBK/Gg==
X-Received: by 2002:a17:906:1313:: with SMTP id
 w19mr4636856ejb.79.1589991169104; 
 Wed, 20 May 2020 09:12:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a10sm2046789ejt.76.2020.05.20.09.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 09:12:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EAF4D1FF7E;
 Wed, 20 May 2020 17:12:46 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-12-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 11/17] Always write for --master
In-reply-to: <20200519025355.4420-12-richard.henderson@linaro.org>
Date: Wed, 20 May 2020 17:12:46 +0100
Message-ID: <874ksah9fl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> For trace, master of course must write to the file we create.
>
> For sockets, we can report mismatches from either end.  At present,
> we are reporting mismatches from master.  Reverse that so that we
> report mismatches from the apprentice, just as we do for trace.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

