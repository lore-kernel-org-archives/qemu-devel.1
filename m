Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F48C17460
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A16217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A16217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS086-0004io-TE
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 09:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS03M-0008SC-Lz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS03L-0002jr-Eb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:43:28 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:55037)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iS03F-0002fa-0J; Tue, 05 Nov 2019 09:43:21 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNOZO-1iHcpa0A94-00OnFO; Tue, 05 Nov 2019 15:43:00 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] qom: Fix error message in object_class_property_add()
Date: Tue,  5 Nov 2019 15:42:46 +0100
Message-Id: <20191105144247.10301-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105144247.10301-1-laurent@vivier.eu>
References: <20191105144247.10301-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6lLJMzjHAvmf+zbwEIjFaYmgyD4Xp9wj/yXBg2phAoLtjGTLNyf
 jFjRccWeRNCD3ubmrfEp6pKPVm7zFgjB+CKCqYNlLfEM0oSrYgQF1m5aP+VPUibYsU/asll
 l0BTqu8MMLy2rC5IlFC/P74gFDbdiPqYjDS81gLzgE669CpGIkKZX6QpwL+i+h9nd3ihAHs
 k0aU8H/oBeIugwumgO8KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9IzBdaTOrfc=:WVe7Hft7P5ufdiP75OVziB
 x8KctqAt8Cv13LcM75gj++4dutEn1v6LhQCSchEOYg+3tcCUGhIt50OpmFgITwSRxocBrT6e1
 bLP2HAWKwgcU66M482GnlsGwKAOwQSJubLVIpHxdSfMoOFUbTgySaV4aNsT8/NXQ44Ekpb6dj
 fkHmWUkptVIFOgHWCV8k7MOqOuGhzS4yhquR6JINooEiJtgAdBX7i7cYnis4JxR90Rq7mGqcm
 r8TB5sXsaFdr2oMLgWl23Fv+1rChP4I+6k371AwGaZIom+FcxtKUVlK9SnhPQErgGNMr0eaKv
 exQ23WnT7L0Q80b1ybigTikE0TmleJRNc/kVNs/6G0L9AQ6yIZpFpWoDb8rBApCbyt4ShbJPU
 ANLd4+KPQn2ALCD9oXPCD7JYQEAmtSclO/2X9fYeMaRedVAseex7WifatctvkBWGZ1NbpXfpD
 VJAmA+VGKVzMy1hC7r8S19oX6SnbiFpS6KrzdL+UBRPD6cYUfU1TMWr53tI+RSeydqA6CF7d+
 cI0ZBSSQ+ydwV0IgBhHd90uy2gMyoxuwEn2wacAXtC6zUy/R8Hdu1de7EpV6skhW6Dzb+TXyq
 nHnuwiwgIrNcSkeEn44cN7ThC6TWlXbVEo2lK+e/FtwcX2dLjRb9+7BAMOFpVcc1jnv03IeI6
 Y2l5mm0yZ489zSr+dbjUHxYaHF2spJzvD7vxmkeDD3V//U+togeiqoOm5AXdQJAcBcH1zAy3D
 b6tewJkju/xecXIYUa9kGmGwLWBWI1IMTK2wQ6W8+NQpz2/P78nHKQuxG6cQwqQI/rPdhAViP
 QWZcUcoFU7WV3kHIckvdm551ETQMMONk8tpB6dkM4yh7dSXhZjSapaolihSSiV7SlsFh/jcva
 rfBzTogkwOQAHn9mOXYA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, qemu-trivial@nongnu.org,
 Claudio Fontana <claudio.fontana@huawei.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Fabien Chouteau <chouteau@adacore.com>, Greg Kurz <groug@kaod.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The error message in object_class_property_add() was copied from
object_property_add() in commit 16bf7f522a2ff. Clarify that it is
about a class, not an object.

While here, have the format string in both functions to fit in a
single line for better grep-ability, despite the checkpatch warning.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <157287383591.234942.311840593519058490.stgit@bahia.tlslab.ibm.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qom/object.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 6fa9c619fac4..d51b57fba11e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1106,9 +1106,8 @@ object_property_add(Object *obj, const char *name, const char *type,
     }
 
     if (object_property_find(obj, name, NULL) != NULL) {
-        error_setg(errp, "attempt to add duplicate property '%s'"
-                   " to object (type '%s')", name,
-                   object_get_typename(obj));
+        error_setg(errp, "attempt to add duplicate property '%s' to object (type '%s')",
+                   name, object_get_typename(obj));
         return NULL;
     }
 
@@ -1139,9 +1138,8 @@ object_class_property_add(ObjectClass *klass,
     ObjectProperty *prop;
 
     if (object_class_property_find(klass, name, NULL) != NULL) {
-        error_setg(errp, "attempt to add duplicate property '%s'"
-                   " to object (type '%s')", name,
-                   object_class_get_name(klass));
+        error_setg(errp, "attempt to add duplicate property '%s' to class (type '%s')",
+                   name, object_class_get_name(klass));
         return NULL;
     }
 
-- 
2.21.0


