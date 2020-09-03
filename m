Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B7BC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E55C20578
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bSidBniL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E55C20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDs8o-0001E8-OR
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmi-000837-Je
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:57871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmg-0007ni-JS
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149271;
 bh=1RjbbzPbP2N3QF83H9SFCrSjVVJRqbftyMByeZf/fTw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bSidBniLmBAbz4xC0eG2lG2nhujdmXwqc1J1+nH0aOzw4Nd7wnPKT9cJ1VnmVUYLx
 wYSGJ8LFOx1TQGGElaPHPZWrbxcaCAT9+9oHWquXp3s+RJqlbojSS1a9+7E14c3jkR
 3RxAAndjpkBLzChVK12I8As92sJud7bZHk5WUsL8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1kiMQr29io-013fKq; Thu, 03
 Sep 2020 18:07:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 07/10] target/hppa: Fix boot with old Linux installation CDs
Date: Thu,  3 Sep 2020 18:07:43 +0200
Message-Id: <20200903160746.27491-8-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IyZw5rE5Eb9PmvzGd2UsYwpORXov3NYsgJCrsf1BYpUqAV2lP23
 0kSvaqxFpxehgMQ7Uv0PrSLdCpgbo46/FP3L3gwguMouFUYQT0yVuoPTFCG7qCJjIyAfJGN
 AAMdlzZ0blfWYNPr3GO0j3js5CZ3ORmJOqPCP78lssUAUjjQ25PYJRIaq5dhaXZ3FqcSV4a
 vVhA+Smsp+mY+JmvYgGsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N9OylkwgT7w=:LLxMufjBoOj7Kp5lizsmHw
 tJ5ad4DGq4khw4ERY+CWLoIXjWlmVBeePgXbcg/U/j9aHFeEJPqNtUbpjExijitQxjmdu47Oy
 uUfzTZSOLEScewiKvDLKPasY6hZfnD5z+IR7rhak5BGrQ7DzZV80BoTrDBsGazf+0AcCYZeH0
 JncXbzL+1YNOl/c40/2kkLC8gCbZjfNtVEhuEV8MGhEQ9QiZZFWu9CrKfT4HhdXxt6DPpxl5D
 Pi2NXPtpHmfm3ot/g6JK73hwpcTqin4xyEMhilvtcW/SSYiTK863Pb2eNZUHjWV6QulSH+ihF
 v2UB6hy7dqH61zRg0KzgiQyw242D88XX2QjLsXriS80zMoDRVaLz69wx/OE/+iNsWfX1WTUtM
 xFxHC7AryzVrWqs468RXNqH8ibenHlYjrDSNCNat6Oh8vOk69NT4Tld4XPrjhBW9FBvrntEwJ
 AbejcNDfIL+jdFngjAuB2ZjD+0QAqKdhZwW6P5NEq9M/b2oVPZpgvfWVnhR5oMWnHmWoC6e8D
 zxS7gq+HKISnie/j/JaXl+qX+hV1wzQnrrP3twVW6gyCWyGvE2py2PGEA5pqNWQ9DQ+/j8DRv
 yjjHerV114V/aOANUxjTN4W2lpIBuL7Z6V5IhsnD8Xe+FFuo5U8D8vNfuXlZg9n9/RLnnBuM7
 rChSPuEJ96HbQV4iIA9iX1H8lq9kyS81RXJ7fS4XTm8U2YLjnnIS6XTdHUZo86JwoOC9jIeix
 dyhUsAe7mXpEPxHA+hYyort3/kmQHL35wul2maAGdTh9Ycb83kst1RyTtOhYxsbopjLHqmMXF
 mRu4rZPjhIGUXhVJLUCZWfu2Iji3AYOzgfy1ltYwz5Z/sbB+lwo1kBx9322sH5xgkQHGJy9Ew
 LXr4k7naMhIM/e5fepFY8km0t/20kuNJwusxl3uqkRxGd5u5GWn9XJaWN9rW8cZOCV9ZclMH1
 z93IVfr9YoSEdfWSi7Wt+//MX7yJ3l/ENy7cItmexCe6Cm0HcdbMLpBsFqM/ShPT/ZGQEI3jC
 692gv3BwfX/6BVm8X0P2ZUfqt+6OUstZOvNFljq28JtmbOc1AfcMzC3BGuaIcqFjIpMa2QsaF
 5GHq74JwtXjKkS2uqFBZIR288NeDBRcp85kcQfVyCC8fNZftNesm1WmH0MKDfaosx7SU9ZA1Z
 QFxlWg35diXFR+CLdxzDuKJuf30KhYVuGQ4ksMhjlXoUevC7IUduapf31qK62QaBl3WeE1XsD
 P74i+F/EGhLFNNH0O
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:05
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


