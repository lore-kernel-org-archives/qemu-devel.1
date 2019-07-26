Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8C5C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31877206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31877206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqtKU-00045d-G9
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 02:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53246)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hqtKI-0003hU-Bh
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hqtKG-000484-76
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:03:34 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.71]:57753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hqtJu-0002vb-Gx; Fri, 26 Jul 2019 02:03:10 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 BWP09926076.bt.com (10.36.82.107) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 26
 Jul 2019 07:03:05 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 26 Jul 2019 07:03:05 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 26 Jul
 2019 07:03:05 +0100
From: <tony.nguyen@bt.com>
To: <philmd@redhat.com>, <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 02/15] memory: Access MemoryRegion with
 MemOp
Thread-Index: AQHVQs6us5Ke12ptjEW1c49AzysqcKbbJooAgAE/RY4=
Date: Fri, 26 Jul 2019 06:03:05 +0000
Message-ID: <1564120985317.14967@bt.com>
References: <45d1ebe4b2ed4c039c9da20a738652df@tpw09926dag18e.domain1.systemhost.net>
 <1564048354001.54262@bt.com>, <ee5949da-4457-0560-4525-40e4d4aaef4a@redhat.com>
In-Reply-To: <ee5949da-4457-0560-4525-40e4d4aaef4a@redhat.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.42]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.71
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 02/15] memory: Access MemoryRegion with
 MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 david@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 rth@twiddle.net, atar4qemu@gmail.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 shorne@gmail.com, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 9:45 PM, Philippe Mathieu-Daud=E9 wrote:
>On 7/25/19 11:52 AM, tony.nguyen@bt.com wrote:
>> Replacing size with size+sign+endianness (MemOp) will enable us to
>> collapse the two byte swaps, adjust_endianness and handle_bswap, along
>> the I/O path.
>>
>> While interfaces are converted, callers will have existing unsigned
>> size coerced into a MemOp, and the callee will use this MemOp as an
>> unsigned size.
>>
>> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
>> ---
>>  include/exec/memop.h  | 4 ++++
>>  include/exec/memory.h | 9 +++++----
>>  memory.c              | 7 +++++--
>>  3 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/exec/memop.h b/include/exec/memop.h
>> index ac58066..09c8d20 100644
>> --- a/include/exec/memop.h
>> +++ b/include/exec/memop.h
>> @@ -106,4 +106,8 @@ typedef enum MemOp {
>>      MO_SSIZE =3D MO_SIZE | MO_SIGN,
>>  } MemOp;
>>
>> +/* No-op while memory_region_dispatch_[read|write] is converted to MemO=
p */
>> +#define MEMOP_SIZE(op)  (op)    /* MemOp to size.  */
>> +#define SIZE_MEMOP(ul)  (ul)    /* Size to MemOp.  */
>
>SIZE_MEMOP() is never used until patch #10 "memory: Access MemoryRegion
>with MemOp semantics", it would be clearer to only introduce the
>MEMOP_SIZE() no-op here, and directly introduce the correct SIZE_MEMOP()
>macro in patch #10.

SIZE_MEMOP() is used, and is the main change, in patches #3 to #10. Perhaps=
 you
meant MEMOP_SIZE()?

Either way, you have raised an issue :)

There is a lack of clarity in how the two macros are used to update the
interfaces.?

