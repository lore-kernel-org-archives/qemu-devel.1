Received: from eggs.gnu.org ([2001:4830:134:3::10]:53501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4Mkj-0000eO-Iw
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4Mkg-0004h2-Fp
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:57:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e4Mkg-0004f1-A0
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:57:26 -0400
Date: Tue, 17 Oct 2017 09:57:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017095721.564fbadc.cohuck@redhat.com>
In-Reply-To: <1507729193-9747-1-git-send-email-jjherne@linux.vnet.ibm.com>
References: <1507729193-9747-1-git-send-email-jjherne@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/event-facility: variable-length
 event masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Wed, 11 Oct 2017 09:39:53 -0400
"Jason J. Herne" <jjherne@linux.vnet.ibm.com> wrote:

> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> The architecture supports masks of variable length for sclp write
> event mask. We currently only support 4 byte event masks, as that
> is what Linux uses.
> 
> Let's extend this to the maximum mask length supported by the
> architecture and return 0 to the guest for the mask bits we don't
> support in core.
> 
> Initial patch by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> ---
>  hw/s390x/event-facility.c         | 35 +++++++++++++++++++++++++++++------
>  include/hw/s390x/event-facility.h | 20 ++++++++++++++++----
>  2 files changed, 45 insertions(+), 10 deletions(-)

Thanks, applied.
