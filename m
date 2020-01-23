Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4760520684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snbU6Z9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4760520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf3Y-0003lO-Uy
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrR-00054X-Q0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrQ-0003U7-Jc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:29 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrQ-0003Sc-DA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:28 -0500
Received: by mail-wr1-x42f.google.com with SMTP id g17so3163223wro.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/n6fsNYCgUUz+As71BcAONX0z/kz1Ylr8LtgTEjsS5g=;
 b=snbU6Z9mUj4plDzrnUMTaGH5GhASijPgXmAb3gJJD0N8+2bfH/T+2sqFD8fYG+olyz
 nesy4KzDawR15+8qHL3/CnhjtVF5LQGMAO71z0OPZHrYR698eszA+9SJkE3gf7KkBVvx
 2OKFsXFHnZ1Xsq3hGsvJp8W+/rmOkDoLG4fPt8WFh6eZAkYAmvpOv5mqCFXSLIgEACqh
 j+SmVWblTrUMZdiQHmEpkWOX+KbuxYUgxmYR3q7365QVUQsSYl3phL7IPTeKpQYcfEX/
 ZnYHn6MhqI8//uwbJtUygpTslkTBjD5dTwoQJE+MGyi5FwXnKTDDONjdR6Ta0WjGAlEw
 nv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/n6fsNYCgUUz+As71BcAONX0z/kz1Ylr8LtgTEjsS5g=;
 b=MbWE+rKaUd3V/e23Kf6gLcP8J/tI+c/bvb+SMup9NDUnIUsJhfMYbEv4QQlDxFK8bd
 BC3uw9zQvKQZk1EhDWb128TZOFoK4XHgTR0ATYgvbOrLE4Xm1imBtIMISe1pj1tpd/9G
 qWbBWF1cVvRpAgE6s1u5ZoX+H05KrW4cvzGIZYbe0nNBYYV+p9LbbNLMWNJd5m3kupIk
 Gvdvxj4Z0zfrfB+KqlUgBN5DgoDOW4RbRKQo10Uq2wuPzWZVgLdSVW9jKOYYQOUm6+Ex
 udnEsLQG/dnDN7qiuN9HR9OZmoPLum9ZDqzFHUvpmSv8cwMwOY0owhwFsjVQxMSXV0N6
 GT/Q==
X-Gm-Message-State: APjAAAX+AwQLNhDTXvAo88o5eeptRRAjYtg/AZ+ZVWsJB+s352OcREuP
 u/asAFW501EF8TawJsZgr0DS4oEp
X-Google-Smtp-Source: APXvYqzRFC3ttRI7vgAqJaBtp88XDmxF7e105HOQO9kDKnHMwlA49LU4uGKQS2tO1QaK4rimee16nQ==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr17216943wrh.49.1579787367209; 
 Thu, 23 Jan 2020 05:49:27 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/59] hw/ppc/spapr_rtas: Use local MachineState variable
Date: Thu, 23 Jan 2020 14:48:26 +0100
Message-Id: <1579787342-27146-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since we have the MachineState already available locally,
use it instead of the global current_machine.

Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200121110349.25842-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr_rtas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 8d8d8cd..e88bb19 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -281,7 +281,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           "DesProcs=%d,"
                                           "MaxPlatProcs=%d",
                                           max_cpus,
-                                          current_machine->ram_size / MiB,
+                                          ms->ram_size / MiB,
                                           ms->smp.cpus,
                                           max_cpus);
         if (pcc->n_host_threads > 0) {
-- 
1.8.3.1



