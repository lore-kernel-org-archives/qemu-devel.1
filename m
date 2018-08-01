Received: from eggs.gnu.org ([2001:4830:134:3::10]:37615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fktZh-0004ci-8b
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fktZb-00026O-JB
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:02:09 -0400
Date: Wed, 1 Aug 2018 18:01:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180801180159.57525ec9.cohuck@redhat.com>
In-Reply-To: <20180801131905.148778-1-frankja@linux.ibm.com>
References: <20180801131905.148778-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] s390x: Enable KVM huge page backing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, david@redhat.com, qemu-s390x@nongnu.org

On Wed,  1 Aug 2018 14:19:03 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> v4:
> 	* Now using MiB
> 	* Now supporting 4k memory backings
> 
> v3:
> 	* Fixed Cap name
> 	* Added mempath page size check and error reporting
> 
> Janosch Frank (2):
>   kvm: sync linux headers
>   s390x: Enable KVM huge page backing support
> 
>  linux-headers/linux/kvm.h |  1 +
>  target/s390x/kvm.c        | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 

Looks good to me.

Same comment as for the etoken patch: I'll queue this as soon as the
kernel interface has landed (and we can do a proper headers update).
Please ping me if I forget about it :)
