Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D913C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084FD2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2sU53h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084FD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagv7-0004a3-3p
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqt-00028G-EU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqn-0003NB-75
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:31 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iagqm-0003I2-UZ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:25 -0500
Received: by mail-wr1-x434.google.com with SMTP id c14so10716892wrn.7
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bl/q66EQnB/Vpv+0jM7P6EssXQ6U7FEXGyqS8D7LPwk=;
 b=n2sU53h1JPh4ueANeHRgmU8jWPm7UL0w7WWkdFZ8WFvzmpuXpGNlh5l+MIffaGR5xk
 HF5zPpxZW1oMvwgNRYRLuHIZow6Flsdgnp0uJ0pt7j9Of2xkHMzKN7IzVK02OoaXGgGr
 oixjlf1p/pKUgwtw53CILGiDFIvAg2N+WUXegg3mi5TeCyCBJ5BYF5nenOk/BfGJONu0
 rQ916JbNRPLxUMViPlEo5yB+xrIAnOu/DBAmqrE0ZByl9rtm5qhQdhuHhcNXZkiStN7L
 HSVhuf8HcH3EQyvtnI/84b+lIvnfiAdSfQpayt60fpUpJr5vzqv+VvF9jn5Q+BbjeRa3
 GYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Bl/q66EQnB/Vpv+0jM7P6EssXQ6U7FEXGyqS8D7LPwk=;
 b=Kt67rsqJDLxZrnr9BZZMIzZBc1Zq0StqtloTfAmiN+sxngLViDd1irmIhIIntTnxNW
 R6ONaPGUIDvET9aVsw/vAMoxcK2q7V8P5H4LmXovyqiFHMthF9LcR5rAehtXXw5dV0VN
 Evu4yUTDzdohsaoDsCQXPVkW3dvBCIopdYosLH+uNFGjUvCkFiJn6z9fKGacH3N0I1Ud
 VJP+ZEupPPoqCkor9xRzT0YvqfYlM17nmx16usBLg3J5KaEW+otKy2gsRnXLuSDo1iz7
 3xqDM7gAZ6hdvDKVPu/+btaalEUuHEJkPsEDqTcjyNVfon8tEsHTQQHZ/XzM8CBCNa8W
 /6TQ==
X-Gm-Message-State: APjAAAUdHpzU/IyMOGaHT3M93jFCrs/YDZo3N9ADA4PYZFEm2Ux+yKWS
 5m0XxrnRhjCRJR7Uamzc/K1jaQCC
X-Google-Smtp-Source: APXvYqzE05ST/aPpBmHHr+HdmKgPdF+s6wFeYrBUZZ4wP6cUXVJfYztL48liJJagUSJ3DNjvQne6qA==
X-Received: by 2002:adf:db86:: with SMTP id u6mr57316160wri.318.1575036141866; 
 Fri, 29 Nov 2019 06:02:21 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id
 e7sm14190030wrp.43.2019.11.29.06.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 06:02:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] docs/conf.py: Enable use of kerneldoc sphinx extension
Date: Fri, 29 Nov 2019 15:02:12 +0100
Message-Id: <20191129140217.17797-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129140217.17797-1-pbonzini@redhat.com>
References: <20191129140217.17797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190521122519.12573-4-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/conf.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/docs/conf.py b/docs/conf.py
index b7edb0666b..259c6049da 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -54,7 +54,7 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['qmp_lexer']
+extensions = ['kerneldoc', 'qmp_lexer']
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
@@ -216,3 +216,8 @@ texinfo_documents = [
 
 
 
+# We use paths starting from qemu_docdir here so that you can run
+# sphinx-build from anywhere and the kerneldoc extension can still
+# find everything.
+kerneldoc_bin = os.path.join(qemu_docdir, '../scripts/kernel-doc')
+kerneldoc_srctree = os.path.join(qemu_docdir, '..')
-- 
2.21.0



