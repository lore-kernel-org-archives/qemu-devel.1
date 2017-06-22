Received: from eggs.gnu.org ([2001:4830:134:3::10]:34852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNwXl-0008T9-6Z
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNwXk-0002np-CJ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:28:45 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNwXk-0002mk-5m
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:28:44 -0400
Received: by mail-wr0-x22b.google.com with SMTP id c11so10919046wrc.3
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 00:28:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170622033231.19344-22-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-22-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 08:28:22 +0100
Message-ID: <CAFEAcA9Vkg7hN8nipTaMyA0r9w7=E5VjQQ2d5vZ+A6NtVT1GGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 21/21] ui/vnc: silent unuseful OSX
 clang warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 22 June 2017 at 04:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
>     ui/vnc.c:3945:20: warning: 'sasl_server_init' is deprecated: first de=
precated in OS X 10.11 [-Wdeprecated-declarations]
>         if ((saslErr =3D sasl_server_init(NULL, "qemu")) !=3D SASL_OK) {
>                        ^
>     /usr/include/sasl/sasl.h:1016:17: note: 'sasl_server_init' has been e=
xplicitly marked deprecated here
>     LIBSASL_API int sasl_server_init(const sasl_callback_t *callbacks,
>                     ^

Mmm, I've been vaguely wondering what to do about those warnings
for a while. The difficulty is that applying -Wno-deprecated-declarations
silences all deprecation warnings, not just the SASL ones, so we
lose a bit of warning coverage. Maybe that's just a hit we have
to take, though.

thanks
-- PMM
