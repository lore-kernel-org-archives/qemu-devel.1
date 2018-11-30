Received: from eggs.gnu.org ([2001:4830:134:3::10]:52196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSqgt-0007E2-Cw
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSqgq-0000Tm-7d
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:51:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gSqgp-0000MU-Qf
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:51:12 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAULhncd112077
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 16:51:09 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p3cewajh3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 16:51:09 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 30 Nov 2018 21:51:08 -0000
References: <cover.1543610035.git.alifm@linux.ibm.com>
	<3130ecca88d5f7d97860c05cf1346164938cb15d.1543610035.git.alifm@linux.ibm.com>
	<cbd1ca87-b547-5649-7449-2f4de203dfd9@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 30 Nov 2018 16:51:04 -0500
MIME-Version: 1.0
In-Reply-To: <cbd1ca87-b547-5649-7449-2f4de203dfd9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <4337f943-4a18-87f2-b67a-880db4e2e564@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for 3.1? or 4 v3 1/1] qemu-iotests: Don't run
 the test when user is root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, kwolf@redhat.com



On 11/30/2018 03:52 PM, Eric Blake wrote:
> On 11/30/18 2:37 PM, Farhan Ali wrote:
>> Test 232 creates image files with read-only permission and
>> expects an error message when trying to access the image
>> files with read-only and auto-read-only turned off.
>>
>> Don't run as root user, since root can open files with read/write
>> access for read-only files.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>> =C2=A0 tests/qemu-iotests/232 | 5 +++++
>> =C2=A0 1 file changed, 5 insertions(+)
>=20
> Did you mean to keep RFC in the subject line?=C2=A0 Will patchew even s=
pot it=20
> without PATCH in the subject line?
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
Thanks for reviewing the patch. I am not sure if patchew will pick it=20
up; I have no problem in spinning another patch but I will wait till=20
Monday to see if anyone else has any feedback.

Thanks
Farhan
