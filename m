Received: from eggs.gnu.org ([2001:4830:134:3::10]:56984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gSHbI-0006S3-8W
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gSHbE-0002WS-2h
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:23:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gSHbD-0002Uz-Of
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:23:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so1073565qtc.2
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 00:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20181128155932.16171-1-marcandre.lureau@redhat.com>
	<20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
In-Reply-To: <20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Nov 2018 12:22:51 +0400
Message-ID: <CAMxuvaywjHiBPLuaqhV1H_0XnariFHm=JLeo3fptSKLaZbFo9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3] configure: bump spice-server
 required version to 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hoffmann, Gerd" <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Frediano Ziglio <fziglio@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>

On Thu, Nov 29, 2018 at 12:09 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Nov 28, 2018 at 07:59:32PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Looking at chardev/spice.c code, I realize compilation was broken for
> > a while with spice-server < 0.12.3. Let's bump required version
> > to 0.12.5, released May 19 2014, instead of adding more #ifdef.
>
> Oh, you did the 0.12.5 patch already.  Scratch my other reply then.
>
> > -  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
> > +  if $pkg_config --atleast-version=3D0.12.5 spice-server && \
> >       $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
>
> I think we should adjust spice-protocol too to whatever 0.12.5 requires
> to build.
>

Why not leave that responsibility to pkg-config, and only require in
qemu what is required there?
