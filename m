Received: from eggs.gnu.org ([208.118.235.92]:50429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehfbr-0002aj-2b
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehfYH-0006f9-DC
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:58:25 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehfYH-0006em-1w
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:55:05 -0500
Received: by mail-ot0-x241.google.com with SMTP id x15so21075582ote.1
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:55:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fde1ca29-873b-5e5c-76d3-d620301c924b@amsat.org>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<1512670493-18114-5-git-send-email-peter.maydell@linaro.org>
	<d8c2c2ca-5046-f19b-9514-d3cbef3b7c3a@amsat.org>
	<CAFEAcA9k2KKrXk+2LQd+X7-RFuDQO96bYSo8xi81zfb80+ApFg@mail.gmail.com>
	<fde1ca29-873b-5e5c-76d3-d620301c924b@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2018 17:54:43 +0000
Message-ID: <CAFEAcA-0wV+DDwFEEnB1=VvUSOsG2yQRCDFBHRF+O=gayPGLVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] target/arm: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 26 January 2018 at 15:44, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> On 01/26/2018 11:33 AM, Peter Maydell wrote:
>> On 26 January 2018 at 14:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>>> Why not use arm_any_initfn() here?
>>
>> That function (and the 'any' cpu) are deliberately only
>> included in the linux-user binaries, not the system-emulation binaries.
>
> why not use the V8 features?

What v8 features?

>> (Also arm_any_initfn() only initializes userspace-visible stuff, it
>> doesn't provide ID register values etc for kernel-visible things.)
>
> I'd still use an unique arm_max_initfn() such
>
>   // initializes userspace-visible stuff
> #ifndef CONFIG_USER_ONLY
>   // initializes kernel-visible things
> #endif

>>> Actually what seems cleaner is to move "any" features here, and kill th=
e
>>> "any" cpu, using "max" for this purpose.
>>
>> We can't kill 'any', that would break back-compatibility
>> of command lines.
>
> and use an alias for 'any' -> 'max' or just
>
>   { .name =3D "any", .initfn =3D arm_max_initfn }, /* backward compat */

Yes, we could probably do something similar to this.

thanks
-- PMM
