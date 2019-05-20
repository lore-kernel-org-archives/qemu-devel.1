Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91700C04E87
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D19213F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D19213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShn3-000682-Hx
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:53:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hShhT-0002J3-8n
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hShhP-0005sx-VX
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hShhP-0005rw-Pe
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1944F3082E68;
	Mon, 20 May 2019 12:47:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 753B750A63;
	Mon, 20 May 2019 12:47:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 33F331753F; Mon, 20 May 2019 14:47:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 14:47:10 +0200
Message-Id: <20190520124716.30472-9-kraxel@redhat.com>
In-Reply-To: <20190520124716.30472-1-kraxel@redhat.com>
References: <20190520124716.30472-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 20 May 2019 12:47:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 08/14] tests/vm: add DEBUG=1 to help text
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 47084d5717c6..a018288b061c 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -25,6 +25,8 @@ vm-test:
 	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh=
"
 	@echo
 	@echo "Special variables:"
+	@echo "    DEBUG=3D1                       - be verbose, also start int=
eractive"
+	@echo "	                                   shell on build failures"
 	@echo "    BUILD_TARGET=3Dfoo		 - override the build target"
 	@echo "    TARGET_LIST=3Da,b,c    	 - Override target list in builds."
 	@echo '    EXTRA_CONFIGURE_OPTS=3D"..."'
--=20
2.18.1


