Received: from eggs.gnu.org ([2001:4830:134:3::10]:53873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gS1CB-0003Xt-5f
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gS178-0002IW-8m
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:47:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gS176-0002G7-Fx
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:46:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so26068300qtj.10
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 06:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20181128142135.15900-1-marcandre.lureau@redhat.com>
	<20181128143307.GM24355@redhat.com>
In-Reply-To: <20181128143307.GM24355@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Nov 2018 18:46:37 +0400
Message-ID: <CAMxuvayS9ja1H-ftsahECEJU+T6EE8-KcYTpDnii8KdJHwaYmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] configure: bump spice-server
 required version to 0.12.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, Frediano Ziglio <fziglio@redhat.com>

Hi

On Wed, Nov 28, 2018 at 6:33 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Nov 28, 2018 at 06:21:35PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Looking at chardev/spice.c code, I realize compilation was broken for
> > a while with spice-server < 0.12.3. I propose to bump required version
> > to 0.12.6, released 3y ago, instead of adding more #ifdef.
>
> As mentioned last time this patch was posted[1], any changes in the
> min required versions should follow our supported build platforms
> support statement:

Sorry, I totally forgot that.

>
>   https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms
>
> Preferrably the commit message should list the version in each of the
> main distros, such as in a0722409bcb980ecdab8330d4c716a73c9fcb489
>
> At a glance it looks like Debian Jessie is likely to be the determining
> vote with 0.12.5 as its newest version.

https://repology.org/metapackage/spice/versions

Debian Oldstable
oldstable/main spice 0.12.5

https://wiki.debian.org/DebianReleases

~June 6th 2020 (LTS)

But the current stable, Stretch, was released on June 17th 2017.

So we are stuck with spice server 0.12.5 until +2y, June 17th 2019 ?


>
> Regards,
> Daniel
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00905.html
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
