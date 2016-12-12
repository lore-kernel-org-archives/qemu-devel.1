Received: from eggs.gnu.org ([2001:4830:134:3::10]:52171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGOys-0003eA-EK
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGOyo-00026X-LT
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:41:18 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cGOyo-0001r8-5j
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:41:14 -0500
Received: by mail-wm0-f52.google.com with SMTP id t79so63297316wmt.0
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 03:40:51 -0800 (PST)
References: <87lgvm1dvz.fsf@gmail.com>
	<CAFEAcA9qiEK+Z3TBFxebTjqdm-4TeeZLQm2uewMHQUsmtCvL=g@mail.gmail.com>
	<CAJhHMCAvd0+PNFF-PfMVP2aSpN2V9B7XbV59qh-FaXtLGemQmg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJhHMCAvd0+PNFF-PfMVP2aSpN2V9B7XbV59qh-FaXtLGemQmg@mail.gmail.com>
Date: Mon, 12 Dec 2016 11:39:49 +0000
Message-ID: <87k2b5tlyy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Pranith Kumar <bobby.prani@gmail.com> writes:

> On Sun, Dec 11, 2016 at 5:59 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>> Error:
>>> /home/pranith/devops/code/qemu/linux-user/ioctls.h:224:9: error: ‘SNDCTL_DSP_MAPINBUF’ undeclared here (not in a function)
>>>    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)))
>>>          ^
>>
>> SNDCTL_DSP_MAPINBUF is supposed to be defined by your system
>> headers (/usr/include/linux/soundcard.h or equivalent).
>> Similarly for SNDCTL_DSP_MAPOUTBUF and SOUND_MIXER_ACCESS.
>>
>> Looking at QEMU's git history we've used these symbols
>> for years. I would check whether your system headers
>> are actually providing these symbols (and that the
>> compiler is really putting the right headers on the
>> include path).
>
> So soundcard.h header is provided by two packages:
>
> $ apt-file search /usr/include/linux/soundcard.h
> linux-libc-dev: /usr/include/linux/soundcard.h
> oss4-dev: /usr/include/linux/soundcard.h
>
> I had oss4-dev installed. After removing that and reinstalling
> linux-libc-dev, it compiles fine. Not sure why this file differs. May
> be a packaging issue.

Sounds like it. How did you ensure you had your QEMU build dependencies
installed on your system?

--
Alex Bennée
