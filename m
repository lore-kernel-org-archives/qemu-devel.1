Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B63C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2796F20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/lR3g6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2796F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxUD-0004Hm-8w
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHa-0003Z3-8y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHY-0004Vi-7w
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHY-0004VK-3L
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHmCL3a+xAfKgSq86Fdzp47nnxo0weWCnyOq498MzaQ=;
 b=P/lR3g6H/IipQUUZQ4MUxt1YibSOyyxCHR1us6yA2+QaGX3Zz6cEQXlg3+2odXmlg6VTTd
 S0qGq1wta4ocMmQE8Gm9WoxJ6pDv6COuybCCu+GzYn8e4T7IezDZ8VUrKgBx6hn0jD0Mlo
 v5HHYRopFNNmunVwZcGsn4lLVeixTIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-ceghNtbpOIyPlNM-OmVRkw-1; Mon, 16 Mar 2020 17:28:17 -0400
X-MC-Unique: ceghNtbpOIyPlNM-OmVRkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0EF51804540
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:15 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 998EB19C4F;
 Mon, 16 Mar 2020 21:28:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/61] Makefile: Let the 'help' target list the tools targets
Date: Mon, 16 Mar 2020 22:26:51 +0100
Message-Id: <1584394048-44994-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

List the name of the tool targets when calling 'make help':

  $ make help
  [...]
  Tools targets:
    qemu-ga                        - Build qemu-ga tool
    qemu-keymap                    - Build qemu-keymap tool
    elf2dmp                        - Build elf2dmp tool
    ivshmem-client                 - Build ivshmem-client tool
    ivshmem-server                 - Build ivshmem-server tool
    qemu-nbd                       - Build qemu-nbd tool
    qemu-img                       - Build qemu-img tool
    qemu-io                        - Build qemu-io tool
    qemu-edid                      - Build qemu-edid tool
    fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper tool
    scsi/qemu-pr-helper            - Build qemu-pr-helper tool

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 6ec19f8..25a7056 100644
--- a/Makefile
+++ b/Makefile
@@ -1255,6 +1255,11 @@ endif
 =09=09$(foreach t, $(TARGET_DIRS), \
 =09=09$(call print-help-run,$(t)/all,Build for $(t));) \
 =09=09echo '')
+=09@$(if $(TOOLS), \
+=09=09echo 'Tools targets:'; \
+=09=09$(foreach t, $(TOOLS), \
+=09=09$(call print-help-run,$(t),Build $(shell basename $(t)) tool);) \
+=09=09echo '')
 =09@echo  'Cleaning targets:'
 =09$(call print-help,clean,Remove most generated files but keep the config=
)
 ifdef CONFIG_GCOV
--=20
1.8.3.1



