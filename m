Received: from eggs.gnu.org ([2001:4830:134:3::10]:56909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gSOte-0006Rn-7c
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gSOta-00005L-9P
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:10:34 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gSOta-0008W3-3X
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:10:30 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so2224985otk.8
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 08:10:30 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <87mups82sd.fsf@dusky.pond.sub.org>
References: <5BE31F76020000760003D33A@prv-mh.provo.novell.com>
	<87mups82sd.fsf@dusky.pond.sub.org>
Message-ID: <154350782119.28165.5657834529187289321@sif>
Date: Thu, 29 Nov 2018 10:10:21 -0600
Subject: Re: [Qemu-devel] getting link errors when building for qga-vss.dll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirk Allan <kallan@suse.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

Quoting Markus Armbruster (2018-11-29 06:51:46)
> Cc'ing folks who might be able to help.
> =

> "Kirk Allan" <kallan@suse.com> writes:
> =

> > When I try to build qga-vss.dll I get the following link error:
> >
> > LINK    qga/vss-win32/qga-vss.dll
> > /usr/lib64/gcc/i686-w64-mingw32/8.2.0/../../../../i686-w64-mingw32/bin/=
ld: qga/vss-win32/requester.o: in function `requester_freeze':
> > /src/qemu/qga/vss-win32/requester.cpp:284: undefined reference to `g_as=
sertion_message_expr'
> >
> > I started getting this link error with commit 3ebee3b191e755d3f7311a6a6=
2eea5c9628b221b where assert is redefined to g_assert.
> >
> > Is there something additional I need to add to my configure or make com=
mands to resolve g_assertion_message_expr?
> >
> > My configure command is: ./configure --cross-prefix=3Di686-w64-mingw32-=
 --enable-guest-agent --with-vss-sdk
> >
> > My make command is: make qemu-ga.exe qga/vss-win32/qga-vss.dll

Hi Kirk,

I've sent a patch to fix this here:

  https://patchwork.kernel.org/patch/10682937/

but it was recommended we take a different approach that I wasn't able to
get working in time for 3.1. So you might need to make use of the
posted patch in the meantime. The final fix should go in shortly after
the 3.1 release next week.

> >
> > Thanks,
> > Kirk
>=20
