Received: from eggs.gnu.org ([2001:4830:134:3::10]:34484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwRoo-0005Oz-6R
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwRom-0000bZ-Q1
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:44:58 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwRom-0000a8-J3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:44:56 -0400
Received: by mail-wm0-x241.google.com with SMTP id r136so6960192wmf.3
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 04:44:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57170a30-6932-a8f9-343c-1ce1f7c331b1@vivier.eu>
References: <20170922140237.10869-1-carenas@gmail.com>
	<20170922140237.10869-6-carenas@gmail.com>
	<57170a30-6932-a8f9-343c-1ce1f7c331b1@vivier.eu>
From: Carlo Arenas <carenas@gmail.com>
Date: Mon, 25 Sep 2017 04:44:53 -0700
Message-ID: <CAPUEspjFsVQGYX08A3QB6+E7-ESok6Fe6RFDwdawNrWf_=gYNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 5/6] linux-user: fix 64bit versions of sparc
 and mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, riku.voipio@iki.fi

On Fri, Sep 22, 2017 at 10:01 AM, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 22/09/2017 =C3=A0 16:02, Carlo Marcelo Arenas Bel=C3=B3n a =C3=A9crit =
:
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > ---
> >  linux-user/mips64/sockbits.h  | 1 +
> >  linux-user/socket.h           | 4 ++--
> >  linux-user/sparc64/sockbits.h | 1 +
>
> Who includes the two new files?
>

No one yet, but hopefully will make clearer to anyone looking later for
arch specific values that they were indeed equivalent to their non 64bit
versions.

It also mimics what termbits.h is doing and so might allow in the future to
drop the common socket.h for an arch specific one, which will be easier to
maintain and keep in sync with the linux kernel.


> Moreover TARGET_MIPS/TARGET_SPARC (base arch) are always defined when
> TARGET_MIPS64/TARGET_SPARC64 (target arch) are defined.
>
> So I think this patch is useless.
>

ok, glad to know I was wrong about those architectures being broken, still
suspect s390x is though, but don't want to address this in this series,
like I didn't want to include the bigger refactoring explained above.

I am curious also over users of those architectures and their suggestions,
which is why I sent this series as an RFC; is there a better forum for that
somewhere else?

Carlo
