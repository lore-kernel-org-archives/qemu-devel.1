Received: from eggs.gnu.org ([2001:4830:134:3::10]:42637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEak0-000595-BX
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEajw-00082a-EN
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:27:16 -0400
Date: Fri, 4 May 2018 15:26:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180504152658.3537707a.cohuck@redhat.com>
In-Reply-To: <be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-61-git-send-email-mst@redhat.com>
	<20180504091007.55405a6a.cohuck@redhat.com>
	<be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] cover letter cc's [was: [PATCH 60/67] hw/s390x:
 add include directory headers]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, git@vger.kernel.org

On Fri, 4 May 2018 08:07:53 -0500
Eric Blake <eblake@redhat.com> wrote:

> [adding a cross-post to the git mailing list]
> 
> On 05/04/2018 02:10 AM, Cornelia Huck wrote:
> > On Thu, 3 May 2018 22:51:40 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> >> This way they are easier to find using standard rules.
> >>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---  
> ...
> 
> > [Goes to find cover letter to figure out what this is all about.
> > *Please*, cc: people on the cover letter so they can see immediately
> > what this is trying to do!]  
> 
> Is there an EASY way to make 'git format-patch --cover-letter $commitid' 
> (and git send-email, by extension) automatically search for all cc's any 
> any of the N/M patches, and auto-cc ALL of those recipients on the 0/N 
> cover letter?  And if that is not something easily built into git 
> format-patch directly, is it something that can easily be added to 
> sendemail.cccmd?  This is not the first time that someone has complained 
> that automatic cc's are not sending the cover letter context to a 
> particular maintainer interested (and auto-cc'd) in only a subset of an 
> overall series.

I think for most cases where I've been cc:ed on the cover letter and
only some of the patches, people actually added cc: lines to the cover
letter manually.

> 
> On the other hand, cc'ing all recipients for a largely mechanical patch 
> series that was split into 67 parts, in part because it touches so many 
> different maintainers' areas, may make the cover letter have so many 
> recipients that various mail gateways start rejecting it as potential spam.

Yes, large cross-subsystem patch series make this painful.

If I get some patches like "subsystem: frobnicate foo" and it's clear
that it's simply frobnicating foo for various subsystems, I can see
what this is about without reading the cover letter, no need to cc: me.
In this case, however, the patch did not make any sense at all without
looking at the explanation in the cover letter.

So I think we don't want to do this automatically, although some way to
collect potential candidates for cc:ing on the cover letter might be
helpful.
