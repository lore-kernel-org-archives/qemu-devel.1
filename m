Received: from eggs.gnu.org ([2001:4830:134:3::10]:42682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsBct-0005ei-H9
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsBcq-0005ue-8B
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:43:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fsBcq-0005tN-3R
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:43:32 -0400
Date: Tue, 21 Aug 2018 12:43:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180821124330.767abf0f@t450s.home>
In-Reply-To: <153486991405.14686.16930315204565109405.stgit@gimli.home>
References: <153486991405.14686.16930315204565109405.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/1] vfio coverity reported error fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On Tue, 21 Aug 2018 10:47:10 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> The following changes since commit ee135aa0428fe5af2af7be04ff16d2b596a9330a:
> 
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.1-20180821' into staging (2018-08-21 13:27:11 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fix-20180821.0
> 
> for you to fetch changes up to 5d6023cf74cf403fd3aee903050f43278d359e6a:
> 
>   vfio/pci: Handle subsystem realpath() returning NULL (2018-08-21 10:29:26 -0600)
> 
> ----------------------------------------------------------------
> VFIO fix 2018-08-21
> 
>  - Fix coverity reported issue with use of realpath (Alex Williamson)
> 
> ----------------------------------------------------------------
> Alex Williamson (1):
>       vfio/pci: Handle subsystem realpath() returning NULL
> 
>  hw/vfio/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Put a halt on this, nothing wrong with the fix but I notice a separate
bug in the original commit (not closing an fd on error).  I'll post
the fix and send another pull request with both.  Thanks,

Alex
