Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F77C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C9B20665
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C9B20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ocmigroup.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmtX-0006sk-1F
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Ilver.Belletti@ocmigroup.com>) id 1iClaD-0001PG-63
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Ilver.Belletti@ocmigroup.com>) id 1iClaB-00008T-Cn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:14:24 -0400
Received: from mail.ocmigroup.com ([89.96.158.60]:13466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Ilver.Belletti@ocmigroup.com>)
 id 1iClaB-00007b-6F
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:14:23 -0400
Received: from MSG00.local.ocmigroup.com (192.168.1.5) by
 MSG00.local.ocmigroup.com (192.168.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 24 Sep 2019 16:14:20 +0200
Received: from MSG00.local.ocmigroup.com ([fe80::dca9:1345:3c29:d411]) by
 MSG00.local.ocmigroup.com ([fe80::dca9:1345:3c29:d411%11]) with mapi id
 15.00.1497.000; Tue, 24 Sep 2019 16:14:20 +0200
From: Ilver Belletti <Ilver.Belletti@ocmigroup.com>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Subject: pcmcia support windows xp 32 bit guest
Thread-Topic: pcmcia support windows xp 32 bit guest
Thread-Index: AdVy4lr8H6P4T0GBTjuZkwcPjKU+Mw==
Date: Tue, 24 Sep 2019 14:14:19 +0000
Message-ID: <9531684a8f004efeb8013bc048125617@MSG00.local.ocmigroup.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.95]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 89.96.158.60
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We would like to install Windows XP 32 bit as a guest operating system in a=
 Windows 10 64 bit host operating system. With the QEMU emulator will be th=
e pcmcia slot available ?
We would like to use an epp parallel port in the guest operating system by =
means of Quatech pcmcia card installed in the slot.

Best Regards
Ilver Belletti
Ocmi-Otg

