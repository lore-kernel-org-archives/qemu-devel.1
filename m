Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178AC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 03:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00F92075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 03:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="ShCFWnmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00F92075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFsbW-0001nQ-1K
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 23:48:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hFsaP-0001UD-P6
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hFsaO-0000mp-OB
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:47:13 -0400
Received: from pv50p00im-ztdg10021801.me.com ([17.58.6.56]:55618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hFsaO-0000ls-BP
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
	t=1555300029; bh=XPPhwHPrDeRzxkTP3K9UsRju/Oe26cMXHsa0BrEqDM0=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
	b=ShCFWnmdX5HliYxsPYF49pushLlCfzMSXK0xO/1QyTogyCSo+uCphvmovBrEi7wX+
	pFjU2LkqgsBTZKcxW2SIR5fxsqanO3l0KWi3lofHRq407Tm2BP2QiUA/7M/P5R/wT3
	jF/T9VldPZc4seFRRm0WkvVytgZqGSyOI3PHSrVNfq+J5fvLcVdJ1iqdPkUiHg60bK
	47WbY0G2mghQWdpn9D65YHSuEi/OUnS55UNTTKFqOxqVu8eBVzKlrcACX6KTeKCMKg
	1mo+xoYCBwgunX4PuN7h77pGjSQsoWB+86LGSMR4j4cUtwxWlELpQdLsA3jm2knB6l
	l6tbuQxwJQVvA==
Received: from [172.18.2.102] (unknown [36.106.166.64])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 02A8C3600F2; 
	Mon, 15 Apr 2019 03:47:08 +0000 (UTC)
Message-Id: <3E4F522E-55ED-4DC4-88D5-8F1D68E68A84@me.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Date: Mon, 15 Apr 2019 11:46:36 +0800
In-Reply-To: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
To: QEMU Developers <qemu-devel@nongnu.org>
References: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-15_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
	mlxlogscore=833 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1812120000 definitions=main-1904150023
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/2] ui/cocoa: Fix absolute and relative
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415034636.g4ehx12Hinv5jekYjKkj2SqHUxrWLg4bZXYDIdCcmQQ@z>

ping

> On Apr 8, 2019, at 10:04 AM, Chen Zhang <tgfbeta@me.com> wrote:
>=20
> The following patches fixed absolute and relative input device issues =
on macOS Mojave.
>=20
> Chen Zhang (2):
>   ui/cocoa: Fix absolute input device grabbing issue on Mojave
>   ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
>     device
>=20
>  ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.19.2
>=20

