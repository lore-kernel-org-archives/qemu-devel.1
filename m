Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF159FC6197
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EF220674
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EF220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTB3G-0005Yo-Kj
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 15:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iTB22-0004ZL-9n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iTB20-0002yw-AP
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:38:58 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:55703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iTB20-0002qU-14
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:38:56 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrPVJ-1i6EkZ2GMp-00oVl6; Fri, 08 Nov 2019 21:38:48 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Q800 branch patches
Date: Fri,  8 Nov 2019 21:38:44 +0100
Message-Id: <20191108203846.8837-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UEq1ImDzzqzeYUjxj7nsNvJ+2czOvG9EfL9jyMEDBO2/cBF3tG2
 mKU1rufddNZe/HdHIcU3AdOKWzfC9xCYrNtTfuFmUZrg6XNZhv3FPJbinMiXmFp8BuhNf0J
 zoBA1NeMXItU9r+4/sO6O58Z6BDFIM15BY0waGOg53t13KhP9yjJ2eMqf/IithUAjCAFeCH
 6zsJAX7E1s7uOXODbYCaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2g08UT3j+MU=:m6/u7k/IheLiMieYVCSJd1
 jk9wkD1J4hQlXQaUjUCIB628nTNy2bbutQG0Oz9+bYXkzVaM1SwIXMNzJzpTfK7fF9AIR0Lum
 V/sebGOizu12YD3BnXROqGQCQz+ZcCSFnx/+amTVhKmVu1ZoPrtxHVm0nH44ZIANHvGT25kPO
 1sb5l4wisq/jH4YixwEj/ZsTzEL32AIq2aohMrABP8IHOsuBkEw2s5QnHgKUi3L4yT5aXP5sG
 beevYAQ7D+ie8OtyEpaButzItNbiMQ6zHF4kPPMeDqMibuB1E2iSmxq3zUZJoJkajF+GkNPDT
 V2WdSc9hVuB88l7AShVoWjNZcEHQfzFJ9fQ2Q2RY9Wsk6qTgzxl61MbPY63mbe77/uX8MFe+9
 KwmG2/8FOnbdyKd8WKreIzGh/lt26yqvYweBgd+3poFH9G7e7CR8rH2AjHQyoZzoLJtX5XFGe
 QEuo2jRszSawFT95wa2LXDg4oVjpQG6KLErpNro2zDr+w+M7tMpUTCI3JcFku8l+IkFiBuEn2
 8n2koM/ZXoGy906uxb6cA/S7pn1r/oAoA//40axgfmWvA8dSqFmzJwVedXU1okr2jEkafL90J
 O0WwVqpwgw388ghsLSBISuOUZPbBDcP6HCSkEDctD3zrfPfrD5lLcrZC7F8b+eu9kT+nVTBkR
 fO7eT1BdN2yM71nmZ121fiKupJp3m/uPdE66vJdXwOtGd9k+ECRmS2ZQ0bOmeVm8dg6k5krji
 JNdQ8emzjfLz6CK+tTQPNIOJpdKStu9+uD5zXilTLl+t6Dwb6WQ+BpegWagORXYVVfm9s91jM
 tOxTq1NwX3kpTFIcj7WjeWyUXyr2fnW91rcDqSAcpjaDFKvcoL5dEZUj6WiHqKF1T28d8nX/Z
 4N1QBXV6zCzPbDvQ19catqVImoe4M1m8X7SVFq/GU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1cee80fa665d37411f8ad8a930b84840bbab62e5:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20191107-pull-request' into staging (2019-11-08 11:00:28 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/q800-branch-pull-request

for you to fetch changes up to c744cf78791e7ddc903a46d6506f1a0cbcbb3387:

  dp8393x: fix dp8393x_receive() (2019-11-08 21:32:31 +0100)

----------------------------------------------------------------
Fix dp8393x when used in big-endian/double-word mode
(fix DHCP address allocation for q800 machine)

----------------------------------------------------------------

Laurent Vivier (2):
  dp8393x: put the DMA buffer in the state structure
  dp8393x: fix dp8393x_receive()

 hw/net/dp8393x.c | 113 ++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 56 deletions(-)

-- 
2.21.0


