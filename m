Received: from eggs.gnu.org ([2001:4830:134:3::10]:56893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cGmPC-0000Nh-OO
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cGmP7-0006u7-NY
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:42:02 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cGmP7-0006pG-Gb
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:41:57 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so18108477wmu.0
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 04:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-35-marcandre.lureau@redhat.com>
	<d7d971e2-af70-0ea5-7c0e-8b70c547c2cd@redhat.com>
In-Reply-To: <d7d971e2-af70-0ea5-7c0e-8b70c547c2cd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Dec 2016 12:40:22 +0000
Message-ID: <CAJ+F1CL7V-ACHV66Jx5ZRn8Xk3KfmeOW8gE6zh7QsXgW4N=bMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi

On Tue, Dec 13, 2016 at 2:18 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 12/12/2016 23:43, Marc-Andr=C3=A9 Lureau wrote:
> > This will help to split char.c in several units without having to
> > reference them all everywhere.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  Makefile               | 3 ++-
> >  Makefile.objs          | 4 +++-
> >  Makefile.target        | 3 +++
> >  chardev/Makefile.objs  | 2 +-
> >  tests/Makefile.include | 4 ++--
> >  5 files changed, 11 insertions(+), 5 deletions(-)
>
> Any reason to do this instead of keeping common-obj-y?
>
>
common-obj-y has a lot of other units, including vl.o, making it not
possible to link with tests/test-char for ex. However, if we changed it to
link with everything except vl.c (or other changes), we may be able to link
with and test spice-qemu-char. The resulting binaries will likely explode
though.

Thanks,
>
> Paolo
>
> --
Marc-Andr=C3=A9 Lureau
