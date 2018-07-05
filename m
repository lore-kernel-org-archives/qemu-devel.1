Received: from eggs.gnu.org ([2001:4830:134:3::10]:43620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fb7cX-0008G0-5r
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fb7cS-0000cE-GO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:00:41 -0400
Date: Thu, 5 Jul 2018 19:00:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180705190031.4499ebc9.cohuck@redhat.com>
In-Reply-To: <1530787170-3101-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1530787170-3101-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x/storage attributes: fix
 CMMA_BLOCK_SIZE usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu,  5 Jul 2018 12:39:30 +0200
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> The macro CMMA_BLOCK_SIZE was defined but not used, and a hardcoded
> value was instead used in the code.
> 
> This patch fixes the value of CMMA_BLOCK_SIZE and uses it in the
> appropriate place in the code, and fixes another case of hardcoded
> value in the KVM backend, replacing it with the more appropriate
> constant KVM_S390_CMMA_SIZE_MAX.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-stattrib-kvm.c | 3 ++-
>  hw/s390x/s390-stattrib.c     | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

Thanks, applied.
