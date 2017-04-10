Received: from eggs.gnu.org ([2001:4830:134:3::10]:39993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxU3l-0000tw-09
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxU3f-0000Ob-TH
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:48:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46531
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cxU3f-0000OR-Mj
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:48:19 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3A7iCfa088282
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 03:48:18 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29r4vt300w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 03:48:17 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 17:48:15 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <87k26ska7j.fsf@linaro.org>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<20170408065107.GG27571@umbus>
	<AM5P194MB01292723DDB978AC78F8FDD7C80E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
	<871st1wt9q.fsf@linaro.org>
	<87r310rf6i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<87k26ska7j.fsf@linaro.org>
Date: Mon, 10 Apr 2017 13:17:18 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87mvbor9fd.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: luigi burdo <intermediadc@hotmail.com>, David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "programmingkidx@gmail.com" <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> luigi burdo <intermediadc@hotmail.com> writes:
>>>
>>>> Hi David and Nikuji,
>>>>
>>>> can i suggest to remove the message:
>>>>
>>>>
>>>> Guest not yet converted to MTTCG - you may get unexpected results
>>>> where the mttcg is enabled?
>>>
>>> Have you declared the memory ordering for the guest?
>>
>> No, I havent done that yet, will send a patch.
>
> You also need to update configure so mttcg=3D"yes" (resulting in
> TARGET_SUPPORTS_MTTCG being set for the build).

Yes, I have that patch for ppc64, will send it to the list.

Regards
Nikunj
