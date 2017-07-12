Received: from eggs.gnu.org ([2001:4830:134:3::10]:47451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVJJz-0005q2-Km
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVJJw-0007Mt-TP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:12:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVJJw-0007Mg-MB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:12:56 -0400
Date: Wed, 12 Jul 2017 17:12:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712171252.5211aebd@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499864265-144136-10-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-10-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/11] s390x/flic: introduce inject_airq
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>

On Wed, 12 Jul 2017 14:57:43 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> 
> Let's introduce a specialized way to inject adapter interrupts that,
> unlike the common interrupt injection method, allows to take the
> characteristics of the adapter into account.
> 
> For adapters subject to AIS facility:
> - for non-kvm case, we handle the suppression for a given ISC in QEMU.
> - for kvm case, we pass adapter id to kvm to do airq injection.
> 
> Add add tracepoint for suppressed airq and suppressing airq.

s/Add add tracepoint/Add tracepoints/

> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/intc/s390_flic.c          | 27 +++++++++++++++++++++++++++
>  hw/intc/s390_flic_kvm.c      | 18 ++++++++++++++++++
>  hw/intc/trace-events         |  4 ++++
>  include/hw/s390x/s390_flic.h |  2 ++
>  4 files changed, 51 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
