Received: from eggs.gnu.org ([2001:4830:134:3::10]:39584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRcFH-0007zg-EW
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 07:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRcFG-0005kS-Ii
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 07:41:23 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRcFG-0005k3-EV
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 07:41:22 -0400
Received: by mail-ot0-x241.google.com with SMTP id q1-v6so18674236oth.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 04:41:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180608185826.10708-1-f4bug@amsat.org>
References: <20180608185826.10708-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Jun 2018 12:41:01 +0100
Message-ID: <CAFEAcA8aVX6RjzDJ6+VxM3mENHP-aE6DYbZjhboCc+46bAnoAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: Remove qemu-version.h and
 qemu-options.def during 'make distclean'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 8 June 2018 at 19:58, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> qemu-version.h and qemu-options.def are generated files
> that should be deleted during 'make distclean'.

These are both in GENERATED_FILES, and 'make distclean'
invokes 'make clean' which does an rm of all GENERATED_FILES.
Why isn't that sufficient here?

thanks
-- PMM
