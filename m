Received: from eggs.gnu.org ([209.51.188.92]:37685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goTo1-0007iQ-NF
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goTo1-0003u7-0V
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:52:01 -0500
Date: Tue, 29 Jan 2019 14:51:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190129145156.6719b8a4.cohuck@redhat.com>
In-Reply-To: <1548769067-20792-1-git-send-email-thuth@redhat.com>
References: <1548769067-20792-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Fix LGPL version in the file
 header comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-s390x@nongnu.org

On Tue, 29 Jan 2019 14:37:47 +0100
Thomas Huth <thuth@redhat.com> wrote:

> It's either "GNU *Library* General Public License version 2" or
> "GNU Lesser General Public License version *2.1*", but there was
> no "version 2.0" of the "Lesser" license. So assume that version
> 2.1 is meant here.

I think we can assume that.

Given that there have been several of these cases (and that there's a
lot of boilerplate in general): Should we adopt SPDX license
identifiers for QEMU, as the Linux kernel did? They also discovered and
fixed some problems/oddities while at it.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/cc_helper.c   | 2 +-
>  target/s390x/excp_helper.c | 2 +-
>  target/s390x/fpu_helper.c  | 2 +-
>  target/s390x/gdbstub.c     | 2 +-
>  target/s390x/helper.c      | 2 +-
>  target/s390x/int_helper.c  | 2 +-
>  target/s390x/mem_helper.c  | 2 +-
>  target/s390x/misc_helper.c | 2 +-
>  target/s390x/translate.c   | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)

Is this going through the trivial tree? If so,

Acked-by: Cornelia Huck <cohuck@redhat.com>

I can also take this through the s390x tree.
