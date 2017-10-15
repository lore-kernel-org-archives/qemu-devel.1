Received: from eggs.gnu.org ([2001:4830:134:3::10]:44943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e3n6K-0005BY-CJ
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 13:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e3n6F-0002P1-IK
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 13:53:24 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:56446
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1e3n6F-0002OJ-BH
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 13:53:19 -0400
From: Stefan Weil <sw@weilnetz.de>
References: <20171013054842.32120-1-sw@weilnetz.de>
	<dacdf7e7-0b16-99a0-ab50-ea7a458e0ec6@amsat.org>
	<4028eece-c9ff-113a-3cab-1a95c9ce79cc@redhat.com>
	<81efd75c-0716-c149-c483-6cf487748ab5@weilnetz.de>
Message-ID: <2be5f194-ccc4-d3cc-6001-feae580e77e1@weilnetz.de>
Date: Sun, 15 Oct 2017 19:53:17 +0200
MIME-Version: 1.0
In-Reply-To: <81efd75c-0716-c149-c483-6cf487748ab5@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] oslib-posix: Fix compiler warning and
 some data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Am 15.10.2017 um 19:46 schrieb Stefan Weil:
> Am 15.10.2017 um 17:32 schrieb Paolo Bonzini:
>> On 14/10/2017 18:53, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> @@ -328,7 +328,7 @@ static void *do_touch_pages(void *arg)
>>>>               * don't need to write at all so we don't cause
>>>>               * wear on the storage backing the region...
>>>>               */
>>>> -            *(volatile char *)addr =3D *addr;
>>>> +            *addr =3D *addr;
>>> I personally prefer the other form which is mostly self-explicit when
>>> reviewing this code.
>>>
>>> Declaring addr non volatile and using volatile cast here:
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>
>>
>> I agree with Philippe; in general, volatile is more of a property of
>> the access rather than the variable.
>>
>> Paolo
>=20
> Thanks for the feedback.
>=20
> I see your arguments. Maybe that part can be removed from my patch
> when it is applied, or should I send a v3 (cc'ing qemu-trivial)?
>=20
> Stefan

While thinking more about that line of code, I wonder whether
it would make sense to replace the byte r/w by a 32 bit r/w.
Would that be faster on architectures with a 32 bit memory bus?

Stefan
