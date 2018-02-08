Received: from eggs.gnu.org ([2001:4830:134:3::10]:51720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejoAC-0002S5-IN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejoA8-0002BI-Q5
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:31:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ejoA8-0002Ay-Ho
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:31:00 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18FQeHH134393
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 10:30:57 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g0s6n07jn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 10:30:57 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 15:30:54 -0000
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<3e34d51f-e4d1-a69b-1fac-c4d1982834c2@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 16:30:52 +0100
MIME-Version: 1.0
In-Reply-To: <3e34d51f-e4d1-a69b-1fac-c4d1982834c2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <4fd72954-ed19-fe96-f7b6-d238a373c71c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 08.02.2018 16:19, Eric Blake wrote:
>=20
> Missing a documentation line that mentions when the enum grew. Also, ha=
s
> a conflict with this other proposed addition, which demonstrates what
> the documentation should look like (should be easy to resolve, though):
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01986.html
>=20
Good pointer, thanks. So the enum conflict would be resolved on a
first-to-ack base?
>=20
>> =C2=A0 ##
>> +# @CpuInfoS390State:
>> +#
>> +# An enumeration of cpu states that can be assumed by a virtual
>> +# S390 CPU
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'enum': 'CpuInfoS390State',
>> +=C2=A0 'data': [ 'uninitialized', 'stopped', 'check_stop', 'operating=
',
>> 'load' ] }
>> +
>=20
> Is there a consistency reason for naming this 'check_stop', or can we g=
o
> with our preference for using dash 'check-stop'?
No specific reason, I've based that on the definitions previously in
target/s390x/cpu.h, same thing for cpu-state. Will update.
>=20
>> +##
>> +# @CpuInfoS390:
>> +#
>> +# Additional information about a virtual S390 CPU
>> +#
>> +# @cpu_state: the CPUs state
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'CpuInfoS390', 'data': { 'cpu_state': 'CpuInfoS390State' =
} }
>=20
> Likewise for 'cpu-state'
>=20


--=20
Regards,
 Viktor Mihajlovski
