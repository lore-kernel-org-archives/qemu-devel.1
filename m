Received: from eggs.gnu.org ([2001:4830:134:3::10]:36280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZvvd-0001oz-5H
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZvvc-0006bT-Ec
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:14:57 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:33998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZvvc-0006au-8d
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:14:56 -0400
Received: by mail-wm0-x234.google.com with SMTP id l81so25385814wmg.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 02:14:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725061158.10745-1-f4bug@amsat.org>
References: <20170725061158.10745-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 10:14:34 +0100
Message-ID: <CAFEAcA8QV9iScELrbOYXGmsZ2GeU9bYoNaO4mGHtNHgP8aOeWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: add
 all-user/all-linux-user/all-softmmu meta-targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On 25 July 2017 at 07:11, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Useful to build a whole set at once.

You can already do this by not specifying a --target-list=3D
option and using whichever of --disable-system and
--disable-user you need to skip the ones you don't want,
can't you?

thanks
-- PMM
