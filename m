Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A9C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F44C2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F44C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKMp-0005Ml-NH
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2c-0008D6-Ma
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2b-0007qX-JT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36727)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2U-0007hq-Ac; Mon, 09 Mar 2020 11:09:54 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGz5h-1j6f2k11LX-00E6BZ; Mon, 09 Mar 2020 16:08:45 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/33] dp8393x: Mask EOL bit from descriptor addresses, take 2
Date: Mon,  9 Mar 2020 16:08:05 +0100
Message-Id: <20200309150837.3193387-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+TAkKLV0CIXTz0Mr9Xhgny60rXsV/drmGR3EGLSIm7g4KaxGwJI
 G9/nP0tkn2RsIVSHMo3zDeqfWVPCU5u8OsIGMRp6MPT1tObWdaR5XhatwW5JtZaeoGsP9hK
 x4kCPcJkFNLak0tc9qIZe13RsQgC3/YogsfGkwe/EFem+BGe1d0vqnByv9dq45pLrNGFase
 PtXgyvDDGPTc4EM9+D9pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EbA4j4yfY2A=:CQ09mVT0DAh1Fg/k4OfT0F
 6LewUgHUDckKH+qV1GR4e8ySJyFS1F7oSJSySzvqe1pZDaMq/gwHJZUO9vKkqtmatAr2YMbxD
 8wtxRXH5OLzWonGxXBjvP06irGV8X75YTFnqGz2eNHT1lscKjCr8Aum4uYZmnNu61tgvB+HVt
 DMg4yr1FCxw67WL4F+v+psjyNRYaDlTUXYiacTvmTt0MU7tp2JcCBXunQ8fVFOcTn8K63/8Hj
 iDKrAh03iCNYtO5eC2m+SKdG0Rit8Q3GkhoYamZIM7+ic4SAMuz4/lhTQa91awr7PXy0NHvju
 7TMhdWUFazTyb3aaln9guCY39fY2R9lA1QPa1L6BgDbcMYMKlUUWSavlLpUWLKa4uIL7PeWYK
 IrE4hFBhGe7hiYoeoyTrCaUvJv8AlX9mPx+rhElDSz0FtlSRjQeMXGlJNqkAGMvED1LA9qFBB
 NBn2FUVVXCS0xCY0JYy92aUsaHknmD9cn07xvHanGhdNPUpCptfqRMVaN0CiDKwBL0DzmcYBX
 mzcrlZHZWhOomn61U3vspLHyfDCI1Qz7Ukc2eG85GHDzezr5QCoE2A/q1ey+Ro7B5lEwRp9Zj
 VjZ8mGdEYlUJHo0o56195ermlFZRBL6gMwYY5+WX5rzHlxz8Ez5J09NbZ0ZOKWqfTmJPHiWzl
 XYagUH5AyC1100p+vwgrNaswbCDRG8CtTs7ZV4+sHajS7kFglMlwA8oR9422iJTGNNwrQDzvN
 /yLENPHNOd07Utz9nQNBYlK5V1rCRJQU7oLt/PDUTtCDJs2KJk8EEdqCApYJwJ0KqnbZmNAuC
 /Gua+Kx4Aguvwrfs2qN8wxRU80M0KqCWxNAdoXRN+EGBptf7dhtwdArDoPW4aAB9l9tOKEv
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 Finn Thain <fthain@telegraphics.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

A portion of a recent patch got lost due to a merge snafu. That patch is
now commit 88f632fbb1 ("dp8393x: Mask EOL bit from descriptor addresses").
This patch restores the portion that got lost.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <alpine.LNX.2.22.394.2003041421280.12@nippy.intranet>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 8a3504d9628e..81fc13ee9fa7 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -525,8 +525,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                                  * (4 + 3 * s->regs[SONIC_TFC]),
                                MEMTXATTRS_UNSPECIFIED, s->data,
                                size);
-            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
-            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
+            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0);
+            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
                 /* EOL detected */
                 break;
             }
-- 
2.24.1


