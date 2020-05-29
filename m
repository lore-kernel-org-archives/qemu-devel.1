Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C79C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D0B2075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poWPHWm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D0B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeaR3-0007WB-SZ
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 04:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeaQ8-00075N-9C
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:31:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeaQ7-0007V0-4K
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:31:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id r15so2342360wmh.5
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Q15pkxLoNW0siDV3tqKTbyoCaayDbCzMhARK3OPwees=;
 b=poWPHWm2LZMe+S0atWBC6j5cpL21l6wdfj/AscO0tuHARsi3UnzmFt6QA3avU7iGoG
 O19zxnxyhaZvmlpkjZERTNBJDzjBvn109D/kVj+7r9MRAFOEJeJHV2YBIzZLMl8cULaD
 SAjthVo46Es36DgaOBnw0l5PRH6+DCWJroxy6hym7uanTZr7bGB0/Y8pgwztYYZYrsn2
 5ECIa2ka38Wgy/KPj2gaq1lpdn6ADUPJr3TCAtNJ0zT/Kz1XfE9rpMVBJihssYC0Y4KL
 4WbAAQfdxXGA2YmFKAYHUolPaUSADOBjC965OwXk1dFRdq7kx/eOSe6Oq8HjpT1CLfK3
 0l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Q15pkxLoNW0siDV3tqKTbyoCaayDbCzMhARK3OPwees=;
 b=sl6rYmy35fM33FHjUnpxg2kTc1sv7WumZU78GumAsodw7aCw4Q8wyvr3/b96MYw0/X
 10RoBsF3SrdvWNOJ4ukevzkyzthqvbPvKdoTTMf9GT3cu++dYKy04tjMdwl4klPRWHZ1
 BD9oXDEQT7OoO0plQ4T7icHKWv0Gu9dpwqy87vdcOB2G1KmhmOCwLEwuPes3f7VAWOfo
 ZmqY8rPAkWYdSa/vOMmoIUGetKw8QX3ko5WGeuSipUf+kVCdyFAvaAj1UQDy4dGO6qt/
 Rqo7NEQLPET2rmzNz2uYa2rf9ZMLl4IBXsxatGIdOOXUXPNnlFa6jYIJiglCwueceyzw
 dvcA==
X-Gm-Message-State: AOAM530g6wI9gdG4bcdg5JjgYDaWzaHv0ukzSU5ogDGieHaGH8BUPZSj
 /6p505thsbIIY4ku1uF2pe9TDg==
X-Google-Smtp-Source: ABdhPJy/s38kVEHkqq9RWE/rWzn5hUkxHrgeB+M18ikLDvWgQfRDO9QTey1oFCLLDHyBOHFlxkJxmg==
X-Received: by 2002:a1c:de46:: with SMTP id v67mr7368547wmg.146.1590741072753; 
 Fri, 29 May 2020 01:31:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j190sm10497501wmb.33.2020.05.29.01.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 01:31:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF5FE1FF7E;
 Fri, 29 May 2020 09:31:10 +0100 (BST)
References: <20200529072148.284037-1-kbastian@mail.uni-paderborn.de>
 <20200529072148.284037-6-kbastian@mail.uni-paderborn.de>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 5/5] target/tricore: Implement gdbstub
In-reply-to: <20200529072148.284037-6-kbastian@mail.uni-paderborn.de>
Date: Fri, 29 May 2020 09:31:10 +0100
Message-ID: <87y2pb2ldd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

