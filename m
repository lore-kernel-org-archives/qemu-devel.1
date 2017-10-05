Received: from eggs.gnu.org ([2001:4830:134:3::10]:37297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e05g6-000202-Q2
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e05g1-0001r4-VG
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:55:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e05g1-0001qN-ON
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:54:57 -0400
Date: Thu, 5 Oct 2017 14:54:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171005145450.38bb1890.cohuck@redhat.com>
In-Reply-To: <1507193105-15627-1-git-send-email-thuth@redhat.com>
References: <1507193105-15627-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Mark the "sclpquiesce" device
 with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On Thu,  5 Oct 2017 10:45:05 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The "sclpquiesce" device is just an internal device that should not be
> created by the user directly. Though it currently does not seem to cause
> any obvious trouble when the user instantiates an additional device, let's
> better mark it with user_creatable = false to avoid unexpected behavior,
> e.g. because the quiesce notifier gets registered multiple times.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/sclpquiesce.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Thanks, applied.
