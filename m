Received: from eggs.gnu.org ([2001:4830:134:3::10]:57206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEVzY-0001Ov-3D
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEVzW-0005SW-HI
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:23:00 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEVzW-0005RN-Bd
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:22:58 -0400
Received: by mail-ot0-x242.google.com with SMTP id l12-v6so23623058oth.6
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 01:22:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zi1g8qrd.fsf@linaro.org>
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<87zi1g8qrd.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 09:22:37 +0100
Message-ID: <CAFEAcA9bZoF5zt77z8_+rNxOOoaN0KUMONqnZhTgQZAUE+DnDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/3] target/arm: Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 3 May 2018 at 20:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:
>
>> The previous version:
>> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D33714
>
> I was trying to do some testing but I was finding it very hard to do at
> gdb kept throwing up errors like:
>
> (gdb) x/10i $pc
> =3D> 0xffffff8008097760 <check_and_switch_context>:       Cannot access m=
emory at address 0xffffff8008097760
> Detaching from program: /home/alex/lsrc/qemu/kernel-v8-plain.build/vmlinu=
x, Remote target
> Ending remote debugging.
>
> However this seems to be the same on master as well so I wonder there is
> a regression somewhere.

What gdb version are you using? If it's a new one you may be running
into https://sourceware.org/bugzilla/show_bug.cgi?id=3D23127
(a regression in gdb).

thanks
-- PMM
