Received: from eggs.gnu.org ([2001:4830:134:3::10]:53340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSMkn-0007wm-TS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSMkk-00009E-4f
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSMkj-00008s-S3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:16:26 -0400
Date: Tue, 4 Jul 2017 13:16:18 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704121618.GK3135@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170704111404.28569-1-berrange@redhat.com>
	<CAFEAcA9EKaUP_7JgT553fZ2_z2kcg_UsKwdgwQKRQVQMH3fbfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9EKaUP_7JgT553fZ2_z2kcg_UsKwdgwQKRQVQMH3fbfA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Document deprecated features &
 support lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>

On Tue, Jul 04, 2017 at 01:00:54PM +0100, Peter Maydell wrote:
> On 4 July 2017 at 12:14, Daniel P. Berrange <berrange@redhat.com> wrote:
> > This is a followup to
> >
> >   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02390.html
> >   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01286.html
> >
> > The goal is to clarify to users & app developers what they can expect
> > from QEMU in terms of feature lifecycle & any deprecation policy should
> > it be neccessary to remove features.
> >
> > The list of features marked as deprecated was determined by looking at
> > the QEMU source for the word "deprecated'. It was then compared with
> > the doc Thomas put up at http://wiki.qemu.org/Features/LegacyRemoval
> >
> > Key differences with the wiki page that Thomas wrote up vs patch 2
> > in this series
> >
> >  - Deprecated features are given a fixed lifespan of 2 releases,
> >    rather than listing deletion at a future "major" v3.0.0 release.
> >    This ensures that applications like libvirt have a predictable
> >    fixed amount of time to react to deprecations.
> 
> That's 8 months. Is that enough time for QEMU versions to get into
> distros and out to users? (I don't necessarily think it's too short,
> but it seems worth thinking about.)

If someone is consuming QEMU via a distro that releases every 6 months
(eg Fedora/Ubuntu), then by the time they see the deprcation message
there may not be much time left before feature deletion. On the flipside
they will not be suspectible to the feature deletion, until the next
major release of their distro, another 6 months after that. This does,
however, not provide much time for them to object to feature removal
to try to convince us to un-deprecate the feature.

If someone is consuming QEMU directly from upstream, it is hard to
answer, because they might rebase to newer QEMU frequently, or they
may stick on a release forever. People in the latter group though
would have a very long time before being impacted by any delation,
while people in the former group would see the deprecation reasonably
early.

If we publicise the deprecations in release notes, that gives a more
visible heads up to people than we've ever had in the past. So even
if they're not consuming new QEMU releases any time soon, they still
stand a chance of hearing about the planned feature removal and
planning ahead.

>From libvirt POV, we track QEMU activity quite closely and release
libvirt once a month, so that leaves libvirt developers 8 releases
in which to get a fix done to stop using the deprecated feature,
so I think that's acceptable for libvirt.


I think 2 releases is the minimum acceptable window of deprecation,
but I also wouldn't object if we wanted to make it 3 release, so
there's a nice clear "1 year" grace period before deletion. That
would make it slightly more likely that users of distros would
see the warning before the feature has actually been deleted.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
