Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82681C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBDF2089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vj0DUpcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBDF2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRWH-0004Hr-C0
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRSB-0001lO-N2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRS9-0006WK-JI
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:44:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCRS8-0006Vm-TX
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:44:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id i1so14763479wro.4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FGJY4YyJcKGe5zH767lv83KHbec0j2Ny2zMvOd+NI+M=;
 b=vj0DUpcd0L2D9Seub1L3EJo0C4V0oKpduMMS+Z0QtJG01VEj27J3MC67bOCuPo261G
 MhcoiCtmbut3ZFk61TBvInB5xLttogOE1d03bTZGxAUsVeUcxTViZurFoWekryOCLZfW
 ueCbYMcaAVTPjjXTD3uqWQ6Nf+DOzn1wTPsSnzcwP68Uq1AiNVcWwKrVlycj7mnCaFnY
 Ba25wPCnMy8/CCdhgC5KjAeixAKO0mllPnhnt4GLq8xOv31F399CF+bDfo5dZCTPbeV0
 JFLucq3EjGkFaxxttDLP1erpOWSSRIQMHVyrlrguaYweR+DpLNR2DofEyAyGGB0DEx7b
 ICFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FGJY4YyJcKGe5zH767lv83KHbec0j2Ny2zMvOd+NI+M=;
 b=BYFnT0H8vpD08X/yT0IwCxBmO4s6TZPA40+0OT3VJJCCxfct5Zo8kSPhmNGssBnBsP
 qOwBv1g6YKc8UoJuI/DM9wpDahwGRuUQXeELDMbcSJbu9lu5TYjkt8ZRyjfTKNU43h0G
 a3FKdYtDVILDeJgyJ1apBRsPhsMlniKHj+3uPx76xp2fH2qfb3VisvrlnQGty1wKtFE6
 KRObR77/XpcbA7GQaDYkEPtO5BOaqkvMIUYTEtcD37kmecxmE2+9b0tN7cM2QuXpsWkV
 rr1p8U1CJ88dRbffCgyydaLlNPGvI+kTsATXccU0idvzaZyFTD4KB1tpppLESi4ZezL6
 2yZQ==
X-Gm-Message-State: APjAAAU75HSC9uBEMWKIYw5ozyn8RUoCgiNyYt3wermD3dxzpaucQEJO
 WlaSJxp/9MNuNr5N+tWs5/aCCw==
X-Google-Smtp-Source: APXvYqy5eBYEzK991kqlCR5T8U7nTSb1Esm9PWh0bOpNypLZqjJ5qOM1MN08zmrvqY9w9RntdU/vvQ==
X-Received: by 2002:a5d:4742:: with SMTP id o2mr233948wrs.253.1569257083299;
 Mon, 23 Sep 2019 09:44:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm20000732wmf.48.2019.09.23.09.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 09:44:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F98E1FF87;
 Mon, 23 Sep 2019 17:44:42 +0100 (BST)
References: <20190921043256.4575-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/7] target/alpha: Fix linux-user exception for CVTTQ
In-reply-to: <20190921043256.4575-1-richard.henderson@linaro.org>
Date: Mon, 23 Sep 2019 17:44:42 +0100
Message-ID: <87k19zarnp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

> Alex's new float_convs test dies with SIGFPE for alpha-linux-user.
>
> This is fixed in patch 6, where I mask the exception similar to how
> the kernel would, when passed through the software completion handler.
>
> Patches 2 & 3 fix bugs that I noticed in the process; the rest are
> simple cleanup, trying to make the code better or easier.

Now Richard has eli5'd the CONVERT_BITS magic for me>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

the rest of the series.

>
>
> r~
>
>
> Richard Henderson (7):
>   target/alpha: Use array for FPCR_DYN conversion
>   target/alpha: Fix SWCR_MAP_UMZ
>   target/alpha: Fix SWCR_TRAP_ENABLE_MASK
>   target/alpha: Handle SWCR_MAP_DMZ earlier
>   target/alpha: Write to fpcr_flush_to_zero once
>   target/alpha: Mask IOV exception with INV for user-only
>   target/alpha: Tidy helper_fp_exc_raise_s
>
>  target/alpha/fpu_helper.c | 15 +++------
>  target/alpha/helper.c     | 68 +++++++++++++++++++--------------------
>  2 files changed, 38 insertions(+), 45 deletions(-)


--
Alex Benn=C3=A9e

