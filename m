Received: from eggs.gnu.org ([2001:4830:134:3::10]:50234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eROQ2-00053G-7u
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eROPy-0002sk-6Z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:23:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eROPx-0002s5-U2
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:23:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBJKK2Io109268
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 15:23:09 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ey5qsuefq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 15:23:09 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 19 Dec 2017 13:23:08 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-2-git-send-email-walling@linux.vnet.ibm.com>
	<a6920dc1-f2be-cdd9-ba6e-a341a9e93343@redhat.com>
	<231e9fad-a4e0-b957-229e-3f3dcc342e4e@linux.vnet.ibm.com>
	<31f9a2b4-b8c2-c823-1dfc-b251d00d7fc2@redhat.com>
	<889623b1-f186-33af-e1be-8222a429518d@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 15:23:02 -0500
MIME-Version: 1.0
In-Reply-To: <889623b1-f186-33af-e1be-8222a429518d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <27778497-8f7b-5d3d-b86c-9cb48d1592ad@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 1/5] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

On 12/19/2017 11:29 AM, Collin L. Walling wrote:
> On 12/19/2017 02:31 AM, Thomas Huth wrote:
>> On 18.12.2017 17:16, Collin L. Walling wrote:
>>> On 12/18/2017 08:06 AM, Thomas Huth wrote:
>>>> On 11.12.2017 23:19, Collin L. Walling wrote:
>>>>> Moved:
>>>>> =C2=A0=C2=A0=C2=A0 memcmp from bootmap.h to libc.h (renamed from _m=
emcmp)
>>>>> =C2=A0=C2=A0=C2=A0 strlen from sclp.c to libc.h (renamed from _strl=
en)
>>>>>
>>>>> Added C standard functions:
>>>>> =C2=A0=C2=A0=C2=A0 isdigit
>>>>> =C2=A0=C2=A0=C2=A0 atoi
>>>>>
>>>>> Added non-C standard function:
>>>>> =C2=A0=C2=A0=C2=A0 itostr
>>>>>
>>>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 pc-bios/s390-ccw/Makefile=C2=A0 |=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 pc-bios/s390-ccw/bootmap.c |=C2=A0 4 +--
>>>>> =C2=A0=C2=A0 pc-bios/s390-ccw/bootmap.h | 16 +---------
>>>>> =C2=A0=C2=A0 pc-bios/s390-ccw/libc.c=C2=A0=C2=A0=C2=A0 | 75
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>>> =C2=A0=C2=A0 pc-bios/s390-ccw/libc.h=C2=A0=C2=A0=C2=A0 | 31 +++++++=
++++++++++++
>>>>> =C2=A0=C2=A0 pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0 | 17 +------=
----
>>>>> =C2=A0=C2=A0 pc-bios/s390-ccw/sclp.c=C2=A0=C2=A0=C2=A0 | 10 +------
>>>>> =C2=A0=C2=A0 7 files changed, 112 insertions(+), 43 deletions(-)
>>>>> =C2=A0=C2=A0 create mode 100644 pc-bios/s390-ccw/libc.c
>>>> [...]
>>>>> +
>>>>> +/**
>>>>> + * itostr:
>>>>> + * @num: the integer to be converted.
>>>>> + * @str: a pointer to a string to store the conversion.
>>>>> + * @len: the length of the passed string.
>>>>> + *
>>>>> + * Given an integer @num, convert it to a string. The string @str
>>>>> must be
>>>>> + * allocated beforehand. The resulting string will be null
>>>>> terminated and
>>>>> + * returned.
>>>>> + *
>>>>> + * Returns: the string @str of the converted integer @num.
>>>>> + */
>>>>> +char *itostr(int num, char *str, size_t len)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 long num_len =3D 1;
>>>>> +=C2=A0=C2=A0=C2=A0 int tmp =3D num;
>>>>> +=C2=A0=C2=A0=C2=A0 int i;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* Count length of num */
>>>>> +=C2=A0=C2=A0=C2=A0 while ((tmp /=3D 10) > 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_len++;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* Check if we have enough space for num and nu=
ll */
>>>>> +=C2=A0=C2=A0=C2=A0 if (len < num_len) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> I'm afraid, but I think you've got an off-by-one bug in this code.
>>>>
>>>> In patch 5, you're using this function like this:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char tmp[4];
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sclp_print(itostr(entries, tmp, sizeo=
f(tmp)));
>>>>
>>>> That means if entries is >=3D 1000 for example, num_len is 4 ...
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 /* Convert int to string */
>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D num_len - 1; i >=3D 0; i--) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str[i] =3D num % 10 + '=
0';
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num /=3D 10;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 str[num_len] =3D '\0';
>>>> ... and then you run into a buffer overflow here.
>>>
>>> Doh, you're correct.=C2=A0 I forgot to put a "<=3D" in the len / num_=
len=20
>>> check.
>>> That should fix things up.=C2=A0 Thanks for catching that.
>>>
>>>
>>>>> +=C2=A0=C2=A0=C2=A0 return str;
>>>>> +}
>>>> Maybe it would also make more sense to panic() instead of "return 0"
>>>> since you don't check the return value in patch 5 ?
>>>
>>> I'm a bit conflicted about doing something like that.=C2=A0 I'm not s=
ure if
>>> there's any kind
>>> of guideline we want to follow for defining functions in libc.
>>>
>>> I see one of two possibilities:
>>>
>>> a.=C2=A0 define these functions as "libc-like" as possible, and use t=
hem as
>>> if they were
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regular standard libc functions
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 or
>>>
>>> b.=C2=A0 change up these functions to better fit their use cases in
>>> pc-bios/s390-ccw
>>>
>>> Does that make sense?=C2=A0 What do you think?
>> Keeping them libc-like likely makes sense ... but could we somehow als=
o
>> make sure that we're not running into unexpected errors when using the=
m?
>> Something like "IPL_assert(entries < 1000, ...)" before calling the
>> functions in patch 5?
>>
>> =C2=A0 Thomas
>>
>>
>
> Sounds good to me.
>


What if we made a wrapper function for itostr. This func will have a tmp=20
variable
that stores the return of itostr. We then do an assertion to make sure=20
we did not
return 0 (which indicates that the size of the array was not large=20
enough). If we
pass, then just return tmp.

e.g.

static char *_itostr(int num, char *str, size_t len)
{
 =C2=A0=C2=A0=C2=A0 ...
}

char *itostr(int num, char *str, size_t len)
{
 =C2=A0=C2=A0=C2=A0 char *tmp =3D _itostr(num, str, len);
 =C2=A0=C2=A0=C2=A0 IPL_assert(tmp !=3D 0, "array too small for itostr co=
nversion");
 =C2=A0=C2=A0=C2=A0 return tmp;
}

And as a side note: we know that the number of boot table entries for=20
both ECKD
DASD andSCSI cannot exceed 31, so we should be safe with a rather small=20
value
for our char arrays.

--=20
- Collin L Walling
