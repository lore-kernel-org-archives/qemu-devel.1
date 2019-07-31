Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71FDC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9828320693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9828320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsjr7-0005zo-RW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 04:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37933)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hsjqk-0005a2-Lh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hsjqj-00061n-O5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:20:42 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.235]:13949)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hsjqj-000614-Iz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:20:41 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 RDW083A011ED67.bt.com (10.187.98.37) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 31 Jul 2019 09:25:59 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 31 Jul 2019 09:20:38 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Wed, 31 Jul
 2019 09:20:38 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 0/1] configure: Define target access
 alignment in configure
Thread-Index: AQHVR3jVuZzJ9tFLT0SwlztPFbLfTw==
Date: Wed, 31 Jul 2019 08:20:38 +0000
Message-ID: <2aaac4eafedb4aec979657993d00b8cd@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.44]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.235
Subject: [Qemu-devel] [PATCH v4 0/1] configure: Define target access
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
Analysed target/foo/cpu.h for more candidates to define earlier but=0A=
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
v3:=0A=
- dropped cosmetic changes=0A=
- improved commit message=0A=
=0A=
v4:=0A=
- further improved commit message=0A=
=0A=
Tony Nguyen (1):=0A=
  configure: Define TARGET_ALIGNED_ONLY in configure=0A=
=0A=
 configure             | 10 +++++++++-=0A=
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
 11 files changed, 17 insertions(+), 17 deletions(-)=0A=
=0A=
-- =0A=
2.22.0=0A=

