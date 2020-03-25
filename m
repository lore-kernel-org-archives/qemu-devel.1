Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C42C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62F22073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62F22073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9BZ-0005wI-QT
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jH9AY-00057X-1q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jH9AW-0003tz-Hx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:46:17 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:40183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jH9AW-0003sx-Cc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:46:16 -0400
Received: from player734.ha.ovh.net (unknown [10.108.57.183])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id CA7DE13664A
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:46:14 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id CB8E110A5C2C2;
 Wed, 25 Mar 2020 16:46:06 +0000 (UTC)
Subject: Re: [PATCH 3/5] nmi: add MCE class for implementing machine check
 injection commands
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-4-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1d4fb41b-4846-b5a8-481b-dcfadcacd1e2@kaod.org>
Date: Wed, 25 Mar 2020 17:46:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325144147.221875-4-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10004183623548111780
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.93
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 3:41 PM, Nicholas Piggin wrote:
> Like commit 9cb805fd26 ("cpus: Define callback for QEMU "nmi" command")
> this implements a machine check injection command framework and defines
> a monitor command for ppc.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks good to me,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

> ---
>  hmp-commands.hx              | 20 +++++++++++-
>  hw/core/nmi.c                | 61 ++++++++++++++++++++++++++++++++++++
>  include/hw/nmi.h             | 20 ++++++++++++
>  include/monitor/hmp-target.h |  1 -
>  include/monitor/hmp.h        |  1 +
>  monitor/hmp-cmds.c           |  1 +
>  target/ppc/monitor.c         | 11 +++++++
>  7 files changed, 113 insertions(+), 2 deletions(-)
>=20
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7f0f3974ad..4a9089b431 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1581,12 +1581,30 @@ ERST
>          .cmd        =3D hmp_mce,
>      },
>=20
> -#endif
>  SRST
>  ``mce`` *cpu* *bank* *status* *mcgstatus* *addr* *misc*
>    Inject an MCE on the given CPU (x86 only).
>  ERST
>=20
> +#endif
> +
> +#if defined(TARGET_PPC)
> +
> +    {
> +        .name       =3D "mce",
> +        .args_type  =3D "cpu_index:i,srr1_mask:l,dsisr:i,dar:l,recover=
ed:i",
> +        .params     =3D "cpu srr1_mask dsisr dar recovered",
> +        .help       =3D "inject a MCE on the given CPU",
> +        .cmd        =3D hmp_mce,
> +    },
> +
> +SRST
> +``mce`` *cpu* *srr1_mask* *dsisr* *dar* *recovered*
> +  Inject an MCE on the given CPU (PPC only).
> +ERST
> +
> +#endif
> +
>      {
>          .name       =3D "getfd",
>          .args_type  =3D "fdname:s",
> diff --git a/hw/core/nmi.c b/hw/core/nmi.c
> index 481c4b3c7e..2a79500967 100644
> --- a/hw/core/nmi.c
> +++ b/hw/core/nmi.c
> @@ -86,3 +86,64 @@ static void nmi_register_types(void)
>  }
>=20
>  type_init(nmi_register_types)
> +
> +struct do_mce_s {
> +    const QDict *qdict;
> +    Error *err;
> +    bool handled;
> +};
> +
> +static void mce_children(Object *o, struct do_mce_s *ns);
> +
> +static int do_mce(Object *o, void *opaque)
> +{
> +    struct do_mce_s *ms =3D opaque;
> +    MCEState *m =3D (MCEState *) object_dynamic_cast(o, TYPE_MCE);
> +
> +    if (m) {
> +        MCEClass *mc =3D MCE_GET_CLASS(m);
> +
> +        ms->handled =3D true;
> +        mc->mce_monitor_handler(m, ms->qdict, &ms->err);
> +        if (ms->err) {
> +            return -1;
> +        }
> +    }
> +    mce_children(o, ms);
> +
> +    return 0;
> +}
> +
> +static void mce_children(Object *o, struct do_mce_s *ms)
> +{
> +    object_child_foreach(o, do_mce, ms);
> +}
> +
> +void mce_monitor_handle(const QDict *qdict, Error **errp)
> +{
> +    struct do_mce_s ms =3D {
> +        .qdict =3D qdict,
> +        .err =3D NULL,
> +        .handled =3D false
> +    };
> +
> +    mce_children(object_get_root(), &ms);
> +    if (ms.handled) {
> +        error_propagate(errp, ms.err);
> +    } else {
> +        error_setg(errp, QERR_UNSUPPORTED);
> +    }
> +}
> +
> +static const TypeInfo mce_info =3D {
> +    .name          =3D TYPE_MCE,
> +    .parent        =3D TYPE_INTERFACE,
> +    .class_size    =3D sizeof(MCEClass),
> +};
> +
> +static void mce_register_types(void)
> +{
> +    type_register_static(&mce_info);
> +}
> +
> +type_init(mce_register_types)
> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
> index fe37ce3ad8..de39d95c9a 100644
> --- a/include/hw/nmi.h
> +++ b/include/hw/nmi.h
> @@ -43,4 +43,24 @@ typedef struct NMIClass {
>=20
>  void nmi_monitor_handle(int cpu_index, Error **errp);
>=20
> +
> +#define TYPE_MCE "mce"
> +
> +#define MCE_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(MCEClass, (klass), TYPE_MCE)
> +#define MCE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MCEClass, (obj), TYPE_MCE)
> +#define MCE(obj) \
> +     INTERFACE_CHECK(MCEState, (obj), TYPE_MCE)
> +
> +typedef struct MCEState MCEState;
> +
> +typedef struct MCEClass {
> +    InterfaceClass parent_class;
> +
> +    void (*mce_monitor_handler)(MCEState *n, const QDict *qdict, Error=
 **errp);
> +} MCEClass;
> +
> +void mce_monitor_handle(const QDict *qdict, Error **errp);
> +
>  #endif /* NMI_H */
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.=
h
> index 8b7820a3ad..afb8f5bca2 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -45,7 +45,6 @@ CPUState *mon_get_cpu(void);
>=20
>  void hmp_info_mem(Monitor *mon, const QDict *qdict);
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict);
> -void hmp_mce(Monitor *mon, const QDict *qdict);
>  void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
>  void hmp_info_io_apic(Monitor *mon, const QDict *qdict);
>=20
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index e33ca5a911..f747a5e214 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -54,6 +54,7 @@ void hmp_ringbuf_read(Monitor *mon, const QDict *qdic=
t);
>  void hmp_cont(Monitor *mon, const QDict *qdict);
>  void hmp_system_wakeup(Monitor *mon, const QDict *qdict);
>  void hmp_nmi(Monitor *mon, const QDict *qdict);
> +void hmp_mce(Monitor *mon, const QDict *qdict);
>  void hmp_set_link(Monitor *mon, const QDict *qdict);
>  void hmp_balloon(Monitor *mon, const QDict *qdict);
>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 58724031ea..3664ef2a4f 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -52,6 +52,7 @@
>  #include "exec/ramlist.h"
>  #include "hw/intc/intc.h"
>  #include "hw/rdma/rdma.h"
> +#include "hw/nmi.h"
>  #include "migration/snapshot.h"
>  #include "migration/misc.h"
>=20
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index a5a177d717..6daf543efc 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -28,6 +28,8 @@
>  #include "qemu/ctype.h"
>  #include "monitor/hmp-target.h"
>  #include "monitor/hmp.h"
> +#include "qapi/qmp/qdict.h"
> +#include "hw/nmi.h"
>=20
>  static target_long monitor_get_ccr(const struct MonitorDef *md, int va=
l)
>  {
> @@ -72,6 +74,15 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>      dump_mmu(env1);
>  }
>=20
> +void hmp_mce(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err =3D NULL;
> +
> +    mce_monitor_handle(qdict, &err);
> +
> +    hmp_handle_error(mon, err);
> +}
> +
>  const MonitorDef monitor_defs[] =3D {
>      { "fpscr", offsetof(CPUPPCState, fpscr) },
>      /* Next instruction pointer */
>=20


