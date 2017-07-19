Received: from eggs.gnu.org ([2001:4830:134:3::10]:41247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dXjOQ-0006Fe-8m
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dXjON-0000Zp-3k
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42750
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujbjl@linux.vnet.ibm.com>)
	id 1dXjOM-0000ZU-UW
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J7OMva136523
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 03:27:30 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bspja2ubu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 03:27:29 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <liujbjl@linux.vnet.ibm.com>;
	Wed, 19 Jul 2017 03:27:29 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
	<96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
From: Jing Liu <liujbjl@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 15:27:39 +0800
MIME-Version: 1.0
In-Reply-To: <96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b77f50e6-e8ce-75c3-bd1e-7cae3a4cee68@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>



On 2017/7/19 =E4=B8=8A=E5=8D=882:07, John Snow wrote:
>
> On 07/17/2017 11:01 PM, Jing Liu wrote:
>> Hi all,
>>
>> Do you anybody have iotests failure: 188, 189 and 087 of the latest qe=
mu
>> upsteam?
>>
>> I just wondered if it has something wrong with my test machines becaus=
e
>> I have different results with two machines.
>>
>>
>> Thanks.
>>
>> Jing
>>
>>
> Presumably you are missing aio=3Dnative support for 087,
>
> and 188/189 I believe require compression and/or LUKS libraries.
Hi John,

Yes, I indeed miss some crypto libraries.
Thank you for your support. Now all of them are fixed.

Jing
> These are false positives caused by missing libraries. We should
> probably work out a proper solution to meaningfully skipping tests we
> didn't compile support for.
>
> --js
>
