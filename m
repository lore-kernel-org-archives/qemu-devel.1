Received: from eggs.gnu.org ([2001:4830:134:3::10]:38242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1wFo-0005Wp-Pr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1wFk-0004ER-Gg
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:15:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1wFk-0004Dl-5K
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:15:28 -0400
Date: Tue, 10 Oct 2017 16:15:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171010151513.GK30015@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
	<1726032a-16fb-3eae-1dbf-f711d4e98a5a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1726032a-16fb-3eae-1dbf-f711d4e98a5a@redhat.com>
Subject: Re: [Qemu-devel] updating to a u-boot without the case-sensitive
 filename clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Oct 10, 2017 at 10:06:35AM -0500, Eric Blake wrote:
> On 10/10/2017 09:22 AM, Peter Maydell wrote:
> > Hi; we currently have an issue with the u-boot we're using where it
> > has a file and a directory that differ only in case (scripts/Kconfig
> > and scripts/kconfig/). This means that QEMU's release tarballs won't
> > unpack on a case-insensitive filesystem (OSX, Windows).
> > 
> > u-boot have now fixed this upstream:
> > http://git.denx.de/?p=u-boot.git;a=commitdiff;h=610eec7f0593574c034054ba54fc1c934755e208
> > 
> > but we need to decide how best to get this fix into QEMU so that
> > our tarballs will unpack, both for the upcoming QEMU 2.11 and
> > ideally for future point releases based on 2.10.
> > 
> > I can see a couple of options:
> >  (1) wait for next u-boot release (scheduled for Nov 13, 2017),
> >      and move to that
> >      [downsides: would be in the middle of QEMU's own release cycle,
> >       pretty late to fix any problems with the new version;
> >       rather a big change to put into stable]
> >  (2) move to u-boot current head-of-unstable
> >      [downsides: would mean running some random git commit version,
> >       also not really very suitable for stable]
> >  (3) backport the upstream fix to sit on top of the u-boot version
> >      we're currently using (I think the patch should apply as-is)
> >      [downsides: would need to figure out how to get that commit into
> >       the mirror of the u-boot repo that we use; would a build of it
> >       claim a misleading u-boot version number?]
> >  (4) suggest your better idea here!
> > 
> > Thoughts?
> 
> half-and-half? Use option (1) for 2.11 (that is, wait for November's
> release there), but option (3) for 2.10.2 (that is, backport just the
> fix onto the u-boot version uses in 2.10.x right now)?  (I'm not sure
> I'm a fan of the idea of split maintenance like that, but am throwing it
> out as a possible (4) since you asked).

There's always the "do nothing" option for the stable branch too.

It isn't nice but there is a workaround, which we could easily publicise
on the '/download/' page of the website until 2.11 comes out


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
