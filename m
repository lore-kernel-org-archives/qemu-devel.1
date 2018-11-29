Received: from eggs.gnu.org ([2001:4830:134:3::10]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSK7G-0007YL-58
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSK7C-0002YH-0x
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:04:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSK7B-0002Wk-Qi
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:04:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B4E53002C6D
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:04:13 +0000 (UTC)
Date: Thu, 29 Nov 2018 11:04:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181129110407.GC25007@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181128153858.11845-1-berrange@redhat.com>
	<f73a6661-83a1-73fa-d087-a8d9c9aaaff5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f73a6661-83a1-73fa-d087-a8d9c9aaaff5@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] download: document version
 numbering scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Nov 29, 2018 at 11:58:22AM +0100, Thomas Huth wrote:
> On 2018-11-28 16:38, Daniel P. Berrang=C3=A9 wrote:
> > The new version numbering scheme was mentioned in the blog post
> > announcing 3.0 previously, but this will fall out of view over
> > time. It is thus preferrable to mention this on the download page
> > too.
> >=20
> > Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  download.html | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >=20
> > diff --git a/download.html b/download.html
> > index 5a1e4ea..bbdc00c 100644
> > --- a/download.html
> > +++ b/download.html
> > @@ -39,6 +39,30 @@ permalink: /download/
> >  	{% include_relative _download/source.html %}
> >  </article>
> >  </div>
> > +
> > +<h2>Version numbering</h2>
> > +<div>
> > +  <p>
> > +  Since version 3.0.0, QEMU uses a time based version numbering sche=
me:
> > +  </p>
> > +<ul>
> > +<dt>major</dt>
> > +<dd>incremented by 1 for the first release of the year</dd>
> > +<dt>minor</dt>
> > +<dd>reset to 0 with every major increment, otherwise incremented by =
1 for each release from git master</dd>
> > +<dt>micro</dt>
> > +<dd>always 0 for releases from git master, incremented by 1 for each=
 stable branch release</dd>
> > +</ul>
>=20
> HTML validator (https://validator.w3.org) complains here:
>=20
> * Element dt not allowed as child of element ul in this context.
>=20
> * Element dt not allowed as child of element ul in this context.

Oh fun, browsers still rendered it correctly despite being wrong :-)

>=20
> Since I don't want to mess up your intended formatting, could you pleas=
e
> fix it on your own and send a v3?

I've sent a v3 with s/ul/dl/=20


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
