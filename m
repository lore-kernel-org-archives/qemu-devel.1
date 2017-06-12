Received: from eggs.gnu.org ([2001:4830:134:3::10]:58227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dKMxR-0005hl-Df
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dKMxO-0002Gw-AS
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dKMxO-0002Gg-1s
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:52:26 -0400
Date: Mon, 12 Jun 2017 06:52:21 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2049897596.33250900.1497264741149.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA83HnSBD+c+pyUot+v-yBfhFvHU1J_zAb9ZqY3f9f-Sfg@mail.gmail.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
	<CAFEAcA83HnSBD+c+pyUot+v-yBfhFvHU1J_zAb9ZqY3f9f-Sfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] QAPI patches for 2017-06-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi

----- Original Message -----
> On 9 June 2017 at 14:46, Markus Armbruster <armbru@redhat.com> wrote:
> > The following changes since commit
> > 64175afc695c0672876fbbfc31b299c86d562cb4:
> >
> >   arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06=
-07
> >   17:21:44 +0100)
> >
> > are available in the git repository at:
> >
> >   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-06-09
> >
> > for you to fetch changes up to 9f70c3652654d59a1cc0e2ef4cc5b0e541d93579=
:
> >
> >   tests/qdict: check more get_try_int() cases (2017-06-09 13:48:45 +020=
0)
> >
> > ----------------------------------------------------------------
> > QAPI patches for 2017-06-09
> >
>=20
> Some compilers don't like the assert(0) idiom used in qnum.c to
> say "code flow doesn't reach end of function":
>=20
> /home/petmay01/linaro/qemu-for-merges/qobject/qnum.c: In function
> =E2=80=98qnum_get_double=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/qobject/qnum.c:162:1: error:
> control reaches end of non-void function [-Werror=3Dreturn-type]
>  }
>  ^
> /home/petmay01/linaro/qemu-for-merges/qobject/qnum.c: In function
> =E2=80=98qnum_to_string=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/qobject/qnum.c:200:1: error:
> control reaches end of non-void function [-Werror=3Dreturn-type]
>  }
>  ^
>=20
> (probably older gcc; that was the w32 gcc compiler; one of
> patchew's build environments fails the same way).
>=20
> I think one common working idiom for this is:
> int foo(void) {
>    switch (whatever) {
>        case X:
>           return 0;
>        case Y:
>           return 1;
>        default:
>           g_assert_not_reached();
>    }
> }
>=20
> Can you fix and resend the pullreq, please?

Markus made me switch from g_assert_not_reached() to assert(0) in v3.

He is on PTO this week, if you don't mind (as you wanted this series applie=
d quickly), you could fix it by adding dummy return?
