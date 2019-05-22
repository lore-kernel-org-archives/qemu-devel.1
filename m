Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C823CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 01:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7166C2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 01:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="idcv9mQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7166C2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTcQA-0006Ok-IG
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 21:21:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48542)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3rsvlXAQKCsk6zx6v33v0t.r315t19-stAt0232v29.36v@flex--rkir.bounces.google.com>)
	id 1hTZdD-0000uf-0G
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3rsvlXAQKCsk6zx6v33v0t.r315t19-stAt0232v29.36v@flex--rkir.bounces.google.com>)
	id 1hTZdC-0004zP-2G
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:22:42 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:43370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3rsvlXAQKCsk6zx6v33v0t.r315t19-stAt0232v29.36v@flex--rkir.bounces.google.com>)
	id 1hTZdB-0004yc-Ro
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:22:42 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id r16so2114236ybl.10
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=date:message-id:mime-version:subject:from:to:cc;
	bh=66UZ7u1EgKXC5CA47Jgl+SU5nc7Y/seRCoNZatAMsL0=;
	b=idcv9mQlLfd54yTcAdqqCA6ZOrYuG5r16K5Y+sOLqTokEkW0cEG8dAHDIUFe2oSdQi
	0Ml0jbswD7T8A/6lPZERvTkpWEZq+czLNJ+XzXg91shyOPWZLAv129V2xwi9Lzk+OjSh
	r8T4TU/LMVipmXWycPcSZEvvYLoNjg4iRmg/A3GRruX4a9qAiClFbIsZgMqUulZ0k7eK
	gYIsJbKAOL3mFMPAr3h8z4N60OkPOgKCIAosFgjdj5mpp0KCCRufWGVL9bh/L8jOjKwo
	EX23GEEztgpwPvnhjOz782nD3zkI97PgodvXfKBK5vxLC+gK4fCr46HCWxrQqrlVTmNO
	PnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
	bh=66UZ7u1EgKXC5CA47Jgl+SU5nc7Y/seRCoNZatAMsL0=;
	b=NPNLcY4IY3/xsfwoiKWKJ3hlcxj0k/uAS4Z2sXb+KFJHc64CZyhHee4+ZbU6hTLz1f
	OOOX0UZrHM1BZuSXffGwSWfkUw8bcWWxz9tpczJJPjaYSj5lZDxs6/7HJJspYNby1y3b
	eeh24ylWn1o//XT9hbrkAu80P3rBBGGVZZQC4xyxc5ma0xUgJaFDMua5DC/8M/4AtjYe
	kJXYUvha7sDbhTeHvg3TlRqNal/8djq+4b0aII8ir4VYLNWsYF05lztSiIEZKQ3vwHxU
	as/759cDYWbL0fd+qY+xtb+K4MeYpl+A3LsdPVO0//iLEvomF+Kpy0UrIK0IH9NRrfNt
	KJlQ==
X-Gm-Message-State: APjAAAVRs9bHYpc277WAMQ+W4fc0Hr15BjB8jicb+skenD63ymWm3cuW
	5h9oE23MBJNUZ+6htIvjY6NHMm+fodxyQgeRXX1roROYkxh5kBf+LLggUSvJlVZDThb5VGs3CQW
	V91Zi8QdL10kD75dRSZFniqZZ/S/eHikzYxSTTJhFMizSOVzY1CG+grs=
X-Google-Smtp-Source: APXvYqy3Eu3jP7DKSGU1ySREO9g6/hVGk3wXz/AMtZsvjgvHscnD/FhOTaSTiOPptq6qwStw/TkXKEwg
X-Received: by 2002:a81:2bc6:: with SMTP id r189mr8844141ywr.337.1558563758603;
	Wed, 22 May 2019 15:22:38 -0700 (PDT)
Date: Wed, 22 May 2019 15:22:24 -0700
Message-Id: <20190522222224.244714-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b4a
X-Mailman-Approved-At: Wed, 22 May 2019 21:19:54 -0400
Subject: [Qemu-devel] [PATCH] vmstate: Add VMSTATE_OPAQUE to save/load
 complex data structures
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
From: rkir--- via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: rkir@google.com
Cc: Roman Kiryanov <rkir@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kiryanov <rkir@google.com>

VMSTATE_OPAQUE allows passing user defined functions to save
and load vmstate for cases when data structures do not fit
into int/struct/array terms.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/migration/vmstate.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 9224370ed5..2736daef17 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -737,6 +737,19 @@ extern const VMStateInfo vmstate_info_qtailq;
     .start        = offsetof(_type, _next),                              \
 }
 
+/* Provides a way to save/load complex data structures that do not
+ * fit into int/struct/array terms.
+ * _info: a user defined instance of VMStateInfo to handle saving and loading.
+ */
+#define VMSTATE_OPAQUE(_name, _version, _info) {                      \
+    .name         = _name,                                            \
+    .version_id   = (_version),                                       \
+    .size         = 0,                                                \
+    .info         = &(_info),                                         \
+    .flags        = VMS_SINGLE,                                       \
+    .offset       = 0,                                                \
+}
+
 /* _f : field name
    _f_n : num of elements field_name
    _n : num of elements
-- 
2.21.0.1020.gf2820cf01a-goog


