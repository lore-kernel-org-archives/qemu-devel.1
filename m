Received: from eggs.gnu.org ([209.51.188.92]:55165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hEhEh-0000Bv-Ar
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hEhEf-0000mi-MN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:27:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hEhEf-0000lt-7Y
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:27:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BLFhFG015447
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 17:27:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rtc9v300t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 17:27:49 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 11 Apr 2019 22:27:48 +0100
From: Eric Farman <farman@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
Date: Thu, 11 Apr 2019 17:27:42 -0400
MIME-Version: 1.0
In-Reply-To: <4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <571b9f8c-cfb0-704e-ded4-8661a8136876@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 4/10/19 10:59 PM, Eric Farman wrote:
>=20
>=20
> On 4/9/19 7:34 PM, Halil Pasic wrote:
>> On Mon, 8 Apr 2019 19:07:47 +0200

...snip...

>> I'm just running fio on a pass-through DASD and on some virto-blk disk=
s
>> in parallel. My QEMU is today's vfio-ccw-caps from your repo.
>>
>> I see stuff like this:
>> qemu-git: vfio-ccw: wirte I/O region failed with errno=3D16[1811/7332/=
0=20
>> iops] [eta 26m:34s]
>=20
> Without knowing what the I/O was that failed, this is a guessing game.=20
> But I encountered something similar just now running fio.
>=20
> qemu:
> 2019-04-11T02:06:09.524838Z qemu-system-s390x: vfio-ccw: wirte I/O=20
> region failed with errno=3D16

...snip...

>  From the associated I/O, I think this is fixed by a series I am nearly=
=20
> ready to send for review.=C2=A0 I'll try again with those fixes on top =
of the=20
> two series here, and report back.

So, I've run enough combinations to feel comfortable saying that the=20
error (EBUSY) I saw last night (and presumably the one Halil saw) exists=20
in today's code and is not introduced by this series.  It also appears=20
to be addressed by one of the patches in a series I'm working on, but=20
which that series still has some further problems.  Sigh, there are too=20
many branches and too many interrupts.

  - Eric
