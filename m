Received: from eggs.gnu.org ([2001:4830:134:3::10]:43677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dXeuC-0006hn-PR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 22:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dXeu9-0001hh-Nl
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 22:40:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59128
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujbjl@linux.vnet.ibm.com>)
	id 1dXeu9-0001hL-Iu
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 22:40:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J2d9S2086895
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 22:40:00 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bspj9t4gf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 22:40:00 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <liujbjl@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 22:39:59 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
	<93a523dc-0cf4-c73b-518d-ef48e9f8ca64@redhat.com>
From: Jing Liu <liujbjl@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 10:40:11 +0800
MIME-Version: 1.0
In-Reply-To: <93a523dc-0cf4-c73b-518d-ef48e9f8ca64@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6e17b13f-e903-2073-409c-2442c734251d@linux.vnet.ibm.com>
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Hi Eric,


On 2017/7/18 =E4=B8=8B=E5=8D=8810:57, Eric Blake wrote:
> On 07/17/2017 10:01 PM, Jing Liu wrote:
>> Hi all,
>>
>> Do you anybody have iotests failure: 188, 189 and 087 of the latest qe=
mu
>> upsteam?
>>
>> I just wondered if it has something wrong with my test machines becaus=
e
>> I have different results with two machines.
> It might help to show the ./check command line you are using, as well a=
s
> the errors you are getting.  Right now, master is failing on 51, 140,
> and 143 when I test across './check -raw', './check -qcow2', and
> './check nbd',
I used ./check -qcow2 to do it.
I tested on different machines and got different results. One is failed=20
on 140 and 143. The other one told
me 087, 140, 143, 188, 189.
I guess it is because some configuration or libraries, and will also=20
refer to other replies from the mail.
I'll check the details.

Thank you so much.

Jing


> but not the three you mention.  But the iotests framework
> allows a lot more combinations of testing (and we probably have some
> lurking testsuite bugs on some of the more exotic combinations).
>
