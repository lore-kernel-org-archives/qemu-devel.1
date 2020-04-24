Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80543C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E3D2098B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EqcOuTNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E3D2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS5h7-0002hm-IU
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS5XJ-0007pd-AW
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS5XH-00044Q-Nw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:07:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:54727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jS5XH-00044F-4L
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1587762410;
 bh=s34YglCjtoVbxwshRrGXBbUBdp/VLnL/jFW9VGRHqhs=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=EqcOuTNN3Ajb/PQOSwrrp04iLYDOBCo0+T7MAY9B36jT6DqzrNJB+YOOwj8ayb8ll
 SE1REXq6nZ1vBU7ejRWX/4cvyjYCRsJXVfiiefhK3hlewpmAG0y1jYN8MLI7bFe71S
 eGRtNZMti98cOAx7G49zEJpwHnyjgc8hEqlpT33k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.192]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1jJ36m3r5l-009D5O; Fri, 24
 Apr 2020 23:06:50 +0200
Date: Fri, 24 Apr 2020 23:06:48 +0200
From: Helge Deller <deller@gmx.de>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Add support for /proc/cpuinfo on hppa platform
Message-ID: <20200424210648.GA26715@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:8Veuvy0dTk9tVrBakDDRFKTG9Cpl7zILu7Sjj+1qm7GAVeYpIdj
 sEugvmntkqw3Pm2jkxk9tJ9yrL8w6BO5s4thIM5xAYLaYyCk082jeu4GQabBrQHzDOe+j2c
 R7UTOrZ0ThQtY0UQ/cjlfYqfTNH72JG4DEZTszUnzDhqekGeDiGfFZ0T539U+Ngyp+e2pGJ
 ISrM51A/gSX7l+9Mh50tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uDRDrSLD3Wk=:hFEcvWbGOVyB0dRg++kNhV
 bLo/2aNqw3M9tsQThx5pCoslH0ZJRVUZ3MCfRA7Y9QManX21LOtCFm33b35M5UtRM9nYoSYby
 9P/yk94ejKUQORWylbcqv0VA+1Au8rEb3t/Y3JBu5fBM9WzYMIVHqNJWN+zziHb05kWMv2jEE
 mM0te3wnQiX7ZRTmVJdf7ddH69Hkq1KSmZIZ8OTjruwQjO6zKRHOYqyIPhlmEWhWTriLDAHeI
 +vyGjCmizt9c6GIWH/vvZ8tOKFSv9iH2ZEsCk9lNSG458ccstSVsGElzp/ESBf6N0ky77Sba7
 zENiqH0Ep92WKaIJoTeIMNjAF+/3pCQHLSlRnGIMqYK5QiPBl61momMjmzTQmY+jelwc9JOk9
 oVx9cwVpAQBAEf9rQ7z/ltWsp4pfDFfpqbnpSb28yZMqEfckUn48mjmSTS571q7C2Wayj893D
 pu7E+szb+FFxl75jW1Rm3HXCx0iIA5p5fR/tq89TCo0BmhdO5m7X29ipvhmre+VNO59Ac++OF
 5/sOOpqG0vvPp2jhYZK20z0s+ImhYDJHb86iynQVu2X2N9ovQqUyEPrXkgd9Vf92iJHIP62wD
 zCY0nA1h3aVK60ADkaGtiFdyC5dRINdQ+V8p0gi/Jgz6caFVDVSCBeFaVOzqucudeib9sELVT
 uT183RJrO65RDs4CHe8so8H6Gv1zp10sFbpqK2jLEr8fb3maYIijHdGXAGrxdn9JbxdEyvY6Y
 ODR0Al//Q8xBoer1BnfaU2xcxBfC5YvdbaYf5On0YyCpsqi8fyP3t45czXL+iU78Tscf3lY4i
 PaSBtpJgeETkq++Bd65XpiCh4mKGPptRy5S0WUWbf/pfL7gX0xqopLAwtEh8rXIJfA7eKbnL5
 WH1FNh1ObLdXRrMl6NvW2SYHdKBe5mADJ/rcQ8bAz1x55N4uNE4KfE/1BFAq8VXcRl3g6D9x4
 ITaRpFaRWYTPlGOBbpCfsFsj8q1Qz+SFDUFlWe55RZnrNvuOcrKCjsQUj2uyOOiy7ntL7SYo5
 xBjaB9oNXHuXD9LSu4/tH5CETFtJTNT7uqnN1kJmi/RMm8R0YSR+RxYb2AKPto/JBo92gED0p
 SWuRw1ocGlP+rvrRzIjWvgWd2K3aBxBQkU7N1NFeMoesOQHeAZn1Sj+uoRDs23K4XnQjBdmrE
 df2hHx/ySEFUca0UYfYmVA1rdlPK2SAZpKa+fI4p5f+d46cX9bbcGN3n4NEF2+lO4BfJhQVGt
 rm/EWrYGuJRQkZLjz
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 16:58:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
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

Provide an own /proc/cpuinfo file for the hppa (parisc) platform.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..ebf0d38321 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7438,6 +7435,18 @@ static int open_cpuinfo(void *cpu_env, int fd)
 }
 #endif

+#if defined(TARGET_HPPA)
+static int open_cpuinfo(void *cpu_env, int fd)
+{
+    dprintf(fd, "cpu family\t: PA-RISC 1.1e\n");
+    dprintf(fd, "cpu\t\t: PA7300LC (PCX-L2)\n");
+    dprintf(fd, "capabilities\t: os32\n");
+    dprintf(fd, "model\t\t: 9000/778/B160L\n");
+    dprintf(fd, "model name\t: Merlin L2 160 QEMU (9000/778/B160L)\n");
+    return 0;
+}
+#endif
+
 #if defined(TARGET_M68K)
 static int open_hardware(void *cpu_env, int fd)
 {
@@ -7462,7 +7471,7 @@ static int do_openat(void *cpu_env, int dirfd, const=
 char *pathname, int flags,
 #if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)
         { "/proc/net/route", open_net_route, is_proc },
 #endif
-#if defined(TARGET_SPARC)
+#if defined(TARGET_SPARC) || defined(TARGET_HPPA)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)

