Received: from eggs.gnu.org ([2001:4830:134:3::10]:42397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAiq-00027E-1T
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAil-00065z-Li
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:01:56 -0400
Date: Wed, 14 Mar 2018 19:01:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180314180140.GB4764@localhost.localdomain>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180314172351.GA4764@localhost.localdomain>
	<7F85C9E4-D04F-474C-A8E3-2EAFC5B864B9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F85C9E4-D04F-474C-A8E3-2EAFC5B864B9@oracle.com>
Subject: Re: [Qemu-devel] CVE-2018-7550 (was: multiboot: bss_end_addr can be
 zero / cleanup)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jack Schwartz <jack.schwartz@oracle.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ppandit@redhat.com, qemu-stable@nongnu.org

Am 14.03.2018 um 18:35 hat Konrad Rzeszutek Wilk geschrieben:
> On March 14, 2018 1:23:51 PM EDT, Kevin Wolf <kwolf@redhat.com> wrote:
> >Am 21.12.2017 um 18:25 hat Jack Schwartz geschrieben:
> >> Properly account for the possibility of multiboot kernels with a zero
> >> bss_end_addr.  The Multiboot Specification, section 3.1.3 allows for
> >> kernels without a bss section, by allowing a zeroed bss_end_addr
> >multiboot
> >> header field.
> >> 
> >> Do some cleanup to multiboot.c as well:
> >> - Remove some unused variables.
> >> - Use more intuitive header names when displaying fields in messages.
> >> - Change fprintf(stderr...) to error_report
> >
> >[ Cc: qemu-stable ]
> >
> >This series happens to fix CVE-2018-7550.
> >http://www.openwall.com/lists/oss-security/2018/03/08/4
> >
> >Just a shame that we weren't told before merging it so that the
> >appropriate tags could have been set in the commit message (and all of
> >the problems could have been addressed; I'm going to send another
> >Multiboot series now).
> 
> Huh?
> 
> You mean the CVE tags that were created in 2018 for a patch posted in
> 2017?

Well, it seems to me that this patch was created for a different
purpose, but it happens to fix the bug for which this CVE was assigned
now. It's not your or Jack's fault, that's just how things go sometimes.

I think PJP knew that this CVE was coming before the patches were merged
into master, so if he had told us, we could have had a better commit
message. But either way, it's not a disaster to have a suboptimal commit
message.

> Or that the reporter of the security issue didn't point to this particular patch?
> 
> Irrespective of that,  is there a write-up  of how security process
> works at QEMU?
> 
> That is what is the usual embargo period, the list of security folks,
> how one can become one, what are the responsibilities, how changes to
> process are being carried out (and discussed), what breath of testing
> and PoC work is done , how security fixes are being reviewed, etc?

I don't think a problem like this would be embargoed at all. Anyway,
have a look here:

https://wiki.qemu.org/SecurityProcess

Kevin
