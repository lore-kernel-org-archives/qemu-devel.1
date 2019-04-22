Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E441C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 22:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEC8205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 22:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEC8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIhJP-0006E5-TD
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 18:21:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIhFd-0003Pk-Cm
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIhFc-0006zb-Ea
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hIhFZ-0006wh-51; Mon, 22 Apr 2019 18:17:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D003A3082B22;
	Mon, 22 Apr 2019 22:17:19 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-206.bos.redhat.com [10.18.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BAFC461B77;
	Mon, 22 Apr 2019 22:17:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 18:17:13 -0400
Message-Id: <20190422221714.7630-2-jsnow@redhat.com>
In-Reply-To: <20190422221714.7630-1-jsnow@redhat.com>
References: <20190422221714.7630-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 22 Apr 2019 22:17:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/2] Makefile: add nit-picky mode to
 sphinx-build
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, aliang@redhat.com,
	kchamart@redhat.com, John Snow <jsnow@redhat.com>,
	qemu-stable@nongnu.org, armbru@redhat.com, nsoffer@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422221713.o_cqwP81hB6DZx_bY-YcRcWMXViO8uhUYVcSl6CKTQ8@z>

If we add references that don't resolve (or accidentally remove them),
it will be helpful to have an error message alerting us to that.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 04a0d45050..ff9ce2ed4c 100644
--- a/Makefile
+++ b/Makefile
@@ -899,7 +899,7 @@ docs/version.texi: $(SRC_PATH)/VERSION
 sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/inter=
op/index.html
=20
 # Canned command to build a single manual
-build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -b htm=
l -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees/$1 =
$(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$=
1")
+build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -n -b =
html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees/=
$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR=
)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$=
1/conf.py $(SRC_PATH)/docs/conf.py
=20
--=20
2.20.1


