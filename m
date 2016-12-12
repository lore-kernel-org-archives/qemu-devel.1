Received: from eggs.gnu.org ([2001:4830:134:3::10]:43847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cGFZW-0004pi-QU
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 20:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cGFZT-0003sX-Ky
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 20:38:30 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cGFZT-0003s3-Es
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 20:38:27 -0500
Received: by mail-oi0-f51.google.com with SMTP id w63so74101979oiw.0
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 17:38:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qiEK+Z3TBFxebTjqdm-4TeeZLQm2uewMHQUsmtCvL=g@mail.gmail.com>
References: <87lgvm1dvz.fsf@gmail.com>
	<CAFEAcA9qiEK+Z3TBFxebTjqdm-4TeeZLQm2uewMHQUsmtCvL=g@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sun, 11 Dec 2016 20:36:55 -0500
Message-ID: <CAJhHMCAvd0+PNFF-PfMVP2aSpN2V9B7XbV59qh-FaXtLGemQmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] aarch64-linux-user compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Sun, Dec 11, 2016 at 5:59 PM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>
>> Error:
>> /home/pranith/devops/code/qemu/linux-user/ioctls.h:224:9: error: =E2=80=
=98SNDCTL_DSP_MAPINBUF=E2=80=99 undeclared here (not in a function)
>>    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_des=
c)))
>>          ^
>
> SNDCTL_DSP_MAPINBUF is supposed to be defined by your system
> headers (/usr/include/linux/soundcard.h or equivalent).
> Similarly for SNDCTL_DSP_MAPOUTBUF and SOUND_MIXER_ACCESS.
>
> Looking at QEMU's git history we've used these symbols
> for years. I would check whether your system headers
> are actually providing these symbols (and that the
> compiler is really putting the right headers on the
> include path).

So soundcard.h header is provided by two packages:

$ apt-file search /usr/include/linux/soundcard.h
linux-libc-dev: /usr/include/linux/soundcard.h
oss4-dev: /usr/include/linux/soundcard.h

I had oss4-dev installed. After removing that and reinstalling
linux-libc-dev, it compiles fine. Not sure why this file differs. May
be a packaging issue.

Thanks for the help!
--=20
Pranith
