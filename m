Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F0DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20EB20578
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VakNV4zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20EB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6wC-0005Gm-WE
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb6v9-0003Zy-3S
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:24:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb6v8-0000Pb-CF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:24:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id y3so520601wrt.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qIo38bHHhcBYwkssXcVXAeJmkACO285h1O7RJlm3CpM=;
 b=VakNV4zgAvO+kLc5t42ZLiCh7QiBF21xMRSt/ME4pfAH4NCf2OuVDT2i3tEBoZGHSW
 qLl1U/JKrXFvBe611gUHt49DnQWbrdSL5px7XRR4+isVSjc/bFG3YC8VqyJHSh523xKc
 FoU6EnQSBYKlXOJqJd/gU6IZJlV59VTcHh4GXL9aiD8b8Du5nb7gtJsflVffzk8tEzMO
 aYdRXJjG5+xq9hju4QLUUF6jjYZir6ajvRxebO3fvFSNd7OJyohC2QUlLI+ndoQVCnRT
 S0ruMZV6CtDWKI/9QHa3gYr+6G3S9ZZE5IdqAh4gKSND8BaZDIb1XnXIRapSoIQks6yZ
 Cg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qIo38bHHhcBYwkssXcVXAeJmkACO285h1O7RJlm3CpM=;
 b=MGTjFy8y1Oj/wHkE92J6nrpIDJLpRAQV0qCx65gi9GsSB1Vj6+XNsWL0D6crGBz4QE
 SrULGKQRsT0WU1j9kRpzy8RYz8Ta1Nsvi3ifQTTs1Q8sIn5j/38UPsKzDjvppOi4zjpg
 g0fdOfrKGw7AqciBrBKCG6oawHWdv5x/g7+HaIyouo7D3FGwcwpFQOHUPcrLbMVgyEcy
 WjvdSoVD81q6fjGTAD6x/dOiFWdM/VvEAfuHnIaTQjeWI5ZiSAuxfvS/EuAGVSWITJt8
 ni19IGAJMvYLu2Zec3UhjXNYMeaMx2hf/AR8ojQudGXhQAsDyABIRkfzCoNbOXcriJtp
 igmQ==
X-Gm-Message-State: AOAM531nRmf4b14RPmMYwjXAn9Wi9stGMSIn21JcMaxP+1Pd5mCjpe6P
 o6iBa8SMfRnaLRXdsk/pQsPkPw==
X-Google-Smtp-Source: ABdhPJyNTM3FniIkjPVxy3oXJCPHZJ2EjXK40JwUmavwoyRJHw6N6St3Rr/x5mbENPHD1a1DZp5W/Q==
X-Received: by 2002:adf:f4c4:: with SMTP id h4mr232176wrp.142.1589912692700;
 Tue, 19 May 2020 11:24:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e7sm300119wrp.0.2020.05.19.11.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:24:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E37771FF7E;
 Tue, 19 May 2020 19:24:50 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-6-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 05/17] Use EXIT_FAILURE, EXIT_SUCCESS
In-reply-to: <20200519025355.4420-6-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 19:24:50 +0100
Message-ID: <87zha3hjf1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

> Some of the time we exit via the return value from main.
> This can make it easier to tell what it is we're returning.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

