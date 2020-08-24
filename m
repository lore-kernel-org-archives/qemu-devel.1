Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C911C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 23:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F0120702
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 23:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7O3SG0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F0120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kALSi-0007YZ-Gr
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 19:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kALR7-000694-Kw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:59:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:42596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kALR6-0006WL-3H
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:59:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id 17so5770033pfw.9
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s3dYOgA7GkXXyUyxgB9kFfNBkj2FaL3vO8uRc/sluZg=;
 b=O7O3SG0LOfORL0K7NuQ08ocuSzFzaCoDJeSgve7HKedsZthOF1m9KKHIFZO2jMZUj8
 aF8bhM/m5Dj7UQRe8FSt+R0x503TVpLtVcbTBlsvZLxU2R8VP4TEHZGaP6hsSnCYJwgX
 oheLfA4uQFKyht4geONb9GOIIXT7w5rqDODq5lhlS9b32tNXI4RQ3TIc7eAbHoxz80A5
 zB3GdK4lNGKZXmFIl6ZLvP4SRHxBdzC4mc4TYxg0Ef/GYgPbKdPBvukE5P7h/xw2thDH
 OXzulHF2jtySKBS/NxtEp7t9jvJFDcEPZwgv78X91q3ntBwerEVD6YJFlnb4VUhPoh8W
 oP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s3dYOgA7GkXXyUyxgB9kFfNBkj2FaL3vO8uRc/sluZg=;
 b=rw4U/rfMRW8I8vFZ6oJMUR8Cq6lQr/IK4T4tY3mfvxj7rLqFNidNhqGczYiTt5acbE
 zbcsK4umGxBGPT7iUgJM3XvhgDrZNx2EKEwXYK2JNN4Kp2xRoDVIQ0G4ADScSWPVE1iJ
 pBEUijq7hxHN1YrWW5B41WSBSHbbG9BslUKdpEAFKo1TOwkDWdIBocm+HUxAhOkw6t6s
 dZ5AJtOTRufSkdfmbJ4GNKhfH8hzd5WKm+y8URsO8MxqLz35Jhrlh7tsr9cfhDn3E0cq
 Sp8Ij3VQVn7IUNX7hwThs2ubJZbz+td+A0b0FaTMJSVwvX71L7nrI4X/cQ8stG9x6xd5
 sj+A==
X-Gm-Message-State: AOAM5329oJ0GnkComGu/5ZJDTcNNxRn03ecK4raQaXERbIspjfd4lLvS
 ahR8Wky6xiWha28EJphd9eKXrzX6ET2cLQ==
X-Google-Smtp-Source: ABdhPJyLd3LvuOWGZedv6Urm9PKCpFpemuoVgKL+VJf6A4Pjm6r9a/D5JDoX7htM1DSCaMmA2UBt/w==
X-Received: by 2002:a62:78d6:: with SMTP id t205mr5814291pfc.68.1598309969906; 
 Mon, 24 Aug 2020 15:59:29 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id gk19sm2027866pjb.2.2020.08.24.15.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 15:59:29 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] fixes relpath may fail on win32.
Date: Tue, 25 Aug 2020 06:59:03 +0800
Message-Id: <20200824225903.1623-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200824225903.1623-1-luoyonggang@gmail.com>
References: <20200824225903.1623-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x435.google.com
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
Cc: pbonzini@redhat.com, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

---
 scripts/mtest2make.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index bdb257bbd9..d7a51bf97e 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -53,9 +53,16 @@ i = 0
 for test in json.load(sys.stdin):
     env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
                     for k, v in test['env'].items()))
-    executable = os.path.relpath(test['cmd'][0])
+    executable = test['cmd'][0]
+    try:
+        executable = os.path.relpath(executable)
+    except:
+        pass
     if test['workdir'] is not None:
-        test['cmd'][0] = os.path.relpath(test['cmd'][0], test['workdir'])
+        try:
+            test['cmd'][0] = os.path.relpath(executable, test['workdir'])
+        except:
+            test['cmd'][0] = executable
     else:
         test['cmd'][0] = executable
     cmd = '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x in test['cmd'])))
-- 
2.27.0.windows.1


