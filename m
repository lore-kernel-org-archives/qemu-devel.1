Received: from eggs.gnu.org ([2001:4830:134:3::10]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXQWG-00074w-Lh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXQWA-0001tD-Sx
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:55:12 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXQWA-0001sk-Em
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:55:06 -0500
Received: by mail-oi1-x241.google.com with SMTP id h25so1540438oig.1
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 04:55:06 -0800 (PST)
MIME-Version: 1.0
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<20181213101940.GC5171@redhat.com>
	<CAFEAcA_rBakXJZuPGgcsvC9m75oeTbg=q-=mOCFJuungF-VR8g@mail.gmail.com>
	<87o99pa9w8.fsf@dusky.pond.sub.org> <20181213123908.GI5171@redhat.com>
In-Reply-To: <20181213123908.GI5171@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 12:54:54 +0000
Message-ID: <CAFEAcA9z=oDWYBv_C3gyL5xSr8rBGk=zOmZ0iuQd+uQxbXUSCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 13 Dec 2018 at 12:39, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> The problem with this assertion is that there's many places which
> call qemu_set_nonblock, so you don't know which code to look at,
> as we don't know the caller.

In an ideal world assert would print a stack backtrace :-)

thanks
-- PMM
