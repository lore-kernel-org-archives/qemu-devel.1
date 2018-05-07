Received: from eggs.gnu.org ([2001:4830:134:3::10]:39832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fFgAv-0006Tb-Bk
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fFgAs-0007WT-54
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:27:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33236
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fFgAr-0007Vi-Vt
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:27:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w47DOrE4003040
	for <qemu-devel@nongnu.org>; Mon, 7 May 2018 09:27:29 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2htp18cqw2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 09:27:29 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Mon, 7 May 2018 09:27:28 -0400
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<20180507033214.19219-2-zyimin@linux.ibm.com>
	<20180507103108.GD17261@vader>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Mon, 7 May 2018 21:27:17 +0800
MIME-Version: 1.0
In-Reply-To: <20180507103108.GD17261@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f6e4ea40-a321-7157-23f7-a0212e47692a@linux.ibm.com>
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
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com



=E5=9C=A8 2018/5/7 =E4=B8=8B=E5=8D=886:31, Eduardo Otubo =E5=86=99=E9=81=93=
:
> On 07/05/2018 - 11:32:14, Yi Min Zhao wrote:
>> If CONFIG_SECCOMP is undefined, the option 'elevatorprivileges' remain=
s
>> complied. This would make libvirt set the corresponding capability and
>> then trigger the guest startup fails. So let's wrap the options with
>> CONFIG_SECCOMP.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> ---
>>   vl.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/vl.c b/vl.c
>> index fce1fd12d8..cb07b19c02 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -268,6 +268,7 @@ static QemuOptsList qemu_sandbox_opts =3D {
>>               .name =3D "enable",
>>               .type =3D QEMU_OPT_BOOL,
>>           },
>> +#ifdef CONFIG_SECCOMP
>>           {
>>               .name =3D "obsolete",
>>               .type =3D QEMU_OPT_STRING,
>> @@ -284,6 +285,7 @@ static QemuOptsList qemu_sandbox_opts =3D {
>>               .name =3D "resourcecontrol",
>>               .type =3D QEMU_OPT_STRING,
>>           },
>> +#endif
>>           { /* end of list */ }
>>       },
>>   };
>> --=20
>> 2.15.1 (Apple Git-101)
>>
> Acked-by: Eduardo Otubo <otubo@redhat.com>
>
>
Thanks for your review!
