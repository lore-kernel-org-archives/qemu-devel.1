Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B59AC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345BB244DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345BB244DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48365 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY4Xf-0001oD-Fu
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:11:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hY4WW-0000uX-Sh
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hY4WU-0000Nc-Jf
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:10:24 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:33338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hY4WT-0000M9-Hg
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:10:21 -0400
Received: from player799.ha.ovh.net (unknown [10.109.159.62])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id BD834214F47
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 10:10:17 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player799.ha.ovh.net (Postfix) with ESMTPSA id 6FD146700FD3;
	Tue,  4 Jun 2019 08:10:09 +0000 (UTC)
To: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
	<20190529065017.15149-30-david@gibson.dropbear.id.au>
	<9f6614b2-2f07-ef0c-cca3-d6fcc1f8f87f@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9bd9c2e3-60df-73c9-3d64-d03bb302ab23@kaod.org>
Date: Tue, 4 Jun 2019 10:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9f6614b2-2f07-ef0c-cca3-d6fcc1f8f87f@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 2839801044020726704
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefledgtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.162
Subject: Re: [Qemu-devel] [PULL 29/44] spapr/xive: introduce a VM state
 change handler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, peter.maydell@linaro.org, groug@kaod.org,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org, rth@twiddle.net,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/2019 09:49, Alexey Kardashevskiy wrote:
>=20
>=20
> On 29/05/2019 16:50, David Gibson wrote:
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> This handler is in charge of stabilizing the flow of event notificatio=
ns
>> in the XIVE controller before migrating a guest. This is a requirement
>> before transferring the guest EQ pages to a destination.
>>
>> When the VM is stopped, the handler sets the source PQs to PENDING to
>> stop the flow of events and to possibly catch a triggered interrupt
>> occuring while the VM is stopped. Their previous state is saved. The
>> XIVE controller is then synced through KVM to flush any in-flight
>> event notification and to stabilize the EQs. At this stage, the EQ
>> pages are marked dirty to make sure the EQ pages are transferred if a
>> migration sequence is in progress.
>>
>> The previous configuration of the sources is restored when the VM
>> resumes, after a migration or a stop. If an interrupt was queued while
>> the VM was stopped, the handler simply generates the missing trigger.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Message-Id: <20190513084245.25755-6-clg@kaod.org>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> This one breaks my nvlink2 passthru setup. The host is v5.2-rc2.
> v5.2-rc3 fixes it though so it is backward compatibility issue which we
> care about to what degree here?=20

v5.2-rc2 had an ugly bug impacting passthru under some VM configuration,
XIVE + single CPU. See :

