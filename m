Received: from eggs.gnu.org ([2001:4830:134:3::10]:33020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slyfox@gentoo.org>) id 1emOAa-0003rQ-JM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slyfox@gentoo.org>) id 1emOAZ-0006tY-Nk
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:22:08 -0500
Received: from mail.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]:41843
	helo=smtp.gentoo.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slyfox@gentoo.org>) id 1emOAZ-0006t5-HN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:22:07 -0500
Date: Thu, 15 Feb 2018 18:21:53 +0000
From: Sergei Trofimovich <slyfox@gentoo.org>
Message-ID: <20180215182153.3696ad5f@sf>
In-Reply-To: <20180215173539.11033-1-f4bug@amsat.org>
References: <20180215173539.11033-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] capstone: fix building using system
 package
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Mike Frysinger <vapier@gentoo.org>, =?UTF-8?B?Wm9sdMOhbg==?= Mizsei <miqlas@gmail.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Thu, 15 Feb 2018 14:35:39 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

>  #else
> +#include <capstone/capstone.h>

I think it's incorrect. 'pkg-config' already reports 'capstone/' path:
    $ pkg-config --cflags capstone
    -I/usr/include/capstone

    $ ls /usr/include/capstone/capstone.h
    /usr/include/capstone/capstone.h

Thus I would guess
    #include <capstone.h>
is still correct for system include path as well (contradicts the example).

qemu just needs to use 'pkg-config' to discover the include path and
libs. Maybe new capstone release has different pkgconfig setup?

--=20

  Sergei
