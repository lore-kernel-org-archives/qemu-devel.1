Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E6C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CB3218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnCzEyah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CB3218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7LMK-0001u7-N8
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7LLF-000117-9V
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7LLD-0006xu-MH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:12:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7LLD-0006x2-Ed
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:12:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id o184so15133220wme.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p4OhRr2/NEqxb12/C0dvcVPBBxOnZC5+Aiiq5HgHF2Q=;
 b=EnCzEyahowdaWWJPVCmp2mfhziojbxj/9XmGuf4wocSrre8RTtOeZrXz1mDBCsjbkP
 umqZDkQXsUd3srAIiOEf3tsyrYRfa/Hlnfs9GY5QC92b1cYWpGrDW/Wffrz4Qy0BE4Cc
 vXdqfgpg3UuuErYOXyTD+97yr8zHIWaDv72CRzieYlv2LtFE+xREULFuwm5GJvdfNR3i
 9CmzAZcDHWwNpVvYNkoOnVusXjtzw1RrlAIQKK5Mh5+IplbS1lSyqbVZX0Vd2Fd5Mf3D
 ju/hIX4/JrEQpASZBr/QZHnEhVUZ9ytYd2RCd+9nFAkoTIK2kenp+za6mZeeRXRFBwaz
 Dkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p4OhRr2/NEqxb12/C0dvcVPBBxOnZC5+Aiiq5HgHF2Q=;
 b=gcj+H5a2dfrW8yiMugDxkuy/jUJI9+SuL27KBZxUglu7RA1KnXi8oxVyt+ZgSemOXn
 QrqoqUQm9LO3YxW6ZT5JuiGGrb5gIzXgPwp2JDlwwi7sMLyOE8iKOFuJM1WSFkunVbjK
 CpXkKDskGM2kvSp8XwNsX/vW/tTNnMl/J01e5GC1eNmLLevackcNKq6n6rFi03t7MsCE
 lzMmfrWx/r6XBbjPpOz8qrRgk+gKaX/YJtSMj37BR2TMRkzIdBehNFcpT6QYl093o/4z
 GfRvYrT2UUX4N8k7MJkgwpeJHNye1nXUv3DW6q3hIM1Ti/kwhcj6abbxjD7N9wajgaLz
 iWxw==
X-Gm-Message-State: APjAAAWy6nW4KvY5BuCE2hzav39z/lEMsdSBJ36HPFhYiF1SlhYcRLf5
 Vl4QzXZbs2/QGL1xRFYTUYkKMg==
X-Google-Smtp-Source: APXvYqxfjXOzlrJDMI++cakCK/vzLue+60XPPu8/HwugUR3GJ8/Y+P0FFPx7FXXHoWPF58SY6MHR2A==
X-Received: by 2002:a05:600c:293:: with SMTP id
 19mr2380223wmk.37.1568041949932; 
 Mon, 09 Sep 2019 08:12:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l6sm6908334wrv.59.2019.09.09.08.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 08:12:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AC7701FF87;
 Mon,  9 Sep 2019 16:12:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 16:12:18 +0100
Message-Id: <20190909151218.16766-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [qemu-web PATCH v3] add support page
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
Cc: pbonzini@redhat.com, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is intended to be a useful page we can link to in the banner of
the IRC channel explaining the various support options someone might
have.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

---
v2
  - add cleanups suggested by Stefan
v3
  - add link to nav bar
---
 _includes/nav.html |  1 +
 support.md         | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 support.md

diff --git a/_includes/nav.html b/_includes/nav.html
index 241d83e..0c81e24 100644
--- a/_includes/nav.html
+++ b/_includes/nav.html
@@ -4,6 +4,7 @@
 			{% assign current = page.url | downcase | split: '/' %}
 			<li class='{% if page.url == '/' %}not-desktop {%endif %}home'><a href="/">Home</a>
 			</li><li {% if current[1] == 'download' %}class='current'{% endif %}><a href="/download">Download</a>
+			</li><li {% if current[1] == 'support' %}class='current'{% endif %}><a href="/support">Support</a>
 			</li><li {% if current[1] == 'contribute' %}class='current'{% endif %}><a href="/contribute">Contribute</a>
 			</li><li {% if current[1] == 'documentation' %}class='current'{% endif %}><a href="/documentation">Documentation</a>
 			</li><li {% if current[1] == 'blog' %}class='current'{% endif %}><a href="/blog">Blog</a></li>
diff --git a/support.md b/support.md
new file mode 100644
index 0000000..9174bbb
--- /dev/null
+++ b/support.md
@@ -0,0 +1,40 @@
+---
+title: Support
+permalink: /support/
+---
+
+If you have a support question that is not answered by our
+[documentation](/documentation) you have a number of options available
+to you.
+
+If the question is specifically about the integration of QEMU with the
+rest of your Linux distribution you may be better served by asking
+through your distribution's support channels. This includes questions
+about a specifically packaged version of QEMU. The QEMU developers are
+generally concerned with the latest release and the current state of
+the [master branch](https://git.qemu.org/?p=qemu.git) and do not
+provide support for QEMU binaries shipped by Linux distributions.
+
+Questions about complex configurations of networking and storage are
+usually met with a recommendation to use management tools like
+[virt-manager](https://virt-manager.org/) from the [libvirt
+project](https://libvirt.org/) to configure and run QEMU. Management
+tools handle the low-level details of setting up devices that most
+users should not need to learn.
+
+* There is a
+[qemu-discuss@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-discuss)
+mailing list for user focused questions<br>
+If your question is more technical or architecture specific you may
+want to send your question to another of [QEMU's mailing
+lists](https://wiki.qemu.org/MailingLists)
+
+* A lot of developers hang around on IRC (network: irc.oftc.net,
+channel #qemu)<br> QEMU developers tend to hold normal office hours
+and are distributed around the world. Please be patient as you may
+have to wait some time for a response. If you can't leave IRC open and
+wait you may be better served by a mailing list.
+
+* If you think you have found a bug you can report it on [our bug
+  tracker](https://bugs.launchpad.net/qemu/)<br>
+Please see our guide on [how to report a bug](/contribute/report-a-bug/)
-- 
2.20.1


