Received: from eggs.gnu.org ([2001:4830:134:3::10]:32909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewA8E-0008FQ-Ia
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewA8B-0007do-El
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:24:06 -0400
Date: Wed, 14 Mar 2018 18:23:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180314172351.GA4764@localhost.localdomain>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
Subject: [Qemu-devel] CVE-2018-7550 (was: multiboot: bss_end_addr can be
 zero / cleanup)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, konrad.wilk@oracle.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ppandit@redhat.com, qemu-stable@nongnu.org

Am 21.12.2017 um 18:25 hat Jack Schwartz geschrieben:
> Properly account for the possibility of multiboot kernels with a zero
> bss_end_addr.  The Multiboot Specification, section 3.1.3 allows for
> kernels without a bss section, by allowing a zeroed bss_end_addr multiboot
> header field.
> 
> Do some cleanup to multiboot.c as well:
> - Remove some unused variables.
> - Use more intuitive header names when displaying fields in messages.
> - Change fprintf(stderr...) to error_report

[ Cc: qemu-stable ]

This series happens to fix CVE-2018-7550.
http://www.openwall.com/lists/oss-security/2018/03/08/4

Just a shame that we weren't told before merging it so that the
appropriate tags could have been set in the commit message (and all of
the problems could have been addressed; I'm going to send another
Multiboot series now).

Kevin
