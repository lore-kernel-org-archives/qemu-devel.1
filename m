Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63038C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA31820716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA31820716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvFC-0003lm-GI
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDvDJ-0001Iw-VJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:48:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44926
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDvDI-0003qB-56
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:48:05 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ZoD_CCXxOVC-sY_br1LWow-1; Thu, 03 Sep 2020 15:48:00 -0400
X-MC-Unique: ZoD_CCXxOVC-sY_br1LWow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 048C3801AEE;
 Thu,  3 Sep 2020 19:48:00 +0000 (UTC)
Received: from bahia.lan (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 812237EEC9;
 Thu,  3 Sep 2020 19:47:56 +0000 (UTC)
Subject: [PATCH 2/2] Makefile: Skip the meson subdir in cscope/TAGS/ctags
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Thu, 03 Sep 2020 21:47:55 +0200
Message-ID: <159916247553.691541.10480293747685886851.stgit@bahia.lan>
In-Reply-To: <159916226258.691541.13056254320330610953.stgit@bahia.lan>
References: <159916226258.691541.13056254320330610953.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the meson submodule is present, we don't really want to index its
source code. Consolidate the find command in a single place and use
it for cscope, ctags and etags. Note that this now causes ctags and
etags to also index assembly files, but this is okay since they both
have been supporting assembly since 2001 at least.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 Makefile |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a9d3e2c4d375..34dd9e6c4c4a 100644
--- a/Makefile
+++ b/Makefile
@@ -229,20 +229,22 @@ distclean: clean ninja-distclean
 =09rm -f linux-headers/asm
 =09rm -Rf .sdk
=20
+find-src-path =3D find "$(SRC_PATH)/" -path "$(SRC_PATH)/meson" -prune -o =
-name "*.[chsS]"
+
 .PHONY: ctags
 ctags:
 =09rm -f tags
-=09find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
+=09$(find-src-path) -exec ctags --append {} +
=20
 .PHONY: TAGS
 TAGS:
 =09rm -f TAGS
-=09find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
+=09$(find-src-path) -exec etags --append {} +
=20
 .PHONY: cscope
 cscope:
 =09rm -f "$(SRC_PATH)"/cscope.*
-=09find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SR=
C_PATH)/cscope.files"
+=09$(find-src-path) -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files=
"
 =09cscope -b -i"$(SRC_PATH)/cscope.files"
=20
 # Needed by "meson install"



