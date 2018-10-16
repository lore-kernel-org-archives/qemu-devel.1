Received: from eggs.gnu.org ([2001:4830:134:3::10]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gCOyb-00051e-MO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gCOyS-0007Cg-6w
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:01:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37550
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gCOyL-0006n7-RU
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:01:19 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9GD0QU0030450
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 09:01:04 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n5ej25h05-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 09:00:59 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 16 Oct 2018 07:00:56 -0600
References: <cover.1539020852.git.alifm@linux.ibm.com>
	<4e79b7522a0da8a5635024a97f3b04cfd64fe900.1539020852.git.alifm@linux.ibm.com>
	<f851ad95-5bcc-f186-0806-571fb3ba1a40@redhat.com>
	<f1949902-8cfe-b9c0-0cc3-f680893dc025@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 16 Oct 2018 09:00:51 -0400
MIME-Version: 1.0
In-Reply-To: <f1949902-8cfe-b9c0-0cc3-f680893dc025@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <3b194f1b-a97b-d453-8abe-37828369d73f@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v1 1/1] qemu-iotests: Fix output for testcase
 082
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, marcandre.lureau@redhat.com



On 10/15/2018 11:45 AM, Max Reitz wrote:
>> 082 is failing for me on master (046936ed), and this fixes it.
>>
>> I'm wondering if/why other people are not running into this, as 082 ru=
ns
>> with qcow2 and is included on `make check-block`.
>>
>> + Max,
>>
>> FIY, I ran into this while reviewing/testing your Python 3 series.
>>
>> Tested-by: Cleber Rosa<crosa@redhat.com>
> Thanks for CC-ing me, Cleber.
>=20
> Farhan, I disagree with this fix, as I wrote here:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg01488.html
>=20
> I don't like the new output, so I think what we should do is change the
> code that produces it.  Marc-Andr=C3=A9 seemed to agree, so I just need=
 to
> write a patch (which I didn't get to so far).
>=20
> Max
>=20

Hi Max,

That is fine with me. The reason I sent this patch out as an RFC was=20
because I wasn't sure about the fix. So for the time being is it okay=20
for the test to fail? And if you do submit a patch, would you kindly cc=20
me as well.

Thank you
Farhan
