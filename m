Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A54C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACB2207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RXK3koUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACB2207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2oi-0001uM-NO
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k6-0008Ox-Rv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:47441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k2-0002V7-Ft
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476430;
 bh=ffjQD9P6e3SE1TvisnqQkLG+rj6/1Nng0HQOzVbN1Mw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RXK3koUskAtpzEbiHNM/CwbFTQiry0bWpITi/kqEa/vrqfZ67SGQgqc/u8RaeOZVd
 LwB8EFoOxdC9GHsLvmXm0pIbpyR1xZSM5FDFmM0bJVbcjqOfCZkgfDkhnEw30cI6KC
 XGOy4lTgEIynhqTcCIQJIw2Fc+iku5/BetKptaHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1kRcFf0tzZ-00sQ1e; Wed, 26
 Aug 2020 23:13:50 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 05/12] hw/hppa/lasi: Don't abort on invalid IMR value
Date: Wed, 26 Aug 2020 23:13:38 +0200
Message-Id: <20200826211345.14295-6-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3kfGOFg2TmyHoaLpgmi0KvD+71Gb0OFxCKmK850eyct/5vSNYqH
 ORiNOeDd2o2TH+rsfFpskImz6yaTz7aoS6a6ubo3UgeXg83MRXapQcraSRcMzgR25Py0Pre
 sNO5sdwRS+It3QY7PlElVQ5TRJ9R6lqfhSVgjAJ/X6HblNiPvIljLXgLuhmzQa3WpkWx5z5
 0mNGiwk5gahFQTEwjyR8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kElX1+bVBs0=:TH5s3t88ySSaPteL+yx4g/
 oUkNbF+JlpsoMM9mpj6JdCh4IJWwgD46wYJekpoIVZtK+frDFyPlnYrzTVGpPpvCXdwfM0e+5
 X80610MiblVloh42xKWTrgNT4QB8m5PeD5cs/5yRf1YNocv37aS5Sq1tztxFeeBiMzRPOUWdv
 7c7cVxWWoiTqZe81M04E524HWXWUZwe8DkQxZK96ywys80yZYW5KWU0xzpXFlphhQPmS1dx2u
 zVwvEDaxJKNUKSEmvjVlOI8dc/bwdOf3VKG6gc70ggZkvKihcZdttc0j4xtQ5HsT1RnBzGvJL
 EEXZt57C04Usdnp9NaZ4jf0CoZidGn6tEOAvdVzZ8fLcSuY6pk4vl6eihGq2GRfow1yJRzT/6
 9yunf8N4quSgdzA1BAuiKg8VPyDe4KhVjjdaoYXh3Aq4cYA85peajjCJ+95Qocy911S9Zj21B
 6io3PlyC4U5WAl0wwwipUAf7cNOmnxT5GKoL12PHi4df4c78jVjBQjCWFGVCmm5m8DwXygk2m
 Dm43y1nyvRU/I+v9jdP9r/0zx24rIkuL8q6D40mTTpR9BQIZHLwWUtvnWGgCkB3BQn5FLLhJB
 FSBdH0L4XiFWNJkLdP5o+ety6wQHuV02jTyCmaH6gERW5Y4t5kEJLtq+ypGaUUVxgO94fyiEG
 mQWawUS2XkLp0nDErRI9hY3xiaLL3vBHB8HLxUvrSE0fqLN43SdlyWF19dEAc+33I4mCaFuXK
 45misuvXc89ChUUZohSO/iJYKnq/GoIRbsqBSOMVwQY6X9JvuNWFNjpiQSmDelomPh/bQI7ES
 Uv9mY118zwVLKsb5mLWooosYNLK8fgem0k/otGrPnCyxXF1OSRgiFtZl70edD7FTNIzh/zGRP
 u81rru5yuJdjFbAg0BlCCCjl/12uOsbrqBYP1UViSHGfPRmEGS2+hfl0qmE+8oQW/jp4sP9J5
 x4vxBKNac9v7zMlNr2/uuTS8iavZvdp4ryEk46Q9vS2gL+haTfPtqEHBVfn4UO8jZ43Znc6HM
 ONjeV2qo002JXD1CMDm9F2J8xjG0C6qgFOPQEEnVYgeZiqYlDfoyJuu5qMdJ9KIm0xOg3ucVO
 uglvPacSdoXMUcrJFDElY14S7HKKzv8mu0+L1NI1agNHJNxCo/DQdOvNF+74NXcGAQXaWulbh
 /6NH6HUKrcARE3bv67YONItNnzuLKZ8pPxU4RuQ76tZRsELFlc0DswPGFP98FQvovz+t1MVDt
 Z392F+flCh2dnNxQf
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 16:12:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 hw/hppa/lasi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index ffcbb988b8..194aa3e619 100644
=2D-- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -11,6 +11,7 @@

 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "trace.h"
@@ -170,8 +171,11 @@ static MemTxResult lasi_chip_write_with_attrs(void *o=
paque, hwaddr addr,
         /* read-only.  */
         break;
     case LASI_IMR:
-        s->imr =3D val;  /* 0x20 ?? */
-        assert((val & LASI_IRQ_BITS) =3D=3D val);
+        s->imr =3D val;
+        if (((val & LASI_IRQ_BITS) !=3D val) && (val !=3D 0xffffffff))
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "LASI: tried to set invalid %lx IMR value.\n",
+                (unsigned long) val);
         break;
     case LASI_IPR:
         /* Any write to IPR clears the register. */
=2D-
2.21.3


