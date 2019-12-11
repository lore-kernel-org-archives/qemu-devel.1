Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBDBC2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3B922527
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mg9/e8la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3B922527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if8s2-0001Ts-PA
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 15:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1if8qX-0000U7-2H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1if8qW-0007uB-36
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:44:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60316
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1if8qV-0007tX-Vb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576097071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtjTDwzdeKY3/qc46xH7vAXelz0oDZ8F2JiLvn05ByU=;
 b=Mg9/e8la53a6peysx3GnSNE9D3c67ufprRM7fdYlnQZH317D9I7INFLEPRsFNzXWwQtdDO
 fhsIH5/BgmQeAWhFWtTpkAqVIXg397wJuwu79T1llDhBdGj+9JFS0fwYg+ZpwqwJ27DZq+
 AmoGC89mgAx0roJrZHOmIdi1dMrD3iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-EWvbA26dPIKNenveQG-XrA-1; Wed, 11 Dec 2019 15:44:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F2CB8CAEDA
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:44:29 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC61F643E4;
 Wed, 11 Dec 2019 20:44:28 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] tests/Makefile: Fix check-report.* targets shown in
 check-help
Date: Wed, 11 Dec 2019 15:44:27 -0500
Message-Id: <20191211204427.4681-2-wainersm@redhat.com>
In-Reply-To: <20191211204427.4681-1-wainersm@redhat.com>
References: <20191211204427.4681-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EWvbA26dPIKNenveQG-XrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The check-report.html and check-report.xml targets were replaced
with check-report.tap in commit 9df43317b82 but the check-help
text was not updated so it still lists check-report.html.

Fixes: 9df43317b82
Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/Makefile.include | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8566f5f119..680bd8a669 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -16,12 +16,10 @@ check-help:
 =09@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
 =09@echo " $(MAKE) check-acceptance     Run all acceptance (functional) te=
sts"
 =09@echo
-=09@echo " $(MAKE) check-report.html    Generates an HTML test report"
+=09@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test r=
eport"
 =09@echo " $(MAKE) check-venv           Creates a Python venv for tests"
 =09@echo " $(MAKE) check-clean          Clean the tests and related data"
 =09@echo
-=09@echo "Please note that HTML reports do not regenerate if the unit test=
s"
-=09@echo "have not changed."
 =09@echo
 =09@echo "The variable SPEED can be set to control the gtester speed setti=
ng."
 =09@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; they c=
an be"
--=20
2.21.0


