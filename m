Received: from eggs.gnu.org ([2001:4830:134:3::10]:50423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f43wz-0001pF-3v
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f43wv-00088c-VN
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:25:09 -0400
Date: Thu, 5 Apr 2018 14:24:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180405142454.2a26a594.cohuck@redhat.com>
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

Thanks, applied.
