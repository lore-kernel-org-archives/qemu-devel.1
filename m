Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF15C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788AF2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsGcthRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788AF2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAthV-0003mP-Pf
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAtgt-0002wQ-KG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:34:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAtgr-0006ha-Q4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:34:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id o5so903066pgb.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7+MsaJjYLlKc/kuo4dhCFuDpn67NQClb7RmuHL3RlA8=;
 b=HsGcthRJ9N3OECP7X47G7ESwjmIP3y8AVPNnspvwZ6H6tJeQxJAbmcnBiDkDY/sVr0
 j6ReJxUk+iHREvryzlZpXE0LYMGl8JgD4GEismbia5IMuJUor+33qP2WINW+pqdAmHmg
 86h3TaFfVUVFKWzIBQ6bh9Ly9HIjDss/7tuNx4iwecf9EZm+Boc25/3awEj4wcOEsHaQ
 asUI/E1RI+S1vHD2Gedu7AtKUxfrfBqUnHByx033SZdaeECPSDDJlc7IJJzCeYlm19ak
 1jxbTZu+OY6xe3dlo5wQnDcdEokFTRsDLOodpsuc3/JjP+hn1qt7jaZ2I6k6apzGdQHn
 lh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7+MsaJjYLlKc/kuo4dhCFuDpn67NQClb7RmuHL3RlA8=;
 b=fFyP/7oFuVPzbt3P7t3bBznViEfLpg2MnYoPy9tfKOLPXVeqapYUJQiN9a0fw3l9ZD
 S9hmvP+6PW3f3/BnDlhkSmYvi6ciqmLS5oSRuryjJm6SRrpqdXuFrf0XYKGPK9gqKa5q
 SIFu+xhvvTtOwI4Km2pOsQgTQXUnshwG+t8Yta2Yj7mubemp5Oz3YkSbJRWkZyp2w17u
 6/jnSRW/NgcyaIaPbwrhKQJkMAHKxnC4rakL5bz3NC6whNHaLCeT8XVmVua45JtzLNgb
 O/mcZFu6plMe36euj+RI47EaTBnzBGnoTHd/UnwK+ElJ3g/DckXUxqkihk1tnX4CbTm5
 y9jw==
X-Gm-Message-State: AOAM53125ugkRLIg6dvaeMkq8YyAG9cFEqMeyVFOhiCKqzBU0IKXrxrN
 dXKhQ+qX1qu+tJN8YBJcffLkGu712USAj/uw
X-Google-Smtp-Source: ABdhPJwNq7RJrlszEOTpuGU7r+F2jPYwowfUiILps/pp642CXdQXsmPpsaOXZm6TKv6k99WSpPz9Rg==
X-Received: by 2002:aa7:982e:: with SMTP id q14mr11932382pfl.299.1598441644133; 
 Wed, 26 Aug 2020 04:34:04 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id p20sm1915914pjz.49.2020.08.26.04.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 04:34:03 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] meson: fixes relpath may fail on win32.
Date: Wed, 26 Aug 2020 19:33:23 +0800
Message-Id: <20200826113326.491-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200826113326.491-1-luoyonggang@gmail.com>
References: <20200826113326.491-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x542.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

On win32, os.path.relpath would raise exception when do the following relpath:
C:/msys64/mingw64/x.exe relative to E:/path/qemu-build would fail.
So we try catch it for stopping it from raise exception on msys2

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
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


