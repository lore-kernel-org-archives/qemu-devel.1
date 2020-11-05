Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2C6C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4392206FB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4392206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadcz-0000fh-HX
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kadcG-0000Ab-0M
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:39:44 -0500
Received: from 10.mo52.mail-out.ovh.net ([87.98.187.244]:58026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kadcD-0003mV-CM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:39:43 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.25])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 508A9203C6F;
 Thu,  5 Nov 2020 12:39:35 +0100 (CET)
Received: from kaod.org (37.59.142.104) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 5 Nov 2020
 12:39:35 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0050d476141-e52d-4a33-90f3-ef1df65c1582,
 5D04B6D4EAACA18D9EDEF493C42F41A1D3896549) smtp.auth=groug@kaod.org
Date: Thu, 5 Nov 2020 12:39:34 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 3/4] spapr/xive: Allocate IPIs independently from the
 other sources
Message-ID: <20201105123934.50ad1c39@bahia.lan>
In-Reply-To: <2d837671-ec7a-2eb8-c9f3-10d031ee4fde@kaod.org>
References: <20200820134547.2355743-1-clg@kaod.org>
 <20200820134547.2355743-4-clg@kaod.org>
 <2d837671-ec7a-2eb8-c9f3-10d031ee4fde@kaod.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: f47443bf-172f-4617-88e5-124134312b44
X-Ovh-Tracer-Id: 16462626965528746278
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpedtgfelhfeiheetjeejgeevgeelkeduveekheejudfgjefffeehueeukefgfffhgeenucffohhmrghinheplhgruhhntghhphgrugdrnhgvthenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=87.98.187.244; envelope-from=groug@kaod.org;
 helo=10.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 06:39:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, Gustavo Romero <gromero@linux.ibm.com>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 09:37:27 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 8/20/20 3:45 PM, C=C3=A9dric Le Goater wrote:
> > The vCPU IPIs are now allocated in kvmppc_xive_cpu_connect() when the
> > vCPU connects to the KVM device and not when all the sources are reset
> > in kvmppc_xive_source_reset()
>=20
> This patch is introducing a regression when vsmt is in used.
>=20

Well, it isn't exactly when vsmt is used, it is when vsmt is set
to a different value than the one which is passed to -smp threads,
otherwise you always get consecutive vcpu ids.

>   https://bugs.launchpad.net/qemu/+bug/1900241
>=20

In this report we have threads=3D1, so depending on vsmt this gives
the following vcpu ids:

-M vsmt=3D1 -smp 8,cores=3D8,threads=3D1
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D0 vcpu_id=3D0
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D1 vcpu_id=3D1
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D2 vcpu_id=3D2
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D3 vcpu_id=3D3
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D4 vcpu_id=3D4
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D5 vcpu_id=3D5
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D6 vcpu_id=3D6
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D7 vcpu_id=3D7

-M vsmt=3D2 -smp 8,cores=3D8,threads=3D1
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D0 vcpu_id=3D0
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D1 vcpu_id=3D2
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D2 vcpu_id=3D4
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D3 vcpu_id=3D6
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D4 vcpu_id=3D8
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D5 vcpu_id=3D10
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D6 vcpu_id=3D12
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D7 vcpu_id=3D14

-M vsmt=3D4 -smp 8,cores=3D8,threads=3D1=20
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D0 vcpu_id=3D0
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D1 vcpu_id=3D4
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D2 vcpu_id=3D8
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D3 vcpu_id=3D12
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D4 vcpu_id=3D16
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D5 vcpu_id=3D20
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D6 vcpu_id=3D24
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D7 vcpu_id=3D28

-M vsmt=3D8 -smp 8,cores=3D8,threads=3D1=20
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D0 vcpu_id=3D0
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D1 vcpu_id=3D8
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D2 vcpu_id=3D16
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D3 vcpu_id=3D24
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D4 vcpu_id=3D32
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D5 vcpu_id=3D40
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D6 vcpu_id=3D48
kvmppc_xive_reset_ipi_on_cpu: cpu_index=3D7 vcpu_id=3D56

> when the OS boots, H_INT_SET_SOURCE_CONFIG fails with EINVAL, which=20
> should mean that the IPI is not created at the host/KVM level.
>=20

[...]

