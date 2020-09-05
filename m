Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15354C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892CE20709
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sT2MzYoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892CE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfTU-00065S-J5
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEfSc-0005FN-Ti; Sat, 05 Sep 2020 17:11:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEfSa-0006dJ-9b; Sat, 05 Sep 2020 17:10:57 -0400
Received: by mail-pf1-x444.google.com with SMTP id u128so6527616pfb.6;
 Sat, 05 Sep 2020 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eGat2Y89VqJumYm2F6b7SNwQL2FY4HyPQvZfIsiYJ2w=;
 b=sT2MzYoK5ngWsuZjQLdNE/hfGJwm1Zv3O4qxiZ996KR/APdL3zmoHci+NoP9Z8/ke6
 0Ax84qWBcoD4HNY5BNC+LsaOUSk9305w4zMKwGxXBkWjkc39AlCZsRcWYIeAl3AhYFi+
 rfxo6BP9mKfAgSciAbKBZXOJjjhsCBCiFaAMJBGLOwKoRJf1OyPgmrdWKUvfREZPVY+C
 /EW6F+uipwdANK82lHak4vlphQsYePBKRjjupRZAzBK+8pBZXchEKBeqAwva4/hN1r5I
 d97i5AuQ9Ga+HyqCulvWk3r/2+cGfLj5yzspsMYgemmw+6bR3pF2tV3eVstNqqbIzje4
 45rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eGat2Y89VqJumYm2F6b7SNwQL2FY4HyPQvZfIsiYJ2w=;
 b=FIUb8VXTajPu6Z8eATOghb7kiFlH1UwZlK9YoPko6UgIfqiPkql1MbrYOUYfGJhdz9
 +a87LD9fS7ceJAYPAXAoDR168nP/Eu4mI2EPIyYa/F8GiqDYOUFk7MirnJRLaF3koEF7
 2plALflXGK6ZBArvbNfrAUvg4Z+3mE1Zo2wipT9+9zIS9HnANJm3IlXRbJ9fsPekuf0l
 ZjXzijFBpOErYiejrNbyoOFRvVtyF1jYEspy4EfGn9uof5oDJdZA1EuFX1Q5oV/Nc+6W
 kxoBznnVJsRQSuv+9LtDjfyYw4EEq7Kbt82C5Q611RytFW49UatmqnDW1g9GGkVCTY0u
 XSwQ==
X-Gm-Message-State: AOAM532y5yfky76JoCn5/wsDAFR2hWzeI11Nywp23DkuV0dpmDMbiY3R
 EKEjOkd3ArvV6h9T7pjktEdGgp3Q48SKADqQ
X-Google-Smtp-Source: ABdhPJycpd/g9tYyWlks/fB7MiZgFcpp7cDqPxjPoM3jPkzgc6QdiCPNJVlOWHMPh67f+DTBiepdkQ==
X-Received: by 2002:a62:2605:: with SMTP id m5mr8832307pfm.137.1599340253881; 
 Sat, 05 Sep 2020 14:10:53 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k88sm8576010pjk.19.2020.09.05.14.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 14:10:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Try fixes test-replication.c running on msys2/mingw
Date: Sun,  6 Sep 2020 05:10:36 +0800
Message-Id: <20200905211038.904-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Still failing=0D
1..13=0D
ok 1 /replication/primary/read=0D
ok 2 /replication/primary/write=0D
ok 3 /replication/primary/start=0D
ok 4 /replication/primary/stop=0D
ok 5 /replication/primary/do_checkpoint=0D
ok 6 /replication/primary/get_error_all=0D
ok 7 /replication/secondary/read=0D
ok 8 /replication/secondary/write=0D
Unexpected error in bdrv_reopen_prepare() at ../block.c:4191:=0D
Block format 'file' used by node '#block4251' does not support reopening fi=
les=0D
=0D
Yonggang Luo (2):=0D
  tests: Trying fixes test-replication.c on msys2/mingw.=0D
  block: get file-win32.c handle locking option consistence with=0D
    file-posix.c=0D
=0D
 block/file-win32.c       | 23 +++++++++++++++++++++--=0D
 tests/test-replication.c | 13 +++++++++----=0D
 2 files changed, 30 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

