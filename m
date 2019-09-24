Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F40C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A91207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A91207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkDJ-000382-C6
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0o-0001KH-8P
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0k-0006yo-D1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0j-0006w9-V1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC76310C0936
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D20C15D9D5;
 Tue, 24 Sep 2019 12:33:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B0031138661; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/37] scripts/git.orderfile: Match QAPI schema more precisely
Date: Tue, 24 Sep 2019 14:33:00 +0200
Message-Id: <20190924123334.30645-4-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

Pattern *.json also matches the tests/qapi-schema/*.json.  Separates
them from the tests/qapi-schema/*.{err,exit,out} in diffs.  I hate
that.  Change the pattern to match just the "real" QAPI schemata.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190913201349.24332-2-armbru@redhat.com>
---
 scripts/git.orderfile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index ac699700b1..e89790941c 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -19,11 +19,11 @@ Makefile*
 *.mak
=20
 # qapi schema
-*.json
+qapi/*.json
+qga/*.json
=20
 # headers
 *.h
=20
 # code
 *.c
-
--=20
2.21.0


