Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB295C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0C420757
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8PeckZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0C420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRXQ-0004bK-7J
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRVX-0003IE-Nl
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:29:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRVW-0006A0-1h
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:29:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id s13so596919wmh.4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8MVBXj6nGqGwqieH+K9nOUiLWNtCSxGz9o2YxOeNPA0=;
 b=w8PeckZxvB8UVvzhYZw9Z6dOEKG3qSXnIZJC0JKqgs54dxQOH3KVbFCPd3BJkNSYa6
 ZdUp+BqUZvumYJSNIjKjzFlmAs7SKBu05pEOy0Z/NBx3kUt954G9KpvFe2IrMEBs0mda
 chQhkyaskx/4jnGoXNz6Gu2SkymA1JQP4pp4hXaRFnJ2X8b92pPA7RppfJygEJLbRWWx
 G65zEutLCZLt+LKLDD6UT/FYrNIT9C+dP7tHfcDiYAnTQp5659FR/7YwGhTepxe/sDPo
 iipaVVO6iisYSRYHYzaroC/Nu44hQo24CWRJIBVgn+0As37W1udswp/Gie0l9B5ceAJi
 JcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8MVBXj6nGqGwqieH+K9nOUiLWNtCSxGz9o2YxOeNPA0=;
 b=T0+0yevAqvRP90IMhaxjTHM3619nu1ywORSiz7T3WYadj4K5ZL3MlDh06xdxOgbsGX
 g12aKMehIcIke7pFDyxOvowZRVFJZ2/5ffQ29fEsam1AECfUaQyl8iDsu0fMcZhQlIXo
 3ttb97FF6z9uYB2jFmluF5B0wm+IpbDIxYBzFBZtErk5pOFDL5kIwhdyZyRGRA8KnSPW
 u1BYtGvu4+EJ/1113OrnwwJDcz+/Vh0OXpq9m2r6vO2RYKT9CwS6zRAFv5s5Hp+vK3W6
 QSXx288+EVA30BG2MC3zACmcccwnBpAUNwqJBKKRwYUfRu0nj6DFeHvL4omqiUhCaWVM
 qfcA==
X-Gm-Message-State: AOAM531IInusvoYQx6K9MFfgSfACi3sEJOjTPuWVM6Jf8xSH8PMbGz9j
 VdCgNwxKN/ZzxKGSaMSr7QnwlA==
X-Google-Smtp-Source: ABdhPJyinxH/FbZoCqk0uzXB62SBLancoUw8hTuqBI7W9dVh2qnzDmIaWaiEJeAd25Gp2lCTzUpX8g==
X-Received: by 2002:a1c:4381:: with SMTP id q123mr848133wma.108.1600716588364; 
 Mon, 21 Sep 2020 12:29:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d13sm21845851wrp.44.2020.09.21.12.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 12:29:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F62D1FF7E;
 Mon, 21 Sep 2020 20:29:45 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-5-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 04/11] disas: Move host asm annotations to tb_gen_code
In-reply-to: <20200921174118.39352-5-richard.henderson@linaro.org>
Date: Mon, 21 Sep 2020 20:29:45 +0100
Message-ID: <87d02fnd1y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Instead of creating GStrings and passing them into log_disas,
> just print the annotations directly in tb_gen_code.
>
> Fix the annotations for the slow paths of the TB, after the
> part implementing the final guest instruction.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I guess what we loose in the inline annotation we gain in simpler code.
We can always grep stuff out of the logs if we need to:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

