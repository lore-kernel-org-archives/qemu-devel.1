Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A71C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4F0204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="e/W5g1y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4F0204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIp5K-0005HL-G5
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 02:39:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIp2i-0003hZ-3z
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIp2h-00073N-9S
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:51381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIp2h-000722-0m
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1556001387;
	bh=gSHlHWtWxJtFqF8i6+ze9K7YB0TmJyPy/nbEKqikGyk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/W5g1y9CWnwBsaDJfc/AZnZx1mml8Fs1dniedGm2EDXFzb3vwJ8kIL+dSI9EZ0Vv
	fgjDl7P9oTQsZ3rEGDJJ/2b240CYUgxaFBvkiG7Ijubrd8Qb+uTSm5fbwFI+ZlfwiF
	Wtg1KFVN8cZjsXkT+A5DKde3O/qx5EnO3OaawldI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zoom.local ([2.122.11.66]) by mail.gmx.com (mrgmx001
	[212.227.17.184]) with ESMTPSA (Nemesis) id 0LzKmP-1goBER3osj-014QLQ;
	Tue, 23 Apr 2019 08:36:27 +0200
Received: by zoom.local (Postfix, from userid 1000)
	id 0BD339C556F; Tue, 23 Apr 2019 07:36:23 +0100 (BST)
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: Richard Henderson <rth@twiddle.net>
Date: Tue, 23 Apr 2019 07:36:21 +0100
Message-Id: <20190423063621.8203-3-nick.hudson@gmx.co.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
References: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
X-Provags-ID: V03:K1:4kx8weGaENRbNwhfNlvioru9ikuUKGaO/pbr8rdrHj6ihHI76oU
	Eap7+oS1ZZxeO6lWH5RDHVd7zhfTeVHDOsjrKUAEF7e9d6L7LMdqMWtBEaMhRecNIIwRiJP
	solH0dMLldRkRwqyVD8klfwL4dqGtKkKAud0fQ1fE+Psn//bDYTMyA3sfjXQXH5ahmBewEI
	HgLr6Wf+S8C+l68RVB2uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHYu46CWdvk=:huFd3zt5Dn1VeregqCgqZP
	f7zsPdxeW1LAyYHNh2Qn7Y56l3VXPG0OkSjwKsZN1fqtYViJvxZU+R8ycHRK/u9CvOLCivaf2
	JJ1iSyVkcQCYzMnUH8kZW4S8Dxc4B1eUqI6I45WtizANpIN+F+iOb4DMZGFs0GPpLekqdbV/b
	mnWlbMDhrDNiEaoQk9KhUvXYI7IUWQXTzTSEQ4EvqDN9hoKXdgUo2DOsk+LcW+gWl+ND1MRz6
	nO6V9NCOC9TSe71rI40CthLZ7DAN18gaNW78CEVukpXxxMvalLx4E21ljLtWi9lMMCki14xk4
	tto/Z5alU1orVsD7Ytwh2tuymhqPJ7paRCM+zQBs8P1oXtoiRo0t7swaK2De7r4DfL+0CXGig
	qP6lgx8YMtqF8E0rFjE7KL7k0771LedCOdmv78iGCAQc6p0xyJqiOt+ePlO5aVQwc2Ehcx+pE
	RtV9RVx4dQ4WfS+5UNaNkt3G2UJq00LqoPYxXu1qyshQLCvAzTQ6vzaU5BHnHybtIvOyX3I5v
	cwaaOZzw6Zpx13ywSSYELBXWUkYcOp2tghwFXZpPlKazuDI5NxZe0XbnTQgQoy9NYlTWihIpo
	miROdn+qIBXyYfJi1ORQrTUhzxViLPi1PrixZ0ZM6tDu46NpJNaF391Xl/sfl3uG4ZWnTq65A
	+BFBzp9LUy7bAfaH3Ged78u3qIGsVStcwf7gvy9G4ecSs3Bkaxhds6TecL4f2cYQlYqPuH6Rf
	+QnfepaJM4l0pwuQZnZCH3/6u+Cc9aLZxyOQKZjVTSTlyS87mt4VLP90Wc9bf4NJINkEOurLW
	3K2NFWcLC/XYhY102oJpqdGvz1Fp6LqMI+GAvLd8IZGp6ccq9zqC9W8lTb5AWyF03ygiy12q2
	jlu4eYNLtOSvpxNp8nrXEHqL+VlbDePlz5+1FiTVOOgpAhPgoZvKZsFRMPomba
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
Subject: [Qemu-devel] [PATCH v3 2/2] Always return EXCP_DMAR for protection
 id trap as EXCP_DMP is considered legacy.
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
Cc: Nick Hudson <skrll@netbsd.org>,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423063621.avNwZ8bwCnsb48dFenjkl1JAcOvcWeR4MBwn1dE1ukQ@z>

From: Nick Hudson <skrll@netbsd.org>

"In PA-RISC 1.1 (Second Edition) and later revisions, processors must use
traps 26, 27,and 28 which provide equivalent functionality"

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

=2D-
2.17.1


