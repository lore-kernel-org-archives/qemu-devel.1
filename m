Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EC2C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260AF208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNnt5IEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260AF208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ0Wd-0004bZ-9X
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 23:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ0Uz-000369-DL; Tue, 06 Oct 2020 23:52:17 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:32833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ0Ux-0001wp-TZ; Tue, 06 Oct 2020 23:52:17 -0400
Received: by mail-pg1-x52b.google.com with SMTP id o25so555255pgm.0;
 Tue, 06 Oct 2020 20:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0u004zZv1eefQLQ4o5fz6OoIFmDGh9h/pn8NmTmgvvs=;
 b=GNnt5IEehDwh0r3Alz9s52CrSTEPX+zpEZ/YrS0UjVl8cG/Og+prBDViqDhe5Npn3G
 5HQi0nJeN/Xl22uvLxWTfJXpzzlg2wqfJA1GtfguDvIfuXnl3FTLi5IsC4Vd7p/y0vzU
 7ijoHmMSBbzXtmgbskNjJmwCmKlZq0QXFajGeac5P74z0zxFlWkva5urWaOoHjPg+hL2
 hiKtUZ0V8x0YYXc6bE91TBY6RfmrEOHmPMiR+WcEJcGKxh63R8RF6ZJKAAxXtfOOLzIy
 6OrADVJMyvYqEGO3VjvMemVojM5mSapJIXk0cf1vV0xA8nHbinKpomGTmcWwhgIYrILD
 Aabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0u004zZv1eefQLQ4o5fz6OoIFmDGh9h/pn8NmTmgvvs=;
 b=lyJDWc6UwrdcVeEWaQmTVBciDYZtVS8kFRgJedZ7MNkEvaRcITDb1kpJ4SHJf1VKkd
 DZ1CMQbdU1DZHGg97LCKWcRzeqWNki7ft/0Hwv8ZW7dw8Q3lkcRybk6ND5hpc+K7B6Td
 Wma8NtV3ydSQ3pUBZWrjyPknHreg40sXbg81kZRVvJoZHWSt4WFAe/uVKcBgEcBQmOPt
 MbLb4NG80xWZJE49a57PwD7dP3BlwuvZQkr8NPCmlSKNAjJvEbgeSDMXI3ObmbLef2cX
 LygcSALrhKl7ueVYjFu1qdq+oLAy8+2rQu/mQl9Co1vim2mEtGmx6Zb6dLefMXYT6Xba
 M+gA==
X-Gm-Message-State: AOAM531YVLJWgvtLFknAdTgEpRhTcpsgpO3A/Ah1DRRQlPTM5ilV9hpi
 2QGbjRYRWyDWJ0Ke4clx+WFtB1hvji/IHA==
X-Google-Smtp-Source: ABdhPJzfNuJIVS7TDo6hdxBI8gb3u5KIpClzQ++2SmrggjFoS6kb+fZdqRqrhoJsKyE5Ud0HQ1FlFA==
X-Received: by 2002:a62:7657:0:b029:152:4d66:dcb with SMTP id
 r84-20020a6276570000b02901524d660dcbmr1265795pfc.74.1602042733462; 
 Tue, 06 Oct 2020 20:52:13 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v10sm497031pjf.34.2020.10.06.20.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 20:52:12 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Improve cirrus msys2
Date: Wed,  7 Oct 2020 11:51:51 +0800
Message-Id: <20201007035154.109-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52b.google.com
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
V2-V3=0D
Add one more patch:=0D
cirrus: msys2/mingw speed is up, add excluded target back=0D
Do not build sphinx on windows, that's failing=0D
set the number of parallel count to fixed number 8=0D
=0D
V1-V2=0D
Resolve the cirrus conflict=0D
=0D
Yonggang Luo (3):=0D
  docker: Add win32/msys2/mingw64 docker=0D
  cirrus: Fixing and speedup the msys2/mingw CI=0D
  cirrus: msys2/mingw speed is up, add excluded target back=0D
=0D
 .cirrus.yml                           | 63 +++++++--------------------=0D
 tests/docker/dockerfiles/msys2.docker | 57 ++++++++++++++++++++++++=0D
 2 files changed, 73 insertions(+), 47 deletions(-)=0D
 create mode 100644 tests/docker/dockerfiles/msys2.docker=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