bcaa3110d584 ("KVM: PPC: Book3S HV: XIVE: Fix page offset when clearing=20
ESB pages")

passthru also had a serious issue impacting the XICS-over-XIVE and the=20
XIVE KVM devices :  =20

ef9740204051 ("KVM: PPC: Book3S HV: XIVE: Do not clear IRQ data of=20
passthrough interrupts")

You need an v5.2-rc3 !=20

> I am forcing ic-mode=3Dxive which is not the default so I am not so sur=
e.

It should be OK.

C.=20

>=20
>=20
>=20
> aik@u1804kvm:~$ cat /proc/interrupts
>            CPU0
>  16:          0  XIVE-IPI   0 Edge      IPI
>  21:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
>  22:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
> 257:      12372  XIVE-IRQ 4353 Edge      ibmvscsi
> 258:          0  XIVE-IRQ 4864 Edge      virtio0-config
> 259:       2157  XIVE-IRQ 4865 Edge      virtio0-input.0
> 260:          1  XIVE-IRQ 4866 Edge      virtio0-output.0
> 261:          0  XIVE-IRQ 4868 Edge      xhci_hcd
> 262:          0  XIVE-IRQ 4869 Edge      xhci_hcd
> 272:          1  XIVE-IRQ 4368 Edge      hvc_console
> LOC:      10508   Local timer interrupts for timer event device
> BCT:          0   Broadcast timer interrupts for timer event device
> LOC:          0   Local timer interrupts for others
> SPU:          5   Spurious interrupts
> PMI:          0   Performance monitoring interrupts
> MCE:          0   Machine check exceptions
> NMI:          0   System Reset interrupts
> DBL:          0   Doorbell interrupts
>=20
>=20
> and 7bfc759c02b8 "spapr/xive: add state synchronization with KVM" works=
:
>=20
>            CPU0
>  16:          0  XIVE-IPI   0 Edge      IPI
>  19:          0  XIVE-IRQ 4610 Level     NPU Device
>  20:          0  XIVE-IRQ 4611 Level     NPU Device
>  21:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
>  22:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
> 257:      11833  XIVE-IRQ 4353 Edge      ibmvscsi
> 258:          0  XIVE-IRQ 4864 Edge      virtio0-config
> 259:       1632  XIVE-IRQ 4865 Edge      virtio0-input.0
> 260:          1  XIVE-IRQ 4866 Edge      virtio0-output.0
> 261:          0  XIVE-IRQ 4868 Edge      xhci_hcd
> 262:          0  XIVE-IRQ 4869 Edge      xhci_hcd
> 263:         60  XIVE-IRQ 4867 Edge      nvidia
> 272:          0  XIVE-IRQ 4368 Edge      hvc_console
> LOC:       2236   Local timer interrupts for timer event device
> BCT:          0   Broadcast timer interrupts for timer event device
> LOC:          0   Local timer interrupts for others
> SPU:          2   Spurious interrupts
> PMI:          0   Performance monitoring interrupts
> MCE:          0   Machine check exceptions
> NMI:          0   System Reset interrupts
> DBL:          0   Doorbell interrupts
>=20
>=20
>=20
> Here is the command line:
>=20
> /home/aik/pbuild/qemu-aikrhel74alt-ppc64/ppc64-softmmu/qemu-system-ppc6=
4 \
> -nodefaults \
> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline -nographic -vga none \
> -enable-kvm \
> -device nec-usb-xhci,id=3Dnec-usb-xhci0 -m 16G \
> -netdev "user,id=3DUSER0,hostfwd=3Dtcp::2223-:22" \
> -device "virtio-net-pci,id=3Dvnet0,mac=3DC0:41:49:4b:00:00,netdev=3DUSE=
R0" \
> img/u1804-64G-cuda10.1-418.67-swiotlb.qcow2 \
> -machine pseries,cap-cfpc=3Dbroken,cap-htm=3Doff,ic-mode=3Dxive \
> -device "vfio-pci,id=3Dvfio0006_00_00_1,host=3D0006:00:00.1" \
> -device "vfio-pci,id=3Dvfio0006_00_00_0,host=3D0006:00:00.0" \
> -device "vfio-pci,id=3Dvfio0004_04_00_0,host=3D0004:04:00.0" \
> -kernel ./vmldbg -append "root=3D/dev/sda2 console=3Dhvc0 debug logleve=
l=3D8" \
> -snapshot \
> -smp 1,threads=3D1 -bios ./slof.bin \
> -L /home/aik/t/qemu-ppc64-bios/ \
> -trace events=3Dqemu_trace_events -d guest_errors \
> -chardev socket,id=3DSOCKET0,server,nowait,path=3Dqemu.mon.user2223.6_0=
_0_1 \
> -mon chardev=3DSOCKET0,mode=3Dcontrol
>=20
>=20
>=20
>=20
>> ---
>>  hw/intc/spapr_xive_kvm.c    | 96 ++++++++++++++++++++++++++++++++++++=
-
>>  include/hw/ppc/spapr_xive.h |  1 +
>>  2 files changed, 96 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index 8dd4f96e0b..735577a6f8 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -433,9 +433,100 @@ static void kvmppc_xive_get_queues(SpaprXive *xi=
ve, Error **errp)
>>      }
>>  }
>> =20
>> +/*
>> + * The primary goal of the XIVE VM change handler is to mark the EQ
>> + * pages dirty when all XIVE event notifications have stopped.
>> + *
>> + * Whenever the VM is stopped, the VM change handler sets the source
>> + * PQs to PENDING to stop the flow of events and to possibly catch a
>> + * triggered interrupt occuring while the VM is stopped. The previous
>> + * state is saved in anticipation of a migration. The XIVE controller
>> + * is then synced through KVM to flush any in-flight event
>> + * notification and stabilize the EQs.
>> + *
>> + * At this stage, we can mark the EQ page dirty and let a migration
>> + * sequence transfer the EQ pages to the destination, which is done
>> + * just after the stop state.
>> + *
>> + * The previous configuration of the sources is restored when the VM
>> + * runs again. If an interrupt was queued while the VM was stopped,
>> + * simply generate a trigger.
>> + */
>> +static void kvmppc_xive_change_state_handler(void *opaque, int runnin=
g,
>> +                                             RunState state)
>> +{
>> +    SpaprXive *xive =3D opaque;
>> +    XiveSource *xsrc =3D &xive->source;
>> +    Error *local_err =3D NULL;
>> +    int i;
>> +
>> +    /*
>> +     * Restore the sources to their initial state. This is called whe=
n
>> +     * the VM resumes after a stop or a migration.
>> +     */
>> +    if (running) {
>> +        for (i =3D 0; i < xsrc->nr_irqs; i++) {
>> +            uint8_t pq =3D xive_source_esb_get(xsrc, i);
>> +            uint8_t old_pq;
>> +
>> +            old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (p=
q << 8));
>> +
>> +            /*
>> +             * An interrupt was queued while the VM was stopped,
>> +             * generate a trigger.
>> +             */
>> +            if (pq =3D=3D XIVE_ESB_RESET && old_pq =3D=3D XIVE_ESB_QU=
EUED) {
>> +                xive_esb_trigger(xsrc, i);
>> +            }
>> +        }
>> +
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Mask the sources, to stop the flow of event notifications, and
>> +     * save the PQs locally in the XiveSource object. The XiveSource
>> +     * state will be collected later on by its vmstate handler if a
>> +     * migration is in progress.
>> +     */
>> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
>> +        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
>> +
>> +        /*
>> +         * PQ is set to PENDING to possibly catch a triggered
>> +         * interrupt occuring while the VM is stopped (hotplug event
>> +         * for instance) .
>> +         */
>> +        if (pq !=3D XIVE_ESB_OFF) {
>> +            pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_10);
>> +        }
>> +        xive_source_esb_set(xsrc, i, pq);
>> +    }
>> +
>> +    /*
>> +     * Sync the XIVE controller in KVM, to flush in-flight event
>> +     * notification that should be enqueued in the EQs and mark the
>> +     * XIVE EQ pages dirty to collect all updates.
>> +     */
>> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
>> +                      KVM_DEV_XIVE_EQ_SYNC, NULL, true, &local_err);
>> +    if (local_err) {
>> +        error_report_err(local_err);
>> +        return;
>> +    }
>> +}
>> +
>>  void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
>>  {
>> -    kvmppc_xive_source_get_state(&xive->source);
>> +    /*
>> +     * When the VM is stopped, the sources are masked and the previou=
s
>> +     * state is saved in anticipation of a migration. We should not
>> +     * synchronize the source state in that case else we will overrid=
e
>> +     * the saved state.
>> +     */
>> +    if (runstate_is_running()) {
>> +        kvmppc_xive_source_get_state(&xive->source);
>> +    }
>> =20
>>      /* EAT: there is no extra state to query from KVM */
>> =20
>> @@ -515,6 +606,9 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **=
errp)
>>                                        "xive.tima", tima_len, xive->tm=
_mmap);
>>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
>> =20
>> +    xive->change =3D qemu_add_vm_change_state_handler(
>> +        kvmppc_xive_change_state_handler, xive);
>> +
>>      kvm_kernel_irqchip =3D true;
>>      kvm_msi_via_irqfd_allowed =3D true;
>>      kvm_gsi_direct_mapping =3D true;
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 7e49badd8c..734662c12a 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -42,6 +42,7 @@ typedef struct SpaprXive {
>>      /* KVM support */
>>      int           fd;
>>      void          *tm_mmap;
>> +    VMChangeStateEntry *change;
>>  } SpaprXive;
>> =20
>>  /*
>>
>=20


