Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C43C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80862075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYb/XmF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80862075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6z8-0001fh-1L
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb6va-0004fH-SI
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:25:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb6va-0000Yq-2R
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:25:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id u1so238772wmn.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bcmMEMNagdP2OTgvAabIzSLwLOLR3y1X9CbKyhfzvA8=;
 b=CYb/XmF9XwSDF56TdqKK2DrGWShwdGCR3735lOlEbs/RcX6wUjf1d8sCL08TqrcRZJ
 hQ/lulOP22NbsYmycTV2XLdguGLGXNAW0irCfBziPFjB6yh+qWgSIgY8zKzcvMF4Sib+
 zZyKGd3Pe9/h42tkdTRiJn6fKUh21XG75oUIrpGhukilEhTSvY9m4bPJpbRS7vzkjTG5
 9LMUJPUywjAXmWKbu5nVs4dXsUeRr/nZm62E50CVVscRvn2vJhoC4Dh9yWzmMNpwr8c/
 mMaFUNjbURUSzWnRdRa1qHWTcikYC5FZeyVSHn/8F3upF3MSbjsbdKtX6FCc2Fe3gTUv
 C6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bcmMEMNagdP2OTgvAabIzSLwLOLR3y1X9CbKyhfzvA8=;
 b=Zac+m+sk34gKPcUQXojSiBxDUL8iVZrxhqgmKnKm/U1E/lM2ACIrbt++QEOvFUspyu
 m4Q6fPkl53gHCLg9xomoHry5kWSbljzwlbg7Il5dVGYXNQE7QdiroDKyEvNWNSxmwPVF
 MyZu70XR+7TWYAn3HefPjZJ1HMUXYIQSWzL1l34KJ7d+FLPAiiUKFp5Y43fERRSPp9mX
 S9ZQFmjSF2MUQ78UULO5gXvwy0RbSW7Xp8ajBErODqsgUSeP+FN32DMAa0zmcnY9qpUO
 Cc6klKJ9qgRxLANaZC7uS8xKAEuALitKrBRJjUExCn0CRFUI5354mmDIB/lQOIm/iEn2
 glNQ==
X-Gm-Message-State: AOAM531pH8lN3wYbmt0fWVu3dgr3esXXPFhnVwS9TDW3yc81ArMu1xqP
 4Pa72nOKNddlhdoN9dq9ctdH1ZEU/88=
X-Google-Smtp-Source: ABdhPJyjgXMcIEytJjLmE2elXDxTGR3mgGc8QmG9QglnHtlj0tvb8jKDu2lWBMNw2LcLbmtRvZoomw==
X-Received: by 2002:a1c:38c3:: with SMTP id f186mr729603wma.137.1589912720604; 
 Tue, 19 May 2020 11:25:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 18sm528880wmj.19.2020.05.19.11.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:25:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BC10D1FF7E;
 Tue, 19 May 2020 19:25:17 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-7-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 06/17] Make some risu.c symbols static
In-reply-to: <20200519025355.4420-7-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 19:25:17 +0100
Message-ID: <87wo57hjea.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> These are unused in other translation units.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

