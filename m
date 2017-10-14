Received: from eggs.gnu.org ([2001:4830:134:3::10]:43839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3Q5S-0001lF-Rt
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3Q5S-00026B-65
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:18:58 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:48029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e3Q5R-00025M-VC
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:18:58 -0400
Received: by mail-wr0-x236.google.com with SMTP id y39so1855679wrd.4
	for <qemu-devel@nongnu.org>; Sat, 14 Oct 2017 10:18:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa3d7fbc-827f-a28b-0cf0-ff0c3f43a0fe@amsat.org>
References: <CA+J4q6dO+V32yF11jFD2jAizigYoZS6eECyuDTgRVfe+a_JUJQ@mail.gmail.com>
	<1507878038.21465.3.camel@redhat.com>
	<fa3d7fbc-827f-a28b-0cf0-ff0c3f43a0fe@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 14 Oct 2017 18:18:34 +0100
Message-ID: <CAFEAcA9Je3GHesmrgejU9H209QF0vU7XGVRZ2Cu=Fuu+Mj0s6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU without X11 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, hanji unit <hanjiunit@gmail.com>, qemu-discuss <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 October 2017 at 17:38, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>>> Hello, is it possible to run (or rebuild modifying build flags) QEMU
>>> without support for X11 window system integration?
>>
>> ./configure --disable-gtk --disable-sdl --disable-opengl
>
> Is there some interest in adding a simpler --disable-x11 option?

We don't directly link to X11, so it wouldn't fit with
our other options.
The --disable-foo options aren't very often necessary --
only if your build environment has support for linking
against foo but for some reason you don't want it
linked in.

thanks
-- PMM
