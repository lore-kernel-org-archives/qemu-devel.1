Received: from eggs.gnu.org ([2001:4830:134:3::10]:39731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et51k-0005sy-81
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et51h-0002BV-3U
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:20:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et51g-0002BF-Ux
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:20:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D300406E8BD
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:20:34 +0000 (UTC)
Date: Tue, 6 Mar 2018 13:20:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180306052023.GB3615@xz-mi>
References: <20180305065040.10353-1-peterx@redhat.com>
	<20180305065040.10353-2-peterx@redhat.com>
	<CAMxuvazSk=YL9boVBbJ6vb74zRXqEasPnp60Aj_JbjAbn=7i0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvazSk=YL9boVBbJ6vb74zRXqEasPnp60Aj_JbjAbn=7i0w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] vl: export machine_init_done
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

On Mon, Mar 05, 2018 at 12:48:27PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Mar 5, 2018 at 7:50 AM, Peter Xu <peterx@redhat.com> wrote:
> > We have that variable but not exported.  Export that so modules can h=
ave
> > a way to poke on whether machine init has finished.
>=20
> Which modules?

E.g., the mux code in patch 5.

>=20
> > Meanwhile, set that up even before calling the notifiers, so that
> > notifiers who may depend on this field will get a correct answer.
> >
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks,

--=20
Peter Xu
