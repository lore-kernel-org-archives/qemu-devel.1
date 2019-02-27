Received: from eggs.gnu.org ([209.51.188.92]:37021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gz0Eq-0000ZI-0l
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gz08y-0004i8-Jt
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:25:14 -0500
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-2-david@redhat.com>
	<87lg21lai8.fsf@zen.linaroharston>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1712bd0f-0a0c-b459-7e10-c5aa1326cb22@redhat.com>
Date: Wed, 27 Feb 2019 12:58:21 +0100
MIME-Version: 1.0
In-Reply-To: <87lg21lai8.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] tests/tcg: Allow targets to set
 the optimization level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 27.02.19 12:46, Alex Benn=C3=A9e wrote:
>=20
> David Hildenbrand <david@redhat.com> writes:
>=20
>> We sometimes want basic optimizations, e.g. for constant propagation
>> into inlined functions.
>>
>> Especially for inline asm with immediates;
>=20
> I agree you need this, but...
>=20
> <snip>
>>  # Start with a blank slate, the build targets get to add stuff first
>> -CFLAGS=3D
>> +CFLAGS=3D-O0
>>  QEMU_CFLAGS=3D
>>  LDFLAGS=3D
>>
>> @@ -70,7 +70,7 @@ ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
>>  endif
>>
>>  # Add the common build options
>> -CFLAGS+=3D-Wall -O0 -g -fno-strict-aliasing
>> +CFLAGS+=3D-Wall -g -fno-strict-aliasing
>=20
>=20
> You don't need to do this - we already have EXTRA_CFLAGS which will
> always be at the end of the compile invocation:
>=20
>   # enable vectors and optimisation to vectorise for this test
>   vglv: CFLAGS+=3D-march=3Dz13 -m64
>   vglv: EXTRA_CFLAGS+=3D-O2
>=20

Cool, missed that - thanks!


--=20

Thanks,

David / dhildenb
