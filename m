Received: from eggs.gnu.org ([2001:4830:134:3::10]:46554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQD8N-00050J-5z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQD8J-0005om-WD
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:40:27 -0400
Date: Tue, 5 Jun 2018 16:40:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180605164019.05710fde.cohuck@redhat.com>
In-Reply-To: <20180524175828.3143-1-pasic@linux.ibm.com>
References: <20180524175828.3143-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] vfio-ccw: loosen orb flags checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu, 24 May 2018 19:58:26 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> See the individual patches (inclusive change log).
> 
> Halil Pasic (2):
>   vfio-ccw: add force unlimited prefetch property
>   vfio-ccw: remove orb.c64 (64 bit data addresses) check
> 
>  hw/s390x/css.c | 12 ------------
>  hw/vfio/ccw.c  | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 12 deletions(-)
> 

Thanks, applied.

We can do any changeover to a common _once reporting infrastructure on
top.
