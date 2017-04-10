Received: from eggs.gnu.org ([2001:4830:134:3::10]:59261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxTUk-0001Gg-4n
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxTUg-0002TE-WE
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:12:14 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxTUg-0002SQ-OG
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:12:10 -0400
Received: by mail-wr0-x234.google.com with SMTP id c55so68602152wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 00:12:10 -0700 (PDT)
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<20170408065107.GG27571@umbus>
	<AM5P194MB01292723DDB978AC78F8FDD7C80E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
	<871st1wt9q.fsf@linaro.org>
	<87r310rf6i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87r310rf6i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Date: Mon, 10 Apr 2017 08:12:16 +0100
Message-ID: <87k26ska7j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: luigi burdo <intermediadc@hotmail.com>, David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "programmingkidx@gmail.com" <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>


Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> Alex Bennée <alex.bennee@linaro.org> writes:
>
>> luigi burdo <intermediadc@hotmail.com> writes:
>>
>>> Hi David and Nikuji,
>>>
>>> can i suggest to remove the message:
>>>
>>>
>>> Guest not yet converted to MTTCG - you may get unexpected results
>>> where the mttcg is enabled?
>>
>> Have you declared the memory ordering for the guest?
>
> No, I havent done that yet, will send a patch.

You also need to update configure so mttcg="yes" (resulting in
TARGET_SUPPORTS_MTTCG being set for the build).
>
>>> another thing im finding  is this message
>>> Guest expects a stronger memory ordering than the host provides
>>> This may cause strange/hard to debug errors
>>
>> See ca759f9e387db87e1719911f019bc60c74be9ed8 for an example.
>
> Regards
> Nikunj


--
Alex Bennée
