Received: from eggs.gnu.org ([2001:4830:134:3::10]:42735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1emf7n-0007rx-Qi
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1emf7k-0006CT-Mv
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:28:23 -0500
Date: Fri, 16 Feb 2018 13:28:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180216132808.562dc547.cohuck@redhat.com>
In-Reply-To: <CAFEAcA8nRr6OgJ0OAgk6xL2dXQVrUMod5kMzPufykjVNj-yNug@mail.gmail.com>
References: <20180216121810.56ed961e.cohuck@redhat.com>
	<CAFEAcA8nRr6OgJ0OAgk6xL2dXQVrUMod5kMzPufykjVNj-yNug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Process] QEMU submaintainers and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>

On Fri, 16 Feb 2018 11:25:12 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 16 February 2018 at 11:18, Cornelia Huck <cohuck@redhat.com> wrote:
> > Hi,
> >
> > for 2.13 (or whatever it will be called), I'd like to switch to a
> > submaintainer model for s390x, where maintainers for a certain s390x
> > area (including myself) send me pull requests that I integrate into
> > s390-next resp. s390-fixes, for which I send a pull request to merge
> > into master.
> >
> > The problem here is that I don't want these sub pull requests to be
> > picked up by Peter's scripts, generating confusion. So far, my ideas
> > have been:
> >
> > - Post s390 pull requests only to qemu-s390x@nongnu.org. This sucks, as
> >   it makes part of the process intransparent to any QEMU developer not
> >   subscribed to that mailing list.
> > - Put a certain marker into the subject, like "PULL *s390x*" or so. I'm
> >   not sure how robust that is.
> > - Ditch the pull request idea, keep applying patches. This is not quite
> >   as bad as it sounds, as I have the infrastructure to apply patches
> >   anyway, but it hides the real workflow (and simply pulling is likely
> >   less work for me in the long run.)  
> 
> The block folks are already doing this, so we should just
> formalize what they're doing at the moment I guess. From my point
> of view as long as there's something I can easily filter
> in/out in the email body or subject so I don't get confused
> (and which doesn't require me to update my filters every time
> a new subsystem switches to using submaintainer pulls!)
> I don't mind about the rest of it. Maybe a subject line with
> 'PULL SUBSYSTEM s390x' (ditto block, etc etc) ?

Yes, "PULL SUBSYSTEM <subsys>" looks reasonable.
