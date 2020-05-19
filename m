Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B76CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82A2206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scGBCWH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82A2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb7Qw-0001oK-VX
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb7Q2-0000F1-1V
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:56:50 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb7Q0-0000D8-QX
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:56:49 -0400
Received: by mail-pg1-x541.google.com with SMTP id j21so247833pgb.7
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0++PSJWAhvVdjcv1UMNeF1TncHXGzO24IGv/wi2vUaQ=;
 b=scGBCWH5vl+RE2zFYNAPZxIQ43E5jvY25bc8R8QYSZD2HiUV04mmtBP2ueVF2MWPTi
 GBsGKc6PsghagZkIx1tRT74jIGpJHgy+M5dGUlpw6iZ7XmC8fFjjHQt2uaxrLyZNUP5w
 gl1n6QlC9M89SXCRKRdsWQiL7JvT0crhbkNYMDhb4cHVAWIjJNlOQhaeRFe4Cal/lvTc
 mwnTC3UhWU1uovNqKio2NoJGoAAX5D3EHROEjgsHt4vO7T7mOPPFiCmAiqew7+eQA+l9
 Fs8M3HEyD5mtCJSAgv1VhYhVOhw7pjQkDNBkpY9sN2x+9FiMiS1yN1N5G1CWPN8CqhrD
 C8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0++PSJWAhvVdjcv1UMNeF1TncHXGzO24IGv/wi2vUaQ=;
 b=KrJ2nAA5lAntdmZOkd4lWxpAa8ttkK8yGh5V6mGLXWxp6cFzx+wZxhBI9hMixvEy7q
 Yvkma1k7OVXXzQmMyOXD8g+TiFzVzxMbtqO9YcQLAtQFZU3XW28I5qkO+Wr/3Mf1J4LD
 zzsx5ER9DL6jAGqM56e3LWx+RRc8LCREWKn0xLQW3Vz4uvofygA/GxGwOvr5i+Tt1cPq
 B/HzIpiGjQH1MNYQk1YUeVIJa90W0L/R5V3f0ujZpFdHQoxBlgaK42YkU8rK1dW/xiXW
 JPUH1SDmk7ynDFnY77wl6XMAIUkTkxlgKG0pfSOtNzaNv/34OSF6Tev3qI9LZiRFhQt8
 RyMQ==
X-Gm-Message-State: AOAM532woQS2b7UbM6QPyVeEkeAUcj4KBMifGzqy+lRMysCl8uvrGO5G
 Diq0jYSaTuyzufa9ArpBVXy4RnQPWfU=
X-Google-Smtp-Source: ABdhPJykochRdBBym0j3JOxSG7R8lovi2HnR3mHc90C6+DTmsWyElFP50eN4sz5otYBCRALql1D/jw==
X-Received: by 2002:a65:5287:: with SMTP id y7mr605055pgp.86.1589914606622;
 Tue, 19 May 2020 11:56:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b5sm237658pju.50.2020.05.19.11.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:56:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] linux-user: mmap/mprotect prot values
Date: Tue, 19 May 2020 11:56:43 -0700
Message-Id: <20200519185645.3915-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new validation hook will give me a place to add extra
hooks to handle BTI and MTE.  But in the meantime, we can
adjust the host page protections to make PROT_EXEC reliable.


r~


Richard Henderson (2):
  linux-user: Validate mmap/mprotect prot value
  linux-user: Adjust guest page protection for the host

 linux-user/mmap.c | 110 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 33 deletions(-)

-- 
2.20.1


