Received: from eggs.gnu.org ([2001:4830:134:3::10]:49081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1ecZln-0005a2-V8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1ecZlk-0003Vk-Oi
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:44:00 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1ecZlk-0003UV-At
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:43:56 -0500
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
Date: Fri, 19 Jan 2018 19:43:44 +0300
In-reply-to: <d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
Content-language: en-GB
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 01/19/2018 07:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 01/15/2018 01:14 PM, Peter Maydell wrote:
>> On 15 January 2018 at 11:52, Juan Quintela <quintela@redhat.com> wrote=
:
>>> Hi
>>> - rebase on top of lastest
>>> - fix compilation on 32bit machines
>>> - add Peter Xu cleanups
>>>
>>> Please, apply.
>>>
>>> The following changes since commit fd06527b80c88c8dde1b35fdc692685b68=
d2fd93:
>>>
>>>    Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibaul=
t' into staging (2018-01-15 10:39:29 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://github.com/juanquintela/qemu.git tags/migration/20180115
>>>
>>> for you to fetch changes up to 816306826a45f4d15352e32d157172af3a3589=
9f:
>>>
>>>    migration: remove notify in fd_error (2018-01-15 12:48:13 +0100)
>>>
>>> ----------------------------------------------------------------
>>> migration/next for 20180115
>> Applied, thanks.
> We have armel/armhf/powerpc hosts failing since this pull due to commit
> 3be98be4e9f.
>
> Those target are currently tested on Shippable CI, eventually adding an
> IRC bot we could notice.
>
> I know companies using QEMU system in embedded armel/armhf hosts, I
> don't know about the ppc32 hosts.
> This is however unlikely the migration features are used there.
>
> If 64bit atomic op are required for migration (performance/security) bu=
t
> not on 32bit system, one way to fix it could be to have the migration
> code being optional... so we can disable it on 32bit hosts.
>
> Regards,
>
> Phil.
>
Thank you Phil for report,

I have a release this week and it's not yet over.

As I remember, I tested build in QEMU's docker build system,

but now I checked it on i386 Ubuntu, and yes linker says about unresolved

atomic symbols. Next week, I'll have a time to investigate it deeper.


--=20
Best regards,
Alexey Perevalov
