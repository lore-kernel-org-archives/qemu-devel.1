Received: from eggs.gnu.org ([2001:4830:134:3::10]:33656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e018w-0004lA-LR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e018t-0007Sc-HD
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e018t-0007R1-BN
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:04:27 -0400
Date: Thu, 5 Oct 2017 10:04:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171005100420.2d7b91f9.cohuck@redhat.com>
In-Reply-To: <1507125199-22562-1-git-send-email-thuth@redhat.com>
References: <1507125199-22562-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/sclp: Mark the sclp device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On Wed,  4 Oct 2017 15:53:19 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The "sclp" device is just an internal device that can not be instantiated
> by the users. If they try to use it, they only get a simple error message:
> 
> $ qemu-system-s390x -nographic -device sclp
> qemu-system-s390x: Option '-device s390-sclp-event-facility' cannot be
> handled by this machine
> 
> Since sclp_init() tries to create a TYPE_SCLP_EVENT_FACILITY which is
> a non-pluggable sysbus device, there is really no way that the "sclp"
> device can be used by the user, so let's set the user_creatable = false
> accordingly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/sclp.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied.
