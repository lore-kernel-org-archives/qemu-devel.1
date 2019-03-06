Received: from eggs.gnu.org ([209.51.188.92]:35930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1WgL-0006Po-0p
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1WgK-0007qy-4n
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1WgJ-0007qN-V1
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:34:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
	<CAL1e-=gTsjAt1O63xuDwm7NfV6nKt3gMHk46Yjfg_PKp0a1m+w@mail.gmail.com>
	<11d78ce4-4646-ca1d-82a6-3db98298996b@redhat.com>
Date: Wed, 06 Mar 2019 14:33:53 +0100
In-Reply-To: <11d78ce4-4646-ca1d-82a6-3db98298996b@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 6 Mar 2019 10:21:21
	+0100")
Message-ID: <87va0wxh32.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] mips_malta: Clean up definition of
 flash memory size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, Alex =?utf-8?Q?Ben?= =?utf-8?Q?n=C3=A9e?= <alex.bennee@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Aleksandar,
>
> On 3/6/19 7:38 AM, Aleksandar Markovic wrote:
>> On Tuesday, March 5, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>> <mailto:philmd@redhat.com>> wrote:
>>=20
>>     Hi Markus,
>>=20
>>     this is a rework of your 'mips_malta: Clean up definition of flash
>>     memory size somewhat' patch:
>>     https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07177.html
>>     <https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07177.html>
>>=20
>>     Regards,
>>=20
>>     Phil.
>>=20
>>=20
>> Philippe,
>>=20
>> Could you summarize end-user-visible changes resulting from this series?
>
> Good maintainer reflex :)
>
> There is an end-user visible change, if he provides a file that is not
> exactly 4MiB he will now get a "Malta CoreLV card expects a bios of 4MB"
> error message and QEMU will exit to his shell. This change is introduced
> by patch 4/5.
>
> Now I rather expect this series to get integrated in Markus current
> work, because his subsequent patches change the PFlash API and it is
> easier he takes this (to avoid merge conflicts).

Definitely.

> Note: Markus series is expected to include the following patch from Alex
> Benn=C3=A9e: "hw/block: better reporting on pflash backing file mismatch"
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07341.html
> which is a more important user visible change. I think the the changelog
> can be updated once, by Markus :)

Yes.

> Meanwhile, if this series is taken by Markus can I have your Ack-by?
>
> Thanks,
>
> Phil.
