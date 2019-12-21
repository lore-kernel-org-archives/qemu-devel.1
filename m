Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8739C2D0C3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 22:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DBF206A5
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 22:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bFfjMvsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DBF206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iinFC-0005QM-Ly
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 17:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iinBq-0003iM-RN
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 17:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iinBp-00040H-Hl
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 17:25:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:45651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iinBp-0003yR-4f
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 17:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1576967132;
 bh=LZbsMnoDr0AvqMrCNNhsiDl+Z/MuEVJEqXX0hldgG8g=;
 h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
 b=bFfjMvsiUrECuI+UqrcewNs59DvLXWtTD3g8D0j1Umh6ZUUoUuq4CvOTTI3E2tqwz
 fNF/0PoF42+cuC0tw+peoM1P5tfXHvAlPk8e4FXpFWR6DLTffelTNzL5ih9pyYjreG
 Vy9uAr2S6ywrh5EJ0hNDAaFVU4zoCrLnJZlPKf7U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.169.139]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1iChqd2JoV-00WksT; Sat, 21
 Dec 2019 23:25:32 +0100
Date: Sat, 21 Dec 2019 23:25:30 +0100
From: Helge Deller <deller@gmx.de>
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Subject: [PATCH 2/2] hppa: Switch to tulip NIC by default
Message-ID: <20191221222530.GB27803@ls3530.fritz.box>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191221222205.GA27749@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221222205.GA27749@ls3530.fritz.box>
X-Provags-ID: V03:K1:bWiHUW4Ub33zUSNysVyRSyoAA2MfQaVEzSQYqodFB4XZB8gikY/
 TmC0uf8irTzJF1yV+xNjHGq4YAXKC00W39WPrPjER3NS3dqX4d0/brr/GeqcWkvrlzEsz1U
 1f9DKPoafZmRvBZju6QkoybwOtehGTI1E30fk4XhaIfGdsZjlVuPSpXEgwn9R0SmPt/TgMG
 xNudRPQTXAhRb4n6Q66tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+gCniKgsZLU=:nc4nxVTlsy7bBbSMxehrWr
 KimQvTTiwFWAyWCIHa9EqOF11LVxZOjWdxTx0FjAeDTklI1gfUh3+Rx+HFbFpKcDwPR+5H7Y9
 7dbfqBhKu7c3QSpu2mAWrsHCJGNkNM6glxZ1B2QRHkGb1PaYqFmA6bzVmhHqugwlhoMHtzN13
 d1OnqWhj4TXXqARTLnwM2bK1g7fQH8mD2A2TXN0MNF6KSAbWDqnHDhNR6uiruNp/rbct3pnYb
 fnSK9SUPBJt+zQasmZhlmPl8+w2IvBM0m07i2yVnlpRYccIbhlC4UtASEtFjXrbmoJsU22Hfl
 2QVAdA27vCju4q07dflPy69s9cLT7tt/QdUKZ5UdOxdPRrK4xTljSCw4FGrRfphYoM6l7WUUc
 76QGEvrAugLzqPbdNm5zE0TPci8Mc/TGjzpWKKN6x6U9H/K72X9tTx9zfBvUGTz2lU3C6cNI4
 giyF2WkQcTAkVeqax8AGGn+AXS7XUOPXp+fM3Vt4qINPgi01JePP2pxuDxWFORrIVUInwCD+O
 cR97FF/mkxXFY8EHGyeIxLOI4mCo8c/UWQOutTWa1qj0+W6apyomHUKMjjeVE/ohfJkj759zV
 YQPTD5+bmIRDFRPh29ljn6HEt3gp0KAcYps0m4qLRbSfMDNUlQ6OSf9gP/cJUZiuYVUlJzVNp
 R/0cxTUBMb4UMcYxSt9wDUw2ePokh9cnKtjuaRW5y+Y2ikrb+Z8mrQAYB15B9+kBtT5DvGMaP
 z1/54OnlZEob/qIQzqWfKuwpTkGTU34x+akbNBlQyQn5PHfKExPnLkNll+rfUmiMsXlDxpfWe
 g5+VEdviF1EZhHIR5VgPoUEqd3G3otWjRmElue6sO2gGaa/k6jpNavJ0mTTAaMmE3IXCuyTs7
 MR4LEIFLn3fDsq9FNcPBAL48o6ZPRmORPO0obKrwIcY+mVrBXLX2JznHCrO/+1K7KUa0KD3LK
 sleIPDHd9DEOfFVlx3DLR8SgyEyHOgQqjHNdxhpHIjYjKqMvaCZkeTOk6T1Pqw4LfiPbTuv2r
 GESLRyumqjwFnMr7g9Y12FoJBj1pKI4INnTH+ARFZJwgjudE6z3Rw/7ZqcxEARdX6/vKrOhtP
 Ozn5cJsie2PuRZQyU3RfoIECnzZV7oULxv91lZWttMSEI/pFAUekNdpil5XfRKKHAMZd0ApJJ
 Ph3vHeNVZmrnBfTHLFEYU7VeDbYul5/8ZaoGMbhZMpWzx2uAMASUXmaq/dgQRxX+gE6uZJBSL
 rbIjvUBFhjdcnJgsoA2IjSSTvRiP/fcDQzWXDQA==
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.19
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

Most HP PA-RISC machines have a Digital DS21142/43 Tulip network card,
only some very latest generation machines have an e1000 NIC.
Since qemu now provides an emulated tulip card, use that one instead.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index aea365bf46..120d4a75fc 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -135,10 +135,10 @@ static void machine_hppa_init(MachineState *machine)
         sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
     }

-    /* Network setup.  e1000 is good enough, failing Tulip support.  */
+    /* Network setup. */
     for (i =3D 0; i < nb_nics; i++) {
         if (!enable_lasi_lan()) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
+            pci_nic_init_nofail(&nd_table[i], pci_bus, "tulip", NULL);
         }
     }


