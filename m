Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewNBa-0001fz-O2
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewNBW-0000LT-MP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:20:26 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ewNBW-0000KD-Fh
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:20:22 -0400
Received: from player159.ha.ovh.net (unknown [10.109.108.186])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id AE85BB2E4A
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 08:20:20 +0100 (CET)
References: <20180314173336.20055-1-clg@kaod.org>
	<1521071936.5486.0.camel@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3226f1d3-2a03-5c20-28ec-c0c016ae4b8c@kaod.org>
Date: Thu, 15 Mar 2018 08:20:15 +0100
MIME-Version: 1.0
In-Reply-To: <1521071936.5486.0.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: fix tlbsync to
 check privilege level depending on GTSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -4526,7 +4526,7 @@ static void gen_tlbie(DisasContext *ctx)
>>      TCGv_i32 t1;
>>  
>>      if (ctx->gtse) {
>> -        CHK_SV; /* If gtse is set then tblie is supervisor
>> privileged */
>> +        CHK_SV; /* If gtse is set then tlbie is supervisor
>> privileged */
> 
> ^^^ Did that line actually change? :)

It did. Look closer :)

C.
