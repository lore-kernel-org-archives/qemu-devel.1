Received: from eggs.gnu.org ([2001:4830:134:3::10]:42858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVJ8Q-0006wS-B9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVJ8K-00019e-Rs
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVJ8K-00018c-JR
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:00:56 -0400
Date: Wed, 12 Jul 2017 17:00:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712170052.57e975d0@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499864265-144136-8-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-8-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/11] s390x: add flags field for
 registering I/O adapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Fei Li <sherrylf@linux.vnet.ibm.com>

On Wed, 12 Jul 2017 14:57:41 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Fei Li <sherrylf@linux.vnet.ibm.com>
> 
> Introduce a new 'flags' field to IoAdapter to contain further
> characteristics of the adapter, like whether the adapter is subject to
> adapter-interruption suppression.
> 
> For the kvm case, pass this value in the 'flags' field when
> registering an adapter.
> 
> Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/intc/s390_flic.c          | 2 +-
>  hw/intc/s390_flic_kvm.c      | 3 ++-
>  hw/s390x/css-bridge.c        | 2 +-
>  hw/s390x/css.c               | 8 ++++++--
>  hw/s390x/s390-pci-bus.c      | 3 ++-
>  include/hw/s390x/css.h       | 8 +++++++-
>  include/hw/s390x/s390_flic.h | 2 +-
>  7 files changed, 20 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
