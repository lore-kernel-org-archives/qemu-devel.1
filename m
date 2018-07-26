Received: from eggs.gnu.org ([2001:4830:134:3::10]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fif0l-0003fc-P8
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fif0i-0000KK-PB
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:04:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fif0i-0000II-H6
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:04:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id j5-v6so1456321wrr.8
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 05:04:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-K-BAsMdn=0g3HCZEVfveLOjsmRutTgqOY96b_yvOs3Q@mail.gmail.com>
References: <20180725141610.12075-1-otubo@redhat.com>
	<CAFEAcA-K-BAsMdn=0g3HCZEVfveLOjsmRutTgqOY96b_yvOs3Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 26 Jul 2018 14:04:46 +0200
Message-ID: <CAJ+F1CKun6Z1DdHojGHEQi71u932o5gVZqfhv_PUKLc-ry2V4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Otubo <otubo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Thu, Jul 26, 2018 at 12:47 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 25 July 2018 at 15:16, Eduardo Otubo <otubo@redhat.com> wrote:
>> The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5f=
4cc:
>>
>>   Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/otubo/qemu.git tags/pull-seccomp-20180725
>>
>> for you to fetch changes up to 5b2f59307372bae13a2ff95706646674eccb65e0:
>>
>>   RFC: seccomp: prefer SCMP_ACT_KILL_PROCESS if available (2018-07-25 16=
:07:31 +0200)
>>
>> ----------------------------------------------------------------
>> pull-seccomp-20180725
>>
>> ----------------------------------------------------------------
>> Marc-Andr=C3=A9 Lureau (2):
>>       seccomp: use SIGSYS signal instead of killing the thread
>>       RFC: seccomp: prefer SCMP_ACT_KILL_PROCESS if available
>
> Hi. This fails to compile with clang:
>
>   CC      qemu-seccomp.o
> qemu-seccomp.c:112:1: error: unused function 'qemu_seccomp'
> [-Werror,-Wunused-function]
> qemu_seccomp(unsigned int operation, unsigned int flags, void *args)
> ^
>
> This is because clang is stricter about warning about static inline
> functions defined in .c files but never used and your ifdef
> guard on the callsite is not matched by one around the function
> definition.
>

https://lkml.org/lkml/2017/6/6/631 ;)



--=20
Marc-Andr=C3=A9 Lureau
