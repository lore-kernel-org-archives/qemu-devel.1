Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B17C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826862190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826862190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbDx-0005Uj-K3
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:31:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45703)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpbDT-0004yS-Tp
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpbDA-0000Ft-9W
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:31:11 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.76]:18659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hpbAa-0007Ar-TI; Mon, 22 Jul 2019 12:28:13 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 BWP09926081.bt.com (10.36.82.112) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 22
 Jul 2019 17:28:09 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 17:28:10 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 17:28:10 +0100
From: <tony.nguyen@bt.com>
To: <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 00/20] Invert Endian bit in SPARCv9 MMU
 TTE
Thread-Index: AQHVQKLzQYdvLYhbLUSW1HY6Ut95kabWuu6AgAAS8LY=
Date: Mon, 22 Jul 2019 16:28:10 +0000
Message-ID: <1563812889499.73128@bt.com>
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>,
 <2b6eb033-4b6e-4d64-c57e-a3257088d0dd@linaro.org>
In-Reply-To: <2b6eb033-4b6e-4d64-c57e-a3257088d0dd@linaro.org>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.37]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.76
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 00/20] Invert Endian bit in SPARCv9 MMU
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, mst@redhat.com,
 palmer@sifive.com, mark.cave-ayland@ilande.co.uk, Alistair.Francis@wdc.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, sw@weilnetz.de, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 cohuck@redhat.com, claudio.fontana@huawei.com, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/19 8:59 AM, Richard Henderson wrote:

>On 7/22/19 8:34 AM, tony.nguyen@bt.com wrote:
>> Tony Nguyen (20):
>>   tcg: Replace MO_8 with MO_UB alias
>>   tcg: Replace MO_16 with MO_UW alias
>>   tcg: Replace MO_32 with MO_UL alias
>>   tcg: Replace MO_64 with MO_UQ alias
>>   tcg: Move size+sign+endian from TCGMemOp to MemOp
>
>I don't like any of these first 5 patches.
>I don't understand your motivation here.  Why?

The motivation is to only move the attributes required by the memory API
from TCGMemOp into accelerator independent MemOp.

Once I moved MO_{8|16|32|64} into MemOp, there arose many -Wenum-compare an=
d
-Wenum-conversion as a TCGMemOp and a MemOp are being compared and implicit=
ly
coerced.

Thus the idea to replace MO_{8|16|32|64} with MO_{UB|UW|UL|UQ} so we remain
comparing and coercing the same enum type, both TCGMemOps.

Do you prefer the v1 implementation of making TCGMemOp -> MemOp?

Tony.
