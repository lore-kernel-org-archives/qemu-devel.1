Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFD8C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358A4205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358A4205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4msD-0002GA-Va
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 10:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i4mrL-0001iw-3X
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i4mrJ-0003nc-6F
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:59:06 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:56187)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i4mrI-0003hx-Ve
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:59:05 -0400
Received: from player772.ha.ovh.net (unknown [10.109.146.19])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id E1B9B141C0A
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2019 15:59:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 22B9B953A064;
 Mon,  2 Sep 2019 13:58:56 +0000 (UTC)
Date: Mon, 2 Sep 2019 15:58:53 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190902155853.5ecb42e2@bahia.lan>
In-Reply-To: <20190902062718.GG415@umbus.fritz.box>
References: <20190830161345.22436-1-lvivier@redhat.com>
 <20190830163413.GH4674@redhat.com>
 <20190830194543.6c1f5776@bahia.lan>
 <20190902062718.GG415@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eoCZJ0azhYVyda96Lo4O4.B"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 2316257584540522982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejtddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.62.179
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] pseries: do not allow
 memory-less/cpu-less NUMA node
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/eoCZJ0azhYVyda96Lo4O4.B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sep 2019 16:27:18 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Aug 30, 2019 at 07:45:43PM +0200, Greg Kurz wrote:
> > On Fri, 30 Aug 2019 17:34:13 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >=20
> > > On Fri, Aug 30, 2019 at 06:13:45PM +0200, Laurent Vivier wrote:
> > > > When we hotplug a CPU on memory-less/cpu-less node, the linux kernel
> > > > crashes.
> > > >=20
> > > > This happens because linux kernel needs to know the NUMA topology at
> > > > start to be able to initialize the distance lookup table.
> > > >=20
> > > > On pseries, the topology is provided by the firmware via the existi=
ng
> > > > CPUs and memory information. Thus a node without memory and CPU can=
not be
> > > > discovered by the kernel.
> > > >=20
> > > > To avoid the kernel crash, do not allow to start pseries with empty
> > > > nodes.
> > >=20
> > > This describes one possible guest OS. Is there any reasonable chance
> > > that a non-Linux guest might be able to handle this situation correct=
ly,
> > > or do you expect any guest to have the same restriction ?
>=20
> That's... a more complicated question than you'd think.
>=20
> The problem here is it's not really obvious in PAPR how topology
> information for nodes without memory should be described in the device
> tree (which is the only way we given that information to the guest).
>=20

The reported issue is to have a node without memory AND without cpu.

> It's possible there's some way to encode this information that would
> make AIX happy and we just need to fix Linux to cope with that, but
> it's not really clear what it would be.
>=20
> > I can try to grab an AIX image and give a try, but anyway this looks li=
ke
> > a very big hammer to me... :-\
>=20
> I'm not really sure why everyone seems to think losing zero-memory
> node capability is such a big deal.  It's never worked in practice on
> POWER and we can always put it back if we figure out a sensible way to
> do it.
>=20

It isn't really about losing the memory-less/cpu-less node capability, but
more about finding the appropriate fix. The changelog doesn't give much
clues on what's happening exactly: QEMU command line ? linux call stack ?

For example, I could hit a crash with the following command line:

-smp 1,maxcpus=3D2 \
-object memory-backend-ram,size=3D512M,id=3Dnode0 \
-numa node,nodeid=3D0,memdev=3Dnode0 \
-numa node,nodeid=3D1

(qemu) info numa=20
2 nodes
node 0 cpus: 0
node 0 size: 512 MB
node 0 plugged: 0 MB
node 1 cpus:
node 1 size: 0 MB
node 1 plugged: 0 MB
(qemu) device_add host-spapr-cpu-core,core-id=3D1

