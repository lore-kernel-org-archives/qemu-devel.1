Received: from eggs.gnu.org ([2001:4830:134:3::10]:46511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebTDz-0008DI-EY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebTDt-0006Yj-TJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:32:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ebTDt-0006Y7-Ks
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:32:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GFVoaO000996
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:32:24 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fhjf4ntdx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:32:19 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 08:32:19 -0700
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
	<34c87c41-eb49-0e2b-3857-9bb3ba86c8d4@redhat.com>
	<e0653416-ea6a-f801-2c30-4d01ed1fcf42@linux.vnet.ibm.com>
	<b0f8289b-287b-a0c5-ab85-82e6c39d24b9@de.ibm.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 10:32:14 -0500
MIME-Version: 1.0
In-Reply-To: <b0f8289b-287b-a0c5-ab85-82e6c39d24b9@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b86618f5-e5cb-8953-508f-e73339b1a475@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/8] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com

On 01/16/2018 06:07 AM, Christian Borntraeger wrote:
>
> On 01/15/2018 06:23 PM, Collin L. Walling wrote:
>> On 01/15/2018 12:05 PM, Eric Blake wrote:
>>> On 01/15/2018 10:44 AM, Collin L. Walling wrote:
>>>> Moved:
>>>>  =C2=A0=C2=A0 memcmp from bootmap.h to libc.h (renamed from _memcmp)
>>>>  =C2=A0=C2=A0 strlen from sclp.c to libc.h (renamed from _strlen)
>>>>
>>>> Added C standard functions:
>>>>  =C2=A0=C2=A0 isdigit
>>>>  =C2=A0=C2=A0 atoi
>>>>
>>>> Added non-C standard function:
>>>>  =C2=A0=C2=A0 itostr
>>>>
>>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>>> ---
>>>> +++ b/pc-bios/s390-ccw/libc.c
>>>> @@ -0,0 +1,83 @@
>>>> +/*
>>>> + * libc-style definitions and functions
>>>> + *
>>>> + * This code is free software; you can redistribute it and/or modif=
y it
>>>> + * under the terms of the GNU General Public License as published b=
y the
>>>> + * Free Software Foundation; either version 2 of the License, or (a=
t your
>>>> + * option) any later version.
>>> I'm not a lawyer, but generically, the GPL and its variants depend on=
 a
>>> copyright owner to actually work.=C2=A0 You may want to add a copyrig=
ht line.
>>
>> I'll have to check on that.=C2=A0 I was not the original author of the=
 libc.h file.
> I think you can add the normal IBM Copyright statement. (I think all au=
thors could add theirs as well)
>
>

"Copyright 2018 IBM Corp."

@Thomas, git shows you as the initial creator of libc.h.=C2=A0 Shall I ad=
d
"Copyright 2018 Thomas Huth, Red Hat Inc." in there as well?

--=20
- Collin L Walling
