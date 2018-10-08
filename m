Received: from eggs.gnu.org ([2001:4830:134:3::10]:48489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g9SMF-0007gw-Oj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g9SM9-00024E-UD
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:01:47 -0400
Date: Mon, 8 Oct 2018 12:01:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181008120130.3f84d6f8.cohuck@redhat.com>
In-Reply-To: <1538751601-7433-1-git-send-email-thuth@redhat.com>
References: <1538751601-7433-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x/excp_helper: Remove DPRINTF()
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri,  5 Oct 2018 17:00:01 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Debug macros that are disabled by default should be avoided (since the
> code bit-rots quite easily). Thus turn these debug prints into proper
> qemu_log_mask(CPU_LOG_xxx, ...) statements instead. The DPRINTF statements
> in do_[ext|io|mchk]_interrupt can even be removed completely since we can
> log the information in a central place, s390_cpu_do_interrupt, instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/excp_helper.c | 48 +++++++++++-----------------------------------
>  1 file changed, 11 insertions(+), 37 deletions(-)

[patch had gained a trivial-to-fix contextual conflict in the
meanwhile; fixed]

Thanks, applied.
