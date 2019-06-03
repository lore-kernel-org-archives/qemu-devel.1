Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4097BC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7FD24A6E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyAZuyzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7FD24A6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmTN-0005ZY-7H
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:53:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmKw-0007F5-9U
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmEp-0006zQ-2e
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:38:55 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmEo-0006xT-Su; Mon, 03 Jun 2019 08:38:55 -0400
Received: by mail-pl1-x642.google.com with SMTP id cl9so1840391plb.10;
	Mon, 03 Jun 2019 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LtyXP6pU3wLcU44kzIV+V39Txu8qaO7ubJvSXbC66PQ=;
	b=NyAZuyzTenzksxLOolD3RsBvaYcx7jzYHKUUP4R2rT2R8NpjAZinT34jHYbkhky/Jf
	YyOk+M/dy1qt5sXpCjoPa1IbVDj3y7pqnN+lesckl+jdIlYBCd025kM9aJceRjfKpcBL
	EFDP7738cKvid4BT0kES+xRBSKLuMNbEKNYSwiNut7aRyPbE+YehnjfmAZ5dVAZL8wK4
	VTIJNpsvU8BKKf34l5NZ6cwNIYXeR9yeUYFbQPZTlB5i5hC7im487OA1DIXDIDtpBoBy
	yKLbU5FprvNPJd/uZNvtGHWoGxyPi4DaAAgGmNSCBU5/SHl3n32U90jiZLe9s6nhmkoK
	qm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LtyXP6pU3wLcU44kzIV+V39Txu8qaO7ubJvSXbC66PQ=;
	b=eNNj8oGPkAJ47tmaPbDA5wBMJfzMF9Fst1031tFumrtJxsVl0RVqQu39wPGG2T6cUS
	UaER9lYW+BU0dIpHmMFGpySH1mZqrQDjgoc0vXHdMKjxe3RTb2jXW6wHOHEBnqMe5qCK
	jYIFP3FpBIgL+NhJaoksZ/1hd9snqYdQP/wxkvVYwsRHK823BeqKte1QIffas1HangNY
	jUDGdIMH8z+x+tuxhN3QY2obub5Ekr0lzQbbGhhC6M4m3ZauoDRmgtT8v5ak/PUw36/7
	FrJu1z48Cbcld/EIHRUui+8uFDujWuhqJL+2zEKWZoCC3BwkEhjwmFjMKa3expcEY5Yp
	A6gw==
X-Gm-Message-State: APjAAAXDp0aEBj+ov7RpC8izygkobaZfDXG1GtU3yzLC9N7UbjgXOnzs
	7p9gvXuH8WLi9Y2ucaz0KGuyz4a8fCDvvg==
X-Google-Smtp-Source: APXvYqwa/HzZA0B2BEH39pEgNt2LZ5ZMmI/6BjfqKXy38aLL4ob/Sv18Emfis3KytOb4+XiEhxhK0w==
X-Received: by 2002:a17:902:7043:: with SMTP id
	h3mr29080981plt.292.1559565533487; 
	Mon, 03 Jun 2019 05:38:53 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.38.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:38:52 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:16 +0530
Message-Id: <20190603123823.32661-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603123823.32661-1-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4 2/9] qapi/block-core: add option for io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Option only enumerates for hosts that support it.
Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qapi/block-core.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1defcde048..db7eedd058 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2792,11 +2792,13 @@
 #
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
+# @io_uring:    Use linux io_uring (since 4.1)
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevAioOptions',
-  'data': [ 'threads', 'native' ] }
+  'data': [ 'threads', 'native',
+            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
 
 ##
 # @BlockdevCacheOptions:
-- 
2.17.1


