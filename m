Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn3FE-0006Sp-NW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn3FB-0006YV-HO
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:41:24 -0400
Date: Wed, 30 Aug 2017 14:41:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830134117.GR24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/10] scsi: introduce
 sg_io_sense_from_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:26PM +0200, Paolo Bonzini wrote:
> Move more knowledge of SG_IO out of hw/scsi/scsi-generic.c, for
> reusability.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 40 +++++++---------------------------------
>  include/scsi/utils.h   |  3 +++
>  scsi/utils.c           | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
