Received: from eggs.gnu.org ([2001:4830:134:3::10]:33486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSfZM-0004rA-JJ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSfZJ-0004Yh-EK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:26:28 -0400
Date: Tue, 12 Jun 2018 11:26:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180612112620.6c6453cb.cohuck@redhat.com>
In-Reply-To: <1528738007-29122-1-git-send-email-thuth@redhat.com>
References: <1528738007-29122-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/s390x/ipl: Fix crashes that occurs
 when -kernel is used with small images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 11 Jun 2018 19:26:47 +0200
Thomas Huth <thuth@redhat.com> wrote:

I've tweaked $SUBJECT to

hw/s390x/ipl: Fix crashes when using -kernel/-initrd with small images

> Add a sanity checks to fix the following two crashes:

Also, s/Add a sanity checks/Add sanity checks/

> 
> $ echo "Insane in the mainframe" > /tmp/test.txt
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
> Segmentation fault (core dumped)
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
> Segmentation fault (core dumped)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Fixed 2nd crash with -initrd
> 
>  hw/s390x/ipl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks, applied.
