Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC184C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADE221848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADE221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18ma-0002pk-BC
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i18d4-0004Em-Rd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i18d2-0005TR-MK
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:25:18 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.237]:6467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i18d0-0005OO-Lf
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:25:16 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 RDW083A010ED66.bt.com (10.187.98.36) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 23 Aug 2019 13:24:09 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 23 Aug 2019 13:25:11 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 23 Aug
 2019 13:25:11 +0100
From: <tony.nguyen@bt.com>
To: <richard.henderson@linaro.org>, <tony.nguyen.git@mail.com>,
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v9 00/20] Invert Endian bit in SPARCv9 MMU
 TTE
Thread-Index: AQHVWU6LOrc/WP67T026hAHgzbhjl6cH8eEAgAC2Sc8=
Date: Fri, 23 Aug 2019 12:25:11 +0000
Message-ID: <1566563109661.99467@bt.com>
References: <cover.1566466906.git.tony.nguyen@bt.com>,
 <a61e429b-6493-3ad0-cd22-07832dbcc1f7@linaro.org>
In-Reply-To: <a61e429b-6493-3ad0-cd22-07832dbcc1f7@linaro.org>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.237
Subject: Re: [Qemu-devel] [PATCH v9 00/20] Invert Endian bit in SPARCv9 MMU
 TTE
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

On 8/22/19 12:29 PM, Richard Henderson wrote:=0A=
> So... after an hour only the cover letter has arrived.=0A=
> I'm thinking that it didn't work.=0A=
=0A=
Frustratingly, I keep getting blocked.=0A=
=0A=
Perhaps new GMail and Mail.com accounts sending in bulk on behalf of bt.com=
=0A=
falls foul of spam filters.=0A=
=0A=
*sigh*=0A=
=0A=
I am mindful tcg-next has a subset of the series.=0A=
=0A=
Again, thanks for the patience. =0A=
=0A=
Warm Regards,=0A=
Tony=

