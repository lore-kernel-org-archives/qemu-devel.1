Received: from eggs.gnu.org ([2001:4830:134:3::10]:45444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLU9D-0006QB-14
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTur-00061w-Or
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:07:16 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:60324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLTur-00061G-Hx
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:07:13 -0500
Date: Sat, 10 Nov 2018 15:07:11 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181110140711.gfhxxmzpgtklhiag@function>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
	<20181110134548.14741-11-marcandre.lureau@redhat.com>
	<20181110135335.pw35cgnbyuzgbecx@function>
	<CAFEAcA93Vszet7tq4gDm7UhoHmf2MBeBvHM_spxX-8A34-LEBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA93Vszet7tq4gDm7UhoHmf2MBeBvHM_spxX-8A34-LEBg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 10/13] slirp: improve subprocess
 socket creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell, le sam. 10 nov. 2018 14:04:10 +0000, a ecrit:
> On 10 November 2018 at 13:53, Samuel Thibault <samuel.thibault@gnu.org>=
 wrote:
> > Marc-Andr=C3=A9 Lureau, le sam. 10 nov. 2018 17:45:45 +0400, a ecrit:
> >> @@ -163,23 +183,14 @@ fork_exec(struct socket *so, const char *ex)
> >>               exit(1);
> >>
> >>        default:
> >> -             qemu_add_child_watch(pid);
> >> -                /*
> >> -                 * XXX this could block us...
> >> -                 * XXX Should set a timer here, and if accept() doe=
sn't
> >> -                 * return after X seconds, declare it a failure
> >> -                 * The only reason this will block forever is if so=
cket()
> >> -                 * of connect() fail in the child process
> >> -                 */
> >
> > At least this got fixed by Peter lately, so please rebase.
>=20
> My patches aren't in master yet, though -- do you have a
> public slirp tree that slirp patches should be based on?
> (I'm assuming you're planning a pull request too.)

Ah, right.
My tree is documented in MAINTAINERS :)
git https://people.debian.org/~sthibault/qemu.git slirp

Let me push that to master indeed.

Samuel
