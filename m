Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F87C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCD7207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaokFBFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCD7207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4Y0-0004At-Ih
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb4XP-0003jM-4b
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:52:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb4XO-0000g4-8O
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:52:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id z72so4203745wmc.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3KO1nMTnNXE656bcXzEaTRcgJC05+j0kM/MObb+GXYU=;
 b=YaokFBFPlKNQUsL6YfSt8ba0Z9D4994nVs9JiqJz1agLzDDNPutlPfEY7dy45YET9A
 P3LyowZGkFASte1zcliFnNOXL8xEgdb8Gi4s8fbG7UJsbNk9b1cTQwda0V9FbaYUx/Yg
 WHtG8yEwvwage3RA41zPtZ5v7H2gnDyZAQ+PSIN0AYe8W9RQRuQDSEazgnSNj0NmJGg8
 lrVjH1Al9XdjIF6LAIbEpdCNmNhjB1J9j+BKkHD8idS+/fQ55m1/IN0or/5jxN5VRJ2w
 Ov0yLbXoDqloDP3ZRxRBZ0+rjBXplnAYpL8I2vWgM4ZPFSksbvsKh4McEXe1OpDL8VPI
 CfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3KO1nMTnNXE656bcXzEaTRcgJC05+j0kM/MObb+GXYU=;
 b=h3TCVTGF81nt30NDGKuovO5oRsgLQNtOUY34BDVbZZ8cRjWtX9J4VlAes9FeDffIoe
 mPCGMSVriJWfpSvrwYh5Pos3GIOEM3iVhJTtRZS07gYLmN3IV+rVvvkYaoK3Vs7wHcft
 oNk2hUhZWtwbSGGKYZppvfJOeNDvH0O9WLJ+ITD5QvypBQO7bequBb2EeOyeOUmJlDeK
 pxNDWBYF6kkwCeUxwofK4nwvLiUSpk8TE7lT2Q8440SdekIDVpUPtUTV/DwIbTM1oBc7
 oaMNRTVuhnWnkGJnUT6zyi1FQTLFRTv68az490arN3P9k3eSh9ax8hDyMGR03IZBmfrX
 tUlA==
X-Gm-Message-State: AOAM532KncSF0k8PcRJjacTIiwCXzOMV2ou5vHDydNOrGHlsc/gOVDgB
 k4wgchECH8GF104pSwTTISIPBg==
X-Google-Smtp-Source: ABdhPJzvZv2qooyJ6ipQ/SM94NTX9IwjHeTDwxGWT84Hn8GbjZGX5f4S2rV5YDYg+3fEor8+pgyVMQ==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr44269wmj.3.1589903532054;
 Tue, 19 May 2020 08:52:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d6sm17306519wrj.90.2020.05.19.08.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 08:52:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE0DC1FF7E;
 Tue, 19 May 2020 16:52:09 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-2-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 01/17] Use bool for tracing variables
In-reply-to: <20200519025355.4420-2-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 16:52:09 +0100
Message-ID: <87blmjj51y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

