Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AC8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B85720729
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="izDQMDNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B85720729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57rK-0002vn-B1
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57ne-00010b-Qi
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:60399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nZ-0008GI-J8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065887;
 bh=jLLmqaosE8xt+OARVvHb93VE1fgCMwuTT/uP+6We6T4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=izDQMDNTH/Ybt5yVM5r3jwKIGu7ehcVkbtgBFOc/aDH7gBZJSNRlH89DnTXVw/BbI
 irsAxe3mo4EYn6s/2lOGxR2UccwvOrXW3L5YNC3zD6b4vW4zoycWJofqNsCGzbbjj8
 jt1oB+dPaIQnhIDj84OsgRYV86gfriR59mCPKxGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1kVh7P1zNY-00iApM; Mon, 10
 Aug 2020 15:24:47 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 10/12] hw/display/artist: Unbreak size mismatch memory
 accesses
Date: Mon, 10 Aug 2020 15:24:39 +0200
Message-Id: <20200810132441.16551-11-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H0/g0Nm4m9YCmIHZ/vbNJIhe13VCHbiBulBUz+S1a3zZuMdPaMD
 XmkkWTeaxYshxGRdWYK1A+zAX04O2GDmXX3YyoKiFGMx8qacDIDfwGsvX2DJxAWB4ORXEFh
 DLTYTaG9GujpCB76+akgP247nq+3YO7FEThsZTmvvV6TsFJKjhmE4ul4zb6GR/HZp5EcgmV
 pSwmDusGlpx5ju5MW+mtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7e4K+HXrMa8=:DSkxsrKKS3+TKQbtYPgJIy
 0jVe5rrEs1KjiqJ7RQRbdoLbUwxv2VkLMFcJBqojI8NfzbvsjD68DsFl7GJ6K0nVWJmn5CcWL
 SMM575Extg9wTRNzFnuS5NuuhH79X2uzR9lqdL4RjJGrY1DF0dBRaWDbUX36NnCIbl2OcSGfy
 at7U4xnZXR1O69kE41gnYuUsJi7gMBq9wdw7FbkjDXy8QCkrAaJH4s/5JMlVcoQv0YVmoIR8S
 LWvuXDEjKHqUtJkkAmjM1IcmXAYhxt3RUA0NZ532RyWZSvDl9aHufqqa2ga7cmftReq0F8YVQ
 uDB4Rz8zrQ33GnIXvv4bjqaO/4tX9jTQB9BjQR0enNDkzgCzSgcP91XKCZGjvWV7/mm4YDRYo
 jmE1RffPlosNjnaKDzDZjNb2D0R3u8B23Aw2ym6SIzUR9NCvQ+vx3abgaUcvDxo0ggUxl4fxR
 hq6Peil9IYUjRK9jfd8P2yAuCT+B9kdntWrLGCvbkE1v7mzKdib5nF8jGCZXqmnyGiA9pB9Zk
 2xijaf44FG1k4p6MRXHF1ckx8OnAReJMxn5HXwFXDyt1VEmsVLEL3yJSXfEp3cepDsSXtF12q
 XUtFQBVYK8mIB1sHzhK+w6rtMesBByb6wKPBp0ZsIqBBUDn9P4oUqWw9GKvQ3IwV+LnAsdi3b
 cU+C2fSI0tgAr5kBK9nLgqgdIvOKeKLGoF1pEw1E7zdzs/TwhgHidh6OZ1NKv+ZD8EcDehzt8
 ooFVZyFQRAtOFiz6lz3frEi0+O8IyRjuczrlvvfPYxyvD0L00vvNXHwWh/3c7jEHPerfXzF1R
 CQ61bzH01uiZLd6fcXJN2RNkn6xqvbW1JT6Nrmu/ZY5cS/d9+Wa01hlGwjEyamc/f1JBpQ5Wp
 EtXXdKNnz5M7oFQXFDzO7NXqe8d5Y+eJVWHncU2u+6XY1T+TbPtNxgdtsemqkrNM2GNAwUNAc
 VnCe82WCARriYeY637adkcQ0YP0cHM49a/uMwgLY4LWvh3k+xJV9QX9bQO5hpX18SpIUhaN5L
 b3HahtBqjq2wMx+Uhc1Ggi+I2QKioJXp97XyEYDK9OzvtWKbXU1N8vFhQgraUYWRPp8cvlcGl
 w9cwORhwjPsHJIWeaAm52cuTrly/NWD1DzEfdmQ0eCucinhPVX+Sc5H+Qfh3NwHkqu+SvbWQD
 tuW4cvvh2jSEfGmdjdVPYXDAcXx1jalxMfpCp6A9+pNNm7Gttmfta8Oy3ucQ0xRb5XfA3xj7D
 /mI8V5oaEyuP78Fv/
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:25:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes
in memory_region_access_valid") broke the artist driver in a way that
the dtwm window manager on HP-UX rendered wrong.

Fixes: 5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes in =
memory_region_access_valid")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 46eaa10dae..44bb67bbc3 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1237,20 +1237,16 @@ static const MemoryRegionOps artist_reg_ops =3D {
     .read =3D artist_reg_read,
     .write =3D artist_reg_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
-    .valid =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 4,
-    },
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 4,
 };

 static const MemoryRegionOps artist_vram_ops =3D {
     .read =3D artist_vram_read,
     .write =3D artist_vram_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
-    .valid =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 4,
-    },
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 4,
 };

 static void artist_draw_cursor(ARTISTState *s)
=2D-
2.21.3


