Received: from eggs.gnu.org ([2001:4830:134:3::10]:55395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erLw5-0005Hh-4H
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erLw2-0002QZ-3A
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:59:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1erLw1-0002QJ-VE
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:59:38 -0500
Date: Thu, 1 Mar 2018 11:59:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180301115916.634904f3.cohuck@redhat.com>
In-Reply-To: <CAJ+F1CJVyrK5PtpavMKuGwus9RC_KDjx9i2csduW9JMdV8tRbg@mail.gmail.com>
References: <1519888086-4207-1-git-send-email-jusual@mail.ru>
	<CAJ+F1CJVyrK5PtpavMKuGwus9RC_KDjx9i2csduW9JMdV8tRbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] use g_path_get_basename instead of basename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 1 Mar 2018 10:47:42 +0100
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Thu, Mar 1, 2018 at 8:08 AM, Julia Suvorova via Qemu-devel
> <qemu-devel@nongnu.org> wrote:
> > basename(3) and dirname(3) modify their argument and may return
> > pointers to statically allocated memory which may be overwritten by
> > subsequent calls.
> > g_path_get_basename and g_path_get_dirname have no such issues, and
> > therefore more preferable.
> >
> > Signed-off-by: Julia Suvorova <jusual@mail.ru> =20
>=20
> What about adding a warning for basename()/dirname() usage in
> scripts/checkpatch.pl ?

+1 to that.

>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
