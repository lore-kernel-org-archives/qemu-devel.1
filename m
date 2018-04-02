Received: from eggs.gnu.org ([2001:4830:134:3::10]:54033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0630425971=stefanb@linux.vnet.ibm.com>)
	id 1f2yNE-0007a8-6k
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 08:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0630425971=stefanb@linux.vnet.ibm.com>)
	id 1f2yN9-0006to-7v
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 08:15:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0630425971=stefanb@linux.vnet.ibm.com>)
	id 1f2yN8-0006mJ-Nz
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 08:15:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w32CFDoU092077
	for <qemu-devel@nongnu.org>; Mon, 2 Apr 2018 08:15:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h3gtv7qny-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 08:15:25 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 2 Apr 2018 08:15:12 -0400
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1519934373-3629-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAMxuvaxDVJxH0BwdtdqgvCUpOzaFf_0NsjvjQnceVjeO5dDhbQ@mail.gmail.com>
	<944288fa-05f1-7ed1-b35d-f7010d28d4c9@linux.vnet.ibm.com>
	<CAJ+F1CLvt9Uirf+DmF7KQLA0-eN5cHzd=ar8igMmJ5ZGi3cpVQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 08:15:08 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLvt9Uirf+DmF7KQLA0-eN5cHzd=ar8igMmJ5ZGi3cpVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8f4f7a98-3975-32eb-2e97-f1552b6941f3@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/2] tpm: extend TPM TIS with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 03/29/2018 01:07 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Thu, Mar 29, 2018 at 1:56 AM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> On 03/28/2018 11:41 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi
>>>
>>> On Thu, Mar 1, 2018 at 8:59 PM, Stefan Berger
>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>> +
>>>> +static const VMStateDescription vmstate_locty =3D {
>>>> +    .name =3D "loc",
>>>> +    .version_id =3D 1,
>>>> +    .minimum_version_id =3D 0,
>>>> +    .minimum_version_id_old =3D 0,
>>> I don't understand the problem there is leaving all the version field=
s
>>> to 0, just like CRB.
>>>
>>>> +    .fields      =3D (VMStateField[]) {
>>>> +        VMSTATE_UINT32(state, TPMLocality),
>>>> +        VMSTATE_UINT32(inte, TPMLocality),
>>>> +        VMSTATE_UINT32(ints, TPMLocality),
>>>> +        VMSTATE_UINT8(access, TPMLocality),
>>>> +        VMSTATE_UINT32(sts, TPMLocality),
>>>> +        VMSTATE_UINT32(iface_id, TPMLocality),
>>>> +        VMSTATE_END_OF_LIST(),
>>>> +    }
>>>> +};
>>>> +
>>>>    static const VMStateDescription vmstate_tpm_tis =3D {
>>>>        .name =3D "tpm",
>>>> -    .unmigratable =3D 1,
>>>> +    .version_id =3D 1,
>>>> +    .minimum_version_id =3D 0,
>>>> +    .minimum_version_id_old =3D 0,
>>> same
>>>
>>> If you remove the version fields: Reviewed-by: Marc-Andr=C3=A9 Lureau
>>> <marcandre.lureau@redhat.com>
>>
>> This is the error I got when setting .version_id =3D 0 (on both) and d=
oing a
>> localhost migration
>>
>> qemu-system-x86_64: Missing section footer for tpm-tis
>> qemu-system-x86_64: load of migration failed: Invalid argument
> It's clearly not the most friendly error message, but I debugged it,
> you just have to specify the right version for VMSTATE_STRUCT_ARRAY:
> 0.
>          VMSTATE_STRUCT_ARRAY(loc, TPMState, TPM_TIS_NUM_LOCALITIES, 0,
>                               vmstate_locty, TPMLocality),
>
> Then it all works with version 0 (or default value)
>
> thanks
Thanks.
