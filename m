Received: from eggs.gnu.org ([2001:4830:134:3::10]:52862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIZlP-0007nb-7B
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIZlM-0004ND-18
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:13:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fIZlL-0004My-T6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:13:07 -0400
Date: Tue, 15 May 2018 16:12:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180515161223-mutt-send-email-mst@kernel.org>
References: <1526303228-486609-1-git-send-email-mst@redhat.com>
	<CAFEAcA_bWJupL7oj=uxNAi3=1RGUZxpEeKx1L=JBZa6J4CuuYA@mail.gmail.com>
	<20180514212856-mutt-send-email-mst@kernel.org>
	<CAFEAcA_mLsbULijnaWfVShO0ZHSJx7QQTB32Cs+FU-HZiFbFSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_mLsbULijnaWfVShO0ZHSJx7QQTB32Cs+FU-HZiFbFSw@mail.gmail.com>
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

On Mon, May 14, 2018 at 07:37:49PM +0100, Peter Maydell wrote:
> On 14 May 2018 at 19:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, May 14, 2018 at 04:10:42PM +0100, Peter Maydell wrote:
> >> On 14 May 2018 at 14:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > It turns out that we have unistd.h and kvm headers for some
> >> > architectures but not others.  We are thus unable to use e.g. usefaultfd
> >> > on these systems unless system headers have been updated.
> >> >
> >> > Fix up update-linux-headers.sh to make sure we auto-updates
> >> > all architectures which have linux-headers/
> >> > (unfortunately this still does not mean "all linux systems").
> >> >
> >> > Tested on x86 only.
> >> >
> >> > Pls consider merging this through the ARM tree.
> >> >
> >> > Changes from v5:
> >> >     rebase to master
> >>
> >> Still doesn't apply:
> >
> > Against which commit?
> 
> bbd87423ea0c436c55bb, but the last change in master
> to scripts/update-linux-headers.sh is 7afcfd32a65688 a
> month ago, so this won't apply to anything since then
> and wouldn't have applied before that either. I think you
> have based your patchset on some other changes to the script
> which are not in master (at a guess, your "move kvm_para.h
> to standard-headers" series).
> 
> thanks
> -- PMM

OK I will just do a pull with these + kvm headers since it was
approved by Paolo.

-- 
MST
