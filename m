Received: from eggs.gnu.org ([2001:4830:134:3::10]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et589-0007TV-Ir
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et586-0004Ps-GX
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:27:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et586-0004P5-C2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:27:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3E2D4001416
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:27:13 +0000 (UTC)
Date: Tue, 6 Mar 2018 13:27:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180306052706.GC3615@xz-mi>
References: <20180305065040.10353-1-peterx@redhat.com>
	<20180305065040.10353-6-peterx@redhat.com>
	<CAMxuvaxRU0VQqUka9x=DNHkoYfzQzLAqw3rx38bEedvnDNzA2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaxRU0VQqUka9x=DNHkoYfzQzLAqw3rx38bEedvnDNzA2Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] chardev: introduce chr_machine_done
 hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On Mon, Mar 05, 2018 at 11:54:22AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Mar 5, 2018 at 7:50 AM, Peter Xu <peterx@redhat.com> wrote:
> > Introduce ChardevClass.chr_machine_done() hook so that chardevs can r=
un
> > customized procedures after machine init.
> >
> > There was an existing mux user already that did similar thing but use=
d a
> > raw machine done notifier.  Generalize it into a framework, and let t=
he
> > mux chardevs provide such a class-specific hook to achieve the same
> > thing.  Then we can move the mux related code to the char-mux.c file.
> >
> > Since at it, replace the mux_realized variable with the global
> > machine_init_done varible.
> >
> > This notifier framework will be further leverged by other type of
> > chardevs soon.
> >
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> patchew caught that:
> tests/test-char.o: In function `char_mux_test':
> /tmp/qemu-test/src/tests/test-char.c:169: undefined reference to
> `muxes_realized'

Yeh, I replied to patchew mail with a fix to be squashed.

I was planning to repost some days later, but let me repost now in
case that it may ease the reviewers a bit.  Thanks,

--=20
Peter Xu
