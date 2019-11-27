Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F947C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B15120684
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIIODQ9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B15120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZzcX-0001rF-7h
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iZzb6-0008Qz-CR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iZzb5-0002ss-FL
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:51:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iZzb5-0002qq-CP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574869876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fMYtqfEPtvwR1oq2gVG2Msg0FfbaqLatOFvY14i/d6I=;
 b=eIIODQ9vY7OURgQJ3+E09ZYEm6Yc9NZOMxdQQMSHsgoazZKotxgC9uMbdRtn09oKSDp6eP
 MkXcuYfgwcHat5SiLem/ipejARI/RhHuzonlAeJT6wK/5yQ72Ovm8Lu5hBEVEQhcvzMsjw
 MkWocZWtVrCoRoExi1qWb+x1WP3puqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-nhUGtkGTMm-o17djqDQqlQ-1; Wed, 27 Nov 2019 10:51:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02F768BEF88;
 Wed, 27 Nov 2019 15:51:09 +0000 (UTC)
Received: from thuth.com (ovpn-117-186.ams2.redhat.com [10.36.117.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E751087ED6;
 Wed, 27 Nov 2019 15:51:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] gitlab-ci.yml: Run tcg test with tci
Date: Wed, 27 Nov 2019 16:51:05 +0100
Message-Id: <20191127155105.3784-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nhUGtkGTMm-o17djqDQqlQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add
implementation for INDEX_op_ld16u_i64") has been included now, we
can also run the TCG tests with tci, so let's enable them in our
Gitlab CI now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index be57c6a454..125d4204b3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -73,6 +73,7 @@ build-tci:
  - ./configure --enable-tcg-interpreter
       --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; =
done)"
  - make -j2
+ - make run-tcg-tests-x86_64-softmmu
  - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
  - for tg in $TARGETS ; do
      export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
--=20
2.18.1


