Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4479CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932C020867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCiZ80fP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932C020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtSy-0000uZ-50
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE1-0003Hu-Ji
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE0-0008Qn-5r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDz-0008QG-Dl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n15so884227wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9UrS1uw6AZDTMRq/tP2Ot5sPWM4GF3Yu6lTDbahkAEo=;
 b=gCiZ80fP6IaH1GG9J2JrpclaWG4fUpRiyvGpWRjlE6f2tZK2YkikjIjyzDdefpjyo4
 1F0Z0lfOYSbWSjuaz7EvwCRcItiERn8OJmDYbYMxPBNL1nFJyEUIBIAgXGQNM4/+gkjw
 jhvKqFPsQQCf6qtrTLPd4+Eb+ZdMvqT7mdhin3AYzvnPg1/03xkqQZtTkzo84bodtHrn
 nYkfWabUTWwPP6yr4UYciTIVsqTscRpu6SNM6kZeLpcejXmpU6mtMgP/b1PLih1+DyHi
 6QLrM7gNo3rVIdsxoOMfnypTppsW4Bn8bF+cWGbjWLiRuwReRFvHpgyzFB7cRiaYIVyB
 6DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9UrS1uw6AZDTMRq/tP2Ot5sPWM4GF3Yu6lTDbahkAEo=;
 b=ao8ILi/I4oGbyfjAUB8ojmH0CrcvEvXZbTrZ7Q4SHjUlY3+3SXF1E3WDweYFDXxXk9
 igAwrhYnYelZDowvhO+rJ76lsbJxbGJp1OgiwGYDTakD/B/4q3SwggC+mTqkU55TNwjG
 N5LXnbksutG5vcm85sv3QBSAC5bH/WnXAJOxo5/+G+xGzNJ0JKkTYFeGwDOFIvFmGkfy
 SPNDIKbpkLNmJSupwkzX0//SEeFsHxvZ/pKj7skm0G3WBJjQKn32yRFcNiKeT8zlIiyl
 SkV0wgAQ3eZ0bPgk8fVPwVE33BMwD1iHtKeCzxZmC8WB96Obpg+C7NhM8bOqA6NECfjb
 +C3w==
X-Gm-Message-State: APjAAAWbDdvfJ6q30EDCWOLhjkYvwVuU+5DfHKVlscfzAby7I/KFLH+8
 yhIJJme5mzHp1ZoNQGIUF3XbgQ==
X-Google-Smtp-Source: APXvYqxtIsyLWOzAD3V+9A+DbBcfIuLnEyorR4ma8Esm285Rq7yabSzBSPhnFA77MrNUPSYrVi1PYQ==
X-Received: by 2002:adf:f40a:: with SMTP id g10mr1262888wro.228.1571985446192; 
 Thu, 24 Oct 2019 23:37:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z189sm1918933wmc.25.2019.10.24.23.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A80581FFAB;
 Fri, 25 Oct 2019 07:37:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 21/73] docs/devel: add plugins.rst design document
Date: Fri, 25 Oct 2019 07:36:21 +0100
Message-Id: <20191025063713.23374-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is mostly extracted from Emilio's more verbose commit comments
with some additional verbiage from me.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 1ec61fcfed9..2ff058bae38 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -22,3 +22,4 @@ Contents:
    decodetree
    secure-coding-practices
    tcg
+   plugins
diff --git a/docs/devel/plugins.rst b/docs/devel/plugins.rst
new file mode 100644
index 00000000000..b18fb6729e3
--- /dev/null
+++ b/docs/devel/plugins.rst
@@ -0,0 +1,112 @@
+..
+   Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+   Copyright (c) 2019, Linaro Limited
+   Written by Emilio Cota and Alex Bennée
+
+================
+QEMU TCG Plugins
+================
+
+QEMU TCG plugins provide a way for users to run experiments taking
+advantage of the total system control emulation can have over a guest.
+It provides a mechanism for plugins to subscribe to events during
+translation and execution and optionally callback into the plugin
+during these events. TCG plugins are unable to change the system state
+only monitor it passively. However they can do this down to an
+individual instruction granularity including potentially subscribing
+to all load and store operations.
+
+API Stability
+=============
+
+This is a new feature for QEMU and it does allow people to develop
+out-of-tree plugins that can be dynamically linked into a running QEMU
+process. However the project reserves the right to change or break the
+API should it need to do so. The best way to avoid this is to submit
+your plugin upstream so they can be updated if/when the API changes.
+
+
+Exposure of QEMU internals
+--------------------------
+
+The plugin architecture actively avoids leaking implementation details
+about how QEMU's translation works to the plugins. While there are
+conceptions such as translation time and translation blocks the
+details are opaque to plugins. The plugin is able to query select
+details of instructions and system configuration only through the
+exported *qemu_plugin* functions. The types used to describe
+instructions and events are opaque to the plugins themselves.
+
+Usage
+=====
+
+The QEMU binary needs to be compiled for plugin support:
+
+::
+    configure --enable-plugins
+
+Once built a program can be run with multiple plugins loaded each with
+their own arguments:
+
+::
+    $QEMU $OTHER_QEMU_ARGS \
+      -plugin tests/plugin/libhowvec.so,arg=inline,arg=hint \
+      -plugin tests/plugin/libhotblocks.so
+
+Arguments are plugin specific and can be used to modify their
+behaviour. In this case the howvec plugin is being asked to use inline
+ops to count and break down the hint instructions by type.
+
+Plugin Life cycle
+=================
+
+First the plugin is loaded and the public qemu_plugin_install function
+is called. The plugin will then register callbacks for various plugin
+events. Generally plugins will register a handler for the *atexit*
+if they want to dump a summary of collected information once the
+program/system has finished running.
+
+When a registered event occurs the plugin callback is invoked. The
+callbacks may provide additional information. In the case of a
+translation event the plugin has an option to enumerate the
+instructions in a block of instructions and optionally register
+callbacks to some or all instructions when they are executed.
+
+There is also a facility to add an inline event where code to
+increment a counter can be directly inlined with the translation.
+Currently only a simple increment is supported. This is not atomic so
+can miss counts. If you want absolute precision you should use a
+callback which can then ensure atomicity itself.
+
+Finally when QEMU exits all the registered *atexit* callbacks are
+invoked.
+
+Internals
+=========
+
+Locking
+-------
+
+We have to ensure we cannot deadlock, particularly under MTTCG. For
+this we acquire a lock when called from plugin code. We also keep the
+list of callbacks under RCU so that we do not have to hold the lock
+when calling the callbacks. This is also for performance, since some
+callbacks (e.g. memory access callbacks) might be called very
+frequently.
+
+  * A consequence of this is that we keep our own list of CPUs, so that
+    we do not have to worry about locking order wrt cpu_list_lock.
+  * Use a recursive lock, since we can get registration calls from
+    callbacks.
+
+As a result registering/unregistering callbacks is "slow", since it
+takes a lock. But this is very infrequent; we want performance when
+calling (or not calling) callbacks, not when registering them. Using
+RCU is great for this.
+
+We support the uninstallation of a plugin at any time (e.g. from
+plugin callbacks). This allows plugins to remove themselves if they no
+longer want to instrument the code. This operation is asynchronous
+which means callbacks may still occur after the uninstall operation is
+requested. The plugin isn't completely uninstalled until the safe work
+has executed while all vCPUs are quiescent.
-- 
2.20.1


