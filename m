Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D016DC47258
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE51206D7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5CN3KFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE51206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVx9C-0007n2-QL
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 08:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVx8V-0007Mm-GU
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:57:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVx8U-0000Gs-PY
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zQMuWS7zjD4d6JnwVgxUv5Po5zlQzm4gphgS9LFkmto=;
 b=Z5CN3KFKH7Ay8xZpjURehB9w0KOJHa4qs5MMz21NNuT5bXX+TKHF4X6E7Q/jtrsMwbyJXB
 AlO182qIL7Gd36skPSQfbDd77juM+Lvalk5iTbACYjSxdYhFAquVa3p1ndfytQTwzvJ0+6
 daisoEi3lGfENfTWZ3oaAtzB0+ZTeJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-2gvkTlJ_P6uNquGUxuQscQ-1; Tue, 05 May 2020 08:57:20 -0400
X-MC-Unique: 2gvkTlJ_P6uNquGUxuQscQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBFF7100CCC0
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 12:57:19 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 020BE5C1B2;
 Tue,  5 May 2020 12:57:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ui: update keycodemapdb submodule commit
Date: Tue,  5 May 2020 13:57:13 +0100
Message-Id: <20200505125713.940953-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Primarily this is to pull in a fix for Win32 keycodes. The other useful
change is the removal of build timestamp from generated files which is
desirable for reproducable builds.

The make rules need updating due to slightly changed CLI syntax - more
args must now come after the command name.

27acf0ef828bf719b2053ba398b195829413dbdd Fix win32 keycode for VK_OEM_102
317d3eeb963a515e15a63fa356d8ebcda7041a51 Add support for generating RST for=
matted docs pages
7381b9bfadd31c4c9e9a10b5bb5032f9189d4352 Introduce separate args for title =
& subtitle with docs generator
6280c94f306df6a20bbc100ba15a5a81af0366e6 keymap-gen: Name sections in pod o=
utput
df4e56f8fab65ba714ec18f4e7338a966a1620ad Add an empty meson project
16e5b0787687d8904dad2c026107409eb9bfcb95 remove buildtime from generated fi=
les
044f21dd0d4f62519aae9f1d53a026407a0b664f add header file generators
7779876a6b06755e3bb2c94ee3ded50635bcb0fa c++: add extern declaration to the=
 generated file
0e0a317889464397d6f1ae03aad0d2ca593aab04 move CLanguageGenerator closer to =
CLanguageGenerator itself

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 Makefile        | 4 ++--
 ui/keycodemapdb | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 34275f57c9..5f2b63b1cd 100644
--- a/Makefile
+++ b/Makefile
@@ -310,10 +310,10 @@ ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_C=
SV) $(SRC_PATH)/ui/Makefile
 =09$(call quiet-command,\
 =09    stem=3D$* && src=3D$${stem%-to-*} dst=3D$${stem#*-to-} && \
 =09    test -e $(KEYCODEMAP_GEN) && \
-=09    $(PYTHON) $(KEYCODEMAP_GEN) \
+=09    $(PYTHON) $(KEYCODEMAP_GEN) code-map \
 =09          --lang glib2 \
 =09          --varname qemu_input_map_$${src}_to_$${dst} \
-=09          code-map $(KEYCODEMAP_CSV) $${src} $${dst} \
+=09          $(KEYCODEMAP_CSV) $${src} $${dst} \
 =09        > $@ || rm -f $@, "GEN", "$@")
=20
 $(KEYCODEMAP_GEN): .git-submodule-status
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
index 6b3d716e2b..27acf0ef82 160000
--- a/ui/keycodemapdb
+++ b/ui/keycodemapdb
@@ -1 +1 @@
-Subproject commit 6b3d716e2b6472eb7189d3220552280ef3d832ce
+Subproject commit 27acf0ef828bf719b2053ba398b195829413dbdd
--=20
2.26.2


