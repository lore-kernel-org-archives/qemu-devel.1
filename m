Received: from eggs.gnu.org ([2001:4830:134:3::10]:58973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGmZq-0006hg-5k
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGmZm-000162-6g
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:53:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGmZm-00015w-15
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:52:58 -0500
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-35-marcandre.lureau@redhat.com>
	<d7d971e2-af70-0ea5-7c0e-8b70c547c2cd@redhat.com>
	<CAJ+F1CL7V-ACHV66Jx5ZRn8Xk3KfmeOW8gE6zh7QsXgW4N=bMw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6860218-ce69-cfff-bbd6-5ae02b90af23@redhat.com>
Date: Tue, 13 Dec 2016 13:52:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL7V-ACHV66Jx5ZRn8Xk3KfmeOW8gE6zh7QsXgW4N=bMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 34/54] char: create chardev-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org



On 13/12/2016 13:40, Marc-Andr=C3=A9 Lureau wrote:
>=20
>     On 12/12/2016 23:43, Marc-Andr=C3=A9 Lureau wrote:
>     > This will help to split char.c in several units without having to
>     > reference them all everywhere.
>     >
>     > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m
>     <mailto:marcandre.lureau@redhat.com>>
>     > ---
>     >  Makefile               | 3 ++-
>     >  Makefile.objs          | 4 +++-
>     >  Makefile.target        | 3 +++
>     >  chardev/Makefile.objs  | 2 +-
>     >  tests/Makefile.include | 4 ++--
>     >  5 files changed, 11 insertions(+), 5 deletions(-)
>=20
>     Any reason to do this instead of keeping common-obj-y?
>=20
>=20
> common-obj-y has a lot of other units, including vl.o, making it not
> possible to link with tests/test-char for ex. However, if we changed it
> to link with everything except vl.c (or other changes), we may be able
> to link with and test spice-qemu-char. The resulting binaries will
> likely explode though.

Ok, so it's for tests.  Fair enough!

Paolo
