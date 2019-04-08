Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE8C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B011220879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="gBmQrt2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B011220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDJfU-0005oK-Ue
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 22:05:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hDJeh-0005Qb-FE
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hDJeg-0005cU-FU
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:05:03 -0400
Received: from pv50p00im-ztbu10011701.me.com ([17.58.6.53]:55693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hDJeg-0005bk-2d
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1554689099; bh=Hmjg+4QgXUOXa7/ll6IqOgen4cRvCajEiDvxlnkvvIM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=gBmQrt2HDcDAQLfn6b9ThAJdx7zscdvLgPRTMpnwgI8nNkYGdcYPdtFrKOpsnu5yG
	FGTSsCxDfNYkRJjnYhUOtCfHyxWItZqHlRk/6fec5k6KJAB59J/bS54RykwmEL/Yqm
	gc2hU0nvujcF4mlvjawopqY5q/y1Ot6S0Iw51m6aJVqgjj48hIa+PMaZo4NScZUabJ
	xftncWnPq/njGa+eUHFUOf+qAS7fxzYM8p8+cg/1UkrojvJG9Mkc8KpOutpXonuZvF
	Qx4Xxq7YK7+aJUSRxlnBTfufpgFSJRF3cYaRb7tfJxMchUZCN4kODWnhOO+8OMxbU7
	hMsH/tyOLaUjg==
Received: from [172.18.2.102] (unknown [36.106.167.87])
	by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 96F248A00DD; 
	Mon,  8 Apr 2019 02:04:57 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
Date: Mon, 8 Apr 2019 10:04:52 +0800
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-08_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
	mlxlogscore=678 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1904080017
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH 0/2] ui/cocoa: Fix absolute and relative input
 issues on Mojave
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408020452.cWodY8GW2oZuExsMZCIeNcqgDfDFNBn-qwcVgcMvhpk@z>

The following patches fixed absolute and relative input device issues on =
macOS Mojave.

Chen Zhang (2):
  ui/cocoa: Fix absolute input device grabbing issue on Mojave
  ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
    device

 ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

--=20
2.19.2

