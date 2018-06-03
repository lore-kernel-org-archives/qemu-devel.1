Received: from eggs.gnu.org ([2001:4830:134:3::10]:50847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kvapss@gmail.com>) id 1fPRZB-0004vB-DF
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 07:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kvapss@gmail.com>) id 1fPRZA-00035S-E6
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 07:52:57 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:45348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kvapss@gmail.com>) id 1fPRZA-00035G-8I
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 07:52:56 -0400
Received: by mail-io0-x22a.google.com with SMTP id l25-v6so12357065ioh.12
	for <qemu-devel@nongnu.org>; Sun, 03 Jun 2018 04:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGO-sgOsRvJbjdDH4dbRJPgVu=oYqvEZdFmzSprDkcn-A6rc5Q@mail.gmail.com>
	<20180601171657.GP3458@redhat.com>
In-Reply-To: <20180601171657.GP3458@redhat.com>
From: kvaps <kvapss@gmail.com>
Date: Sun, 3 Jun 2018 13:52:43 +0200
Message-ID: <CAGO-sgPw4Hedh0oUCCMQEcWkfLnRScHUrhUPrSmdUfeCfKiH3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Mistake on man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Ok, thanks for the clarification.

On Fri, Jun 1, 2018 at 7:17 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Fri, Jun 01, 2018 at 04:47:55PM +0200, kvaps wrote:
> > Hi, here is mistake in man page for qemu-nbd:
> >
> > --- a/qemu-nbd.texi
> > +++ b/qemu-nbd.texi
> > @@ -1,2 +1,2 @@
> > --- a/qemu-nbd.texi
> > -Don't exit on the last connection
> > +++ b/qemu-nbd.texi
> > +Don't exit on the lost connection
>
> It isn't a mistake actually. qemu-nbd can allow multiple concurrent
> client connections, and will exit once the last client closes.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
