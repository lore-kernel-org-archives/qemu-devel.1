Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_MSGID_YAHOO,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E1AC282E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D142085A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i8hSTve/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D142085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUo62-0001QC-6J
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 04:01:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hUo4E-0008LP-MJ
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hUnsZ-0005aQ-Us
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:47:40 -0400
Received: from sonic304-46.consmr.mail.sg3.yahoo.com ([106.10.242.236]:39779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1hUnsY-0005YX-8A
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1558856852; bh=h9lJAUyyyDlRjzeGFvmdpGDGbP/+clu4dXEDohXQDzI=;
	h=From:To:Cc:Subject:Date:From:Subject;
	b=i8hSTve/gP1fqpJE+0zb7UaSICgBBNgQjZY3maRkkampOVWNxg/02GnjYcKOOT5gdcbXBo40hFsbYn/NH8Hj4t+oj3Y/cu4YTpBY3BasV5Qhl3oxyIBLnVnpOKoa4iPCBXaeSQ0mCY0NMpbg9nVRcrKBrRa+p5Dm2neFD3ik/HM+zJtXuaU8FUFqeScc/Vagc5pYM530WlQO+5SZUQ0R/BFg2AO6LjvZuVLbVrJgmI3e2tgbPlYS5fvFnm+Kq4/4j/Y1WjISNGThHLfydafRHk19FAsdC4sVjyx5uanFlgCUvtG+PzOffV1SQwuJhCe8KY+o7H/Dvad68hkphRiyiQ==
X-YMail-OSG: sENCgDAVM1mSNY.agDYZ0MoWkVuFTosqpxCA14flrzrxWxEokHQFrqSk.hMK0SO
	Olh2vk9SsQY406fAPvTR14hPU3.y1Dj6n8e.9GZ4fDTnIcX20hGTCr5rHLaJHRZIepr.cz0sqv7g
	J.HQUcq0UvRlzOs59zKNST1aGd8Rx_CqL8j5pWwFEWxQgIhBJPLM6JZeiSJNy0FQaCjcUGPgqynp
	ih6Ljo_HIIZgL5hkHR1I3JXGCK0dJNhqzmy0PlwQJzp4jtq.2N30YSdKxGLXTQ4fpfmWugEP9ZPq
	sLKlsDCnWEyRPFbbbD6OMCMGc2Ncxv3xf4q57FnHh8TlHPNNeT6GYtOBqoCZ2GZyqQJ5u4BHIxu1
	rAZxz8VW.vAanspdrxowUQeV3uivN.0MV_eE_5ael8sbQAzixUbj9KqBJ9LTU5_Xl.xFFz_yFoWA
	.WfKofLLuGWaSGYaFXAHh_vk15KCXzwkkKHshoQcaVA8rHuGpxR5IyCrMN8VtRQVtk_lUF0DiKzE
	1R.JcxH84bw.RUDt.pMp90pfUP7qiqZFLZxdDncg5VSEtJ0x7zK_c3YZIFcqHQuOkkCFm.Hde1iX
	M7o4Apbry6lmUH6zNUZPai4Vx4au4cv5_UK.aMjoETrHIExrbrYiWcYD3dQ59c7Xqyas0aPreedU
	S4YpPMNAXumRKhqF9klsttWLbFEbalExpqaBWYe7xkkVVrCwJkJUc80vRrgwv8qTLzumUxipoHZG
	zAZ8ExRu5po8RCqlLswLDbIQkkskG1bmnyrWoABTkCIosIprN0kqD3U4hNsiQoFITIwrqJ3TSQr.
	UUBqIr1Pehim8MWgo_bjoIzaPK.097Lt75HveWPqGDj5H4_KzBYlQQNxeL9UjPXeO27IuWI8RhzH
	IIQkmrlqe7q6aCG.xAMoFUX3gntmXnt4et__xYRVADZIRwhGyk_SVi43jVf7PFxxwr9yak1Z2BiN
	fSrwfGy1GQFgQt8pjNX8NrMobVtkLfUJq0RO6sewZmrVEniL8Zbbcx7Ex63hMoMoNDYcHfHijtxG
	z9O0eHlltrN631oZPsrlD4WAaKkAjh9AGTWbr_gLoD_aB5IvYbmoFSrW41G6lvOfvjQzwI6eaZ.S
	NrVeB7wDDVKmUStWOWi9O6Vn7vHVumgokell7h8OXA2_vnpzbfxW7DtG_dWFkS3P9taAh5ZtNLbx
	IHAVz6E5Ztg_YkBpL1yfZrrQK8nyQPiAbFDfW_2KfVJRBkhWMk.y9TS50Tpt1U6VMAcIoc9uO7Th
	XY9hchdhvi7L535gbrtTFtyhj3huICvlcyfgaK2MLUKTXD5226ovAoRRIYTbzPwFniVADGhPB
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic304.consmr.mail.sg3.yahoo.com with HTTP;
	Sun, 26 May 2019 07:47:32 +0000
Received: from pl35138.ag1212.nttpc.ne.jp (EHLO localhost.localdomain)
	([133.232.247.66])
	by smtp424.mail.sg3.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
	3374f1a399936d92882ce880a6210ec2; 
	Sun, 26 May 2019 07:45:31 +0000 (UTC)
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 16:45:27 +0900
Message-Id: <20190526074527.33632-1-lucienmp_antispam@yahoo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 106.10.242.236
Subject: [Qemu-devel] [PATCH] The m68k gdbstub SR reg request doesnt include
 Condition-Codes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Lucien Murray-Pitts via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	"Emilio G . Cota" <cota@braap.org>, lucienmp_antispam@yahoo.com,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The register request via gdbstub would return the SR part
which contains the Trace/Master/IRQ state flags, but
would be missing the CR (Condition Register) state bits.

This fix adds this support by merging them in the m68k
specific gdbstub handler

Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
---
 target/m68k/gdbstub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index fd2bb46c42..f092044883 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -35,8 +35,10 @@ int m68k_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         return gdb_get_reg32(mem_buf, env->aregs[n - 8]);
     } else {
         switch (n) {
-        case 16:
-            return gdb_get_reg32(mem_buf, env->sr);
+        case 16: {
+            /* SR is made of SR+CCR, CCR is many 1bit flags so uses helper */
+            return gdb_get_reg32(mem_buf, (env->sr | cpu_m68k_get_ccr(env)));
+        }
         case 17:
             return gdb_get_reg32(mem_buf, env->pc);
         }
-- 
2.21.0


