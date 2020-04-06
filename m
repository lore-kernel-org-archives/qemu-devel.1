Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA50C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC6020672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4qrPO1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC6020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVjS-0006Mg-Df
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLVij-0005w0-Td
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLVii-0005R7-M4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:39:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLVii-0005Qt-C3
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:39:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id w10so484026wrm.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zVsZYfvPkPZQiDGtrodSsuFSZlYWQpH7o6buIjo+aRQ=;
 b=N4qrPO1e2POPtQ8fn6T3M4g7TVOUwxPuNv/Xz2WwIAlcugIHr97qps91xskDwTAE1W
 munqZ8LY+Gj7pTen2qXML/9QYKF4yVX8C9F+K3/C+ENUfngEOP6BAug5oax3NkG8MIHg
 p1ZXPXAcylaBJZMV9eMnbo/0I6dj4Or0E4oCdSgprpqcwzkmNtzNRamh9amWegEbjX9v
 PoE7abH7/R2HPRwVedCFVfWE6CDQLWmGHpFwECfF+xrTYQD8NKeQLxRRMwCjvkqVf7PP
 DgJJ/rgxFIOrksXVTTgWlXv1DpT/OwOjoNG8L522hVhy7AEkX0SFca9PXDuMGnTAtel0
 xGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zVsZYfvPkPZQiDGtrodSsuFSZlYWQpH7o6buIjo+aRQ=;
 b=YxZ//Zu9C10+xjwockzhzVG4DRtqtr5IloWQzv7p1B8L+A5cvj7ysadxn2WB3CIQaI
 cnoikz4YtGWapIxISPskqSgtFLIOcQ5yAMCdSPxCQmMSj/X3Uu1EjXhwtuMAVowLYYVm
 Gkj9FVDpHOrBU+gHp4N9UmL9E17X/jaXKYIyqd+VmZZpNglyktP/lcG5t1q8ldIK90pU
 XPYOlQKrVdCd7DRYq0OBkoKz0Evhavyz3ew/vodeVDP1w3DpSO/CE+fYshkrfAO7AdnN
 UBeFk4Ut+r19hNDjy85rqo4XGd7ifL1RaVNzS7XGFiuwMRJPbhrzLvqX/FGsdB3RHvpI
 t0GQ==
X-Gm-Message-State: AGi0Pua3oS3fRPulUCBGwfgIzUxNu1OallygFP1NunN6AEUxNvgsRRYV
 QLIicl2BTDfB/No7djtKOrxOdg==
X-Google-Smtp-Source: APiQypJuHYEVPoD7P07KFcKxAoasgWYQy4U7j0VMZea2j3y2NQ7zgsLPAc86AQxErVllFJyKbPTRQw==
X-Received: by 2002:adf:ed8c:: with SMTP id c12mr369880wro.204.1586194775071; 
 Mon, 06 Apr 2020 10:39:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o16sm27385962wrs.44.2020.04.06.10.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:39:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0EF6A1FF7E;
 Mon,  6 Apr 2020 18:39:33 +0100 (BST)
References: <20200403094014.9589-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.0?] docs: Improve our gdbstub documentation
In-reply-to: <20200403094014.9589-1-peter.maydell@linaro.org>
Date: Mon, 06 Apr 2020 18:39:33 +0100
Message-ID: <87wo6sa4yy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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


Peter Maydell <peter.maydell@linaro.org> writes:

> The documentation of our -s and -gdb options is quite old; in
> particular it still claims that it will cause QEMU to stop and wait
> for the gdb connection, when this has not been true for some time:
> you also need to pass -S if you want to make QEMU not launch the
> guest on startup.
>
> Improve the documentation to mention this requirement in the
> executable's --help output, the documentation of the -gdb option in
> the manual, and in the "GDB usage" chapter.
>
> Includes some minor tweaks to these paragraphs of documentation
> since I was editing them anyway (such as dropping the description
> of our gdb support as "primitive").
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Maybe 5.0 material since it's just a docs improvement?

Sure why not.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

