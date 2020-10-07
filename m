Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A4C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAD3206F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnZsg2rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAD3206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ9Hk-00028c-Pe
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ9GV-0001FT-9S
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:13:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ9GT-000329-EE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:13:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id t10so2131880wrv.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=18dulIPt2dIMSmjXKoi7uSFamyhRelALvLKid9hS5bU=;
 b=jnZsg2rOtIev9xru8/KJXIlMaMUhjcjJ8slq7dkLQFsrBq8YW896l7rXgAjID7mLYu
 sbHAGmIKCi+aD9lr6TxlQ2O1fmWX4hsJ2qb5YkQj9AIwFwV4KJ0IGSaF9IKoM7Xq89zK
 EQ4X8QBultraYRXpfKu43LZrIEdmZo9OI7IffLa9CdDmrLZNnprUzUfek/BcN1vEhlPk
 Hmcdjd2ALye96V9JWp9UfdpeWhjqwCA0CJMxMdZXKG0wW9BG61Um/349VT99AP2XitoG
 FI748aov7NRrnG/IRbJvesMqTplSiTe9sDEnyYpXitUvL+S9nO0d377X4KbAFLwxqcmK
 jWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=18dulIPt2dIMSmjXKoi7uSFamyhRelALvLKid9hS5bU=;
 b=CHuqaJawEjtvyUgImG90dsJnvxvfShhx2p7H/e3/1hRgIZsnX36aQ1rrO2//RfcoDN
 uE4aUTxIMnBr/5vGj20B3R3A7rAxfUwtMr4QFgjUlwCS/AF1aSkTONqeEILhHLOPBwXt
 bZGWjqi0lAv0YoF3HM0A29ShvGZnapWOAbbRr3NPitNUHk2oXLlSAg/mvqDx7S3YluFr
 Ya/7t59Dp8ApgIhaTGVVskNCKT6QAgwGyDh/avDShKKMeRgKJvtBl9aXCCgsK6sOtPZL
 aVnRSLDsz/hUngnK4k/UMkQxwiYY+SP4Ku+bJxTTmuV/335LpKV1TR1f7nIIFTiV6Tca
 jMpA==
X-Gm-Message-State: AOAM5301BSwo9UgCi2rQO3KN7ndA4c8jqE7kbIQh23u5KgEaa+C63YW7
 LTw/ajm5Skj5CvaoWUmq4qG39A==
X-Google-Smtp-Source: ABdhPJwuWAewFZxrHuQdFE0l76khfo4gUODQ/e8spAieDdLG8cwWstj6ofAXuOZH3GXByk7FRVVJuA==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr3446016wrw.389.1602076431750; 
 Wed, 07 Oct 2020 06:13:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v4sm2613179wmg.35.2020.10.07.06.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 06:13:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 018CA1FF7E;
 Wed,  7 Oct 2020 14:13:50 +0100 (BST)
References: <20201007113942.2523866-1-f4bug@amsat.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/misc/mips_cpc: Start vCPU when powered on
In-reply-to: <20201007113942.2523866-1-f4bug@amsat.org>
Date: Wed, 07 Oct 2020 14:13:49 +0100
Message-ID: <87wo02yy9e.fsf@linaro.org>
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> In commit 102ca9667d we set "start-powered-off" on all vCPUs
> included in the CPS (Coherent Processing System) but forgot to
> start the vCPUS on when they are powered on in the CPC (Cluster
> Power Controller).
>
> This fixes the following tests:
>
>   $ avocado run tests/acceptance/machine_mips_malta.py
>    (1/3) test_mips_malta_i6400_framebuffer_logo_1core: PASS (3.67 s)
>    (2/3) test_mips_malta_i6400_framebuffer_logo_7cores: INTERRUPTED: Test=
 interrupted by SIGTERM (30.22 s)
>    (3/3) test_mips_malta_i6400_framebuffer_logo_8cores: INTERRUPTED: Test=
 interrupted by SIGTERM (30.25 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 =
| CANCEL 0
>
> Fixes: 102ca9667d ("mips/cps: Use start-powered-off CPUState property")
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Queued to prepr/misc-testing-gitdm-plugin-fixes, thanks.

--=20
Alex Benn=C3=A9e

