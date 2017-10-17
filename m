Received: from eggs.gnu.org ([2001:4830:134:3::10]:59144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4U8C-0005MB-Vu
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4U8A-0004Zo-0Q
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:50:12 -0400
Date: Tue, 17 Oct 2017 17:50:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017175006.19f5a9fd.cohuck@redhat.com>
In-Reply-To: <1508253203-119237-1-git-send-email-imammedo@redhat.com>
References: <20171017162927.5ee8b9cd.cohuck@redhat.com>
	<1508253203-119237-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390x: move s390x_new_cpu() into
 board code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 17 Oct 2017 17:13:23 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> s390-virtio-ccw.c is the sole user of s390x_new_cpu(),
> so move this helper there.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Cornelia Huck <cohuck@redhat.com>
> 
> v2:
>  - style fix: wrap the argument list
> 
> ---
>  target/s390x/cpu.h         |  1 -
>  hw/s390x/s390-virtio-ccw.c | 21 +++++++++++++++++++++
>  target/s390x/helper.c      | 20 --------------------
>  3 files changed, 21 insertions(+), 21 deletions(-)

Thanks, applied.
