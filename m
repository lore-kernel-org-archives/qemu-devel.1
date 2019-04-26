Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C98C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCDD206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FQx8GD+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCDD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuNb-0004xV-OG
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:30:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1N-0006TE-Db
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1M-0005hv-ET
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43479 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu1M-00057Q-2K; Fri, 26 Apr 2019 02:07:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tq6vkhz9sP6; Fri, 26 Apr 2019 16:06:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258799;
	bh=r6JNa1prXyLYVctVx2AwTgsbKg4g21LB0JfRL3C1tXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQx8GD+/A5y3Qv4J2pH7yVeS99mSmtheTlumgXdwGarG1oonFMiiOfa6HMc+gfzGP
	6Tw7w2UMJZpPa/Z1IWyHKeSi7KZXAGFc4+cFcFmBWRpvhIRb6FzAfP0jwnMnuqEbpM
	wMtejEhXCCkcZbRUCIgnWdporbJhceIMpt64Sric=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:21 +1000
Message-Id: <20190426060627.18153-31-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 30/36] target/ppc/trace-events: Fix trivial typo
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
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060621.wmsIK3n2ZV3_J0x_XctSKiEjLewM5oC1NMUdvOokoF4@z>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index 3858f97dff..ed4d57c6d9 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -1,5 +1,5 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
 # kvm.c
-kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR=
 %d to KVM: %s"
-kvm_failed_spr_get(int str, const char *msg) "Warning: Unable to retriev=
e SPR %d from KVM: %s"
+kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR=
 %d to KVM: %s"
+kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retriev=
e SPR %d from KVM: %s"
--=20
2.20.1


