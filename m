Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0785AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84E720758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eUPia1mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84E720758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYhX-0004Bq-Oj
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXd-00065l-K5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:52807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXU-0002vL-3B
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075301;
 bh=1RjbbzPbP2N3QF83H9SFCrSjVVJRqbftyMByeZf/fTw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eUPia1mr8Nw95fzjlxWkmd7jHHeLefifA93p2y7qyMqBXbW0a7fqcgC1SCoF53diY
 qtRZc7N/Npa/IFBsWcCsAQEBVyOMY2QhtXiFZwXXLcTbQbWgTu9zZIYGc1ISLzkhA7
 Tc9zdnRoIushbk/Rixl+y8Kcbjk2JRa3MSKyOXso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH9i-1kjKRt3AMe-00ckNK; Wed, 02
 Sep 2020 21:35:01 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/8] target/hppa: Fix boot with old Linux installation CDs
Date: Wed,  2 Sep 2020 21:34:56 +0200
Message-Id: <20200902193456.29844-9-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200902193456.29844-1-deller@gmx.de>
References: <20200902193456.29844-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6whmd1PeULOGtUxrlLBN1QODfsPfnNBL6s4Ee+NmGh2ID2k8KXq
 C00A5BnUtI4DB6xisULPetgftDk0W5/twIYo8tClqVboHjV3QwcqNaEhz84w7x+7MR1pPX3
 H1XprvUcCP8FJoPYyDd59DqyUngiNQw1XYXqff7UQ6iqruzaQ+9bTm3Sir48uDQXho9AlWI
 6J9DOZq0dBeH5DLRjPO5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/OSBts4U/BE=:EBeNju3OfuAVjUdU/Cgchj
 SIjsXMZ2KvCjLI9OcKul0wLsYVLW58qDBc0JH01EmqrdZygoWsuZR17W0iM2s+6uGLCgQV/Uk
 Ehk7dFU5sY/Y+40qcb8UFpFzJoEnV3xy7vZTjv2tbd+1fEQDTGE02R1fVxOtH+4R65Pc2jYO7
 7XppIYN+vSKK05BCWdYshx/Isgrt0dPC+vzGjjapxqUnQ9Ze8Pm7eV+aRPFT/EDG+eseaQ32Y
 J6WT6xyEfYuykNdTTnfeFzQy4yPS5EwsA31Cig44YuX9l8Oz8ykples6UPZ/Q4edw8L2DPxUd
 mijEvWW7x5FoiG0HjPdZoXlwsRBoHZndR8qIW0kHoNG5iLF/po2zKunedISn3yDeyW1MzbpcE
 WVMF4UqnreZ3kYXzy1beB/6laeV6cZPFrpmF5mGxBxhdTUrjaoY3BAR5irNSVeblT2SDzyuXj
 MotAdRZk/HVuKDlKzIxoqvEMcMTDsZCyu+rcLFBvcUtEK1lDIJYL1ULUfbMAYBGQQo54FAY5o
 hBuWlyOM2nfH7c/hoMKd9NYcFXxB326dZA3FAE8951glKmYiFmPSnFiHmj+yw6Z8A5xNzaBDm
 JNxXm1jZX30L61ldGQo0rLhVOerEqr7bEA6mHONOWVsyHtj3hP5OCZetRqDTCCQs3Js3dEd2E
 hGsmf6DSBHZTW6yFgNdMiSbxO228MlAyttSarChEuAekyv5og0XdQdkGCNbaz/3CQZcr7TeYr
 B3zDDGLJiRMg4A5G27DogbrT8zXevEYK68z4kE2iJu5GLsrAytWbBTjj1pC6Dw/lTI6mveNhL
 Hajg4Fg5G7xhIN0uhxO7I5KA8wk9HVgoBBr3gE3jlzFJ1rLy7QiUHG3/TWUiWdZyneZAQgzGc
 JIIfUisZyfpTgsquIEbCTNTkR45A2GNbfV+TxsSjBS+w2wSlcK+UedTOgFybVrEyTjikdIC2B
 9FSahkVX4NTEZRVPic2bGozoYHAkTWYsvEJ5cXuIbYXTb/wD7jEaKoq84LkvWnc3T6v5qJEfl
 RmB1ZAWGawmfwlMYBVUjVSa8T+wAkPcWPu1v5D+hnEdwhKQLle2uKZlnuna+H+SLxdY7Xi59u
 LSJwAGjdazGc3pUoyFMBrf+5oKBK5/d60pky66jT3G3KZNGpjtFVx2eSuBb5CWql5S+95cdk8
 +avnXNDe8MzjiS0s+n3SoryWMA9VKh1RyzTn7qAbTkaCM/7KwpUWs/z9aBHHBHJK0OWNu044E
 DokYpRyrBHR5XO8vM
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:08
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


