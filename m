Received: from eggs.gnu.org ([2001:4830:134:3::10]:39257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gYy9a-0001m9-Fk
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gYy9X-000723-Qp
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:02:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gYy9X-00071d-Ke
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:02:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
	<1543467132-2873-3-git-send-email-liq3ea@gmail.com>
	<644186db-32d3-7c83-8b37-02e8427ef217@redhat.com>
Date: Mon, 17 Dec 2018 20:01:57 +0100
In-Reply-To: <644186db-32d3-7c83-8b37-02e8427ef217@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon,
	17 Dec 2018 13:43:30 +0100")
Message-ID: <87o99kj7tm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw: vmmouse: Use link instead of
 pointer property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Thomas Huth <thuth@redhat.com>, darren.kenny@oracle.com, qemu-devel@nongnu.org, rth@twiddle.net

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Li,
>
> On 11/29/18 5:52 AM, Li Qiang wrote:
>> According to qdev-properties.h, properties of pointer type should
>> be avoided. Turn "ps2_mouse" into a link.
>>=20
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>> ---
[...]
>> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>> index 4412eaf604..f63aac6673 100644
>> --- a/hw/i386/vmmouse.c
>> +++ b/hw/i386/vmmouse.c
[...]
>> @@ -283,8 +289,6 @@ static void vmmouse_class_initfn(ObjectClass *klass,=
 void *data)
>>      dc->realize =3D vmmouse_realizefn;
>>      dc->reset =3D vmmouse_reset;
>>      dc->vmsd =3D &vmstate_vmmouse;
>> -    dc->props =3D vmmouse_properties;
>> -    /* Reason: pointer property "ps2_mouse" */
>>      dc->user_creatable =3D false;
>
> "user_creatable =3D false" must have an justification comment.

Correct.

> Can you keep 'Reason: link property "ps2_mouse"'?

Is this a valid reason?

A pointer property is one, because it can only be set by code.

> Eventually the maintainer taking this patch can fix this for you.
>
> With the comment:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>>  }
[...]
