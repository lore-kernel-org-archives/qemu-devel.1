Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C73C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6126F20776
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loxfPL9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6126F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPNLa-0002Lo-8S
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPNIc-0000i3-Ah
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:00:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPNIQ-0003oo-Kr
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:00:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id e17so123645wru.12
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UZ9BFAzg6pnhcW0Gfb7V8AhzKo1m8niCY+Wyd5/pQqk=;
 b=loxfPL9Uu4+7WTMfu26Rt0dawRBLO/HlvvoxtnvJHiApQtMLYTGX3Mpe0DF6xoBirB
 fZT/UaWGB5rQimZlE+nhcAtgEWiTQwy3o/6LnL36Nw0HZ1GDgk2hWtsSeFA7vbkIaZIF
 +CYq2ZiU3VnUe5B6G56MOX2xo/4TXBNo4ql3U2AbHO+AHISl1yLA+sVNLBsdBqEm1+pD
 7OqD0vUBmVIIjujN6+bD7VlotMSM3yM4Ug5rs9hBLva540jb3n89G5GsEeYTOgQcvxMz
 5WMcb3yvVY6hCr3cLhri1leAT16dIZ8bUfnpRlkQI2n6lreyMgMwbTrsFIDmKuustI3t
 deWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UZ9BFAzg6pnhcW0Gfb7V8AhzKo1m8niCY+Wyd5/pQqk=;
 b=ndsPaNh5hHhlxR+b6Yrm5GiwybW5BxuAdYB8b95h/A8Yy/Me8iN98usciG32R/8rYf
 Eek451INt4jjwgf/Vxus9XEOHBb/TBgh9/Fb6msqoGcijdq/T5O5+wjRcUWHLpWnMIkV
 /gF+8X0YgdwtQWJrs2AW3ukxEdq1mznKYydmGvq465vecPZQsCYlUElM9ALw8bkh2nFh
 v3xBUHK1Lyjv4Lr7LVIE41jSW2ngiZdYoz1HgH6GaYv1FiR2T5ULIed+EbVCRobbJnsK
 A7DIttDX24Gjaj2RfmmpmZzm5Y+x11ft+HxICVixJR2HZrrwIRrBmyUc1qk8B1y2g+A8
 FCEA==
X-Gm-Message-State: AOAM5316G1dMGjkS22ctTr1diTFOcR/fLnxsVJ4mkDUmOBPGo377QTvr
 r1vcz10GUBkGCKkoEg1+Lm9DdQ==
X-Google-Smtp-Source: ABdhPJx8FkjezfRuD66XIdQ66v2B9nDRM45tyrpuBWSXYUvlstUMXqIX4aJBbUb3frQBh+QhxnRFmg==
X-Received: by 2002:adf:e481:: with SMTP id i1mr16752329wrm.391.1601892035293; 
 Mon, 05 Oct 2020 03:00:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y14sm11589892wma.48.2020.10.05.03.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:00:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7394B1FF7E;
 Mon,  5 Oct 2020 11:00:33 +0100 (BST)
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-3-luoyonggang@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 2/6] plugin: Fixes compiling errors on msys2/mingw
In-reply-to: <20201001163429.1348-3-luoyonggang@gmail.com>
Date: Mon, 05 Oct 2020 11:00:33 +0100
Message-ID: <87zh512dry.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yonggang Luo <luoyonggang@gmail.com> writes:

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

