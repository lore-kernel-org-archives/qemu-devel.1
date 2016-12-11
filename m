Received: from eggs.gnu.org ([2001:4830:134:3::10]:53385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGD6d-00086b-UR
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 18:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGD6a-0001QQ-Pz
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 18:00:32 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGD6a-0001Q0-Lg
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 18:00:28 -0500
Received: by mail-ua0-f174.google.com with SMTP id 12so66797367uas.2
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 15:00:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lgvm1dvz.fsf@gmail.com>
References: <87lgvm1dvz.fsf@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Dec 2016 22:59:07 +0000
Message-ID: <CAFEAcA9qiEK+Z3TBFxebTjqdm-4TeeZLQm2uewMHQUsmtCvL=g@mail.gmail.com>
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
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 11 December 2016 at 19:09, Pranith Kumar <bobby.prani@gmail.com> wrote:
> I am getting a strange compilation error lately for aarch64-linux-user. I
> think it is somehow related to TYPE_PTRVOID handling but my investigation=
 has
> not led to anything concrete. I think this is a compiler error since the =
build
> passes on an other system with gcc-6.

> Error:
> /home/pranith/devops/code/qemu/linux-user/ioctls.h:224:9: error: =E2=80=
=98SNDCTL_DSP_MAPINBUF=E2=80=99 undeclared here (not in a function)
>    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_desc=
)))
>          ^

SNDCTL_DSP_MAPINBUF is supposed to be defined by your system
headers (/usr/include/linux/soundcard.h or equivalent).
Similarly for SNDCTL_DSP_MAPOUTBUF and SOUND_MIXER_ACCESS.

Looking at QEMU's git history we've used these symbols
for years. I would check whether your system headers
are actually providing these symbols (and that the
compiler is really putting the right headers on the
include path).

thanks
-- PMM
