Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824A4C10F14
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 03:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424EB20833
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 03:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="YVctx1dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424EB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60095 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIPra-0007p8-7P
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 23:43:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hIPql-0007YS-Kx
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hIPqk-0003kT-Of
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:42:35 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:54072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hIPqk-0003kA-Io
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1555904552; bh=q0jctMQZFKKqPnqr0q44tB9DYOQ48pyAL+pluOJjiNQ=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=YVctx1dgHavsIiqY9bianXPBN6iCggJspKUvlVEmAs4n12k5F53nT7JXoylBLzbvh
	NIcZpllI3rXYQFz+qV/FTOgHIfLEQC7W6CgZvcfT70swdF3hajbSZew3z5V9AXGqzq
	Ykw5OcK3psbEFD0/ity8q7Q9L4B+KZo2NMiNHXbBmPIGYoZHADTBRsSpq52palLt+V
	hhyB/x0qC9P9scqVtAKGtEtdXWGJS6YxizyREN/EydzzQ5rCKKX86Pjnpd4UzRvVec
	iR0wUUsrvmEb6rLt9C3r0diKuz2MfLmEUaX9mSJnseZay3CODdHNWVKx5QEX0WM5BB
	mh2GwF573+6+A==
Received: from [172.18.2.102] (unknown [36.106.167.46])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 638F4640054; 
	Mon, 22 Apr 2019 03:42:31 +0000 (UTC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <087F1D9C-109D-41D1-BE2C-CE5D840C981B@me.com>
Date: Mon, 22 Apr 2019 11:42:25 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Eduardo Habkost <ehabkost@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-21_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
	mlxlogscore=682 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1904220025
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.40
Subject: [Qemu-devel] [PATCH] hvf: Add missing break statement
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
From: Chen Zhang via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Chen Zhang <tgfbeta@me.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422034225.wfndZcROVm2vYQzBX8CRtRswJB2OmBfs_Zn7ask0dkE@z>

In target/i386/hvf/hvf.c, a break statement was probably missing in =
`hvf_vcpu_exec()`, in handling EXIT_REASON_HLT.

These lines seemed to be equivalent to `kvm_handle_halt()`.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 target/i386/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 42f9447303..2751c8125c 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -708,6 +708,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu->halted =3D 1;
                 ret =3D EXCP_HLT;
+                break;
             }
             ret =3D EXCP_INTERRUPT;
             break;
--=20
2.21.0


