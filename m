Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4130C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27D1206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27D1206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Ld-0003Qv-SN
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kD78y-0001hS-O5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:20:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50153
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kD78x-000563-7V
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:20:16 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-BsOtR3ioOmaC8hHh-Te3Ag-1; Tue, 01 Sep 2020 10:20:12 -0400
X-MC-Unique: BsOtR3ioOmaC8hHh-Te3Ag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B351425D3
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 14:20:11 +0000 (UTC)
Received: from bahia.lan (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D34F778B40;
 Tue,  1 Sep 2020 14:20:10 +0000 (UTC)
Subject: [PATCH 1/2] Makefile: Add back TAGS/ctags/cscope rules
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 01 Sep 2020 16:20:10 +0200
Message-ID: <159897001005.442705.16516671603870288336.stgit@bahia.lan>
In-Reply-To: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
References: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.61; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:16:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is a bit of a pain to be forced to run configure before being able
to use cscope and friends. Add back the rules to build them in-tree
as before commit a56650518f5b.

Fixes: a56650518f5b ("configure: integrate Meson in the build system")
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 Makefile |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 81794d5c34a2..8ffe2872915d 100644
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,7 @@ ninja-distclean::
 build.ninja: config-host.mak
=20
 Makefile.ninja: build.ninja ninjatool
-=09./ninjatool -t ninja2make --omit clean dist uninstall < $< > $@
+=09./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags=
 < $< > $@
 -include Makefile.ninja
=20
 ${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command +=
=3D -MP
@@ -229,6 +229,21 @@ distclean: clean ninja-distclean
 =09rm -f linux-headers/asm
 =09rm -Rf .sdk
=20
+.PHONY: ctags
+ctags:
+=09rm -f tags
+=09find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
+
+.PHONY: TAGS
+TAGS:
+=09rm -f TAGS
+=09find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
+
+cscope:
+=09rm -f "$(SRC_PATH)"/cscope.*
+=09find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SR=
C_PATH)/cscope.files"
+=09cscope -b -i"$(SRC_PATH)/cscope.files"
+
 ifdef INSTALL_BLOBS
 BLOBS=3Dbios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vg=
abios-cirrus.bin \
 vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \



