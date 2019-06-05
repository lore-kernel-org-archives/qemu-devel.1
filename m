Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7CAC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53C720693
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI6yrydI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53C720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXGi-0003RV-2A
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:52:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hYX5Y-0002PG-QQ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hYX5X-0004J8-63
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:28 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hYX5W-0004GL-UB
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:27 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n4so14492464wrw.13
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fF19xYu0+HFkIIi6MXFFaCEjhliIhGHLof0zrfgmqj8=;
	b=EI6yrydI2+LfHUhw+ZPCnoN66ieSU0nHlXBUaFhQhbCjt77fTWwZfPCV7LM1cec2PP
	dRQqk8i9wFEUPSUbDwNu7CHPFDqQBSTvtAUpQvqWtYBwWBFB/ee4b3cRXyPieZ24DvXs
	p5xAcAzLaIhVRnUsqCo7Pr6FyxR/0S9Eq64q/Zs5l4nQbg6jO64NNwNhP4Q3bnxPyLvq
	fFXLmUzNje/7z6fgtGNiuTI1qx/zr0/2UziBn5ju9qvrXywZX3ALP/YxWOByeIW/1DUj
	vE7mr8sdZYpCW7hRLolJfT1BKK86CExTrMs9Jqghwyvipy2mUu5MF5Cbwfd7/58f2ler
	oyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=fF19xYu0+HFkIIi6MXFFaCEjhliIhGHLof0zrfgmqj8=;
	b=p2SCjC+CurMbl9NB4nhzw9NoRsKI8M2nhTxQTZx5S+gjACOUeHFw6pLvltFBWMOlJi
	ERejiyWLwBwvVF3yN22/+yp9q27uBglzPEDUxCnPh7Xg04DhsBoyIOySCTmdeTqLXbTp
	hhf9vf5LdAOesWBvXKrx2lwAe3xMxM6pkqGBhOZynk+aNIHvh0513tB/pDEzP+OxSbJL
	GIFjXEwSfyuBWnEqeENZbzUszJHjnl8tJxlg7yTH52J18VkC+/6SiHgMAnWIBjAJCPWF
	WJ9UcdMEQdY20DTGsSy81Egkw8iQ64hXCZNBRq9JXxHbPh11JRIoAnNRjQD7VbRXdB+u
	pPFA==
X-Gm-Message-State: APjAAAX6CClnCIPafMrv9BNn3hX+6ShjaoCwYaF+DVOGz/w6p4tGdiSU
	wJytdXshBiawa/iNYqszMTOSPQpt
X-Google-Smtp-Source: APXvYqwFYBaUivrkYGoUqzAgJegQhtPbZ3RA9SPa5yY8/CirvRZx9vP7II99VY5ogPxLvDiN+1NACA==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr3328283wru.195.1559745624418; 
	Wed, 05 Jun 2019 07:40:24 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	t14sm22123117wrr.33.2019.06.05.07.40.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 07:40:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 16:40:20 +0200
Message-Id: <1559745620-18828-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559745620-18828-1-git-send-email-pbonzini@redhat.com>
References: <1559745620-18828-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 2/2] vl: Document why objects are delayed
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Objects should not be "delayed" without a reason, as the previous
commit demonstrates.  The remaining ones have reasons.  State them.
and demand future ones come with such a statement.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190604151251.9903-3-armbru@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index cc6246d..cd1fbc4 100644
--- a/vl.c
+++ b/vl.c
@@ -2751,19 +2751,25 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
         exit(0);
     }
 
+    /*
+     * Objects should not be made "delayed" without a reason.  If you
+     * add one, state the reason in a comment!
+     */
+
+    /* Reason: rng-egd property "chardev" */
     if (g_str_equal(type, "rng-egd")) {
         return false;
     }
 
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
+    /* Reason: cryptodev-vhost-user property "chardev" */
     if (g_str_equal(type, "cryptodev-vhost-user")) {
         return false;
     }
 #endif
 
     /*
-     * return false for concrete netfilters since
-     * they depend on netdevs already existing
+     * Reason: filter-* property "netdev" etc.
      */
     if (g_str_equal(type, "filter-buffer") ||
         g_str_equal(type, "filter-dump") ||
-- 
1.8.3.1


