Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A61C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94BD20863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94BD20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDa61-0002MN-Gu
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:38:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5B-00024s-3i
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5A-00076O-94
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:29 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hDa59-00075h-To
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:28 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MxHLs-1gy8d23NZQ-00xfDQ; Mon, 08 Apr 2019 21:37:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 21:37:09 +0200
Message-Id: <20190408193711.32680-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e6phu8x0eq9hLr7jESNqd8ChUAAr8pgsM6b/lQi3P8x50llWnkx
	a6GZuAHAQKCaBNkj52L7mC4DuusZU4mI6ZQyB0l7sg8zBqLTHA86BV4G9QfrcXS3ptplzD0
	//duy5I9y7rMGA7V5u/X81VDzeW7HfSjDsqvapoe/5FPgiAxPW7EFztK1N7Arxk1J3uH0W9
	FMSQTxT6RsRcGMCJxk3Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jOAm+aoFC2I=:KbIMVcyaSBwh1ev9kWD8jR
	xjBsG6EkLhYy23F9mM5DMCg3Ud3Kkaq91gIz18xxDGckgsQ9ItsY+NljdwD37cde7noZpOsMo
	ZyYsqSrWVat+yC/wg2ikStVKdO1+/Lb4imFkg8UiLsg8B2cPOm6sE83bpju0m6hFu4ILaRFgm
	IM8GJxDEWooOkIX0QbNfgcC9+euXOE37tD0+2NeBBxk7wydWRvh75Mq7tlcyUs9d/CYDMFJKs
	m4dotVJSLge70i50HogSBdOHAQIoHJDRYJnrmYSCT5j/8Y2KZBIz289uk5iPyTJYOC4jQ+FOh
	UqGP212Q4ms6TqkI5UEqih/GfdIlfoYkEuHIpmATFFMQxkToJmq8Z+iv8gmEveFkAMA5vXxkW
	KIn0giH2dh/kfy8QdFt6QDslTUFNcqmKf4Bv/TSj6pZdB4LDBAZNq4Z0XGrvu01lJyZ3UgvdI
	8i14yAXgF856tt+4181Bbb+EXExckh2EKrOxLZScbzfRJ5LdNLHA0Sfqx06byfiEo18QSCT4Y
	7heHOQE7s36puPIPRmYSKDiwnr9MIc6NqP444p/jYrb31+Qfgw9IfL8+d3QUPb7CiFzSh6Zzy
	sISgDG5BWPH2gsR2x66D3K3logM172zvj5wZ5xsZ9P+uzB8unEYQqdykL1jfffBm/3/Tiao9z
	3W1aET+kk1q5m6/sCEBMf1meIevmLu9THv4jIFAN9ASYu9lTaaiOZY5t4KudpTG2kuQU6dxxU
	/V028Bq4VOkV9GzErovZun4GnjBf7gZSPKX4FYFj1zGzgDMKoRxGvVxvsEk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL 0/2] Linux user for 4.0 patches
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
Message-ID: <20190408193709.ZBhWeuZTTmDdNAygms-QSNsCsZNl8xtDV0U0jgrwSAU@z>

The following changes since commit f55a585d1037e5de6088f25e75443c2776786e29:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-04-07 14:54:55 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request

for you to fetch changes up to 71ba74f67eaca21b0cc9d96f534ad3b9a7161400:

  linux-user: rename gettid() to sys_gettid() to avoid clash with glibc (2019-04-08 17:27:13 +0200)

----------------------------------------------------------------
fix gettid() clash with new glibc

----------------------------------------------------------------

Daniel P. Berrangé (2):
  linux-user: assume __NR_gettid always exists
  linux-user: rename gettid() to sys_gettid() to avoid clash with glibc

 linux-user/syscall.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

-- 
2.20.1