[   24.507552] Built 1 zonelists, mobility grouping on.  Total pages: 7656
[   24.507592] Policy zone: Normal
[   24.553481] WARNING: workqueue cpumask: online intersect > possible inte=
rsect
[   24.608814] BUG: Unable to handle kernel data access at 0x14e13da04c5bc3=
7e
[   24.608875] Faulting instruction address: 0xc000000000175650
[   24.608931] Oops: Kernel access of bad area, sig: 11 [#1]
[   24.608976] LE PAGE_SIZE=3D64K MMU=3DRadix MMU=3DHash SMP NR_CPUS=3D1024=
 NUMA pSeries
[   24.609042] Modules linked in: virtio_net vmx_crypto net_failover failov=
er crct10dif_vpmsum ip_tables xfs libcrc32c crc32c_vpmsum virtio_blk kvm rp=
adlpar_io rpaphp 9p fscache 9pnet_virtio 9pnet
[   24.609222] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.1.17-300.fc30.pp=
c64le #1
[   24.609286] NIP:  c000000000175650 LR: c000000000175310 CTR: 00000000000=
00000
[   24.609351] REGS: c00000001e597210 TRAP: 0380   Not tainted  (5.1.17-300=
.fc30.ppc64le)
[   24.609414] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44444248 =
 XER: 00000000
[   24.609482] CFAR: c000000000175528 IRQMASK: 0=20
[   24.609482] GPR00: c000000000175310 c00000001e5974a0 c0000000015fc400 00=
00000000000002=20
[   24.609482] GPR04: 0000000000000001 0000000000000001 0000000000000001 00=
00000000000400=20
[   24.609482] GPR08: 14e13da04c5bc37e 0000000000000000 0000000000000000 00=
00000000000000=20
[   24.609482] GPR12: 0000000024022248 c00000000fffee00 0000000000000007 c0=
0000001e0e8fb0=20
[   24.609482] GPR16: c00000000162dc70 0000000000000008 c00000001e5976d8 00=
00000020000000=20
[   24.609482] GPR20: 0000000100000003 0000000000000001 0000000000000000 14=
e13da04c5bc35e=20
[   24.609482] GPR24: c000000001630164 0000000000000010 14e13da04c5bc37e 00=
00000000000000=20
[   24.609482] GPR28: 0000000000000002 c0000000142a0e00 c00000001ff25d80 c0=
0000001e5975a8=20
[   24.610052] NIP [c000000000175650] find_busiest_group+0x510/0xe10
[   24.610107] LR [c000000000175310] find_busiest_group+0x1d0/0xe10
[   24.610169] Call Trace:
[   24.610203] [c00000001e5974a0] [c000000000175310] find_busiest_group+0x1=
d0/0xe10 (unreliable)
[   24.610304] [c00000001e597680] [c000000000176110] load_balance+0x1c0/0xe=
80
[   24.610377] [c00000001e5977d0] [c000000000176ff8] rebalance_domains+0x22=
8/0x380
[   24.610467] [c00000001e597880] [c000000000c7c170] __do_softirq+0x170/0x4=
04
[   24.610542] [c00000001e597980] [c000000000124368] irq_exit+0xd8/0x110
[   24.610617] [c00000001e5979a0] [c000000000028778] timer_interrupt+0x128/=
0x2e0
[   24.610706] [c00000001e597a00] [c000000000009314] decrementer_common+0x1=
54/0x160
[   24.610799] --- interrupt: 901 at plpar_hcall_norets+0x1c/0x28
[   24.610799]     LR =3D check_and_cede_processor+0x48/0x60
[   24.610915] [c00000001e597d00] [c00000001e597d60] 0xc00000001e597d60 (un=
reliable)
[   24.611004] [c00000001e597d60] [c0000000009e22a8] shared_cede_loop+0x68/=
0x180
[   24.611096] [c00000001e597da0] [c0000000009dec64] cpuidle_enter_state+0x=
a4/0x660
[   24.611191] [c00000001e597e30] [c0000000001647a0] call_cpuidle+0x50/0xa0
[   24.611270] [c00000001e597e50] [c000000000164d6c] do_idle+0x2cc/0x3b0
[   24.611350] [c00000001e597ec0] [c00000000016508c] cpu_startup_entry+0x3c=
/0x50
[   24.611445] [c00000001e597ef0] [c000000000051dd0] start_secondary+0x630/=
0x660
[   24.611539] [c00000001e597f90] [c00000000000b25c] start_secondary_prolog=
+0x10/0x14
[   24.611632] Instruction dump:
[   24.611680] 7c374800 41820234 e8920016 3b570020 8152002c 7c893670 7d2901=
94 548506be=20
[   24.611775] 788606a0 7d2907b4 79291f24 7d1a4a14 <7cfa482a> 7ce72c36 78e7=
07e0 2d270000=20
[   24.611871] ---[ end trace 0e5e3ed14d31f59d ]---
[   24.617852]=20
[   25.617885] Kernel panic - not syncing: Aiee, killing interrupt handler!

(qemu) info numa=20
2 nodes
node 0 cpus: 0
node 0 size: 512 MB
node 0 plugged: 0 MB
node 1 cpus: 1
node 1 size: 0 MB
node 1 plugged: 0 MB

but the crash doesn't occur with:

-smp 1,maxcpus=3D2 \
-object memory-backend-ram,size=3D512M,id=3Dnode0 \
-numa node,nodeid=3D0,memdev=3Dnode0 \
-numa node,nodeid=3D1 \
-device spapr-pci-host-bridge,index=3D1,id=3Dphb1,numa_node=3D1

(qemu) info numa=20
2 nodes
node 0 cpus: 0
node 0 size: 512 MB
node 0 plugged: 0 MB
node 1 cpus:
node 1 size: 0 MB
node 1 plugged: 0 MB
(qemu) device_add host-spapr-cpu-core,core-id=3D1

[  154.637304] Policy zone: Normal
[  154.665463] WARNING: workqueue cpumask: online intersect > possible inte=
rsect

(qemu) info numa=20
2 nodes
node 0 cpus: 0
node 0 size: 512 MB
node 0 plugged: 0 MB
node 1 cpus: 1
node 1 size: 0 MB
node 1 plugged: 0 MB


nor with:

-smp 1,maxcpus=3D2 \
-object memory-backend-ram,size=3D512M,id=3Dnode0 \
-numa node,nodeid=3D0,memdev=3Dnode0,cpus=3D0 \
-numa node,nodeid=3D1

qemu-system-ppc64: warning: CPU(s) not present in any NUMA nodes: CPU 1 [co=
re-id: 1]
qemu-system-ppc64: warning: All CPU(s) up to maxcpus should be described in=
 NUMA config, ability to start up with partial NUMA mappings is obsoleted a=
nd will be removed in future
(qemu) device_add host-spapr-cpu-core,core-id=3D1
(qemu) info numa=20
2 nodes
node 0 cpus: 0 1
node 0 size: 512 MB
node 0 plugged: 0 MB
node 1 cpus:
node 1 size: 0 MB
node 1 plugged: 0 MB

so I don't know why linux crashes, but it isn't exactly because of having
a cpu-less/memory-less node and this patch catches the non-crashing cases
anyway.

--Sig_/eoCZJ0azhYVyda96Lo4O4.B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl1tIB0ACgkQcdTV5YIv
c9Y4Kw//TxMMNuMdoX+CO7A9pLMF+73tq02Sfst4Y4hOqmcWGD/CDPVT9LTSfKmi
oVLx9v+qYCmJ2roO/evlYCHdVfQOUbhyUqOYTqTlyvs7OFBNGZJ96Kxkz6+OJZLc
LSjwZmvYB74TQdTzjYlscHFUYjtsu3TI583nsLF5J6rlXLBrhJ3Thyo1GYb02zM8
C4caJj2PGnuqlXEK4dJFOVZMmNC+Hd66y+LuBfJC7UrHz4I1MhuDDNyki8yPQCj+
0tGbM9rmkr2fA5rscTxjVxXo+iHVFc3wOznhM+TkesaFM51aM1bqqsni1+N02Thl
eJSUN8WzeVtdvRr+JoISj8bCNJITfG2HUnfb/vooMr/gztABAye/HklkEpRgNVKa
Pa3MJYEfdQTJE9k/aYYnvzjXeSvA+TILmdGDMtTLWm1f5856IoJ9owxJOdRfGBMM
1CarFXVuaotMYSUrDolkM7voMVQWDaMJYstGQLaVjS/peTck+LHD9EfCI0CUXjmN
o1VUdMeJrYALmAI7XLCoYxZPPsdi3CLKYJhWaaO8TpxFiKCwzNOuqHrgDyjzuryZ
jyRlYjDv2ugG7/H6A8Hscj0g9eVp4N9su9cQD/9YiP6eEMCGBKtpxUYbJQbMLAii
TMYY7DF5VvUt+EkV4V+PHFYWAwJrFpmgBwj9Eeto+Pu/OIW6MAM=
=G+LF
-----END PGP SIGNATURE-----

--Sig_/eoCZJ0azhYVyda96Lo4O4.B--

