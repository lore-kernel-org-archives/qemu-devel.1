Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99235C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFFE2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cWVXHol1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFFE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xYS-0002Jx-G1
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xV6-0000kE-8f
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:42905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xV4-000383-A4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596549659;
 bh=2t00/wToPXdci/sCMNt4gNmLdt2OOd+Fs0qy1+SNfwk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cWVXHol1mx9oz21RpXiTpcVwOsuUpYgjApfP8ti1JDEMclhP3PauaGhfrdKnCbiP4
 j7JbbtkP2HEA4DTrZiKEGb3kEuASP+cauyseKcFNV5Q3kye6if9l7ozoCpLEhDKHtQ
 Vgilmc4aMfvsyT8Yng00lzSGlxErVpo5+kbizFpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5eR-1kLJra2nhd-00J2xE; Tue, 04
 Aug 2020 16:00:59 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] hw/hppa/lasi: Don't abort on invalid IMR value
Date: Tue,  4 Aug 2020 16:00:53 +0200
Message-Id: <20200804140056.7690-6-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804140056.7690-1-deller@gmx.de>
References: <20200804140056.7690-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Rl3PMapyfvrI/et7avVNtw3KKpxJ48Fgn/ai0em8/Jvuf/fH8l
 SIHWKHAQX+4pnLqt6qtapLU8xfM/mJOY6zBlBQg8+KWN2zmBZ4PXX3okGw38aAESySJ323r
 8fQtiaG6yIPH1sMAEIpZ1akZHIxKJe4npag2oeKeoQZpdP2dNYnmTQIVIZokal9seKD6I29
 +on5d2vaqN1dmCeyfyauw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pWyls6/Nt1Y=:Pi8aC16AabB1sa91WrLrpf
 bjjKbkIYhGevGM+sqtPdqM+Un2YVjH+DMlgbMwAbDlFNVutIlCpr6fXsvAZp5oeHMJFyvfC0z
 G4E6JMj9iPN1YQP8/m2VYCoiYbvi/7w66NJEBuLuh2p/YkRn5xCEiqSkW1sr8wIyosAaSl5TN
 gEBRpxT7jmIHKzZZP/49JJKog0l8YyeV9EMZDSH46gjAteOYm8wU+DVL4YvLsQpfFtTxv3Ck6
 cVugv18Bhr4Dk3BALVqk/lDDgfdoQpFrpCh49Z07ecBhM5q7v8R2ER+vQ6XJxrDXjI1JbsaIy
 ynyQOhdGyhMxFgWSJiDBKvy2K5Q5S7Wyg1uxSYj2p924FnvV+6W7e8qM9Tao8cogMeJ8iTvQ0
 vyB/Q9/iIL6atba0Yd7BU+MT/O7/UrvKuMRGUQx/3AB5Xv59pEvq7CT6OFFX5Qk9qwzcyFJ3C
 oTTK6gJgPfRlWwHYPaHbcRr7o32r2aTl2HDUjnFB7azYQjDKfw0/FTL0+Rm4/KsT01Ap2hX8t
 aw0cJdzlTzTYB2aLZpW6TLLfoS5yDeyo1s+wtw6q4UJLjAnP/duwJrg8hu5SZ2UG1X49ayffy
 zOBwBPFxhzyTr1IehYML+BnehbsJyjOY/FSoyBYAZXUxVUa/PagYLG/Z1Iqh4wixbFvgSzgzS
 VBEixbsIYV7RkBfvgUurHFOz+cI58QtfcDV2pB5naM2fTDYsOCHdI+XLS+uxym+qovVRIYa3p
 g0jEu0u18kXrhZ4R71MUxGRNjovj9sDQmVvYaEAHsWVzD55/XP9JBO8t962Mn8PI850IhW/Kh
 Ye35QptL5ySM4+AonxHa022hepf0U/U23vWFPWd/8geQ9rq3AnOIziftwlaqLsIp9vQxKs21e
 DmO4lUzccrTSC3KxIbm2gfeHu1cNepJaiUU+U5JquJUeYe8PmWDh0wa2aYR7rDmh85t4dIdTn
 n4w9kLplX9luQwVP0RgN9UP7lVWrQqqSaFadIo0GufwPe69iI7fiL7gECp9/1vDhhwdQ/h8MB
 GZFO1jQOt3meM6A9bl85UcAH/bdng2D/Y7N4cmTvG5p7wWnZoO6PzXA1DN9R+LriUNIFre/8f
 PJh/REwejD1Lfh0n1PB42xsdnYK5efokSFk48z9fTig5brEtVQMBYuQjQ8o8poSSlscRFE6FY
 QfNeYQK/T7HAlgXD7Zy0GaStJ/Quu6j4QwYkfn0Q5q+eddl7iNhb/pGpV2MIXqg76bEZiV5hB
 sI6sCjMlwLSb8tnaB
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 09:08:36
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NetBSD initializes the LASI IMR value with 0xffffffff to disable all LASI
interrupts. This triggered an assert() and stopped the emulation.  By repl=
acing
the check with a warning in the guest log we now allow NetBSD to boot agai=
n.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/lasi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index ffcbb988b8..7b4a168468 100644
=2D-- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -11,6 +11,7 @@

 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "trace.h"
@@ -170,8 +171,10 @@ static MemTxResult lasi_chip_write_with_attrs(void *o=
paque, hwaddr addr,
         /* read-only.  */
         break;
     case LASI_IMR:
-        s->imr =3D val;  /* 0x20 ?? */
-        assert((val & LASI_IRQ_BITS) =3D=3D val);
+        s->imr =3D val;
+        if (((val & LASI_IRQ_BITS) !=3D val) && (val !=3D 0xffffffff))
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "LASI: tried to set invalid %lx IMR value.\n", val);
         break;
     case LASI_IPR:
         /* Any write to IPR clears the register. */
=2D-
2.21.3


