Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B72C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19402084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceLFGLTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19402084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsXa-0004G2-Oa
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:20:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsWQ-0003kU-Cj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsWE-00029E-SR
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:18:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDsWE-00021x-0A
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:18:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id z24so3808238wmi.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=gfY+dbclmdhipPDWOY/oT9Jrli1jXNhGCiG17GGu0/k=;
	b=ceLFGLTZ9LgUlV/M/7/l4HQDFn7IShrpXxJ2SNO4dMX350IngKaX6ijna34yAkMZQk
	rLTMrIXQkYzXkJWx5eTUkg7jYjEiEO8lnT+pXQFUrTXYRxFSg5xzgqH7jjWFGzwsL7WV
	7vq02g4Fh6Fq6GLajb1kwHYIR2U9aP2sQzLIPlnB6v+eRxd4f+v0e+InfllWgZy4sqOG
	/Y0a48NUZ/vhvX+QPf/+rgFWtHbTtE/AAvoj1KHITFgv2p+gMdO6WTLM6SZk+AO4wTeF
	K+kicrIcfBvdSg6YDUhRQyCJ4nWrWMjsZfGZsMzvt8zqFoLzmbooKnQbQcXIFOKtFOUh
	VuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=gfY+dbclmdhipPDWOY/oT9Jrli1jXNhGCiG17GGu0/k=;
	b=eTcO/RXUSXH4Z3rq5+SXB/FlySf893hkJvuc5cbV9//zygdKPGb+5DcDHdhsLFub5F
	mv3YRsZqsp6lSzzX+PmzsY6sYriKimFHSlSAL/VS5KGF/wm+EhbHYGoqfggYWOEw0awn
	OlMLXMKdOk3rxKBvHp16L9oJwJiee4PatIVVk7XOudjXzYKtgJ+AYV1Hsw0aHVB9HcEG
	I4T0rG1kJHH91I/nW6l8gT1yhjxVDnyqaJMUo1lTfdMLgilyLZwGJaTwtS4V7edk4ze4
	JObJnwKaGw0oYaE5fqapnNck0GLDgr8rgifxthLoGF4ngQ3We7gKyrnwbCly89TXN3W4
	ezHw==
X-Gm-Message-State: APjAAAULyapDTuykK7QyP+QVvOz/3AWU3Z7D91J4z+1lxcyRKojVQl+Y
	jAixTpZOzHaYs9kGATM742AsF/v3mO0=
X-Google-Smtp-Source: APXvYqx9qBEmrUU3EC6USfD8Sb5UErgy0hqOmWn148jx32D1U9vKiTIXeOU88KxtmfzIg4Qf7icRTA==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr23331531wme.72.1554823112702;
	Tue, 09 Apr 2019 08:18:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	h10sm57912517wrs.27.2019.04.09.08.18.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:18:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 16:18:30 +0100
Message-Id: <20190409151830.6024-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH for-4.0] migration/ram.c: Fix use-after-free in
 multifd_recv_unfill_packet()
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409151830.WtP5tBvvwG_Lu3OOcOuWMrd6rbwm3Ln6bH6H9_ByYDk@z>

Coverity points out (CID 1400442) that in this code:

    if (packet->pages_alloc > p->pages->allocated) {
        multifd_pages_clear(p->pages);
        multifd_pages_init(packet->pages_alloc);
    }

we free p->pages in multifd_pages_clear() but continue to
use it in the following code. We also leak memory, because
multifd_pages_init() returns the pointer to a new MultiFDPages_t
struct but we are ignoring its return value.

Fix both of these bugs by adding the missing assignment of
the newly created struct to p->pages.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I don't know anything about the multifd code, but this seems like
the obvious fix based on looking at what the clear and init
functions are doing. I have only run 'make check' on this,
so review and testing definitely in order. I think we should
really put this into 4.0, which means ideally I'd like to
commit it to master today or tomorrow, though...
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index f68beeeeffc..1ca9ba77b6a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -851,7 +851,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
      */
     if (packet->pages_alloc > p->pages->allocated) {
         multifd_pages_clear(p->pages);
-        multifd_pages_init(packet->pages_alloc);
+        p->pages = multifd_pages_init(packet->pages_alloc);
     }
 
     p->pages->used = be32_to_cpu(packet->pages_used);
-- 
2.20.1


