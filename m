Received: from eggs.gnu.org ([2001:4830:134:3::10]:46215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIedv-0004yV-FF
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIedu-0002R9-C8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:21:15 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dIedu-0002Qf-4d
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:21:14 -0400
Received: by mail-lf0-x241.google.com with SMTP id v20so1427551lfa.2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 10:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
	<20170529084546.26500-12-marcandre.lureau@redhat.com>
	<20170607164115.GE1919@perard.uk.xensource.com>
In-Reply-To: <20170607164115.GE1919@perard.uk.xensource.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 07 Jun 2017 17:20:59 +0000
Message-ID: <CAJ+F1CLEJeeQqHRA5=P+_0wri-cXffi4SSkuTeF1LBzACB_8bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/14] char: move CharBackend handling
 in char-fe unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: pbonzini@redhat.com, xen-devel@lists.xen.org, qemu-devel@nongnu.org, f4bug@amsat.org

Hi

On Wed, Jun 7, 2017 at 8:57 PM Anthony PERARD <anthony.perard@citrix.com>
wrote:

> On Mon, May 29, 2017 at 12:45:43PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Move all the fronted struct and methods to a seperate unit. This avoids
> > accidentally mixing backend and frontend calls, and helps with
> readibilty.
> >
> > Make qemu_chr_replay() a macro shared by both char and char-fe.
> >
> > Export qemu_chr_write(), and use a macro for qemu_chr_write_all()
> >
> > (nb: yes, CharBackend is for char frontend :)
>
> Hi Marc-Andr=C3=A9,
>
> Following this patch, we are not able anymore to launch QEMU with
> -monitor /dev/null.
> > qemu-system-i386: -monitor /dev/null: 'tty' is not a valid char driver
> name
>
> FYI, the full command line used:
> /usr/lib/xen/bin/qemu-system-i386 -xen-domid 0 \
>     -xen-attach -name dom0 -nographic -M xenpv -daemonize \
>     -monitor /dev/null -serial /dev/null -parallel /dev/null \
>     -nodefaults -no-user-config \
>     -pidfile /var/run/xen/qemu-dom0.pid
>
>
My bad, and the worse is that CI actually gave me some hints of the
regression because the ChardevAlias array was empty.

I dropped char-serial.h and char-parellel.h in this patch, it shouldn't be.
I'll send fixes and add some tests.

Thanks for the report!
--=20
Marc-Andr=C3=A9 Lureau
