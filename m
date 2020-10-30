Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B995C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D668520729
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7VlJ+se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D668520729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWRB-0007Ly-PA
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYWQ5-000648-U7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYWQ3-0001V3-Ow
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604072062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nuOhsJ3Uo1Z227rZ8I4Xl07IBBGO07oqf1EMKuGdmw=;
 b=X7VlJ+semylxuQFNH3bo1piUyf8vFGgAu8xe3SUw2j65hgrpKM6K6jcENCl8pCsp1y5Vo1
 5SdPPcFGOn33Mtxpn/aKznswX4kwGFRg/Nz8mG57wrJiDVi3yT/vZzRS7+xrnKglDX5TUG
 8oe7tilC2IXkct6xYa/asSNJNWG2z2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-DJ_jwuRtOhibsOKNwRWf6w-1; Fri, 30 Oct 2020 11:34:20 -0400
X-MC-Unique: DJ_jwuRtOhibsOKNwRWf6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90215186DD31;
 Fri, 30 Oct 2020 15:34:19 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D69745D9D2;
 Fri, 30 Oct 2020 15:34:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] MAINTAINERS: Make status spellings consistent
Date: Fri, 30 Oct 2020 11:34:16 -0400
Message-Id: <20201030153416.429791-3-jsnow@redhat.com>
In-Reply-To: <20201030153416.429791-1-jsnow@redhat.com>
References: <20201030153416.429791-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d46f7b126c9e..c335f40adc73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1134,7 +1134,7 @@ F: tests/acceptance/machine_mips_malta.py
 
 Mipssim
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Orphaned
+S: Orphan
 F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
 
@@ -2390,7 +2390,7 @@ T: git https://gitlab.com/jsnow/qemu.git python
 Python scripts
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
-S: Odd fixes
+S: Odd Fixes
 F: scripts/*.py
 F: tests/*.py
 
@@ -2623,7 +2623,7 @@ F: tests/test-coroutine.c
 
 Buffers
 M: Daniel P. Berrange <berrange@redhat.com>
-S: Odd fixes
+S: Odd Fixes
 F: util/buffer.c
 F: include/qemu/buffer.h
 
@@ -2652,7 +2652,7 @@ F: qapi/sockets.json
 
 File monitor
 M: Daniel P. Berrange <berrange@redhat.com>
-S: Odd fixes
+S: Odd Fixes
 F: util/filemonitor*.c
 F: include/qemu/filemonitor.h
 F: tests/test-util-filemonitor.c
@@ -3184,7 +3184,7 @@ S: Odd Fixes
 F: scripts/git-submodule.sh
 
 UI translations
-S: Orphaned
+S: Orphan
 F: po/*.po
 
 Sphinx documentation configuration and build machinery
-- 
2.26.2


