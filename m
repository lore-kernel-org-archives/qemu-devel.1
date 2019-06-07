Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CFBC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D832083D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D832083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48410 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZG93-0007UY-NY
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hZFbf-0006xV-UE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hZFbe-0006X7-AR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:12:35 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.77]:29445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hZFbe-0006RB-1O; Fri, 07 Jun 2019 10:12:34 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 BWP09926082.bt.com (10.36.82.113) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 7 Jun
 2019 15:06:58 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 7 Jun 2019 15:07:11 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 7 Jun 2019
 15:07:11 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-trivial] [PATCH] test: Use g_strndup instead of plain
 strndup
Thread-Index: AQHVHTpMtEQE4swKekybGdM8Y3P6xw==
Date: Fri, 7 Jun 2019 14:07:11 +0000
Message-ID: <430a9a42f7a34b799ee4d2f3d7ab2e23@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.77
Subject: [Qemu-devel] [Qemu-trivial] [PATCH] test: Use g_strndup instead of
 plain strndup
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
Cc: qemu-trivial@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Due to memory management rules. See HACKING.=0A=
    =0A=
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>=0A=
=0A=
diff --git a/tests/check-qjson.c b/tests/check-qjson.c=0A=
index fa2afcc..07a773e 100644=0A=
--- a/tests/check-qjson.c=0A=
+++ b/tests/check-qjson.c=0A=
@@ -767,7 +767,7 @@ static void utf8_string(void)=0A=
                     if (*end =3D=3D ' ') {=0A=
                         end++;=0A=
                     }=0A=
-                    in =3D strndup(tail, end - tail);=0A=
+                    in =3D g_strndup(tail, end - tail);=0A=
                     str =3D from_json_str(in, j, NULL);=0A=
                     g_assert(!str);=0A=
                     g_free(in);=0A=
diff --git a/tests/migration/stress.c b/tests/migration/stress.c=0A=
index 49a03aa..72c4012 100644=0A=
--- a/tests/migration/stress.c=0A=
+++ b/tests/migration/stress.c=0A=
@@ -104,7 +104,7 @@ static int get_command_arg_str(const char *name,=0A=
     }=0A=
 =0A=
     if (end)=0A=
-        *val =3D strndup(start, end - start);=0A=
+        *val =3D g_strndup(start, end - start);=0A=
     else=0A=
         *val =3D strdup(start);=0A=
     return 1;=

