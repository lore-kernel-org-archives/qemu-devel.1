Received: from eggs.gnu.org ([2001:4830:134:3::10]:55097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHpSP-0005QP-AD
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHpSL-0005fk-H2
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:14:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eHpSL-0005ei-AM
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:14:09 -0500
Date: Thu, 23 Nov 2017 11:14:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171123111403.GH8166@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU 3.0 ? (was: [PATCH for-2.12 v3 01/11] spapr:
 add pseries 2.12 machine type)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Nov 23, 2017 at 10:17:48AM +0000, Peter Maydell wrote:
> On 23 November 2017 at 10:03, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Mon, 13 Nov 2017 08:14:28 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >
> >> By the way, before everybody now introduces "2.12" machine types ... is
> >> there already a consensus that the next version will be "2.12" ?
> >>
> >> A couple of months ago, we discussed that we could maybe do a 3.0 after
> >> 2.11, e.g. here:
> >>
> >>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
> >>
> >> I'd still like to see that happen... Peter, any thoughts on this?
> >
> > So, as I just thought about preparing the new machine for s390x as
> > well: Did we reach any consensus about what the next qemu version will
> > be called?
> 
> I haven't seen any sufficiently solid plan to make me want to
> pick anything except "2.12".

I would suggest we just make major version number changes explicitly an
arbitrary choice. ie just bump the major version for the first release
of each year. Or just always bump it when we get to x.5 o x.9.

We have a planned deprecation process for making incompatible changes
at an arbitrary time, with no need to batch it up in a "big bang" break
the whole world release. This kind of incremental change is much preferred
from libvirt POV, as adapting to a huge pile of changes at the same time
is a much bigger burden to deal with.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
