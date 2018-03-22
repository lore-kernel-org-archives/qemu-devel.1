Received: from eggs.gnu.org ([2001:4830:134:3::10]:52337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eyw1a-0007Fq-Nv
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eyw1X-0007Dp-Mi
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:56:42 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:32809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eyw1X-0007DC-FX
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:56:39 -0400
Received: by mail-wm0-x236.google.com with SMTP id i189so1420896wmf.0
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 01:56:39 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521663109-32262-1-git-send-email-cota@braap.org>
Date: Thu, 22 Mar 2018 08:56:36 +0000
Message-ID: <87woy4ij3v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 00/14] fp-test + hostfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

<snip>
> For performance numbers see the last patch.

Just another random data point as we've been using himeno for our SVE
wor:

Master:

8:05:45  [alex@zen:~/l/q/qemu.git] master =C2=B1 ./aarch64-linux-user/qemu-=
aarch64 sve.demo/himeno-v80
mimax =3D 129 mjmax =3D 65 mkmax =3D 65
imax =3D 128 jmax =3D 64 kmax =3D64
cpu : 33.430299 sec.
Loop executed for 200 times
Gosa : 1.688752e-03
MFLOPS measured : 98.519585
Score based on MMX Pentium 200MHz : 3.052978

Host FPU:

08:25:03 [alex@zen:~/l/q/qemu.git] master =C2=B1 ./aarch64-linux-user/qemu-=
aarch64 sve.demo/himeno-v80
mimax =3D 129 mjmax =3D 65 mkmax =3D 65
imax =3D 128 jmax =3D 64 kmax =3D64
cpu : 15.067773 sec.
Loop executed for 200 times
Gosa : 1.688752e-03
MFLOPS measured : 218.581684
Score based on MMX Pentium 200MHz : 6.773526

Given SVE also beats v80 code thanks to avoiding marshalling overhead by
doing bigger vectors I expect that improvement to be even better. Once
the SVE patches are re-based I'll measure them.

By the way I've been talking to some of the people at connect about
tracking performance over time. I got pointed to LLVM's LNT tool
(example: https://lnt.llvm.org/) so I might see if I can get a server
set up that we can start pushing numbers to. Have you come across any
other such things?

--
Alex Benn=C3=A9e
