Received: from eggs.gnu.org ([2001:4830:134:3::10]:38462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cOrib-0006pd-Aw
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cOria-0006b3-Lz
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:59:29 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:34744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cOria-0006av-EB
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:59:28 -0500
Received: by mail-ua0-x235.google.com with SMTP id 34so320039391uac.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 11:59:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8760lu65gs.fsf@linaro.org>
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
	<8760lu65gs.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Jan 2017 19:59:07 +0000
Message-ID: <CAFEAcA8Ssvh54AtqoHZLHaAorjRBkZJHcYtOJNoMSzjkGQR1qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Sean Bruno <sbruno@freebsd.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 January 2017 at 18:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> Apart from syscall mapping and backend calls to the BSD ABI what
> differences are there between the two user-mode implementations?

I'm a bit wary of sharing code between the two just because
I think we'd end up breaking bsd-user all the time because
nobody who works on linux-user is in a position to test it
at all.

thanks
-- PMM
