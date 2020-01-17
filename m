Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE03C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B842072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B842072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTt5-0008FH-S0
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1isTsI-0007oP-F3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1isTsH-0000ce-00
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:49:30 -0500
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:43980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1isTsG-0000Zi-PZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:49:28 -0500
Received: from player786.ha.ovh.net (unknown [10.109.146.163])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 20FD9267E9F
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 16:49:25 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 28411E813337;
 Fri, 17 Jan 2020 15:49:16 +0000 (UTC)
Date: Fri, 17 Jan 2020 16:49:14 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200117164914.34575e98@bahia.lan>
In-Reply-To: <22499afe-20e9-da7c-5bdf-b22848104884@redhat.com>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <ed2df775-b4d5-4ea7-ccf6-637c037f897b@redhat.com>
 <58c966da-45a6-3c31-589b-ebce5a489ff3@redhat.com>
 <20200117124932.2cd9edfb@bahia.lan>
 <22499afe-20e9-da7c-5bdf-b22848104884@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 15529818893550983462
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdejgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.173.103
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Lukas Doktor <ldoktor@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 13:10:35 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 17/01/2020 12:49, Greg Kurz wrote:
> > On Wed, 15 Jan 2020 19:26:18 +0100
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >=20
> >> On 15/01/2020 19:10, Laurent Vivier wrote:
> >>> Hi,
> >>>
> >>> On 15/01/2020 18:48, Greg Kurz wrote:
> >>>> Migration can potentially race with CAS reboot. If the migration thr=
ead
> >>>> completes migration after CAS has set spapr->cas_reboot but before t=
he
> >>>> mainloop could pick up the reset request and reset the machine, the
> >>>> guest is migrated unrebooted and the destination doesn't reboot it
> >>>> either because it isn't aware a CAS reboot was needed (eg, because a
> >>>> device was added before CAS). This likely result in a broken or hung
> >>>> guest.
> >>>>
> >>>> Even if it is small, the window between CAS and CAS reboot is enough=
 to
> >>>> re-qualify spapr->cas_reboot as state that we should migrate. Add a =
new
> >>>> subsection for that and always send it when a CAS reboot is pending.
> >>>> This may cause migration to older QEMUs to fail but it is still bett=
er
> >>>> than end up with a broken guest.
> >>>>
> >>>> The destination cannot honour the CAS reboot request from a post load
> >>>> handler because this must be done after the guest is fully restored.
> >>>> It is thus done from a VM change state handler.
> >>>>
> >>>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >>>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>>> ---
> >>>>
> >>>
> >>> I'm wondering if the problem can be related with the fact that
> >>> main_loop_should_exit() could release qemu_global_mutex in
> >>> pause_all_vcpus() in the reset case?
> >>>
> >>> 1602 static bool main_loop_should_exit(void)
> >>> 1603 {
> >>> ...
> >>> 1633     request =3D qemu_reset_requested();
> >>> 1634     if (request) {
> >>> 1635         pause_all_vcpus();
> >>> 1636         qemu_system_reset(request);
> >>> 1637         resume_all_vcpus();
> >>> 1638         if (!runstate_check(RUN_STATE_RUNNING) &&
> >>> 1639                 !runstate_check(RUN_STATE_INMIGRATE)) {
> >>> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> >>> 1641         }
> >>> 1642     }
> >>> ...
> >>>
> >>> I already sent a patch for this kind of problem (in current Juan pull
> >>> request):
> >>>
> >>> "runstate: ignore finishmigrate -> prelaunch transition"
> >>>
> >>> but I don't know if it could fix this one.
> >>
> >> I think it should be interesting to have the state transition on source
> >> and destination when the problem occurs (with something like "-trace
> >> runstate_set").
> >>
> >=20
> > With "-serial mon:stdio -trace runstate_set -trace -trace guest_cpu_res=
et" :
> >=20
> > OF stdout device is: /vdevice/vty@71000000
> > Preparing to boot Linux version 4.18.0-80.el8.ppc64le (mockbuild@ppc-06=
1.build.eng.bos.redhat.com) (gcc version 8.2.1 20180905 (Red Hat 8.2.1-3) (=
GCC)) #1 SMP Wed Mar 13 11:26:21 UTC 2019
> > Detected machine type: 0000000000000101
> > command line: BOOT_IMAGE=3D/boot/vmlinuz-4.18.0-80.el8.ppc64le root=3DU=
UID=3D012b83a5-2594-48ac-b936-12fec7cdbb9a ro console=3DttyS0 console=3Dtty=
S0,115200n8 no_timer_check net.ifnames=3D0 crashkernel=3Dauto
> > Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
> > Calling ibm,client-architecture-support.
> >=20
> >  Migration starts here.
> >=20
> > ..qemu-system-ppc64: warning: kernel_irqchip allowed but unavailable: I=
RQ_XIVE capability must be present for KVM
> > Falling back to kernel-irqchip=3Doff
> >=20
> >  This ^^ indicates that CAS was called and switched to XIVE, for which
> >  we lack proper KVM support on GA boston machines.
> >=20
> > 23348@1579260982.315795:runstate_set current_run_state 9 (running) new_=
state 7 (finish-migrate)
> > 23348@1579260982.360821:runstate_set current_run_state 7 (finish-migrat=
e) new_state 5 (postmigrate)
> >=20
> >  The migration thread is holding the global QEMU mutex at this point. It
> >  has stopped all CPUs. It now streams the full state to the destination
> >  before releasing the mutex.
> >=20
> > 23340@1579260982.797279:guest_cpu_reset cpu=3D0xf9dbb48a5e0=20
> > 23340@1579260982.797319:guest_cpu_reset cpu=3D0xf9dbb4d56a0=20
> >=20
> >  The main loop regained control and could process the CAS reboot request
> >  but it is too late...
> >=20
> > 23340@1579260982.866071:runstate_set current_run_state 5 (postmigrate) =
new_state 6 (prelaunch)
>=20
> Thank you Greg.
>=20
> So I think the best we can do is to migrate cas_reboot.
>=20
> To delay the H_CAS call would be cleaner but I don't know if H_BUSY is a
> valid return state and this forces to update SLOF too.
>=20

Since SLOF is currently the only user of H_CAS, I guess we have some
flexibility with the valid return codes... but anyway, David doesn't
like the idea :)

> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>=20
> Thanks,
> Laurent
>=20


