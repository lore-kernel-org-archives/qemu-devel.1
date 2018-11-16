Received: from eggs.gnu.org ([2001:4830:134:3::10]:39839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNajS-0002hj-Gd
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNajR-0007gi-TA
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:48:10 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:35301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNajR-0007gS-OS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:48:09 -0500
Received: by mail-oi1-x22a.google.com with SMTP id v6so6870404oif.2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 01:48:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181116050134.GA16550@xz-x1>
References: <20181115085808.GH27915@xz-x1>
	<162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
	<20181116025304.GC11565@xz-x1>
	<CANCZdfrozw4f+ntOyUuX+N1Ny1j+BBEqhuowPXk2sRTSBzCGEw@mail.gmail.com>
	<20181116050134.GA16550@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 09:47:48 +0000
Message-ID: <CAFEAcA_r6QmSHHpvRCAOic1EppZamfhwFVQ_R7dUvNzomfNsgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

On 16 November 2018 at 05:01, Peter Xu <peterx@redhat.com> wrote:
> I would guess there aren't many people like me to prefer booting a VM
> using console, though I agree that it'll be nice if we put something
> into the prebuilt images like what's suggested by Ilya (and so far I
> don't see anything bad with that):

As it happens I would have preferred the instructions on
the QEMU wiki to work with a pure serial console but was unable
to get that working so defaulted to graphics. (I didn't try very
hard: x86 in general is much worse for getting serial boot
working than other architectures, partly because of the BIOS.)

thanks
-- PMM
