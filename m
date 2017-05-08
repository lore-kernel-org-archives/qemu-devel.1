Received: from eggs.gnu.org ([2001:4830:134:3::10]:46267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d7m6o-0006RA-Su
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d7m6j-0003It-18
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:06:06 -0400
MIME-Version: 1.0
In-Reply-To: <87r2zz8oep.fsf@linaro.org>
References: <20170508073529.23449-1-pbonzini@redhat.com>
	<87r2zz8oep.fsf@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 8 May 2017 10:05:59 -0700
Message-ID: <CAMo8BfKZeZe26qOfuJm0ib-3PhYY0X--ZiFGbT6vSjr9RqJsaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] xtensa: use g_malloc/g_new/g_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On Mon, May 8, 2017 at 6:32 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
>> index d2d1d3a6fd..97307728f7 100644
>> --- a/hw/xtensa/sim.c
>> +++ b/hw/xtensa/sim.c
>> @@ -41,13 +41,13 @@ static void xtensa_create_memory_regions(const Xtens=
aMemory *memory,
>>                                           const char *name)
>>  {
>>      unsigned i;
>> -    char *num_name =3D malloc(strlen(name) + sizeof(i) * 3 + 1);
>> +    char *num_name =3D g_malloc(strlen(name) + sizeof(i) * 3 + 1);
>
> It seems a little sketchy using the size of the storage type as a proxy
> for the number of bytes used by the format specifier in a format string.
> In this sort of situation I'd just use Glib and stop worrying about it:

Ok, I'll send a patch doing it that way.

--=20
Thanks.
-- Max
