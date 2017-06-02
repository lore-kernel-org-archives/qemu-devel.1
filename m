Received: from eggs.gnu.org ([2001:4830:134:3::10]:60279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGvNh-0004Qa-9l
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 18:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGvNe-0000Sn-4K
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 18:49:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGvNd-0000Rn-S0
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 18:49:18 -0400
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-2-marcandre.lureau@redhat.com>
	<465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
	<0a434f41-1131-713d-1fc9-a9edba425f7a@redhat.com>
	<CAJ+F1CKL6OXetG6Liwf3NrpNv3K8PR6_SQ5=rfjyRwa3pJ7nuA@mail.gmail.com>
	<CAJ+F1CKhaNuBO8O-X=u8aWV47q+smG2weo2qqoMojio+fJva_g@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <584abbba-669d-0fac-2144-5f7010b1a7ae@redhat.com>
Date: Sat, 3 Jun 2017 00:49:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKhaNuBO8O-X=u8aWV47q+smG2weo2qqoMojio+fJva_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] dump: add DumpInfo structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, "wencongyang2@huawei.com" <wencongyang2@huawei.com>
Cc: anderson@redhat.com

On 06/02/17 11:55, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Jun 2, 2017 at 1:46 PM Marc-Andr=C3=A9 Lureau <marcandre.lureau=
@gmail.com>
> wrote:
>=20
>> Hi
>>
>> On Thu, Jun 1, 2017 at 10:19 PM Eric Blake <eblake@redhat.com> wrote:
>>
>>> On 06/01/2017 01:06 PM, Laszlo Ersek wrote:
>>>> On 06/01/17 15:03, Marc-Andr=C3=A9 Lureau wrote:
>>>>> One way or another, the guest could communicate various dump info (=
via
>>>>> guest agent or vmcoreinfo device) and populate that structure. It c=
an
>>>>> then be used to augment the dump with various details, as done in t=
he
>>>>> following patch.
>>>>>
>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>>  include/sysemu/dump-info.h | 18 ++++++++++++++++++
>>>>>  dump.c                     |  3 +++
>>>>>  2 files changed, 21 insertions(+)
>>>>>  create mode 100644 include/sysemu/dump-info.h
>>>>>
>>>>> diff --git a/include/sysemu/dump-info.h b/include/sysemu/dump-info.=
h
>>>>> new file mode 100644
>>>>> index 0000000000..d2378e15e2
>>>>> --- /dev/null
>>>>> +++ b/include/sysemu/dump-info.h
>>>>> @@ -0,0 +1,18 @@
>>>>> +#ifndef DUMP_INFO_H
>>>>> +#define DUMP_INFO_H
>>>
>>>>>
>>>>
>>>> Can you please spell out, in the commit message, the reason for
>>>> introducing a new header file? (I suspect your reason, but it should=
 be
>>>> documented explicitly.)
>>>
>>> Also, should you have a copyright header in the new file?  And does
>>> MAINTAINERS cover it?
>>>
>>
>> None of the dump support is covered. Based on commit history, I can
>> suggest Wen Congyang, as original author.
>> Sadly, Qiao Nuohan cannot be reached with his mail today (anyone knows=
 if
>> he is still contributing?). Laszlo has done significant changes and re=
views
>> too. I can also propose myself to help with reviews.
>>
>> Wen or Laszla, do you want to be the main maintainer?
>>
>=20
> (sorry for the typo)
>=20
> or rather "Supported" ("Someone is actually paid to look after this"
> according to MAINTAINERS)
>=20

Thanks, but I don't wish to have an official responsibility for this
feature. My current responsibilities are more than enough to keep me busy=
.

If you'd like to volunteer for maintaining the dump stuff, you have my
blessing of course (whatever weight that might carry).

Thanks
Laszlo
