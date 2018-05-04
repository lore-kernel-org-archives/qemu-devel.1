Received: from eggs.gnu.org ([2001:4830:134:3::10]:60218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEiPq-0003Zx-UE
	for qemu-devel@nongnu.org; Fri, 04 May 2018 17:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEiPn-0003vO-2B
	for qemu-devel@nongnu.org; Fri, 04 May 2018 17:38:58 -0400
Date: Sat, 5 May 2018 00:38:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180505003653-mutt-send-email-mst@kernel.org>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-61-git-send-email-mst@redhat.com>
	<20180504091007.55405a6a.cohuck@redhat.com>
	<be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com>
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, git@vger.kernel.org

On Fri, May 04, 2018 at 08:07:53AM -0500, Eric Blake wrote:
> [adding a cross-post to the git mailing list]
> 
> On 05/04/2018 02:10 AM, Cornelia Huck wrote:
> > On Thu, 3 May 2018 22:51:40 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > This way they are easier to find using standard rules.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> ...
> 
> > [Goes to find cover letter to figure out what this is all about.
> > *Please*, cc: people on the cover letter so they can see immediately
> > what this is trying to do!]
> 
> Is there an EASY way to make 'git format-patch --cover-letter $commitid'
> (and git send-email, by extension) automatically search for all cc's any any
> of the N/M patches, and auto-cc ALL of those recipients on the 0/N cover
> letter?  And if that is not something easily built into git format-patch
> directly, is it something that can easily be added to sendemail.cccmd?  This
> is not the first time that someone has complained that automatic cc's are
> not sending the cover letter context to a particular maintainer interested
> (and auto-cc'd) in only a subset of an overall series.
> 
> On the other hand, cc'ing all recipients for a largely mechanical patch
> series that was split into 67 parts, in part because it touches so many
> different maintainers' areas, may make the cover letter have so many
> recipients that various mail gateways start rejecting it as potential spam.

I do this sometimes (pipe to this script):

grep -e ^Signed-off-by -e ^Acked -e ^Reported -e ^Tested -e ^Cc | sed 's/.*<//'| sed 's/>.*//'|sort | uniq | sed 's/^/Cc: /'


> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
