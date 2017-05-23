Received: from eggs.gnu.org ([2001:4830:134:3::10]:51405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dD4j7-0004uR-Gg
	for qemu-devel@nongnu.org; Tue, 23 May 2017 03:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dD4j4-0007G7-B2
	for qemu-devel@nongnu.org; Tue, 23 May 2017 03:59:33 -0400
Date: Tue, 23 May 2017 09:59:27 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170523075927.vhxqlurygwycfwsu@var.youpi.perso.aquilenet.fr>
References: <149546869825.1005.10210133978512879518@c05f1edc8ed1>
	<48dfeca5-0640-796f-66ce-8cab198fcaef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48dfeca5-0640-796f-66ce-8cab198fcaef@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tests/libqtest: Print error instead of
 aborting when env variable is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-trivial@nongnu.org, armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Thomas Huth, on mar. 23 mai 2017 09:25:30 +0200, wrote:
> > /tmp/qemu-test/src/slirp/tcp_input.c: In function =E2=80=98tcp_input=E2=
=80=99:
> > /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.i=
p_p=E2=80=99 may be used uninitialized in this function
>=20
> I've never seen these warnings in tcp_input.c before ... and they also
> look like false positives too me ...=20

They are.  It's the classical false-positive:

int foo;
if (blah)
	foo =3D 1;
...
if (blah)
	f(foo);

where gcc doesn't realize it's the same condition between the
initialization and the use.

If that poses problem, we can force a dumb initialization...

Samuel
