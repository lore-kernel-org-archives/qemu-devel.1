Received: from eggs.gnu.org ([2001:4830:134:3::10]:53156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fD67b-0003b9-QG
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fD67Y-0003cT-Ht
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:33:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fD67Y-0003c1-CC
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:33:24 -0400
Date: Mon, 30 Apr 2018 11:33:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180430103312.GH3249@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Apr 27, 2018 at 04:51:03PM +0100, Peter Maydell wrote:
> Hi; I usually let people forget about releases for a month or
> so before bringing this topic up, but:
> 
> (1) do we want to call the next release 2.13, or something else?
> There's no particular reason to bump to 3.0 except some combination of
>  * if we keep going like this we'll get up to 2.42, which starts to
>    get silly
>  * Linus-style "avoid being too predictable"
>  * triskaidekaphobia
> but maybe we should anyway?

I'm in favour of changnig the major version to 3.0, but when we do
so we should also define a clear rule we can follow for major version
bumps, so we don't have the same silly debate for how we pick 4.0,
5.0 etc.

Given, that we have a clear deprecation process now, my view is that
we should formally declare that major version numbers changes are
meaningless. As soon as you try to assign special meaning to major
version changes, you open the door to endless debate about whether
a particular set of changes is meaningful enough to justify the
major version change, leading to eventually 2.42. 

Two possible options

 a) Bump major version once a year, so we'll have 3.0, 3.1, 3.3,
    4.0, 4.1, 4.2, 5.0, ...etc  We missed the first release this
    year, so we would only have 3.0 and 3.1 this year.

 b) Bump major release when minor version gets double-digits.
    eg 3.0, 3.1, ...., 3.9, 3.9, 4.0, ...., 4.9, 5.0...

Personally I'd go for (a). If we do this, it doesn't preclude
us from just happening to do some releases that are backwards
incompatible. Our deprecation policy has provided us a way to
have a backwards incompatible change in ANY release we make.
We just have to ensure people are forewarned of what's coming.

If it was an incredibly large & disruptive incompatible change,
we might none the less choose to align its arrival with a major
version bump. That's ok. We simply do not require that a major
version change has to have a major incompatibility.

> (3) retrospective, lessons learned &c
>  * please remember that if every single submaintainer submits
>    a pull request on the morning of an RC, it is physically
>    not possible for me to process all those pulls in time to
>    tag the RC that day. We had several RCs which got delayed
>    by a day because of this; please try to submit earlier
>    rather than later...
>  * provide your opinions here ?

It is moderately rare that we have a huge new subsystem like RiscV
enter tree during a release cycle. Given our experiance of this
though, it is clear that when such new subsystems arrive, we need
one or more existing maintainers to mentor the submitter wrt QEMU
processes. We saw that is is unreasonable to expect a new comer
to QEMU development to figure it all out for themselves, and Peter
doesn't have the time to do this mentoring while also dealing with
existing merge workload.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
