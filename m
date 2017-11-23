Received: from eggs.gnu.org ([2001:4830:134:3::10]:50265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHpl8-0007WI-I0
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHpl5-0002VR-9p
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:33:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eHpl5-0002Ur-1L
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:33:31 -0500
Date: Thu, 23 Nov 2017 11:33:24 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171123113324.GJ8166@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<20171123111105.GG8166@redhat.com>
	<a6581131-852d-f67f-6169-8721134ea763@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6581131-852d-f67f-6169-8721134ea763@redhat.com>
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Nov 23, 2017 at 12:24:24PM +0100, Thomas Huth wrote:
> On 23.11.2017 12:11, Daniel P. Berrange wrote:
> > On Thu, Nov 23, 2017 at 11:57:34AM +0100, Thomas Huth wrote:
> >> On 23.11.2017 11:17, Peter Maydell wrote:
> >>> On 23 November 2017 at 10:03, Cornelia Huck <cohuck@redhat.com> wrote:
> >>>> On Mon, 13 Nov 2017 08:14:28 +0100
> >>>> Thomas Huth <thuth@redhat.com> wrote:
> >>>>
> >>>>> By the way, before everybody now introduces "2.12" machine types ... is
> >>>>> there already a consensus that the next version will be "2.12" ?
> >>>>>
> >>>>> A couple of months ago, we discussed that we could maybe do a 3.0 after
> >>>>> 2.11, e.g. here:
> >>>>>
> >>>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
> >>>>>
> >>>>> I'd still like to see that happen... Peter, any thoughts on this?
> >>>>
> >>>> So, as I just thought about preparing the new machine for s390x as
> >>>> well: Did we reach any consensus about what the next qemu version will
> >>>> be called?
> >>>
> >>> I haven't seen any sufficiently solid plan to make me want to
> >>> pick anything except "2.12".
> >>
> >> I still don't think that we need a big plan for this... The change from
> >> 1.7 to 2.0 was also rather arbitrary, wasn't it?
> >>
> >> Anyway, I've now started a Wiki page to collect ideas:
> >>
> >>  https://wiki.qemu.org/Features/Version3.0
> >>
> >> Maybe we can jump to version 3.0 if there are enough doable items on the
> >> list that we can all agree upon.
> > 
> > From the mgmt app / libvirt POV, I'm against the idea of doing such an
> > API incompatible release associated with major versions. The whole point
> > of the documented deprecation timeframe, was that we can incrementally
> > remove legacy interfaces without having a big bang break the whole
> > world.
> 
> Yes, I agree ... that's why I tried to split the list into a "doable"
> part (which hopefully does not mean any breakage for the upper stack),
> and a "controversial" part (which we could use for collecting ideas, but
> it is likely not feasible to do it any time soon). Sorry for not stating
> this more clearly.

Your "doable" list includes removing all deprecated features, which
basically just nullifies the deprecation process, which declared
that they would live for 2 releases with a warning and then be
deleted. That will break the upper stack.

For the --accel item though, if that's doable without breakage then
there's no point delaying that until a 3.0 release. Just do it as
soon as its functionally ready for any release.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
