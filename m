Received: from eggs.gnu.org ([2001:4830:134:3::10]:35579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g7i5i-0002gr-Dw
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g7i5a-0002ba-Q7
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:25:28 -0400
Received: from mail-bgr052101136080.outbound.protection.outlook.com
	([52.101.136.80]:25036
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1g7i5V-0002Zw-Bn
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:25:19 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 3 Oct 2018 14:25:07 +0000
Message-ID: <20181003142503.GC24354@rkaganb.sw.ru>
References: <20180921082217.29481-1-rkagan@virtuozzo.com>
	<54f9804b-405d-e587-73c5-0fc9b9aa07b7@redhat.com>
In-Reply-To: <54f9804b-405d-e587-73c5-0fc9b9aa07b7@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65F9880E138E9A4F80EA4CFBAAF012D1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 00/10] hyperv: add connection infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On Wed, Oct 03, 2018 at 01:12:10PM +0200, Paolo Bonzini wrote:
> On 21/09/2018 10:22, Roman Kagan wrote:
> > This series introduces the infrastructure to send and receive Hyper-V
> > messages and events.
> >=20
> > More specifically,
> >=20
> > - SynIC is turned into a full-fledged device managing the memory region=
s
> >   used for QEMU->guest communication
> > - machinery is introduced to post messages and signal events to the
> >   guest
> > - infrastructure is added to subscribe to messages and events from the
> >   guest, and to dispatch the received messages and events to the
> >   subscribers
> >=20
> > Based-on: 20180921082041.29380-1-rkagan@virtuozzo.com
> >=20
> > Roman Kagan (10):
> >   hyperv:synic: split capability testing and setting
> >   hyperv: qom-ify SynIC
> >   hyperv: only add SynIC in compatible configurations
> >   hyperv: make overlay pages for SynIC
> >   hyperv: add synic message delivery
> >   hyperv: add synic event flag signaling
> >   hyperv: process SIGNAL_EVENT hypercall
> >   hyperv: add support for KVM_HYPERV_EVENTFD
> >   hyperv: process POST_MESSAGE hypercall
> >   hyperv_testdev: add SynIC message and event testmodes
> >=20
> >  include/hw/hyperv/hyperv-proto.h |   1 +
> >  include/hw/hyperv/hyperv.h       |  58 +++-
> >  include/hw/i386/pc.h             |   8 +
> >  target/i386/cpu.h                |   1 +
> >  target/i386/hyperv.h             |   4 +
> >  hw/hyperv/hyperv.c               | 542 ++++++++++++++++++++++++++++++-
> >  hw/misc/hyperv_testdev.c         | 165 +++++++++-
> >  target/i386/cpu.c                |   2 +
> >  target/i386/hyperv-stub.c        |  13 +
> >  target/i386/hyperv.c             |  54 ++-
> >  target/i386/kvm.c                |  45 ++-
> >  target/i386/machine.c            |   9 +
> >  12 files changed, 872 insertions(+), 30 deletions(-)
> >=20
>=20
> I queued all three series, though if I were to post a pull request now
> I'd stop before "hyperv: add synic message delivery".

To make sure I interpret this correctly: do the remaining patches need
more work beside the things you've commented on?

Also do you want me to post the corrected stuff as incremental fixups or
as a full-fledged respin?  In the latter case should I assume your r-b
on all patches before that one?

Thanks,
Roman.
