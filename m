Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F5CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1548B2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHX/O8Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1548B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhAM-0005Qd-3i
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBh9k-0004iO-BO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:23:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:45751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBh9i-0006DR-Pp
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:23:12 -0400
Received: by mail-pl1-x632.google.com with SMTP id bh1so718377plb.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3MOT9mGHHAevg2fHPGXu8CKWMb3XFGDKA+MZw+kxy5k=;
 b=pHX/O8TzEC0isARq/j8mb7xApHHEQMyvOeHiLtYp53JGWoSZZUL4GmlF/iMFjPGXe9
 E59zQp00HG3hQNp5xkRgBJQGM7DBSkiaZ0LNRKfY2cY77/DGJ5KdJa/EPu4f50Xu8Xtl
 /uCbsK7H/+HQ+D40jZ1d2/VN9L7v9XwYmq/fBxgdqV+ms2H0ETpFJ4SmecVjHT1vJaxn
 aS9Bt8Lcd89rn7W/THmFkSf6QrvzZq/vSrrKtOvMKLk0qFNAlp0CTB7fj6gqrNrqYZ4I
 uwlr7FN5TNl8ZH3YPazJ/h/CwBTzH68Lo4Hm0qnH07G7C+6d22tsoI9pkD6vRl0buwrj
 Gmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3MOT9mGHHAevg2fHPGXu8CKWMb3XFGDKA+MZw+kxy5k=;
 b=XrSBbI37fxZg9i7bbXIqtb3V2igMw0HmWdA6jzi54Vke5yo9B8eMK0GO3HWnkDOlze
 k9Ri7/4X3isTIIR+PRGmQXYnlxV//fqijUzAksyJrvbH7q2oQYBDdPgnEMjd+kTAkWXD
 ER8vyU3ADsMiTmo24XFNcO0c9gQQW2pJM388NFFpfXOmubbve9CY+2XNhlPeozcgbolS
 7YRPMVtbtDE/scr6BPRMiuz2YDiXSozNxSK14IwT7Ruen9ICSwEtXhSuxurfE+RxqnjL
 5SDm0ilDAdu7bs1vAufl0A2rJnHQWev7z4TOQmpjni3EWMUceUzikdfmz3pL67QKnkbv
 0RPg==
X-Gm-Message-State: AOAM531lsnkrFbsbD7c9q+I/eCe5hLOYCE/NfXob37jhaf0JkXVUYWgn
 M+3njQIErFJ6DDgI2cVN16I9dwxDL0B5aQsJ
X-Google-Smtp-Source: ABdhPJze27GHVmpKQTp2yvZ3FW/vuYSj+5INs4GFY0POZwG169JWaDbMzi4Q6DwHAEQt9NHDf6HgzQ==
X-Received: by 2002:a17:90b:4b81:: with SMTP id
 lr1mr2035266pjb.71.1598631788845; 
 Fri, 28 Aug 2020 09:23:08 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 v8sm1629324pju.1.2020.08.28.09.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 09:23:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Getting qemu building under msys2 properly
Date: Sat, 29 Aug 2020 00:22:44 +0800
Message-Id: <20200828162246.423-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x632.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert undefsym.sh to undefsym.py and replace $PWD with $build_dir=0D
=0D
Yonggang Luo (2):=0D
  meson: Convert undefsym.sh to undefsym.py=0D
  configure: Fix include and linkage issue on msys2=0D
=0D
 configure           | 28 +++++++++++++++-------=0D
 meson.build         |  2 +-=0D
 scripts/undefsym.py | 57 +++++++++++++++++++++++++++++++++++++++++++++=0D
 scripts/undefsym.sh | 20 ----------------=0D
 4 files changed, 77 insertions(+), 30 deletions(-)=0D
 create mode 100644 scripts/undefsym.py=0D
 delete mode 100755 scripts/undefsym.sh=0D
=0D
-- =0D
2.27.0.windows.1=0D
=0D

