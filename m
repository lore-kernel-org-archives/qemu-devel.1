Received: from eggs.gnu.org ([2001:4830:134:3::10]:58921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eifXq-0006hi-UH
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eifXn-0001Ps-3p
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:06:46 -0500
Date: Mon, 5 Feb 2018 13:06:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180205130633.1d927116.cohuck@redhat.com>
In-Reply-To: <20180202143746.204851-1-borntraeger@de.ibm.com>
References: <20180202143746.204851-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/1] respin of s390 crash information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

On Fri,  2 Feb 2018 14:37:45 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This patch - originally from Jing Liu - was still on my disk and 
> somehow dropped of my attention. Here is a fixed up version.
> It probably still needs some review and polish.
> One open aspect is migration. Right now QEMU switches from crashed
> back into running state after migration (even without this patch).
> Some fixup will be necessary. 

I would handle that independently of this patch.

> 
> Christian Borntraeger (1):
>   s390x/cpu: expose the guest crash information
> 
>  qapi/run-state.json   | 29 ++++++++++++++++++++++++--
>  target/s390x/cpu.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h    | 10 +++++++++
>  target/s390x/helper.c |  5 ++++-
>  target/s390x/kvm.c    | 27 +++++++++++++++++++-----
>  vl.c                  |  6 ++++++
>  6 files changed, 126 insertions(+), 8 deletions(-)
> 
