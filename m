Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106C8C282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6C22171F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="O8BscZRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6C22171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33196 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHagz-0004wR-4B
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 17:05:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHafZ-0004Ke-Mg
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHafY-0003v7-PO
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:57161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hHafY-0003ul-Gl
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1555707813;
	bh=VvcqQVvmjVHE/KKVb2ZULEDPtO2EnqD4fDh0o9yUJjQ=;
	h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
	b=O8BscZRtN5UbD/EusJMY7ZjAb39uVnwZPOFCSDarVa0TkR+Ul3HqJ6zphcAeyIs+D
	4VvBVy69B4lfkKp1w1w4bJl7b4e9E6jX1yXkZdIlj85GqlxI3HkMIEDrWrXZcbRNDc
	qaBk80sv/EfNbo69L4LdFOHodZgdPRlmvwT0m9Hk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.96] ([90.214.132.136]) by mail.gmx.com (mrgmx001
	[212.227.17.184]) with ESMTPSA (Nemesis) id 0LqQnR-1geO2M2EpF-00e1rW;
	Fri, 19 Apr 2019 23:03:33 +0200
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <eb28f1c2-9556-f3c2-ac2b-0f69db474ff6@gmx.co.uk>
Date: Fri, 19 Apr 2019 22:03:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fh6zqYUhlLJWWYWmxGtEqs22s8Ayq4C7kbbi7qO+yWfcazdLCjz
	hM1I37kiNCQZT9DREpkKZZhcBBg/pYwMIEC6B5HVOoY/v4D8pWTf8b4f8EFYT889mXMXIs/
	a6eEaD5b/RMNj4Ks3eGJv/fgeuPoxRfgOAQqNYAf+P9bEhNvlBMhLgjPcCogq42ORwvEAn1
	LzN1xhumfCQVXJu9Dnt6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPOokM2mqng=:HHRNwLZRmVELpxzC9ohaJL
	BrD2BtPZ3rAFh9V+FHs40sRHylr9QKcIIf0Ejd+/sPP6L1uCKHeEH/IaTJ6nYkPcJ30JfXe0N
	9QFw0jtsaIjV46dxmmA8XP9sx/HqBLHavVxKnuGf7qAH1fCp6sL7PWffMgqKJjtdDzTjDd/1o
	VHsff1gBNzOyt4nb3zOVhJCgTX8bYo8n+bvjt7eZ7DT7adzOd+WaXI9rIO6Y3BU2RPrw71c55
	kJ+fHe3+he2OxD9qUZCK+eQyGleaKGJuVBRoUWSNIqXZRm3xCGWx4xrOTP8pL7ceQSCbekyte
	roMDaJ2wqvt4EVyQ/nlGTVgziCY4xEjxaqGqCH9JNYzdj+RBbgqMgWyzfH1f2iY/ocVcsd0Sd
	T+21m9aw8/t5dx5a15YxResBbhzgVZC6tn8T29u+EaMvTNG7oJbDwcXPbT8hb0M+JNWsi1174
	eF8ty+iy4XH9n+nji49jgeKo993AunmeXC74yrVBPKxAi2f94a5bxXz8b0udwqxiCC4XWQJhD
	Ckr15U1isDuc1z48CSZuRww4WDtnegTE8otDoADwiMr47jxgb4DP70ltVHSL7FFGoUr5HuU0k
	/AHh05glzkY7fjK3MxbQfUEMkuOyfY5PBhSaAZCsmMFPr46y9mzdOwlG9MJhyERVY0BGtFcqv
	MjN9YXOwy3MdYxJIvsy4KG/kfl9L2aurhhRqg7uRNmeosmNSbwm9gMuVgMJOlz1j+7gqXLGxN
	3othjHSVNgZspLQdSAQnvMHPkfUqpiGpyzaOjSbtGJ2YLxbl8Q4LHRUk5dNbeAxGCNTbI4jnH
	2NEMV0CmbGsj9dM5RgqWzNLeWNT0w4/3z0AG/ZawsgaUi0aNeiJVKanuKsQ5axx1fJyOfadK9
	MFNYNmu6lUsc9/dIm46PZlBOgSH+NyF+XaQf8W1v0LMdy4UwSxbz7nfvwppxhbOn9OVkcjkmS
	nM1s5zCS5JA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
Subject: [Qemu-devel] [PATCH v1 2/2] Always return EXCP_DMAR for protection
 id trap as, EXCP_DMP is considered legacy.
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419210326.3W8SM1snbtsMbSvW0c7YktNwxUrbMVnVmYBu5vF1uhE@z>

Always return EXCP_DMAR for protection id trap as EXCP_DMP is considered l=
egacy.

"In PA-RISC 1.1 (Second Edition) and later revisions, processors must
use traps 26, 27,and 28 which provide equivalent functionality"

Signed-off-by: Nick Hudson <skrll@netbsd.org>
=2D--
 target/hppa/mem_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index c9b57d07c3..77fb544838 100644
=2D-- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -154,8 +154,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr=
 addr, int mmu_idx,
      if (unlikely(!(prot & type))) {
         /* The access isn't allowed -- Inst/Data Memory Protection Fault.=
  */
-        ret =3D (type & PAGE_EXEC ? EXCP_IMP :
-               prot & PAGE_READ ? EXCP_DMP : EXCP_DMAR);
+        ret =3D (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
         goto egress;
     }
 -- 2.17.1


