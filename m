Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B035FC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 21:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEB320723
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 21:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0lB9bt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEB320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbVUc-0003W5-53
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 16:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kbVTR-0002rG-HA
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 16:10:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kbVTP-00026q-V3
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 16:10:13 -0500
Received: by mail-wm1-x344.google.com with SMTP id 10so3905740wml.2
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 13:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/Hs2cQPNlW09Lams1bFmLjYEr88ucbLD0gWpO5CkRkc=;
 b=J0lB9bt8/sxSJO1rd/LWo+eeqpxLxRWpQHIoyYXh9Hti61GVx5nIk+PBG5xnejWc8H
 4qz+42G6UAQK1TMO1BN1obq82S5hjgdLP/Ot3VTVFyHJXcu9CuIfuphqr6StE6dT+QtL
 gHDCFhiKDe9ya27mMD6USQEyGaGYKaN9OjbP7V1/33dSnFzg7cbC5rGmfAY4FvUnHelo
 kOagjxdVL2kcPJdtcd1uDAQkFo1YYv4//QuUkysAexUi2dewtkhouSqu4lKRFTQrqIoy
 R5GVq0AVWjB84veiMuut10YEt2FEw9UCOfIBPt31rp7L6Mf0Cp3Leh1AeslHtKbmv5g5
 HEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/Hs2cQPNlW09Lams1bFmLjYEr88ucbLD0gWpO5CkRkc=;
 b=cWPa0N0h7YkR4ea1n3X5L7cuMPJJRZ8dS49uTi7VEA+2S2zsQkHOUfxyHPIOW9Cb8f
 LtCbFYA9icjV4rTNeAVSLcTM42BlSLCgDv6OHmAAWHfQYN5Q95HEsb42bdd4I+nZmS8e
 tmjLaqzHV61aXfVru3A0ROakwDGJHPdouyn/9LvmzXu6BfLMSvoyzuciUwNLdYWST0qi
 TOu9w2F+h+a22mnFwYAGIn1bm4wXZXgT9byNYaF/+FEFQakAaxfl+F2lmQOw6pUHya6S
 PE7ppP0TdqqJ0bG+Cm/Pr444vh5jXD8fFWbCMhalZkyvaK7M4qhC2aJy0724tPaUb/ph
 NL/w==
X-Gm-Message-State: AOAM532kYr+fu9CWHub1cOJrkPxpIn2DlUTJshc7wRectM6OqlA20mZU
 ZHm7W2MdWbihQR7m0a5oZR8FF0k+GHKwEg==
X-Google-Smtp-Source: ABdhPJxIvAqOE3CZSXo9dxHcpXleeLwetw/8KgapTv/ALIUnnO0Ws+jUBAEg6MKIzgqfEjyz3ClUCQ==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr6650454wmk.4.1604783410574;
 Sat, 07 Nov 2020 13:10:10 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o3sm7504403wru.15.2020.11.07.13.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 13:10:08 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC74F1FF7E;
 Sat,  7 Nov 2020 21:10:07 +0000 (GMT)
References: <20201106032921.600200-1-richard.henderson@linaro.org>
 <20201106032921.600200-3-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 02/41] tcg: Move tcg prologue pointer out of TCGContext
In-reply-to: <20201106032921.600200-3-richard.henderson@linaro.org>
Date: Sat, 07 Nov 2020 21:10:07 +0000
Message-ID: <87o8k898ls.fsf@linaro.org>
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
Cc: j@getutm.app, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This value is constant across all thread-local copies of TCGContext,
> so we might as well move it out of thread-local storage.
>
> Use the correct function pointer type, and name the variable
> tcg_qemu_tb_exec, which means that we are able to remove the
> macro that does the casting.
>
> Replace HAVE_TCG_QEMU_TB_EXEC with CONFIG_TCG_INTERPRETER,
> as this is somewhat clearer in intent.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

