Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7f53-0003QI-Qf
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7f50-00037r-9w
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:12:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7f50-00037V-0S
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:12:34 -0400
References: <20180921082217.29481-1-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54f9804b-405d-e587-73c5-0fc9b9aa07b7@redhat.com>
Date: Wed, 3 Oct 2018 13:12:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180921082217.29481-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/10] hyperv: add connection infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On 21/09/2018 10:22, Roman Kagan wrote:
> This series introduces the infrastructure to send and receive Hyper-V
> messages and events.
> 
> More specifically,
> 
> - SynIC is turned into a full-fledged device managing the memory regions
>   used for QEMU->guest communication
> - machinery is introduced to post messages and signal events to the
>   guest
> - infrastructure is added to subscribe to messages and events from the
>   guest, and to dispatch the received messages and events to the
>   subscribers
> 
> Based-on: 20180921082041.29380-1-rkagan@virtuozzo.com
> 
> Roman Kagan (10):
>   hyperv:synic: split capability testing and setting
>   hyperv: qom-ify SynIC
>   hyperv: only add SynIC in compatible configurations
>   hyperv: make overlay pages for SynIC
>   hyperv: add synic message delivery
>   hyperv: add synic event flag signaling
>   hyperv: process SIGNAL_EVENT hypercall
>   hyperv: add support for KVM_HYPERV_EVENTFD
>   hyperv: process POST_MESSAGE hypercall
>   hyperv_testdev: add SynIC message and event testmodes
> 
>  include/hw/hyperv/hyperv-proto.h |   1 +
>  include/hw/hyperv/hyperv.h       |  58 +++-
>  include/hw/i386/pc.h             |   8 +
>  target/i386/cpu.h                |   1 +
>  target/i386/hyperv.h             |   4 +
>  hw/hyperv/hyperv.c               | 542 ++++++++++++++++++++++++++++++-
>  hw/misc/hyperv_testdev.c         | 165 +++++++++-
>  target/i386/cpu.c                |   2 +
>  target/i386/hyperv-stub.c        |  13 +
>  target/i386/hyperv.c             |  54 ++-
>  target/i386/kvm.c                |  45 ++-
>  target/i386/machine.c            |   9 +
>  12 files changed, 872 insertions(+), 30 deletions(-)
> 

I queued all three series, though if I were to post a pull request now
I'd stop before "hyperv: add synic message delivery".

Paolo
