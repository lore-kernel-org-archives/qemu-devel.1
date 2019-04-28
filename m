Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE00CC43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 03:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D02E2077B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 03:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="4llB6g3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D02E2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39262 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKafo-0003fy-05
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 23:40:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hKacz-0001sm-4c
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hKaVt-00051a-E3
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:30:02 -0400
Received: from pv50p00im-ztdg10011901.me.com ([17.58.6.50]:35124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hKaVt-00050l-5f
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1556422199; bh=vKEhVoXlBYyH8XNx4TvLasowpT7v8MJAtuQDfP8V/6U=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=4llB6g3RBfCtc+LKICDJMz6qyP4DwYwQw3ODrdnbDE6jqFaro01T7tTZmOdOgQWpo
	9nTWzWF9GDjRqaA5nUk1sTfWe+pLY2YxtDNF+mTDBZZZvpWtdwsUBi/0De43NdM5yq
	chrvdoepVlD50xRx0SQ/JF0DSUCSQPskld0YKE+qhE2HMTfuth8mLK8DqBjrTGDRRm
	sFBH87CDjbxmqFVdhhhvq5YMKBuACagMlXgx9ac61T5c2ow4ib5ywQGdlEid30ikP7
	OYuQ9pdLKIDzsJfE0TkVuNLXbgR63itj3s1N0UiceErXeAiZYErdKsYejqmeR9TrDB
	GzJep4koQ+4rQ==
Received: from [172.18.2.102] (unknown [36.106.167.46])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 4DAE2800011; 
	Sun, 28 Apr 2019 03:29:58 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
Date: Sun, 28 Apr 2019 11:29:54 +0800
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-28_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
	mlxlogscore=724 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1904280022
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH RESEND 0/2] ui/cocoa: Fix absolute and relative
 input issues on Mojave
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
Message-ID: <20190428032954.VINEtsJMhAXKqp-W7qg2T9oVs_sLREgj9-viA7un_Ag@z>

The following patches fixed absolute and relative input device issues on =
macOS Mojave.

Chen Zhang (2):
  ui/cocoa: Fix absolute input device grabbing issue on Mojave
  ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
    device

 ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

--=20
2.19.2=
