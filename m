Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809A1C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0735A2065F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bPPWluCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0735A2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBRh-0001Y1-KT
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7o-0001mm-QT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:35719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7m-0008ER-B5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598985297;
 bh=1RjbbzPbP2N3QF83H9SFCrSjVVJRqbftyMByeZf/fTw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bPPWluCHqMCw/8NGp3bO3977TGDjRCKEZ6m1/6l8dBN0xG+Ub9x58PAZBQyEHuUvb
 Brk4INs+BK9npQEk4Ot3Jhs2Xu1as014bH747Q1swk7Xfpe8HR3ALqkmWok7mOgyDQ
 q52EtDN9G/DRAvCzmdsz6a0h8WF+WAZCNUiIdd1A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.187.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1kRgnk0WU9-00udbC; Tue, 01
 Sep 2020 20:34:57 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/hppa: Fix boot with old Linux installation CDs
Date: Tue,  1 Sep 2020 20:34:52 +0200
Message-Id: <20200901183452.24967-8-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200901183452.24967-1-deller@gmx.de>
References: <20200901183452.24967-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AWdl05lo+LnlJo1vHT4JZBxorzJoejQ2rjJXeIsOcpM8aBZax6Q
 j1tMva4Wu+ehT90+02AW/X3SyPUdG3BAEjzmznihNNDHbVN8GTtxTH+RkyPRu50I/1AiDLe
 Xyu27qOgBEHSFsZy/PS//cNsxyY9+iPxgH8rp+ElAApue/glSOGH1smPzBS7b4m1P0yRNZI
 ToCTPSxHdenk46oxnjnLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lfGuFExOsP4=:UCwhL40Du6WmtBVIdQtmry
 9bqHrKZeQgP6a7Xo7QNipA8tl9vVEHBHbrhD9zR7gZBu0bK4Mi0V05UZ28Lw75xAFcVqeOIVN
 WXJYwMljhd8bG1Qt5qsPPTuJ98RIGuSdmmdNjHAAoWlUSvDyT3zEfCHdMySjMY19jUrwk6VEJ
 Q9QzlB8zcXACYKAph8K4tu5w07OhgPsV3cD0fkoZxLbzr0kt6k4pm+Vwqllw/4+mRW7iOoXUZ
 lEYy6XrOj2th/1VK2UPhJk8gIlCjzBwZ0DBG/7QGo8KqWJRowrUIwUJSL43uDhwCtsQ4SHarS
 EF7Pp0AVucK1iFpvSE/8dwv7aGV0wAicQtR8rStyQ+SL/2eKo8xdtKoiqyTkZRl9lf2Et3u4b
 +ra1iRxCAc6d4UYPWhClmEZlypdAjIH1M5z7gw7mws4YukCf6iJmjNzA1rYhR/sNmjrDRXeGC
 OPgzRmf1G6kXYxn9IQauQEjxPl8KftkhnwzGf9kUUgNFVkqWiMYrjv2hWxPsIlRHAP6ynjO68
 4ffPDI5yeQeF2oQ50zzDrmSUf/75VqM53vTbtFwvbyo59qneDx5eGxAg2d1AjFciL3z07abM9
 YS19uiSstfdOpEjGjA+1Nx9Ak2cgCGTwFk1CUPES+omQRR8Po6/wZI5qMBG5YK/exW1NceBah
 AaySIGDBD9GG09fIRU4PhI9oDOsaEmH7LBaq+aExV7eq8JpfN3cl9gyEApoexAu+6WhWITOm1
 k2FVagOy+kF59+SXmqw0zEQHFziSTTJxu6Xq6PiiX/+qocZSj3XtiRSe2K6PjW8/KteeDpgP1
 eVhMlApj5QRBNvgMO/Jno/O9vi6z5MsHI/5KJW0U+qotAjYNo1apuPNetxDwcdgM5s6JZn1jk
 HSpZgvedjocjyeogqHkK/RoFFSAPr1UCaCU6tz+oKNApJoYs1i6jX0o2p+2UdDTXt8OsqDNG9
 6AfW26+/m+inFcKVDZGM4S53QhZ4AMDzxoqFwzEPLflAghye2Dhs9AtO6ybLR8K7g5IhGvB0y
 GMGJxM6eoiZXGJNZzmNLbCU6zKyrxoy/AQkomZG1eCMUUWoxWwMi22LCQVkKGsX1j22mt2hWy
 lvHoAeTk/bMzLeMQs5eqvgTAGMaAMVc0/WplyqKmOgF+3eANglkY75ET8DMiVU0GhxJCJQnPB
 iBzp788xUsIs8hByW83E6S6Edj17LyZ0zM30k3AJlFpVfJv8CKS7mCYgK/BcpGom6a9hdjxxa
 VWpsFjEbmTKza0pei
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 13:37:41
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current qemu hppa emulation emulates a PA1.1 CPU, which can only execu=
te
the 32-bit instruction set. For unknown 64-bit instructions, a instruction=
 trap
