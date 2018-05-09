Received: from eggs.gnu.org ([2001:4830:134:3::10]:37062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fGGud-0007t2-Kt
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fGGuY-0004LF-Kf
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:41:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54982
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fGGuY-0004I1-EW
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:41:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w494dF6U135842
	for <qemu-devel@nongnu.org>; Wed, 9 May 2018 00:41:04 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hura7v1ny-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 00:41:04 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 8 May 2018 22:41:03 -0600
Received: from b03ledav004.gho.boulder.ibm.com
	(b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id w494f15P9699586
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 21:41:01 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4CC78043
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 22:41:01 -0600 (MDT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.193.83])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP id 0F7FC78037
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 22:41:00 -0600 (MDT)
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<20180507033214.19219-2-zyimin@linux.ibm.com>
	<e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
	<20180508103704.GK5967@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Wed, 9 May 2018 12:40:56 +0800
MIME-Version: 1.0
In-Reply-To: <20180508103704.GK5967@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <08334b5d-7bc3-befc-65af-0aae6d134e6d@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] sandbox: avoid to compile options if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



=E5=9C=A8 2018/5/8 =E4=B8=8B=E5=8D=886:37, Daniel P. Berrang=C3=A9 =E5=86=
=99=E9=81=93:
> On Mon, May 07, 2018 at 01:04:17PM -0500, Eric Blake wrote:
>> On 05/06/2018 10:32 PM, Yi Min Zhao wrote:
>>
>> In the subject line: s/avoid to compile/avoid compiling/
>>
>>> If CONFIG_SECCOMP is undefined, the option 'elevatorprivileges' remai=
ns
>> s/elevator/elevate/
>>
>>> complied. This would make libvirt set the corresponding capability an=
d
>> s/complied/compiled/
>>
>>> then trigger the guest startup fails. So let's wrap the options with
>>> CONFIG_SECCOMP.
>>>
>>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>>> ---
>>>    vl.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/vl.c b/vl.c
>>> index fce1fd12d8..cb07b19c02 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -268,6 +268,7 @@ static QemuOptsList qemu_sandbox_opts =3D {
>>>                .name =3D "enable",
>>>                .type =3D QEMU_OPT_BOOL,
>>>            },
>>> +#ifdef CONFIG_SECCOMP
>>>            {
>>>                .name =3D "obsolete",
>>>                .type =3D QEMU_OPT_STRING,
>>> @@ -284,6 +285,7 @@ static QemuOptsList qemu_sandbox_opts =3D {
>>>                .name =3D "resourcecontrol",
>>>                .type =3D QEMU_OPT_STRING,
>>>            },
>>> +#endif
>> The commit message mentions only 'elevateprivileges' (once the typo is
>> fixed), but you are also crippling 'obsolete', 'spawn', and
>> 'resourcecontrol'.  Perhaps the commit message should call that out be=
tter?
>> Or, since libvirt is looking at just 'elevateprivileges', per this lin=
e in
>> libvirt's qemu_capabilities.c:
>>
>> src/qemu/qemu_capabilities.c:    { "sandbox", "elevateprivileges",
>> QEMU_CAPS_SECCOMP_BLACKLIST },
>>
>> is it sufficient to just mask out that one option?
> If seccomp is disabled, we should really disable the entire -sandbox
> argument, not merly the options to it.
I think it would bring a lot of changes if disable the entire -sandbox=20
argument.
Looking from current code, sandbox is a default qemu option group, and=20
sandbox.enable is false by default unless you obviously define it with tr=
ue.
So, this patch is an easier way to fixup.
>
> Regards,
> Daniel
