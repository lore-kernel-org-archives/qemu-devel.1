Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C72C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 13:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC39206FA
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 13:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XSmBm6HU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC39206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCNKg-0007wz-MR
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 09:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kCNGq-00074o-S6
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 09:21:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:44901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kCNGn-0000vG-IE
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 09:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598793671;
 bh=P4RYO6qAUK5B7hdETLfxQ80vTlWIbrwC9V/yrbxZsK4=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=XSmBm6HUKTSkzUMfoQYDRAK0D7bXjgfBy5pDl8cSObcFCB3NkkMvQqg8IFiJ2Rciz
 Yqid/QH364r6ZqplHOdqfonhbnCnR5zWIrnPxHEkuMKYOir45JCYJ6JCaAwkXSo+jZ
 StLBgxQuI9+7zPpG6wxmeaai9WpIbnpN/3rZsBXM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.160.119]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwXr-1kIfjq32Tp-00BM1A; Sun, 30
 Aug 2020 15:21:11 +0200
Date: Sun, 30 Aug 2020 15:21:10 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: [PATCH] target/hppa: Fix boot with old Linux installation CDs
Message-ID: <20200830132110.GA31329@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:QA8W1gVP84PJZW3xE0Ko4WFC2iUnoD6fkacwar7o6fUI/nbQezf
 aG/ClSmoQPW4Nqck/UVqI5qMJVlPqYMFJnDM5uON9fF6xfdGp9Tb571YfhpTXNm5MB3JNr7
 sQ1HHZxaZwBYqsmG7of2KS4T7ODORZrO0i9IihOkqohZWJ8NGz0EvIPaQt23JwndyXxSSQw
 +BV5UGgyCsjWQwRHc/J0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:huy2IO4kpUY=:ZpCFjZRbBGAiztWpSt/xVv
 MyFAXe5Nf44DGt3kbdjf5WLVEva5sdzbjCqL3eEUKHjUuDT/zpZQDuI6+t3fjMO5gvnThncqJ
 qxzkwGF8GLpzV4MMzGAxI/43JdSmDPg+7BCkbi/x7jg5iOfJDLwMagDp8H5MHmUoYngeMlgQp
 IqLuVuBikwPCI0SmCXHXNR2UP5bu8eCykO1kSlw0PQbyq51toxrODNfCYPLqsv2g+plrRFLXx
 fXg9YeBdqH/JV/bJ0rA0chCRe0YCRA4c+DmOEBKkQ1cnsERyc80v3UigzupmZFrtGaCbKz1Xw
 a1bEzgWkUc6PAeEjbi+m1pTfevj+OGVTC1eGALRcHn9jRuf3JGRNOPcU86eeuzpOY8mJFwbDi
 1lf6KoHvRsyUHH8pC1WjdO0N5kXaOxZKhoRbcEjFRACjcx4MUpfJKczwJFmy+JLoLKBG9mHYL
 tF4JNDjBFLXONc3Fqwt1JGv0ahQ5iEch8SRHJhA+ciTzIDW5mxfrrPBdYyymXJZGfMv2QlLgm
 yZdEDLxNQ504lsyPL7pTNh/hlqQyTYs49E7HYkfXXrwV1o0/MTcPwc3TS097RarRVHO4O3FsD
 s5lfH55O1cZo/+zfSdTYdQkpjBXr6+dgskfdRs0rXWFCuMGVEFl/zClXExp0zkM19TuYP/waK
 Ai9kswmitbfnazhHmyfguc9wYWnVqH3oeFlwLkUMtEWjXTGuFAHMApaX0CFzzzlfzMvMLPFeI
 akJ4thb1vk/4nJ6tuVk5Ct4MwC+RP3+sjq49E2IOwEhbu2ok15XWiCl+jjAPX/PypM6WLbnct
 hWIibXQ7aIZ8YGVKvdKa+NKYQdUHutAeQ5hW1Ct8T8xOACY8nkbZGs5AiA/wa50nlTt33kAJ8
 2fiP3EIc6YzByO2n+WqDntX9UGEuHXKRzs8OIXFYlFj9xnk9eD9obDCl6ZG9H6xMBP2qrSByW
 AC6OcaoJ2MOJyFVarTMDhTRYjZSl5vH37z/9wQ9+erDi5l5412d2HrzQXa9l1UsdmSIilqS9t
 0xlKzLlci2fYsusLp8/ZASVULFETNSX2xra3EzqUpOmksPgL6fq8NBW83rkYMzFZxGcmIjNoe
 sADh+2BNJntWSWMi1wzNBfEEcDBcP39Mr0qiq5pHfWxbDY3CCFm8CDG170PALu0hunTsuskkj
 LDcjsMqld87SYLE2RRBTjaP0+gorI51cr+5J5an9TsGZr37Z3cpBnyZtZzDA4dJdG0zIfC7SD
 +WSCZno9umyTsCQTj
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 09:21:14
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current qemu hppa emulation emulates a PA1.1 CPU, which can only
execute the 32-bit instruction set. For unknown 64-bit instructions, a
instruction trap is sent to the virtual CPU.
This behaviour is correct in the sense that we emulate what the PA1.1
specification says.

But when trying to boot older Linux installation images, e.g.
ftp://parisc.parisc-linux.org/debian-cd/debian-5.0/lenny-5.0.10-hppa-iso-c=
d/cdimage.debian.org/debian-5010-hppa-netinst.iso
one finds that qemu fails to boot those images.
This can be verified with:
qemu-system-hppa -cdrom debian-5010-hppa-netinst.iso -nographic

The problem is, that in the Linux kernel (e.g. 2.6.26) of those old
images 64-bit instructions were used by mistake in the fault handlers.
The relevant instructions (the ",*" indicates that it's a 64-bit
instruction) I see are:
   0:   09 3e 04 29     sub,* sp,r9,r9
   0:   08 3d 06 3d     add,* ret1,r1,ret1
   0:   0a 09 02 61     or,* r9,r16,r1
   0:   0a ba 00 3a     andcm,* r26,r21,r26
   0:   08 33 02 33     and,* r19,r1,r19

The interesting part is, that real physical 32-bit machines (like the
700/64 and B160L - which is the one we emulate) do boot those images and
thus seem to simply ignore the 64-bit flag on those instructions.

The patch below modifies the qemu instruction decoder to ignore the
64-bit flag too - which is what real 32-bit hardware seems to do as
well.  With this modification qemu now successfully boots those older
images too.

I suggest to apply the patch below - even if it does not reflect what
the SPEC says.  Instead it increases the compatibility to really
existing hardware and seem to not create problems if we add real PA2.0
support anytime later.

Signed-off-by: Helge Deller <deller@gmx.de>

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

