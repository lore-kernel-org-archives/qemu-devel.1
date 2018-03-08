Received: from eggs.gnu.org ([2001:4830:134:3::10]:37945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzoC-0003Ve-Gx
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzo9-0000yU-E2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:58:28 -0500
Date: Thu, 8 Mar 2018 18:58:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180308185805.005df8a2.cohuck@redhat.com>
In-Reply-To: <1520507069-22179-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1520507069-22179-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/1] s390x/sclp: extend SCLP event masks
 to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Thu,  8 Mar 2018 12:04:29 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> Extend the SCLP event masks to 64 bits.
> 
> Notice that using any of the new bits results in a state that cannot be
> migrated to an older version.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  hw/s390x/event-facility.c         | 50 ++++++++++++++++++++++++++++++++-------
>  include/hw/s390x/event-facility.h |  2 +-
>  2 files changed, 42 insertions(+), 10 deletions(-)

While this looks sane to me at a quick look, I did not have the
resources to properly handle this before softfreeze (I'm off after
tomorrow), sorry.

If any of the other maintainers wants to queue this next week, no
objections from me.
