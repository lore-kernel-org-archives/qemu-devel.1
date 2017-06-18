Received: from eggs.gnu.org ([2001:4830:134:3::10]:55884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMeum-00068N-BB
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 14:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMeul-0004Wl-8q
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 14:27:12 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dMeul-0004Wd-2I
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 14:27:11 -0400
Received: by mail-wr0-x236.google.com with SMTP id r103so61079936wrb.0
	for <qemu-devel@nongnu.org>; Sun, 18 Jun 2017 11:27:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y3spcqfg.fsf@frigg.lan>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615220501.GA26408@flamenco> <87y3spcqfg.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Jun 2017 19:26:49 +0100
Message-ID: <CAFEAcA9ue9UbZ_q=hgOnqkkLG-6Pup1ykTb8UBWAWS3ztSBQcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] translator mega-patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 18 June 2017 at 15:37, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
> I seem to remember we discussed this at some point before I sent the firs=
t
> version, to allow multiple targets on the same binary, but decided agains=
t it.
>
> Still, I can leave the ops struct in place without even trying to support
> multiple targets. It should be a little bit slower (using function pointe=
rs
> instead of a "template"), but I don't think performance will suffer that =
much
> since we're at the translation path.
>
> Any other opinions on this and the point above?

Multiple targets in one binary is one of those things that I would
like to see us do some day. So while I wouldn't do huge amounts
of work purely to support it, if we have two designs which are
otherwise more-or-less equivalent and only one has a path available
to support multi-target binaries we should probably prefer that one.

thanks
-- PMM
