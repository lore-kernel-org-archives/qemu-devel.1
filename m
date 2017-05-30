Received: from eggs.gnu.org ([2001:4830:134:3::10]:59923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFeZc-0000UM-FL
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFeZb-0002WL-HF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:40:24 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFeZb-0002WF-AJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:40:23 -0400
Received: by mail-wm0-x22c.google.com with SMTP id d127so92059692wmf.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 03:40:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87h90d3sz9.fsf@linaro.org>
References: <87h90d3sz9.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 11:40:00 +0100
Message-ID: <CAFEAcA8hjzRm7-jxQ8zWt6Cuq50EM2sET5OLvRRKRsMKH1BdCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] sparc64 linux-user status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 22 May 2017 at 14:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> While looking at some of the docker cross-build patches I thought I'd
> checkout if I could still bootstrap some Debian linux-user images. I
> made some tweaks to allow debootstrap to bootstrap from Debian's ports
> to see if I could get the SPARC64 file-system up and running:
>
>  https://github.com/stsquad/qemu/commits/docker/sparc64-linux-user
>
> However when I try to run it:
>
>   make docker-image-debian-sparc64-user V=3D1
>
> It fails

Doesn't surprise me very much, IIRC the last time I tried the
sparc linux-user code it was a bit broken (worked for simple
stuff, not for more complicated stuff). My pull tests include
a basic "can we run ls" for sparc64, but nothing more.

(In particular SPARC is BE so if we messed up on anything that
needs struct endianness swapping it will hit it.)

thanks
-- PMM
