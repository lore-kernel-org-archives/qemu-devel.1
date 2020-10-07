Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A5C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 02:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CD320789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 02:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ3nrmWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CD320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPzQp-0001TW-B7
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 22:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPzOv-0008Pq-Tf; Tue, 06 Oct 2020 22:41:57 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:45064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPzOt-00056I-EY; Tue, 06 Oct 2020 22:41:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id y14so423339pgf.12;
 Tue, 06 Oct 2020 19:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5PEbYzQnYiFvrcn4EJsDEL2gxzyh3HsDEjQLa3bjd14=;
 b=BZ3nrmWynXGkRa0319mInuvgyQEOudaLJFtGh906jgrxmS9/JLq48c4p9TYXDdaZ4h
 DcWKUx7NiZG0IrFtBN/CbeWyiyTq/T8gpsGvkJqiLyjsClMUWejywKZeFZ02imaSDcoL
 kHqJYAqhHF3Hr61i5OSV+vpPB4dbAVLEzdl7gq2S01S+79WwachCAR0oA6SuKkxY+0Wk
 9gX4ACyp+tg+f/qNvbSqgYfnkpS8duhhXcbloKaclKPqzVeGnFYhUBXJ+L5CagMlZyYC
 9+x7BdpfYhSsWMnGJRp43664f9lZjCis1RGvpTNxp/QteZbKSupxe1EggNb7ZEk+F35e
 psiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5PEbYzQnYiFvrcn4EJsDEL2gxzyh3HsDEjQLa3bjd14=;
 b=mhgXRAfmBjxubU3rvgGZfTiAwDzz92b2AYzx1WAUueYavDkD2b5+CsxakQvSJEckGH
 Dv3T/LKvnVzX0FA15rB/KIMR6WRuMjFyJQQ3oyILmKI9fMQbfjogiTz6DeidgX4Mm00K
 fbQ2v/ZK3QIAiAi3RpPSOtf2tRs1A5/D5BwWBbkqO/PDI5LZkKHpYlHfmzmxKWh9abQ/
 +5gC7fskmwv3rUNjG1jhW21Y9mpNxrtO56uMFbt0vUmnL4CYRHbUDXAyFWv80V8ASRTY
 nbrKcGstImatPLecuMTYbzSi4MtcBEKm0fX5g0ohd1e/yJJtQc9386K514Qz5ljBYTw7
 mANQ==
X-Gm-Message-State: AOAM530FvV4mNL0J5WvA3kwrN38/WLHfcXJz/TZsAXUHh4q+74QZTN6s
 G/4GZUrjpelBaNW+F0kdgOD3cSNcSU9img==
X-Google-Smtp-Source: ABdhPJxzUXTqB1KCDyMGy3rAsw3d8OkXclkdLZ3KCeUrTtatQfBoql/LLiOFJ7q3yCnvMLaxwKOe8Q==
X-Received: by 2002:aa7:9a41:0:b029:152:b36e:409e with SMTP id
 x1-20020aa79a410000b0290152b36e409emr963087pfj.31.1602038512589; 
 Tue, 06 Oct 2020 19:41:52 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u27sm583913pgm.60.2020.10.06.19.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 19:41:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Improve cirrus msys2
Date: Wed,  7 Oct 2020 10:41:33 +0800
Message-Id: <20201007024135.1885-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x534.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes the broken msys2/mingw ci and speed it up.=0D
=0D
Yonggang Luo (2):=0D
  docker: Add win32/msys2/mingw64 docker=0D
  cirrus: Fixing and speedup the msys2/mingw CI=0D
=0D
 .cirrus.yml                           | 60 +++++++--------------------=0D
 tests/docker/dockerfiles/msys2.docker | 57 +++++++++++++++++++++++++=0D
 2 files changed, 73 insertions(+), 44 deletions(-)=0D
 create mode 100644 tests/docker/dockerfiles/msys2.docker=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

