Received: from eggs.gnu.org ([2001:4830:134:3::10]:47546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ez2nY-0000Ql-F3
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ez2nV-0005f7-A6
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:10:40 -0400
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-44-marcandre.lureau@redhat.com>
	<16df2073-4c45-1ca8-5477-5c9a5de26a57@redhat.com>
	<CAJ+F1CKjGGBswK9BGZPJ6_hHVM1XVok1pJfbHQrfa05EqqWwqA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <765ac3ba-e682-1706-1434-808a5e1cb266@redhat.com>
Date: Thu, 22 Mar 2018 17:10:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKjGGBswK9BGZPJ6_hHVM1XVok1pJfbHQrfa05EqqWwqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 43/49] qapi: make s390 commands depend
 on TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 22.03.2018 10:41, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Mar 22, 2018 at 6:42 AM, Thomas Huth <thuth@redhat.com> wrote:
>> On 21.03.2018 12:52, Marc-Andr=C3=A9 Lureau wrote:
[...]
>>> diff --git a/qmp.c b/qmp.c
>>> index d8f80cb04e..14972b78df 100644
>>> --- a/qmp.c
>>> +++ b/qmp.c
>>> @@ -601,20 +601,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expan=
sion(CpuModelExpansionType type,
>>>      return arch_query_cpu_model_expansion(type, model, errp);
>>>  }
>>>
>>> -CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *mo=
dela,
>>> -                                                    CpuModelInfo *mo=
delb,
>>> -                                                    Error **errp)
>>> -{
>>> -    return arch_query_cpu_model_comparison(modela, modelb, errp);
>>> -}
>>> -
>>> -CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *mod=
ela,
>>> -                                                   CpuModelInfo *mod=
elb,
>>> -                                                   Error **errp)
>>> -{
>>> -    return arch_query_cpu_model_baseline(modela, modelb, errp);
>>> -}
>>
>> Not sure, but couldn't these two commands be implemented on other
>> architectures in the long run, too? So removing them now here seems
>> somewhat counterproductive?
>=20
> They would have modify the qapi ifdef and implement the qmp handler in
> their target, similar to what would be done by implementing arch_query
> handlers. How counterproductive is that? The benefit is that we don't
> have to have stubs and "de-register" the commands.

Yes, thinking about that again, I guess you're right, this should be
fine. I first thought that there would likely be some common code
between the targets finally, but it's more likely that this CPU stuff is
completely different everywhere. So never mind!

 Thomas
