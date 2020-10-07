Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E88C4727E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6204920760
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAwqc9OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6204920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQGCs-0001Vb-AD
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 16:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBn-0000Il-Il
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBm-0000f2-4x
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id z1so3860856wrt.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Wion4bXNxUG6gI6d7TJrAqixP4aRBEiFI6SiTdGp8Zg=;
 b=JAwqc9OAV6eOObw0KD7wBvJSk5MUv1tQRf8qaqnwN/bNxDFuguEs02ck/6Er7W2FHw
 STKFHk2IX0wyrm2YltqXMP9yUBo1/E/WeANB8/C8cNq8ADLJTzQGSW20T8JvL3KhpGOP
 FfHU+VZrjh3LzAychfxB0Yy7QfTvAMTo1pSI32uSAq5LtvsxZaGvCKJrEzZe4WqCgfKO
 Xq6X610vybmHMpgmbFMaAVVxjrlVvN9oubQzxAztgdJdhRJu7aKQqCYs55rc/FfNx+lJ
 9PGJyeoTeJ4CewxV0LD0XSWnMQyQIkBQpYx+hWNqKs49XUw1UUklpVDJkWPuSugWksTD
 HepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Wion4bXNxUG6gI6d7TJrAqixP4aRBEiFI6SiTdGp8Zg=;
 b=qhIeKO7+Yq5ECfdhh0WgFh6vhFk1kQE7JXrDUoj53NGkpvim0C0xO4txTTaWFWpJLz
 fB3DfzNykXP+mJbwMsp40DJMoxj+8cwDEk1/hN7JCBgKkl2l9mo1BgxVu+sVBviKz/fB
 zshAZ7ikb3xh8/8A3ONLQsIVtmy04fGSzzWwAAb1g3PwjrCiSY89pYgaoXz3wUZlQ85M
 vjHcEy62UKG24l3XmhAy9cwne0zUXwHEZ9fZ+y0sdxTq8cwDSxcjT9sDtUR0j2gEvHAV
 ufF/4Rb6TodlAzIhoV8VMC/ZGGdz2HI83EtZs99jpwlTUJLr6AnBRbLh6IxJjbCuodQZ
 fClw==
X-Gm-Message-State: AOAM533JlO93RdK2sRxeAIuqWlIIqUHIxCFVXODDNicz467KywjK4kME
 ebMmCyWHmWDpqZbKQ7cxVw4iISXuXOo=
X-Google-Smtp-Source: ABdhPJxT21WJpqzddSug3xX3Bb1IOkb2zaGO9gswfC1DA+PceLODMgYcQ69jQeLjbEJKSzsHUE6NZQ==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr5463236wra.348.1602103048027; 
 Wed, 07 Oct 2020 13:37:28 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id d2sm4359083wro.34.2020.10.07.13.37.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 13:37:27 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] target/mips: Misc patches  
Date: Wed,  7 Oct 2020 22:37:16 +0200
Message-Id: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x429.google.com
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com, f4bug@amsat.org,
 jiaxun.yang@flygoat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 hpoussin@reactos.org, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A set of several, mostly FP, refactorings and improvements.

v1->v2:

  - added a patch on MAINTAINERS

Aleksandar Markovic (5):
  target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>
  target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>
  target/mips: Demacro helpers for <MAX|MAXA|MIN|MINA>.<D|S>
  target/mips: Refactor helpers for fp comparison instructions
  MAINTAINERS: Remove myself

 target/mips/fpu_helper.c | 276 +++++++++++++++++++++++++++++++++--------------
 MAINTAINERS              |  17 +--
 2 files changed, 200 insertions(+), 93 deletions(-)

-- 
2.7.4


