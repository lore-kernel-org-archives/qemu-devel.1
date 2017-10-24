Received: from eggs.gnu.org ([2001:4830:134:3::10]:39504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6tqm-0006Mj-Rm
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6tqj-0001Es-Nd
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6tqj-0001EJ-Fd
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:42:09 -0400
Date: Tue, 24 Oct 2017 08:42:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171024074203.GA24198@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171013132507.GH20515@redhat.com>
	<CAFEAcA9qtKi+hPTOBfZqZ97p=J+_3hmq-aNT8m-9ypKN-=+-AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9qtKi+hPTOBfZqZ97p=J+_3hmq-aNT8m-9ypKN-=+-AA@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU CII Best Practices record
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Oct 23, 2017 at 06:55:44PM +0100, Peter Maydell wrote:
> On 13 October 2017 at 14:25, Daniel P. Berrange <berrange@redhat.com> wrote:
> > Many projects these days are recording progress wrt CII best practices
> > for FLOOS projects. I filled out a record for QEMU:
> >
> >   https://bestpractices.coreinfrastructure.org/projects/1309
> >
> > I only looked at the 'Passing' criteria, not considered the 'Silver' and
> > 'Gold' criteria. So if anyone else wants to contribute, register an
> > account there and tell me the username whereupon I can add you as a
> > collaborator.
> 
> For the questions about "50% of bug reports must be acknowledged"
> and ditto enhancement requests, did you mine the launchpad data
> or are you just guessing? :-) Similarly for vulnerability report
> response time.

I didn't measure it, just used gut feeling. I see people like Thomas Huth
and David Gilbert in particular responding to many bugs which come in and
triaging existing bugs. So I think we're in the ballpark give or take 10%.

For vulnerability reports I think we get good response, between QEMU's secalert
team, and the distros security teams, we've got good coverage & response.

> I think you're fudging the test-policy questions in our favour a bit.

IMHO the way the CII website is setup with everyone self-certifying,
means it is largely a game. I view it is a way of identifying notable
gaps where we might consider improving our working practice, and as a
rough guide to outsides to understand our project, rather than a 100%
accurate reflection of what we do.

But if people think I've got something that is grossly inaccurate
please do point it out.



> >  -  The release notes MUST identify every publicly known vulnerability
> >     that is fixed in each new release.
> >
> >     I don't see a list of CVEs mentioned in our release Changelogs or
> >     indeed a historic list of CVEs anywhere even outside the release
> >     notes ?
> 
> Indeed I don't think we do this. I would say that as a project we
> essentially push the job of rolling new releases for CVEs, informing
> users about CVE fixes, etc, to our downstream distributors.

> I suspect we only pass the "no vulns unpatched for more than 60 days"
> if you allow "patched in bleeding edge master and in distros
> but not in any upstream release" to count.

I think patched in git master is sufficient to consider it a pass on the
criteria - they don't mention any specifics about having to maintain
multiple stable branches and backport.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