is sent to the virtual CPU.
This behaviour is correct in the sense that we emulate what the PA1.1
specification says.

But when trying to boot older Linux installation images, e.g.
ftp://parisc.parisc-linux.org/debian-cd/debian-5.0/lenny-5.0.10-hppa-iso-c=
d/cdimage.debian.org/debian-5010-hppa-netinst.iso
one finds that qemu fails to boot those images.
The problem is, that in the Linux kernel (e.g. 2.6.26) of those old images
64-bit instructions were used by mistake in the fault handlers. The releva=
nt
instructions (the ",*" indicates that it's a 64-bit instruction) I see are=
:
   0:   09 3e 04 29     sub,* sp,r9,r9
   0:   08 3d 06 3d     add,* ret1,r1,ret1
   0:   0a 09 02 61     or,* r9,r16,r1
   0:   0a ba 00 3a     andcm,* r26,r21,r26
   0:   08 33 02 33     and,* r19,r1,r19

The interesting part is, that real physical 32-bit machines (like the 700/=
64
and B160L - which is the one we emulate) do boot those images and thus see=
m to
simply ignore the 64-bit flag on those instructions.

The patch below modifies the qemu instruction decoder to ignore the 64-bit=
 flag
too - which is what real 32-bit hardware seems to do.  With this modificat=
ion
qemu now successfully boots those older images too.

I suggest to apply the patch below - even if it does not reflect what the =
SPEC
says.  Instead it increases the compatibility to really existing hardware =
and
seem to not create problems if we add real PA2.0 support anytime later.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
=2D--
 target/hppa/insns.decode | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index f0dd71dd08..dceaad65e9 100644
=2D-- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -149,9 +149,9 @@ lci             000001 ----- ----- -- 01001100 0 t:5
 # Arith/Log
 ####

-andcm           000010 ..... ..... .... 000000 0 .....  @rrr_cf
-and             000010 ..... ..... .... 001000 0 .....  @rrr_cf
-or              000010 ..... ..... .... 001001 0 .....  @rrr_cf
+andcm           000010 ..... ..... .... 000000 - .....  @rrr_cf
+and             000010 ..... ..... .... 001000 - .....  @rrr_cf
+or              000010 ..... ..... .... 001001 - .....  @rrr_cf
 xor             000010 ..... ..... .... 001010 0 .....  @rrr_cf
 uxor            000010 ..... ..... .... 001110 0 .....  @rrr_cf
 ds              000010 ..... ..... .... 010001 0 .....  @rrr_cf
@@ -161,13 +161,13 @@ uaddcm_tc       000010 ..... ..... .... 100111 0 ...=
..  @rrr_cf
 dcor            000010 ..... 00000 .... 101110 0 .....  @rr_cf
 dcor_i          000010 ..... 00000 .... 101111 0 .....  @rr_cf

-add             000010 ..... ..... .... 0110.. 0 .....  @rrr_cf_sh
+add             000010 ..... ..... .... 0110.. - .....  @rrr_cf_sh
 add_l           000010 ..... ..... .... 1010.. 0 .....  @rrr_cf_sh
 add_tsv         000010 ..... ..... .... 1110.. 0 .....  @rrr_cf_sh
 add_c           000010 ..... ..... .... 011100 0 .....  @rrr_cf_sh0
 add_c_tsv       000010 ..... ..... .... 111100 0 .....  @rrr_cf_sh0

-sub             000010 ..... ..... .... 010000 0 .....  @rrr_cf
+sub             000010 ..... ..... .... 010000 - .....  @rrr_cf
 sub_tsv         000010 ..... ..... .... 110000 0 .....  @rrr_cf
 sub_tc          000010 ..... ..... .... 010011 0 .....  @rrr_cf
 sub_tsv_tc      000010 ..... ..... .... 110011 0 .....  @rrr_cf
=2D-
2.21.3


