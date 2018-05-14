Received: from eggs.gnu.org ([2001:4830:134:3::10]:33078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIIFV-0004Fr-Fe
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIIDh-0007vp-Na
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:31:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fIIDh-0007u4-DS
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:29:13 -0400
Date: Mon, 14 May 2018 21:29:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180514212856-mutt-send-email-mst@kernel.org>
References: <1526303228-486609-1-git-send-email-mst@redhat.com>
	<CAFEAcA_bWJupL7oj=uxNAi3=1RGUZxpEeKx1L=JBZa6J4CuuYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_bWJupL7oj=uxNAi3=1RGUZxpEeKx1L=JBZa6J4CuuYA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/3] linux-headers: arch fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, James Hogan <jhogan@kernel.org>

On Mon, May 14, 2018 at 04:10:42PM +0100, Peter Maydell wrote:
> On 14 May 2018 at 14:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> > It turns out that we have unistd.h and kvm headers for some
> > architectures but not others.  We are thus unable to use e.g. usefaultfd
> > on these systems unless system headers have been updated.
> >
> > Fix up update-linux-headers.sh to make sure we auto-updates
> > all architectures which have linux-headers/
> > (unfortunately this still does not mean "all linux systems").
> >
> > Tested on x86 only.
> >
> > Pls consider merging this through the ARM tree.
> >
> > Changes from v5:
> >     rebase to master
> 
> Still doesn't apply:

Against which commit?

> e104462:xenial:qemu$ patches apply -s
> id:1526303228-486609-1-git-send-email-mst@redhat.com
> Applying: update-linux-headers.sh: unistd.h, kvm consistency
> error: sha1 information is lacking or useless (scripts/update-linux-headers.sh).
> error: could not build fake ancestor
> Patch failed at 0001 update-linux-headers.sh: unistd.h, kvm consistency
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> e104462:xenial:qemu$ patch --dry-run -p1 <.git/rebase-apply/patch
> checking file scripts/update-linux-headers.sh
> Hunk #1 succeeded at 83 (offset -1 lines).
> Hunk #2 FAILED at 94.
> Hunk #3 FAILED at 124.
> 2 out of 3 hunks FAILED
> 
> The copy of this script in master has code relating to kvm_para.h,
> and whatever you've based this patchset on apparently does not,
> hence the conflicts.
> 
> thanks
> -- PMM
