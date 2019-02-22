Received: from eggs.gnu.org ([209.51.188.92]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gxCl9-0000Nu-1j
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gxCl8-0006Hg-BG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:29:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gxCl7-0006DX-SI
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:29:06 -0500
References: <20190206105339.32664-1-david@redhat.com>
	<87ef8lneja.fsf@zen.linaroharston>
	<2f4bfa41-09d6-5103-5c69-9bb8912f5c58@redhat.com>
	<874l9gord0.fsf@zen.linaroharston>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b54fe8a6-8274-3e7f-7e8a-ae6bc7900dce@redhat.com>
Date: Fri, 22 Feb 2019 16:29:02 +0100
MIME-Version: 1.0
In-Reply-To: <874l9gord0.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] softfloat: Implement float128_to_uint32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>

On 06.02.19 16:42, Alex Benn=C3=A9e wrote:
>=20
> David Hildenbrand <david@redhat.com> writes:
>=20
>> On 06.02.19 16:12, Alex Benn=C3=A9e wrote:
>>>
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> Handling it just like float128_to_uint32_round_to_zero, that hopeful=
ly
>>>> is free of bugs :)
>>>>
>>>> Documentation basically copied from float128_to_uint64
>>>
>>> Queued to fpu/next, thanks.
>>>
>>> BTW to test:
>>>
>>> tests/fp: add wrapping for f128_to_ui32
>>>
>>> Needed to test: softfloat: add float128_is_{normal,denormal}
>>
>> Thanks, was that supposed to be "softfloat: Implement
>> float128_to_uint32" ?
>=20
> Ahh yes... too liberal with my C&P ;-)
>=20
> Thanks!

Hi Alex,

any chance we can get my two softfloat + richards float_to_odd patches
upstream in the near future? I have quite some patches waiting for these
three to be able to get picked up by Conny (and more to be sent by me).

Thanks!

--=20

Thanks,

David / dhildenb
