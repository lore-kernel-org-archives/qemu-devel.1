Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E90C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4F621926
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4F621926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpOrG-0004fQ-Rt
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 23:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpOr7-0004Gv-7c
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpOr6-0001D7-A1
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:19:17 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.79]:27695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hpOr6-0001BZ-3m
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:19:16 -0400
Received: from tpw09926dag18g.domain1.systemhost.net (10.9.212.34) by
 BWP09926084.bt.com (10.36.82.115) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 22
 Jul 2019 04:19:30 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18g.domain1.systemhost.net (10.9.212.34) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 04:19:13 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 04:19:12 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 0/2] configure: Define target access
 alignment in configure
Thread-Index: AQHVQDw7L2EsUAsHPEekRAPok1iKQQ==
Date: Mon, 22 Jul 2019 03:19:12 +0000
Message-ID: <945056df7ff54ce6b272dce64721d916@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.37]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.79
Subject: [Qemu-devel] [PATCH v2 0/2] configure: Define target access
 alignment in configure
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
Cc: ehabkost@redhat.com, arikalo@wavecomp.com, mark.cave-ayland@ilande.co.uk,
 jcmvbkbc@gmail.com, atar4qemu@gmail.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the define of target access alignment earlier from=0A=
target/foo/cpu.h to configure.=0A=
=0A=
Suggested in Richard Henderson's reply to "[PATCH 1/4] tcg: TCGMemOp=0A=
is now accelerator independent MemOp"=0A=
=0A=
Analysed target/foo/cpu.h for more candidates to define earlier but        =
                 =0A=
did not spot any other straight forward predicates.=0A=
=0A=
Possible future clean ups:=0A=
- TCG_GUEST_DEFAULT_MO and TCG_TARGET_DEFAULT_MO seems like duplicates=0A=
- TARGET_INSN_START_EXTRA_WORDS 1 seems redundant as ifndef value is 1=0A=
=0A=
v2:=0A=
- split cosmetic changes into separate patch=0A=
- cc corresponding maintainers=0A=
=0A=
Thanks to Aleksandar Markovic for the guide in v1 =3D)=0A=
=0A=
Tony Nguyen (2):=0A=
  configure: Define TARGET_ALIGNED_ONLY earlier=0A=
  configure: Cosmetic yes to "yes" for consistency=0A=
=0A=
 configure             | 12 ++++++++++--=0A=
 include/exec/poison.h |  1 +=0A=
 include/qom/cpu.h     |  2 +-=0A=
 target/alpha/cpu.h    |  2 --=0A=
 target/hppa/cpu.h     |  1 -=0A=
 target/mips/cpu.h     |  2 --=0A=
 target/sh4/cpu.h      |  2 --=0A=
 target/sparc/cpu.h    |  2 --=0A=
 target/xtensa/cpu.h   |  2 --=0A=
 tcg/tcg.c             |  2 +-=0A=
 tcg/tcg.h             |  8 +++++---=0A=
 11 files changed, 18 insertions(+), 18 deletions(-)=0A=
=0A=
-- =0A=
1.8.3.1=

