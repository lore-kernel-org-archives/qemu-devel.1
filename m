Received: from eggs.gnu.org ([2001:4830:134:3::10]:42527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dRz99-00004q-40
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dRz98-00075p-47
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:04:03 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:33819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dRz97-00074b-RQ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:04:02 -0400
Received: by mail-lf0-x229.google.com with SMTP id l13so100596126lfl.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 04:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170629185525.GC2399@work-vm>
In-Reply-To: <20170629185525.GC2399@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 03 Jul 2017 11:03:48 +0000
Message-ID: <CAJ+F1CKEEaRTfNiGU3cDYedqRYD9a+teG7t-F1YhGte3J-EbfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, a.perevalov@samsung.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

Hi

On Thu, Jun 29, 2017 at 8:56 PM Dr. David Alan Gilbert <dgilbert@redhat.com=
>
wrote:

> * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Hi,
> >   This is a RFC/WIP series that enables postcopy migration
> > with shared memory to a vhost-user process.
> > It's based off current-head + Juan's load_cleanup series, and
> > Alexey's bitmap series (v4).  It's very lightly tested and seems
> > to work, but it's quite rough.
>
> Marc-Andr=C3=A9 asked if I had a git with it all applied; so here we are:
> https://github.com/dagrh/qemu/commits/vhost
> git@github.com:dagrh/qemu.git on the vhost branch
>
>
I started looking at the series, but I am not familiar with ufd/postcopy.
Could you update vhost-user.txt to describe the new messages? Otherwise,
make check hangs in /x86_64/vhost-user/connect-fail (might be an unrelated
regression?) Thanks
--=20
Marc-Andr=C3=A9 Lureau
