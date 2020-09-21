Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810CC4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E61B2193E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aASx8amB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E61B2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRcz-0007gM-Gq
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRZQ-0005sP-MJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:33:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRZP-0006s5-34
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:33:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so14057551wrm.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=c49in41ZbHKxC42j4zrylQ3QDBsw4xZnFP8N8IvGLhU=;
 b=aASx8amB2z8C+7HEV3/dtK37N6uBQ/DEbPVdzzIExv4vbRM4EJqD6c/b99dDW3DBqo
 WI0s+bOti7VOV2bZKCJCtcKY/ktTzlcoq1MQzwjAVA6P5TOmmH27VXZSavs3oM08cij5
 JXOOuZCDKEYyWvpsaJNImVVlk66qp37VQB1QprXtRlq3Dijyna8EiSJ8C0qbPj5xrAor
 +2YYCSsO2C8VIEiaL+B8oCmZlmiZiwhxDmUkELsNzcYEXo1KHiyT0/FbHzLv2WKxprs1
 vCKgqQin/jVQepJpS1bu+nGAtnwLifSiSMnh151KEFWXop9IEaWcDRwL2UBw+eqzLI0I
 hftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=c49in41ZbHKxC42j4zrylQ3QDBsw4xZnFP8N8IvGLhU=;
 b=M9x9XQdVvKMrO2FbzYH8SZ1gb3QQPdD9RR8RD2Jr+1YUbizw/9cBt4XKyeYCJxv+lD
 J4uJpRHvUbQmSRhBAnCcikj6ipl8E6k+YiDyaAxei5S3UpIT15w7hXiTywfoa4x/IJpx
 03mM96Msy9MxMcShJAXlXIW7uMhQZA7j4g+kzG2ETQJlE7eeDxGEWAZLhDsLA954V9xq
 ZfmAzdvGUG0uHuldYDm8wSNsGJ1sGFII2IR/D0FcC5n+nit+/ooHndZKts8V0kaSNrhS
 pjJYYcBXRsx6tgKlzBUpue/4JXrbXwbQOfPIJCcYZzY+UuxjoFPXOnFaG1WSPup5TGtT
 4nJA==
X-Gm-Message-State: AOAM533HuMan2lU5vL6TnmNEWqeBotS5M3eXi8UBB0pq/+n0RTRuR5PD
 B9le9fnh3AJ3YM6HiUpeOGAJ+g==
X-Google-Smtp-Source: ABdhPJwM19Zx9t8/8NObeAq6B9nF6Y5oV8Hv5xxmwqiXI9Ur1FOtZ6MX7OcgOY3knuRDhK3KaRmXog==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr1330522wrw.253.1600716829691; 
 Mon, 21 Sep 2020 12:33:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x2sm22789735wrl.13.2020.09.21.12.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 12:33:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 593BD1FF7E;
 Mon, 21 Sep 2020 20:33:47 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-7-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 06/11] disas: Use qemu/bswap.h for bfd endian loads
In-reply-to: <20200921174118.39352-7-richard.henderson@linaro.org>
Date: Mon, 21 Sep 2020 20:33:47 +0100
Message-ID: <877dsmorfo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Use the routines we have already instead of open-coding.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

