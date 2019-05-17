Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1710C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965172082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965172082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRczo-0007zI-ST
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:34:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hRcy2-0007Af-Md
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hRcy1-0000Vv-Tt
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:10 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hRcy1-0000Uu-LK
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:09 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1Mzyi6-1gUgiv2Hhu-00x3Mf; Fri, 17 May 2019 15:31:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 15:31:47 +0200
Message-Id: <20190517133149.19593-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2g6kOi5eoSDW6MX37Xb48niNeR5iwyRuyOMM6AL7v7f5qRLkfOg
	C/6OJNar/DNjAWb/PrC9aTvs2nt+yN85gASCkm11g2cJ9nJpStDdpgMSX57wCOx3dGVzzyT
	uBV+OYtuOcwqUP59V3EO5DUWTLIvk6ct1yG3wbV3jwdPdXP2uKcIkQtILhmP6G0Bbpc7Rzi
	jyDyQUv0g6cIAKye0imBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fajgtILYEAE=:3blGcnpEOJ/UiqhFuoFMF2
	Rr5OR4Y5LEhkgSnFz21EZJe0L+FhlKwoNqz3sEQaaosRyPEXf4yImYF6auJfnsvPwDE/GsvPJ
	dg2sjOjgS/YMf2QY5nNN6zp0gzwaKJ3EMCyoRhIQP0UG1i5nweoRS96Wm9FmYAusNZ69oqZ9a
	Uz8LoQCBMSB9bErPbxGagm4NYJfIonpAgAb0ugazrgfpYwl4/Q5+h+J5rezXnHYbU6OWFIPhM
	XfL9CNS4K5OKWiegKqzNVBQvIa8UnslRG47aIoN+pRnmhVjGjsH/gzkBWQSNZ8PlJEK4yqSUK
	zezwMfCoOBQCtYdZhzn27pSgAMAT3s/zfk7usXImt8keN5KunOPfBeGsqHIpxVlhsKznHlWWF
	8+T4JSwcLMT7paH3xBK/kujJj552HoF1gT0YjTOjOyo0hIrOGnLRAd2nesyrOWNoR7kNhgTou
	kKu23VFSHrhtCi84BVU/C5ZbZ0x83vf7rYpqYZ6epq4ZkLSrEiNTQtO24peL4VxWxHY53uaxK
	USNDHbzbZ1VE/BbvWALfBapCgtG6T3zqcLuM9j5gVQFZyqAvJaU90FWedI1O/kQqzTPZAx7Wx
	gg4lYXWU5CRnkR29yNK1eyOFomavcVJevUdKNdePIg+0YwBkmBORT32ddgYnPX4P34O1+EADM
	Fn+r9G5qcLkY7qv9e99H1AbSjqLS+brqTg8dA2Wqy1MWBdklwDDSkjUl31fg7a3xohv80Vl4F
	ggLhtHTyBShV7FNVdCwX7ohOUszsNzhKGjfL8Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PATCH v2 0/2] Add pseudo /proc/hardware and
 /proc/cpuinfo
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They are used by some package setup scripts to set the default configuration.

v2: rebase

Laurent Vivier (2):
  linux-user: add pseudo /proc/cpuinfo for sparc
  linux-user: add pseudo /proc/hardware for m68k

 linux-user/syscall.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
2.20.1


