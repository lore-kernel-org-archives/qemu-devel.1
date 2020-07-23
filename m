Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6703C433EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70ED520737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/gcgJHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ED520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyb7M-0005LZ-NX
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyb6g-0004Wi-VZ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:17:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyb6f-0003r3-3t
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:17:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id f2so5127513wrp.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=O23NpbBlsWAN5zzWgHextMTTgmipuL53FfbiQnR8BJQ=;
 b=A/gcgJHDC3AzX7GifREnpI/G3ANFkMgOF5gdeWzlhR6gGDRbH6XwVYlGuV9pDATuaL
 5CFG+hWQhYL7EwQnknKt8fFsuHpPtIFxeaqXChs4t4GFK3gPq2lasRme+aHuwBO04oi7
 OBJOpG9gw3uFpXrbFggSQD7I1/ckE5790FmlXz5ADuVqCQv1LzcUNAJTh7r/wAaeO593
 6wvwANsxGvye5+5BGVBcwdViaBj772uKBEJxbtrXrx4DUzdTBjvJZK2gZk2ex5LVjDSK
 iqV+pevtgw20ZonZBWa2raxttpxINVfI3WXAjzsV91Rr57FTyI1Me9z7XMhfEzAeCYSA
 g7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=O23NpbBlsWAN5zzWgHextMTTgmipuL53FfbiQnR8BJQ=;
 b=c8O4LHAgy2K22nZ2cO8aGxY/EpfYtA4gl6FxMhWzvQEtQVlQZjmQq1HxceN+f5MqDc
 G8y+Aef8lDm58KL7ZidJrj+RLHY+U2M2J+2I9/8iP/7xKWDpHMBrz2BvbHIGeVuR5i8g
 RMB7tQJ1D0pWSNPF03kyC37/J0bgS2KJP3T4rmxJBs2j99/nGbGLsTAUCsUVKJb+t824
 TWdEQh9gOFsrCpe7979Wmtw4bKM95eNKJqvdy76aICdjU84VM+GST+JoOy8EGqeegHoA
 zf8TxXDYVFkq2EEW9LLv2y5M5dNYikpYC9Cqf1UUoadyYvHab4PPlyyPmKJS44Pt2+Y4
 7vrg==
X-Gm-Message-State: AOAM531/pRW9ZigVq7odNIvsU6AnhqBKovuJyQX/Cs48zRHtp66MN6jI
 2R5v2S3xxvW6+g7csiw2UkzZRw==
X-Google-Smtp-Source: ABdhPJw8fdjSia70MLYVRxWluUAVhUiVprixu46Hv5CZsBVvgV/Pj43tu/U/Otfl7GA8XynUSnLm8A==
X-Received: by 2002:adf:82b2:: with SMTP id 47mr3926972wrc.17.1595510271336;
 Thu, 23 Jul 2020 06:17:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j145sm3891057wmj.7.2020.07.23.06.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 06:17:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB6481FF7E;
 Thu, 23 Jul 2020 14:17:48 +0100 (BST)
References: <20200722174612.2917566-1-laurent@vivier.eu>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 0/2] linux-user: fix clock_nanosleep()
In-reply-to: <20200722174612.2917566-1-laurent@vivier.eu>
Date: Thu, 23 Jul 2020 14:17:48 +0100
Message-ID: <874kpytloj.fsf@linaro.org>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Update the "remain" time only if errno is EINTR and flags is TIMER_ABSTIM=
E.
>
> The v2 restores the get_errno() as our safe_clock_nanosleep() uses
> errno to return the error value (and not ret).
>
> As we use errno, we don't need the special case for ppc here, the CRF
> bit is correctly managed in cpu_loop.c if ret is -errno.
>
> Laurent Vivier (2):
>   linux-user: fix clock_nanosleep()
>   linux-user,ppc: fix clock_nanosleep() for linux-user-ppc
>
>  linux-user/syscall.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Queued to for-5.1/fixes-for-rc1-v3, thanks.

--=20
Alex Benn=C3=A9e