> > +static int kvmppc_xive_reset_ipi(SpaprXive *xive, CPUState *cs, Error =
**errp)
> > +{
> > +    unsigned long ipi =3D kvm_arch_vcpu_id(cs);
>=20
> ( I am wondering if this is the correct id to use ? )
>=20

Setting the ipi to the vcpu id seems to assume that the vcpu ids are
consecutive, which is definitely not the case when vsmt !=3D threads
as explained above.

Passing cs->cpu_index would provide consecutive ids but I'm not
sure this is a correct fix. I gave a try : all the vCPUs get
online in the guest as expected but something goes wrong when
terminating QEMU:

[ 5557.599881] WARNING: CPU: 40 PID: 59101 at arch/powerpc/kvm/book3s_xive_=
native.c:259 xive_native_esb_fault+0xe4/0x240 [kvm]
[ 5557.599897] Modules linked in: xt_CHECKSUM ipt_MASQUERADE xt_conntrack i=
pt_REJECT nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_nat nf_con=
ntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc=
 nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd gra=
ce fscache kvm_hv kvm i2c_dev sunrpc ext4 mbcache jbd2 xts vmx_crypto ofpar=
t ipmi_powernv ipmi_devintf powernv_flash ipmi_msghandler mtd ibmpowernv op=
al_prd at24 uio_pdrv_genirq uio ip_tables xfs libcrc32c sd_mod sg ast i2c_a=
lgo_bit drm_vram_helper drm_ttm_helper ttm drm_kms_helper syscopyarea sysfi=
llrect sysimgblt fb_sys_fops drm ahci libahci tg3 libata drm_panel_orientat=
ion_quirks dm_mirror dm_region_hash dm_log dm_mod
[ 5557.600010] CPU: 40 PID: 59101 Comm: qemu-system-ppc Kdump: loaded Taint=
ed: G        W        --------- -  - 4.18.0-240.el8.ppc64le #1
[ 5557.600041] NIP:  c00800000e949fac LR: c00000000044b164 CTR: c00800000e9=
49ec8
[ 5557.600060] REGS: c000001f69617840 TRAP: 0700   Tainted: G        W     =
   --------- -  -  (4.18.0-240.el8.ppc64le)
[ 5557.600089] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 440442=
82  XER: 00000000
[ 5557.600110] CFAR: c00000000044b160 IRQMASK: 0=20
[ 5557.600110] GPR00: c00000000044b164 c000001f69617ac0 c00800000e96e000 c0=
00001f69617c10=20
[ 5557.600110] GPR04: 05faa2b21e000080 0000000000000000 0000000000000005 ff=
ffffffffffffff=20
[ 5557.600110] GPR08: 0000000000000000 0000000000000001 0000000000000000 00=
00000000000001=20
[ 5557.600110] GPR12: c00800000e949ec8 c000001ffffd3400 0000000000000000 00=
00000000000000=20
[ 5557.600110] GPR16: 0000000000000000 0000000000000000 0000000000000000 00=
00000000000000=20
[ 5557.600110] GPR20: 0000000000000000 0000000000000000 c000001f5c065160 c0=
00000001c76f90=20
[ 5557.600110] GPR24: c000001f06f20000 c000001f5c065100 0000000000000008 c0=
00001f0eb98c78=20
[ 5557.600110] GPR28: c000001dcab40000 c000001dcab403d8 c000001f69617c10 00=
00000000000011=20
[ 5557.600255] NIP [c00800000e949fac] xive_native_esb_fault+0xe4/0x240 [kvm]
[ 5557.600274] LR [c00000000044b164] __do_fault+0x64/0x220
[ 5557.600298] Call Trace:
[ 5557.600302] [c000001f69617ac0] [0000000137a5dc20] 0x137a5dc20 (unreliabl=
e)
[ 5557.600320] [c000001f69617b50] [c00000000044b164] __do_fault+0x64/0x220
[ 5557.600337] [c000001f69617b90] [c000000000453838] do_fault+0x218/0x930
[ 5557.600355] [c000001f69617bf0] [c000000000456f50] __handle_mm_fault+0x35=
0/0xdf0
[ 5557.600373] [c000001f69617cd0] [c000000000457b1c] handle_mm_fault+0x12c/=
0x310
[ 5557.600393] [c000001f69617d10] [c00000000007ef44] __do_page_fault+0x264/=
0xbb0
[ 5557.600411] [c000001f69617df0] [c00000000007f8c8] do_page_fault+0x38/0xd0
[ 5557.600429] [c000001f69617e30] [c00000000000a714] handle_page_fault+0x18=
/0x38
[ 5557.600438] Instruction dump:
[ 5557.600444] 40c2fff0 7c2004ac 2fa90000 409e0118 73e90001 41820080 e8bd00=
08 7c2004ac=20
[ 5557.600455] 7ca90074 39400000 915c0000 7929d182 <0b090000> 2fa50000 419e=
0080 e89e0018=20
[ 5557.600485] ---[ end trace 66c6ff034c53f64f ]---
[ 5557.600509] xive-kvm: xive_native_esb_fault: accessing invalid ESB page =
for source 8 !

So it looks like something needs to be done in the XIVE KVM device anyway.

[...]

> >  static int kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
> >  {
> >      SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
> >      int i;
> > =20
> > -    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> > +    /*
> > +     * Skip the vCPU IPIs. These are created/reset when the vCPUs are
> > +     * connected in kvmppc_xive_cpu_connect()
> > +     */
> > +    for (i =3D SPAPR_XIRQ_BASE; i < xsrc->nr_irqs; i++) {
>=20
> This change skips the range [ 0x0 ... 0x1000 ] and relies on the presenter
> to create the vCPU IPIs at the KVM level. But spapr_irq_init() could have=
=20
> claimed more in :=20
>=20
>         /* Enable the CPU IPIs */
>         for (i =3D 0; i < nr_servers; ++i) {
>             SpaprInterruptControllerClass *sicc
>                 =3D SPAPR_INTC_GET_CLASS(spapr->xive);
>=20
>             if (sicc->claim_irq(SPAPR_INTC(spapr->xive), SPAPR_IRQ_IPI + =
i,
>                                 false, errp) < 0) {
>                 return;
>             }
>         }
>=20

This doesn't reach the XIVE KVM device when running in dual mode because
it doesn't exist yet.

> I think this is what is happening with vsmt. However, I don't know how to
> fix it :/
>=20
> Thanks,
>=20
> C.
>=20

