Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7DC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6982176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6982176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ7g-0008VR-D9
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYx8-00020s-E8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYx7-0008CS-8s
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:22 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:34643)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYx3-0007q8-GG; Wed, 18 Dec 2019 08:01:17 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8XkP-1he1yD1VAH-014TUZ; Wed, 18 Dec 2019 14:01:12 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] qemu-doc: Remove the unused "Guest Agent" node
Date: Wed, 18 Dec 2019 14:01:05 +0100
Message-Id: <20191218130105.125981-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218130105.125981-1-laurent@vivier.eu>
References: <20191218130105.125981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OoM52WcD+7hA490CeupEbe9AmoiALHAO381+nS6jDBKFFoONge9
 /+O3m2dnz2Wu5rNh8VFk8DA0bGrT1kHMOBZYAeShApYc2IZb93M93EYLbmwStUfV6LUOmAF
 nRAr2MJAJvNdnFXQhDxkm1gaDyA2H0QyarUsRDcN3+uSSjE8xk5jWohK1zHNsrOVt/qo7aY
 hyo/MWORXiCSbitVfSduw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RwNdeAo+slw=:X9sff6sd/GVtZmjfFHA4Gv
 O3lvZhI+1dqamncpLlJDCqRH3LjVIw5iKn4WAYtHOWLf3z+t+Asw9hallyunccZEBMEMYNED/
 yXWnFwrQ9rRlnAxIlEapS+ZeXK1moeg/nemQhvZ0Ou8mfPBMjaOdp6lYr6pSsX9IAGvuLPNf9
 ybux64lubRNjjzhUcfrUHk+ufhuqWKTdHAfsJ9wi2Lxjw+2GXDJTW+++i1olgmtlIKT2AyhYp
 PLiU1MTk8VjgwRadhwUiyx+1hRxGxQgieCumb07r0olpdBJVHwPUsw9gsKuKlrn7DGLaOyBVE
 bUZOTahdjclf7IPxVrYEFllknDLGPTYWnkzc/C+hYXuhOlcQ3BiVvD0kGW2y0VwS/gs9UOjap
 +osgE2Y6fV6MA5ALzHaBWX6Lu9FfFZ2ie50E9xX5L1HgkRyXsYziN1rUScjuKvGSwkMwbR8su
 WNGr+wCYAkcohtVPbrIj8SMaNFS1ZyOXkwooAqJHxLa/+Ei2SK7xBSSbp7VBFIjGXYMZhoMUF
 DEY41xvd5RVXXAdfletNDFU2L7yJ6BQb6KI7Jf6UZkQVARB56lJJ3wVtfVnZyzBRAt+TLSKVM
 J4M9/9grPmtZFSylnHTc9zRmwTLKwKo830LL4tJCdm7aUMlxoCh/vvBqTWpLS9DpEguFKYdaD
 UeImpaUtw16KEI43evUwHTGzV6ufBBsCN9Pc3lFQjM2xLvE/mXXT0pUoWOGGTpALYhHY0MSsL
 +3ZFY1TiTKf/E/08BcgBsvHHjH84D0XAeDeK7vxIb04IHmlC3ekeGKdq1mE9GZwcyRErRYT1L
 7LfSl0UbRQ7psL1mzXVZ+YfkWV8/Y3gWlwyF6OIulGDri1Jzpe95QvW+x8WO4hYcRhrLLvkWK
 lFBeSoT3NIAIGISDY8UQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The node has been removed from the texi file some months ago, so we
should remove it from the menu section, too.

Fixes: 27a296fce982 ("qemu-ga: Convert invocation documentation to rST")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191216132941.25729-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-doc.texi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index eea91a2d1efd..39f950471f28 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -38,7 +38,6 @@
 * Introduction::
 * QEMU PC System emulator::
 * QEMU System emulator for non PC targets::
-* QEMU Guest Agent::
 * QEMU User space emulator::
 * System requirements::
 * Security::
-- 
2.24.1


