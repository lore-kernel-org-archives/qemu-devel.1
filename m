Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8EFC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF18620674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUhJr213"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF18620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdC0-0000FK-V7
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAd9m-0005eq-7l
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAd9l-0005C6-6Y
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37211
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAd9k-00058C-Tz
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583601752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0/A/hRH1mvhq8x4w08HMbeR+czGBGSR4kgslcLdl5o=;
 b=NUhJr213+/91vxaK5lMNXWKPVnf9PfEP1Cs5Jprg6iqaPd4v328Pa9X7CF0lGLohenwCOY
 W/X/DBOTpI7NIQ+JUuZZrXqwCTTuaLqB6dq0ZW3nLHPgFlPB6EghhS2Lvm7fJe6PiIV50w
 QhCAJteX5VG3G/ZNFm3RkDSutTHQRcs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-1a_azBPoNM-xFMPw5M3q7Q-1; Sat, 07 Mar 2020 12:22:30 -0500
X-MC-Unique: 1a_azBPoNM-xFMPw5M3q7Q-1
Received: by mail-wm1-f69.google.com with SMTP id t8so908485wmd.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7nTC+WRNSHu4j2JzOidPqvy4DfqhlTeiQA0mMeL+b3M=;
 b=tz/gfIW48kMeklMtkqMMP/lDW32xTeLNEMXAgA/rniP0tP6nwrMrpyhsvoj9BXQO9N
 KzqOLc3skJUmQN7nIaTtXf+MUyTlLxxNxeqAYfcgwNYbaM1JsHPjA+ctT+5lsl0Tpuaf
 PuCUSCByQCEXeDoUNgwAr9FbcDg/S0hEXIL9rxJmXDue+GJs9wTI3+y8/Ux2AuSX/75p
 3/wk2PMfKtAp+OM14uDBkyZFNcdquQePpjehpwhjRrZ3KUINOVsYGyenbYgIXVXyc3na
 BDZejLLfX1iTWWUxsi/QQ6KN0+i89efD1Bp8jylRs/pHEugMLxkoxYQ0sR3xfkTj9F/p
 cpUg==
X-Gm-Message-State: ANhLgQ2Qd6hpkHCkbvrPDZx0dPePxQLd8o35O2FC6MDyi917Tgso/dbS
 Aa0VCCUg2xbx6NltmERf8iTeBJ3JBVrEEeYRH7vgLD74DmdO/gzSAUz+NiVmUoaG8xPXxJ1YUV2
 iylM2z8IMdckqtDQ=
X-Received: by 2002:adf:e506:: with SMTP id j6mr10255170wrm.309.1583601749106; 
 Sat, 07 Mar 2020 09:22:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs/mDwE957yg84UJCtaVSQiH3aa3U+9UoNU8lul0MXByw7FIzH8Y4x1OtX1zRVnMsIaJom97Q==
X-Received: by 2002:adf:e506:: with SMTP id j6mr10255158wrm.309.1583601748938; 
 Sat, 07 Mar 2020 09:22:28 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z129sm830972wmb.7.2020.03.07.09.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 09:22:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] configure: Check for <sys/uio.h> header before external
 libraries
Date: Sat,  7 Mar 2020 18:22:20 +0100
Message-Id: <20200307172222.14764-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200307172222.14764-1-philmd@redhat.com>
References: <20200307172222.14764-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20=D0=9F=D0=B0=D0=B2=D0=BB=D0=BE=D0=B2?=
 <alexey.pawlow@gmail.com>,
 =?UTF-8?q?=D0=9C=D0=B5=D1=82=D0=BB=D0=B8=D1=86=D0=BA=D0=B8=D0=B9=20=D0=AE=D1=80=D0=B8=D0=B9=20=D0=92=D0=B8=D0=BA=D1=82=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the next commit we will add a definition to the SASL CFLAGS,
depending whether the scatter/gather I/O include is present.
Move the  <sys/uio.h> header check before the external libraries
checks.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/configure b/configure
index cbf864bff1..0c2dd1eb08 100755
--- a/configure
+++ b/configure
@@ -2340,6 +2340,32 @@ if test "$vhost_net" =3D ""; then
   test "$vhost_kernel" =3D "yes" && vhost_net=3Dyes
 fi
=20
+##########################################
+# iovec probe
+cat > $TMPC <<EOF
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <unistd.h>
+int main(void) { return sizeof(struct iovec); }
+EOF
+iovec=3Dno
+if compile_prog "" "" ; then
+  iovec=3Dyes
+fi
+
+##########################################
+# preadv probe
+cat > $TMPC <<EOF
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <unistd.h>
+int main(void) { return preadv(0, 0, 0, 0); }
+EOF
+preadv=3Dno
+if compile_prog "" "" ; then
+  preadv=3Dyes
+fi
+
 ##########################################
 # MinGW / Mingw-w64 localtime_r/gmtime_r check
=20
@@ -4145,32 +4171,6 @@ EOF
   fi
 fi
=20
-##########################################
-# iovec probe
-cat > $TMPC <<EOF
-#include <sys/types.h>
-#include <sys/uio.h>
-#include <unistd.h>
-int main(void) { return sizeof(struct iovec); }
-EOF
-iovec=3Dno
-if compile_prog "" "" ; then
-  iovec=3Dyes
-fi
-
-##########################################
-# preadv probe
-cat > $TMPC <<EOF
-#include <sys/types.h>
-#include <sys/uio.h>
-#include <unistd.h>
-int main(void) { return preadv(0, 0, 0, 0); }
-EOF
-preadv=3Dno
-if compile_prog "" "" ; then
-  preadv=3Dyes
-fi
-
 ##########################################
 # fdt probe
 # fdt support is mandatory for at least some target architectures,
--=20
2.21.1


