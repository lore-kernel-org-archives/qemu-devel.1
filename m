Received: from eggs.gnu.org ([2001:4830:134:3::10]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZbbZ-0001z0-50
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZbbW-0004vp-0q
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:32:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZbbV-0004va-Qg
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:32:49 -0400
Date: Mon, 24 Jul 2017 13:32:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170724133245.48649043@gondolin>
In-Reply-To: <1500886370-14572-1-git-send-email-thuth@redhat.com>
References: <1500886370-14572-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] target/s390x: Fix broken build with
 --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, 24 Jul 2017 10:52:45 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Our configure script was recently equipped with a new --disable-tcg
> parameter, but this does unfortunately not work on s390x hosts yet. Fix
> the build by moving some code around and by adding some few #ifdefs
> in the right places.
> 
> v3:
> - Fixed the problem when building the s390x-linux-user target
> - Added a g_assert_not_reached() to tcg_s390_program_interrupt()
>   according to Richard's suggestion

If I get one more R-b by Richard for patch 3 before tomorrow, I'll
merge that in.

> 
> v2:
> - Reworked the changes to program_interrupt() according to the
>   suggestions by Richard
> 
> Thomas Huth (5):
>   target/s390x: Move s390_cpu_dump_state() to helper.c
>   target/s390x: Move diag helpers to a separate file
>   target/s390x: Rework program_interrupt() and related functions
>   target/s390x: Move exception-related functions to a new excp_helper.c
>     file
>   target/s390x: Add remaining switches to compile with --disable-tcg
> 
>  target/s390x/Makefile.objs |   8 +-
>  target/s390x/cpu.c         |   4 +
>  target/s390x/cpu.h         |  17 +-
>  target/s390x/diag.c        | 179 +++++++++++++++
>  target/s390x/excp_helper.c | 515 +++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/helper.c      | 528 +++++----------------------------------------
>  target/s390x/interrupt.c   |  39 ++++
>  target/s390x/kvm.c         |  16 +-
>  target/s390x/misc_helper.c | 193 -----------------
>  target/s390x/translate.c   |  60 ------
>  10 files changed, 819 insertions(+), 740 deletions(-)
>  create mode 100644 target/s390x/diag.c
>  create mode 100644 target/s390x/excp_helper.c
> 

Thanks, queued to s390-next.
