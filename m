Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9829AC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33132177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJz6jueV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33132177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVH8c-00075q-9z
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1l-0006Ql-W5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1e-0005ZT-Ji
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so3783441wrv.7
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zfEkT9MWpUgAX/CaZqQt5HHYDxo93m40+dqR7AiebzI=;
 b=OJz6jueV2oYleN9bmgRUR2QIu/UA7VQPYy/c9trxBR7PKmn9aXXEb0WPDUcpnnhQzo
 rP1A7Xg1higfuGuwT386NRklR3lCNFAXocfs5Qa8cwIxpd27UiKyZ7FlhORcsaXx5Xb+
 Q8J1pzYSM4/Zdtsz9Cv+ougWynoluJAZP34t3zXORSKFd/6Gdg+6pFP2edq1tTZ0cf0a
 Vg+V2q1HQPK1uLHPNoaDG6+wcsRmvvfsYZZrS2DfBgK9BOK1XjQikvg6q3iezz46QwAd
 2A65U34IYjR88NX9p68gFrzQqtO6cV6sur7j4+Dweo/GFQUjry9+k3oAN94jlLWX5Dvh
 VTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zfEkT9MWpUgAX/CaZqQt5HHYDxo93m40+dqR7AiebzI=;
 b=oPbHf23heE7RoyF7LOb3/JimibRdu3xb7HSXr+D5F8DlNgUolGanlscjCdBXizJDE8
 fww4iXuAxh2HChHYX0bRTz0HWWxUpbHfyQJJ98OsxpowlUOPvQMTOgmd3j2QCcPlzM6h
 toepBTeo2fJvUtLhSml0SJ7bzOcR+P7J5OdHLrz7FOLt7jMQmzkopFgsyodcXxq0be3D
 N+/8fEDivWMTMQ6uHz0sTmCWnflpMo+G04OJxTO2RzjdgkzCsn+/5ij6YRK2AWMEb6ly
 UxWhABi2qaCvYoh0X5hlQNX+7irq5juh38d1x/Q9ZrTaeFBidJmct4G0C3Z0ZErtx8YZ
 q3QA==
X-Gm-Message-State: AOAM532Dq3xHeZIpfUcipWfs+ZTw33GTiKaPm5m72LLZeR8Kjq7gHLYO
 hRGmu6xbxFEiSZdXticR1mGsOg==
X-Google-Smtp-Source: ABdhPJxD9TNkAHgUNNVH60yu25lpjpS7Skqwii89ntIUJipUU9Z7z5mTZUoBd50o/iqVp5uk39n2JA==
X-Received: by 2002:adf:f182:: with SMTP id h2mr5737179wro.199.1603297902957; 
 Wed, 21 Oct 2020 09:31:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e11sm4759973wrj.75.2020.10.21.09.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 09:31:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0530E1FF8C;
 Wed, 21 Oct 2020 17:31:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/6] contrib/gitdm: Add more individual contributors
Date: Wed, 21 Oct 2020 17:31:32 +0100
Message-Id: <20201021163136.27324-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021163136.27324-1-alex.bennee@linaro.org>
References: <20201021163136.27324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Thomas Huth <huth@tuxfamily.org>, James Hogan <jhogan@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: <20201004182506.2038515-1-f4bug@amsat.org>
Acked-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Acked-by: Michael Rolnik <mrolnik@gmail.com>
Acked-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Acked-by: Thomas Huth <huth@tuxfamily.org>
Acked-by: James Hogan <jhogan@kernel.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 contrib/gitdm/group-map-individuals | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index d135f4b143..36bbb77c39 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -24,3 +24,8 @@ nieklinnenbank@gmail.com
 devnexen@gmail.com
 pauldzim@gmail.com
 ani@anisinha.ca
+sundeep.lkml@gmail.com
+mrolnik@gmail.com
+huth@tuxfamily.org
+jhogan@kernel.org
+atar4qemu@gmail.com
-- 
2.20.1


