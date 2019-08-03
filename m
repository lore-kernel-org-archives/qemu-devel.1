Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FCC31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 11:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCF4206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 11:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DibPvJqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCF4206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htsXJ-0006cM-RJ
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 07:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@web.de>) id 1htsWP-0005lZ-0Q
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 07:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1htsWM-00047i-O8
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 07:48:24 -0400
Received: from mout.web.de ([212.227.15.14]:41225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1htsWK-00045d-D0
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 07:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1564832893;
 bh=9SmLDVmHRVKud2yiEpRrOvvnfjZGGe/9qn2KjwG5YFI=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=DibPvJqqZhw2hRMGH3ATR7K9YE36fR6SeJctMQ4hkCDPDXiOozL0PR/XsNWVTM47r
 ArWHdU5BAIm5Ffoa6K+Wu1Px77q/pVfqRKJRbCfxfnfiKS+kQPOrmbIJ3hWRar6HUJ
 GXzW5sx5eHAqAB7NY/nphTAkVdtUJnMrG8UZ5vg4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LuIAZ-1iJU8g3Fup-011fiD for
 <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 13:48:13 +0200
To: qemu-devel <qemu-devel@nongnu.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <6976a3e4-d484-56cb-5450-f4a72cc6dddc@web.de>
Date: Sat, 3 Aug 2019 13:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5BREKjVvA8ahMaaIedLwMQQssgO4f+nGuZP2Nr1kED/nTsb/xS0
 X3nn/NZyeJk/Bmp3QuQU9HpNsa4hQmrL95+6JkQhq6xuQ9VEAukGPU5kH11rdlttUAWxuB5
 faO6V9M2TkW0iVFJqp/+66d5hr4iVJ9lEbfcqkkFlwD7g80VFBuThIdQ2KLENwriYkz8uuq
 lAgCkWhFC2x860fLR0v3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WNyWwjp8urc=:MU6T3kHxh38FEUmStOl7xU
 YCtrf4ix/jm5PdcUIG0+DiM56rOOuFPpgP3q8PVfUaGNILOy84VSOgpj7r5e1Y0ssHWf+72rp
 eqex0DaIb+VJWvXLhAkptxCGhsHmtBLsdcoHrX6fKmueEiDlgKgpRGBvSts5NAILW+uWyRLy1
 1iYpC/kMRPRINdbRurmoMWipVmZizF00PVL8/UEZr+aTkTJ3m0lc0tos+SdH2dEiWMHkvRR/W
 +DZRSdh+jdySMNWjIWvr0bsi6bTNL7G26iOP3GVkmJIPCU9GcHXuC235Nu5ciuDXNjLFc0g5O
 gqZAS+bRlX7jzNbvWwNoDDtb/tc+lcUpsLATb+RDQCJg+npr8Mp4CoYdhL6k3PQJoUzr4xBg4
 IC6/sLOkueGCNQDCx4+4IMBFFTcKYjR2VFaQPftn22lqJbNxMGGCZwRpuTYs8wVAUnREL9X0r
 BZLRtYRSA03CFEVf9+8ZYfz2wMfbyhk0Y0AGHF6kfK+ZnYQqlhi7sLGxd/gMY58dQlmkyW8WU
 9dVlKCqHDoH0ECPDLbLhcKqh2E4lYpq2vKser4HBG1fvhKHBb5zEVRbv0NxMXiNjLn6pz4f/y
 iQmFeuWiSaXwI62nLxcdGsfqb50D09t3rZ7FOdSwY1/vaK2sCvDD3ZAc3sLZHK92JwolnXfNk
 sreidWQYn85/g38X4CMQheMHFd6ntgGof1TE2l3J/yyIiKBm9T3kht11HtXGWkbrm/YaiEG2G
 3LDTeq4a+M51we5HoUptRNKH5SZoeB2PWkwO9GaF7eGsO7gLh1cJdoKJPOqvuH+r5lBSgrhJm
 MaRk668SMCwuD0dmzQcQPc8z/yLJro+1HbxDgp+7Djgwlhi0deBG08b3+VWdvbdRjJsD5ewsv
 Fsn/uBWQbEDFzHAwnvH+fA3lcPXkEZGxa4G6CfkefH4jmoupP2NPnJitcGUlMqSKgxCsyFomt
 /F78s0PnNF5hzHG6iT9l9tDoXrIrDKxLADMy9zcM0xzeK1l+mIMkXsqVD6uxoyc0xDI6Cgu/1
 d7zbwRDTWGxOLT2HB2LGFoV49HnumPOp62sF9cQTHqDChvfZl8zk448UB5e0GbnfetdBJJEzS
 ImZVJhDvOdpcjMr+c4hU/2D7l6MXFETJqaxIm2kjmkKBYR83rgNgYh3BovZUot/FRGuOz38D3
 H6tIk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
Subject: [Qemu-devel] [PATCH] ivshmem-server: Terminate also on SIGINT
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to shutdown a foreground session via ctrl-c.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 contrib/ivshmem-server/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
index 197c79c57e..8a81cdb04c 100644
=2D-- a/contrib/ivshmem-server/main.c
+++ b/contrib/ivshmem-server/main.c
@@ -223,7 +223,8 @@ main(int argc, char *argv[])
     sa_quit.sa_handler =3D ivshmem_server_quit_cb;
     sa_quit.sa_flags =3D 0;
     if (sigemptyset(&sa_quit.sa_mask) =3D=3D -1 ||
-        sigaction(SIGTERM, &sa_quit, 0) =3D=3D -1) {
+        sigaction(SIGTERM, &sa_quit, 0) =3D=3D -1 ||
+        sigaction(SIGINT, &sa_quit, 0) =3D=3D -1) {
         perror("failed to add SIGTERM handler; sigaction");
         goto err;
     }
=2D-
2.16.4

