Received: from eggs.gnu.org ([2001:4830:134:3::10]:53023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDmfQ-0001lX-P0
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDmfM-0001Ky-Vz
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:59:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDmfM-0001KY-Pj
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:59:08 -0400
Date: Wed, 2 May 2018 08:59:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180502075904.GF3308@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
	<CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, May 02, 2018 at 12:43:10AM -0700, Liviu Ionescu wrote:
> On 2 May 2018 at 10:38:09, Cornelia Huck (cohuck@redhat.com) wrote:
> 
> > > > >> a) Bump major version once a year, so we'll have 3.0, 3.1,
> > 3.3,
> > > >> 4.0, 4.1, 4.2, 5.0, ...etc We missed the first release this
> > > >> year, so we would only have 3.0 and 3.1 this year.
> > > >>
> > > >> b) Bump major release when minor version gets double-digits.
> > > >> eg 3.0, 3.1, ...., 3.9, 3.9, 4.0, ...., 4.9, 5.0...
> > >
> > > It's just a matter of taste, but I think I'd prefer variant b).
> > That
> > > will bump the major release approx. every three years which
> > sounds like
> > > a good time frame for me.
> >
> > I think anything that keeps release numbers in ascending order
> > would
> > basically work :)
> 
> not really.
> 
> I suggest you use semantic versioning:
> 
> https://semver.org

No, not semver. It is not a good match for the way QEMU is handling
incompatible changes. Our deprecation policy lets us include incompatible
changes in *any* release. So with semver that would force a major version
bump on every release which is madness.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
