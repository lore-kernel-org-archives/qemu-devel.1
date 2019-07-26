Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B1FC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E2D229F9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E2D229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqz16-0005gP-QV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hqyyu-0005Vm-AE
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hqyys-00083o-0z
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hqyyr-0007tX-JC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF5A94628B
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 12:05:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-30.ams2.redhat.com
 [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 646D35DE6F;
 Fri, 26 Jul 2019 12:05:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B9A81132DDB; Fri, 26 Jul 2019 14:05:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 14:05:20 +0200
Message-Id: <20190726120542.9894-7-armbru@redhat.com>
In-Reply-To: <20190726120542.9894-1-armbru@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 26 Jul 2019 12:05:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 06/28] trace: Eliminate use of TARGET_FMT_plx
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/tpm/trace-events uses TARGET_FMT_plx formats with uint64_t
arguments.  That's wrong, TARGET_FMT_plx takes hwaddr.  Since hwaddr
happens to be uint64_t, it works anyway.  Messed up in commit
ec427498da5, v2.12.0.  Clean up by replacing TARGET_FMT_plx with its
macro expansion.

scripts/tracetool/format/log_stap.py (commit 62dd1048c0b, v4.0.0) has
a special case for TARGET_FMT_plx.  Delete it.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/tpm/trace-events                  | 4 ++--
 scripts/tracetool/format/log_stap.py | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 0b94aa1526..25e47a595a 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -1,8 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
 # tpm_crb.c
-tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read =
0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
-tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB writ=
e 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
+tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read =
0x016%" PRIx64 " len:%u val: 0x%" PRIx32
+tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB writ=
e 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
=20
 # tpm_passthrough.c
 tpm_passthrough_handle_request(void *cmd) "processing command %p"
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/for=
mat/log_stap.py
index 3ccbc09d61..9ab0cf2cce 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -30,9 +30,6 @@ def c_macro_to_format(macro):
     if macro.startswith("PRI"):
         return macro[3]
=20
-    if macro =3D=3D "TARGET_FMT_plx":
-        return "%016x"
-
     raise Exception("Unhandled macro '%s'" % macro)
=20
 def c_fmt_to_stap(fmt):
--=20
2.21.0


