Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BC0C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 21:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621AC206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 21:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/rDgy4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621AC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLZVX-0006eS-IE
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 17:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLZUo-0005s3-Ad
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 17:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLZUm-0007Rl-W2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 17:41:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:39447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLZUm-0007R4-Pw
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 17:41:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id y20so1098923wma.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fd4qMe0MNlLWQw0m356lBepCE1KHD5482aT3VMneRyU=;
 b=O/rDgy4ArDBSgC64odnOlwjrIG8xrsj8sYaiBs60aGJRtGEq9QSau62jdEhxlPIHHf
 0qsnQ6OBUFZrCYkwMJn5fXaUF8aSA8Bo7YaJMeWGmO9OUIjYjGMrkGjgz/TRG9l3dZcp
 T0od1Rf0CGRV+kQIkGLQH8AFJ+WrzbcjwwTuVGdUQPYg2oQmY0g8bBcbaKFeS0ZriOVh
 TuCDxMkSV5UIO8yB9RfPoQNxhPFMzdtwckqnco/LoeztuUeWG4pL6aRGLxoskKyyScDM
 eTNIBSxlMMtG7XgNjZpK5Hjvj4itas7LCQSHBNAZB9o+09vpfY9r7vV5bMAIFsl2Oh96
 Oyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fd4qMe0MNlLWQw0m356lBepCE1KHD5482aT3VMneRyU=;
 b=n68IOgiJi89FomcM7fH+uR74NdeL1H0p3MejltZPG1vrMzO1Xmn0wUVYqVjjQgBL8W
 F/4VQdYXFRu0QmbHMmjfHFaKGrqzSyUJBn9Sz4ep6VyvRGn7DfbDPQyEE0pHlqtuH850
 CfpFtbFygiUh2h+KL3HdLo+nmkecE017ELfpxjlxWwUip3ME1Erfjz0T2ri8T80GbMnM
 ijlXF2rt1nwmuGYmF3kJ1N8mYLaBnvow7l9JezhhnhBH9vWVDmgcYIiEnKZN8XszAH2r
 aNk2FvnMXUfVYYj/HFEQWyBGsD0/R8snJA/R9CDUlB0QVYUwzIJEeMA4ZLLh1hn8y2oa
 Kkkw==
X-Gm-Message-State: AGi0PuYvfO1wxMCGaFIJpQZo6/GW7DMfgtZmxoki3ytonCN1KcWqI6bX
 Tqabp9qr634F6HrjjhBvG6ZcfVV8uNE=
X-Google-Smtp-Source: APiQypI8Nw8wJIFACpz1Y0nnk08aB0dmr5fpB+2pDNlaFpytHW/ZCBmf2j7glJkG2xTIRB4eo2Or8g==
X-Received: by 2002:a1c:5446:: with SMTP id p6mr1369265wmi.172.1586209287182; 
 Mon, 06 Apr 2020 14:41:27 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v7sm28011239wrs.96.2020.04.06.14.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 14:41:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0?] .github: Enable repo-lockdown bot to refuse GitHub
 pull requests
Date: Mon,  6 Apr 2020 23:41:25 +0200
Message-Id: <20200406214125.18538-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some GitHub users try to open pull requests against the GitHub
mirror. Unfortunate these get ignored until eventually someone
notices and closes the request.

Enable the 'Repo Lockdown' [*] 3rd party bot which can autorespond
to pull requests with a friendly comment, close the request, and
then lock it to prevent further comments.

[*] https://github.com/dessant/repo-lockdown

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Repo Lockdown is enabled on https://github.com/qemu/qemu/
---
 .github/lockdown.yml | 35 +++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 2 files changed, 36 insertions(+)
 create mode 100644 .github/lockdown.yml

diff --git a/.github/lockdown.yml b/.github/lockdown.yml
new file mode 100644
index 0000000000..94472d1256
--- /dev/null
+++ b/.github/lockdown.yml
@@ -0,0 +1,35 @@
+# Configuration for Repo Lockdown - https://github.com/dessant/repo-lockdown
+
+# Close issues and pull requests
+close: true
+
+# Lock issues and pull requests
+lock: true
+
+issues:
+  comment: |
+    Thank you for your interest in the QEMU project.
+
+    This repository is a read-only mirror of the project's master
+    repostories hosted on https://git.qemu.org/git/qemu.git.
+    The project does not process issues filed on GitHub.
+
+    The project issues are tracked on Launchpad:
+    https://bugs.launchpad.net/qemu
+
+    QEMU welcomes bug report contributions. You can fill new ones on:
+    https://bugs.launchpad.net/qemu/+filebug
+
+pulls:
+  comment: |
+    Thank you for your interest in the QEMU project.
+
+    This repository is a read-only mirror of the project's master
+    repostories hosted on https://git.qemu.org/git/qemu.git.
+    The project does not process merge requests filed on GitHub.
+
+    QEMU welcomes contributions of code (either fixing bugs or adding new
+    functionality). However, we get a lot of patches, and so we have some
+    guidelines about submitting patches described in our Wiki:
+    https://wiki.qemu.org/Contribute/SubmitAPatch and
+    https://wiki.qemu.org/Contribute/FAQ
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d156d73b3..0559e84790 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2833,6 +2833,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 M: Fam Zheng <fam@euphon.net>
 R: Philippe Mathieu-Daudé <philmd@redhat.com>
 S: Maintained
+F: .github/lockdown.yml
 F: .travis.yml
 F: scripts/travis/
 F: .shippable.yml
-- 
2.21.1


