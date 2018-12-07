Received: from eggs.gnu.org ([2001:4830:134:3::10]:37696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gVIXW-0004f4-Cg
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gVIXR-0000b9-TU
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:59:42 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gVIXK-0008GM-AT
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:59:32 -0500
Received: by mail-oi1-x244.google.com with SMTP id x202so3709414oif.13
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 07:59:26 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181207094445.GC13784@redhat.com>
References: <20181203164105.29858-1-berrange@redhat.com>
	<08d36eda-e8e7-4ece-edc5-ef436d25e6b7@redhat.com>
	<86756391-b9b7-12d0-f6ec-8766ea7ab4d7@redhat.com>
	<20181207094445.GC13784@redhat.com>
Message-ID: <154419836052.28165.15022129599921698592@sif>
Date: Fri, 07 Dec 2018 09:59:20 -0600
Subject: Re: [Qemu-devel] [qemu-web PATCH] Import historical documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Quoting Daniel P. Berrang=C3=A9 (2018-12-07 03:44:45)
> On Thu, Dec 06, 2018 at 09:01:46PM +0100, Paolo Bonzini wrote:
> > On 04/12/18 11:56, Thomas Huth wrote:
> > > I think it would be best if we find a way to automate this process, e=
.g.
> > > when a new release is tagged, a script generates the docs and puts th=
em
> > > somewhere on the web server, into the right new folder based on the n=
ame
> > > of the tag. However, I don't know the qemu server well enough to know
> > > whether that's possible or not ... maybe Jeff or Paolo can comment on
> > > this...
> > =

> > There are two possibilities: putting the docs on download.qemu.org and
> > going for Marc-Andr=C3=A9's styling solution, or using a dash of sed to
> > remove the <head> and use Jekyll to generate the page.
> =

> I would really like the docs to be properly integrated into the web
> site including navbar / footers, not just using a similar-ish styling.
> =

> > Either way, there isn't much to do on the webserver side, so a better
> > person to ask would be Mike Roth as he's the Guy Who Does The Releases.
> > For either solution he'd have to build the documentation and scp it (if
> > we go for download.qemu.org) or commit it to qemu-web.git (if we go for
> > Jekyll).  I guess he has scripts already to automate part of the release
> > process, but I have no idea if the website update is automated already.
> =

> A third option is to scp the docs to download.qemu.org (perhaps in a hidd=
en
> dir), and then have a jekyll plugin that pulls that in & applies the
> template.

I have scripts to generate/build/test tarballs, but do the uploads manually
and then manually do the qemu-web.git commit. So whether it's an extra uplo=
ad
or and extra commit/commit step works just as well on my end.

Uploading the docs alongs with the tarballs at the appropriate locations
and having jekyll do any additional processing as part of the
_data/releases.yml update/commit would probably be ideal for me, but any of
these approaches should work fine for me. Hidden directory makes sense if we
don't plan to use them directly so we can easily delete them afterward
to save space.

> =

> Regards,
> Daniel
> -- =

> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20
