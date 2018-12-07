Received: from eggs.gnu.org ([2001:4830:134:3::10]:43948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVCgr-0002sm-Cg
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVCgn-000409-7P
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:44:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gVCgn-0003ys-11
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:44:53 -0500
Date: Fri, 7 Dec 2018 09:44:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181207094445.GC13784@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181203164105.29858-1-berrange@redhat.com>
	<08d36eda-e8e7-4ece-edc5-ef436d25e6b7@redhat.com>
	<86756391-b9b7-12d0-f6ec-8766ea7ab4d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86756391-b9b7-12d0-f6ec-8766ea7ab4d7@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Import historical documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Jeff Cody <codyprime@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Dec 06, 2018 at 09:01:46PM +0100, Paolo Bonzini wrote:
> On 04/12/18 11:56, Thomas Huth wrote:
> > I think it would be best if we find a way to automate this process, e=
.g.
> > when a new release is tagged, a script generates the docs and puts th=
em
> > somewhere on the web server, into the right new folder based on the n=
ame
> > of the tag. However, I don't know the qemu server well enough to know
> > whether that's possible or not ... maybe Jeff or Paolo can comment on
> > this...
>=20
> There are two possibilities: putting the docs on download.qemu.org and
> going for Marc-Andr=C3=A9's styling solution, or using a dash of sed to
> remove the <head> and use Jekyll to generate the page.

I would really like the docs to be properly integrated into the web
site including navbar / footers, not just using a similar-ish styling.

> Either way, there isn't much to do on the webserver side, so a better
> person to ask would be Mike Roth as he's the Guy Who Does The Releases.
> For either solution he'd have to build the documentation and scp it (if
> we go for download.qemu.org) or commit it to qemu-web.git (if we go for
> Jekyll).  I guess he has scripts already to automate part of the releas=
e
> process, but I have no idea if the website update is automated already.

A third option is to scp the docs to download.qemu.org (perhaps in a hidd=
en
dir), and then have a jekyll plugin that pulls that in & applies the
template.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
