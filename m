Received: from eggs.gnu.org ([2001:4830:134:3::10]:43291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxS7T-0003mF-4m
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxS7Q-0002xZ-1R
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:44:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53902
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cxS7P-0002xE-RQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:44:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3A5heaX113377
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 01:44:02 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29qykysdjj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 01:44:01 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 15:43:59 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <871st1wt9q.fsf@linaro.org>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<20170408065107.GG27571@umbus>
	<AM5P194MB01292723DDB978AC78F8FDD7C80E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
	<871st1wt9q.fsf@linaro.org>
Date: Mon, 10 Apr 2017 11:13:01 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87r310rf6i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, luigi burdo <intermediadc@hotmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "programmingkidx@gmail.com" <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> luigi burdo <intermediadc@hotmail.com> writes:
>
>> Hi David and Nikuji,
>>
>> can i suggest to remove the message:
>>
>>
>> Guest not yet converted to MTTCG - you may get unexpected results
>> where the mttcg is enabled?
>
> Have you declared the memory ordering for the guest?

No, I havent done that yet, will send a patch.

>> another thing im finding  is this message
>> Guest expects a stronger memory ordering than the host provides
>> This may cause strange/hard to debug errors
>
> See ca759f9e387db87e1719911f019bc60c74be9ed8 for an example.

Regards
Nikunj
