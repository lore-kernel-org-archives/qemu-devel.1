Received: from eggs.gnu.org ([2001:4830:134:3::10]:33531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1celqN-0008RR-6g
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1celqM-0000X4-EA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:57:15 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1celqM-0000Wd-8T
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:57:14 -0500
Received: by mail-wr0-x232.google.com with SMTP id 89so28767893wrr.3
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 08:57:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 16:56:52 +0000
Message-ID: <CAFEAcA97jqn5XBYgWq4OKLs7ofXrf9aT6+KZP4JdNUkfpOgqzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chad Joan <chadjoan@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 February 2017 at 16:54, Chad Joan <chadjoan@gmail.com> wrote:
> Regarding the signature: IIRC, setting up certificates on a machine using
> gpg can be quite time consuming and learning-intensive if you've never
> needed to do it before.

There is no requirement for gpg (except for maintainers submitting
pull requests). When we say "We need a signed-off-by" what we mean
is literally "your commit message must include a line of the form
Signed-off-by Some Person <some.person@wherever.com>".

I agree that gpg is terrible as a UI and we definitely don't
want it in our patch workflow for submitters ;-)

thanks
-- PMM
