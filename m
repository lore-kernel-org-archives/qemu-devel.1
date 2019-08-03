Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC33C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 13:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445FE2075C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 13:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Q5fgSnzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445FE2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1httzu-0004DG-Gx
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 09:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@web.de>) id 1httzE-0003n2-45
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 09:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1httzD-0007Kg-6S
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 09:22:16 -0400
Received: from mout.web.de ([212.227.15.14]:52391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1httzC-0007Jj-Ps
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 09:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1564838528;
 bh=R3ejnI676/pdtRKXM44ZtN7+PS4/3VROnv/nljAhjQs=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=Q5fgSnzTWXUJMOiNUs4Zne8NAVfV/882AdjMo9shh+3iWj2GrwhiveXW1w+CZMl4g
 HM3qKTzgCmVXXqFcSuJqf0U1vCFTwHHDjyxDoZ/9Zd26seeM825i1lvDSpUC+5Qhq9
 rhBfKMdA8g5b8RYGjonqM9UFAJ2i+vW0qqEPcYsA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9ui8-1i4vY836k4-00B4LK; Sat, 03
 Aug 2019 15:22:08 +0200
To: qemu-devel <qemu-devel@nongnu.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <99c1a7bd-1876-66a2-4b8e-d5bc86116fe7@web.de>
Date: Sat, 3 Aug 2019 15:22:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1pLsXyUl+grBg85UzrdcfyqtF6M4vBHPNUfeYhk7dU1x7YtX2bV
 o4nfF9rhqnF+kMzR9qFuWVl0IlUWaxY7a6l0VauAEfxE296ODYX6ExK0D6d6qpwxn4Sue4M
 EKkWQyH3Dqskh2zxJBxrT6PG7tzKzmQWaS/v3+R1DqjUbU7SdIgejyPqTCbUSC35dJtXkbI
 dRA+GFcqJxC9XC/xTMveQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:khYx7Og24Og=:bIdC5m/FMLrzk9oQ2CPl7U
 45SHqN3baRFdAY3QhceIEWTrElv/fr5pBmbiA8UYJGi6p1Yt4jo5Miuy+a2rD22H4kZSIfbUt
 2RaqU0ymIU0O/q2hTRa/HXa6Jw1b479s51oNxIziV4bgAGGKw1rrzgT6GOAHnP+8JaspPm4A8
 zQZ11+wwkdty7DWFFlSZRfaUW4EDE6b43Diki7i7+h4TWe+H2P1Xny9m4+0/qDbom7D0A3uao
 om6r3fwd0ppsXsbbGB5aY45mpivw7tqvllup77x3w9grF7RkBegMoqobTifuh0h1A+Oh3+PrF
 mU81GbktJ36JL67IT5VrIAYQeAHE5yHEeYMBSq0an6yuKEeYTG8MWUAMBA46uq0AJbRQ/lQoq
 lKYHSxt4tID4ICpclkAqaOtLbPExUen2Ic8QhAOdIIrvhlnpiYWE6C+RNPmFSeJRmEc7HG07N
 7EXTGmxV5+IhLg/nwEjcCOtxOuoBU6QDX9JnO9B7GFz9WZ29Rik20dtlbvdDxVmBmaZHbIII6
 npAeyS7+XuaDFq/LmB6LCZ7VBmsyPLO5TidMNrzD5ur7y1u1VrKHK2r0EkqTTzPyfGu6wYFrw
 Wg185VbHTYPUdJp805VNJht53JlxuqMMJjR5gt/Vc8talDev1EjH1Ula/csJ5IUNy5JC66FZS
 TKsqNajKWJoa1ihRt3rm+bMYDcqjL7Uh34Ge5YsiS1GZPaed5eyyCWJnAEiIWf5Hqqsmc/+Sb
 M3/qHu2jwuYQPJm0uG46IsTEY4sR6isvFgzmKrTROA9OcSjWw/tL5wXC6Q8SEFHiJHRX/Vi4Z
 yTMUj2GiaKLnVS0gaaxVX71CmLuCDNF6JkPlhzmEds+MXGQGG8iItAKk0Fy+zahc6ONxBOAPJ
 5tE+ta658vGJohOjpffh2oehQhrpHSjBd6lvJ1vJutFg4TTDdXX71C6HNG+Y0o+dO97E2+LK9
 aUdAFBMDFY9Rb1Uo74Mun1oGnIthxDcwG9s/ZInGsK/o7w+5Ua74E6T7ZoU3vOKKzvCvP4wHg
 jC5fy85MIAfXDCSR9XdhCu31ySCbkAfK0hKszTMVUAVQG4vA/GZsJgLpG0jJSEGHlb9Kr2RCe
 r2OWD6hSV4sbfyQD1zbmcDS7IQCHBNEfUp8fCiqtUJAUsytuMuKUVtBjxsq+Vf0PH/Cb68RgC
 jm0Rk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
Subject: [Qemu-devel] [PATCH v2] ivshmem-server: Terminate also on SIGINT
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
Cc: Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to shutdown a foreground session via ctrl-c.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--

Changes in v2:
 - adjust error message

 contrib/ivshmem-server/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
index 197c79c57e..e4cd35f74c 100644
=2D-- a/contrib/ivshmem-server/main.c
+++ b/contrib/ivshmem-server/main.c
@@ -223,8 +223,9 @@ main(int argc, char *argv[])
     sa_quit.sa_handler =3D ivshmem_server_quit_cb;
     sa_quit.sa_flags =3D 0;
     if (sigemptyset(&sa_quit.sa_mask) =3D=3D -1 ||
-        sigaction(SIGTERM, &sa_quit, 0) =3D=3D -1) {
-        perror("failed to add SIGTERM handler; sigaction");
+        sigaction(SIGTERM, &sa_quit, 0) =3D=3D -1 ||
+        sigaction(SIGINT, &sa_quit, 0) =3D=3D -1) {
+        perror("failed to add signal handler; sigaction");
         goto err;
     }

=2D-
2.16.4

