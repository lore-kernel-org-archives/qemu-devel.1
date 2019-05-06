Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596EFC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24585205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5+jKVt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24585205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfby-0005vH-CD
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:33:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hNfas-0005YH-Jc
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hNfar-0003sY-Lm
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:31:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:38630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fintelia@gmail.com>)
	id 1hNfar-0003rR-EM; Mon, 06 May 2019 11:31:53 -0400
Received: by mail-lf1-x136.google.com with SMTP id y19so1904492lfy.5;
	Mon, 06 May 2019 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=FB9+SCfnB8QzagMDoXtuby435WXka8anbsg63mzE4aQ=;
	b=a5+jKVt8PEK+67H9Y6nu82VEJPzGr6IsMgm+VFHbU6hMUn2kK0Nrwc42ruKlFAoFFK
	BZlXNjCwSNUAgrGVdUSXnI/2Ej1/0CeqNKn2RJ0uSkJuQrffQYaIRAUtlmb601/QEuHe
	rCQPxC7ULvwx7JZ4zatKEFzmAGImPpYtHYnZxGtOA8o/D1MKgI5rlIese+P4nWSDW74o
	+j29kAkIKZGnl6xysEV4/HJ6qqF5vW+Sx2u6tvWWbE7oeLGW5nwkCl0Ebh8PatdmYC5P
	oyCjneAW92DHRC6mS4SNopjuE8HTEKAEKgMAFpK3vwekyiANBXtDjts7b5aAmchgd3ek
	ZpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=FB9+SCfnB8QzagMDoXtuby435WXka8anbsg63mzE4aQ=;
	b=VP869Nd7Zvfy82Z0X0TlM16iYqwxM8+SSsuFLlTLdAxOjfUXwGfk4a3SZCA/JWQDH2
	kPmwlIAnnSxCGpwwEZOYgeGVFvzgTERymXflS0intovkONhjsUAN3zBo8E297vGabjyZ
	yQJtKXOgma9sRebYJOOYbDkwUC752GecaXw/XMvdl1muchYQF6X7wVh5RxX2KyjQN9lR
	yfsyTXtiXypvh406AK2bzJyr7H43/FNRoSao5y2tP8d1E9uUxpQOPQGp1xX3hAvLQepn
	VqGvDC35wZEo4qcMldKfFDmLB0znk65nxCcjpfL+aM5PyLQUdKlA/SokdArk2yzXyHgs
	jzrA==
X-Gm-Message-State: APjAAAXCzZcCgaFRbsIIzBX9JrsyEuWjujqG7QOWGFviL2+Txh8KAdcZ
	6GvjyHXZ3amiVRpMmbtH3gvlCbJU4H7iuYpiXoM56Nz6lAk=
X-Google-Smtp-Source: APXvYqyYxT56gtddLmGYJfCpC9JolzfCBLbgyKTnf++k2WeNoCajOUNiBTpY3Xg7+IjjusSo7ricWfmRQTSdy6ow7FE=
X-Received: by 2002:ac2:4571:: with SMTP id k17mr4272321lfm.133.1557156710847; 
	Mon, 06 May 2019 08:31:50 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Behrens <fintelia@gmail.com>
Date: Mon, 6 May 2019 11:31:24 -0400
Message-ID: <CANnJOVFj9yhbjPY=_+LNDWwO=Q8jLFnH01AbTY8T0p=cmkrNiw@mail.gmail.com>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::136
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH for 4.1] target/riscv: Only flush TLB if
 SATP.ASID changes
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is an analogous change for ARM here:
https://patchwork.kernel.org/patch/10649857
---
 target/riscv/csr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6083c782a1..1ec1222da1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -732,7 +732,9 @@ static int write_satp(CPURISCVState *env, int csrno,
target_ulong val)
         if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
             return -1;
         } else {
-            tlb_flush(CPU(riscv_env_get_cpu(env)));
+            if((val ^ env->satp) & SATP_ASID) {
+                tlb_flush(CPU(riscv_env_get_cpu(env)));
+            }
             env->satp = val;
         }
     }
-- 
2.20.1
