Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6C8C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4921B20797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4921B20797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5Gx-0005fk-5f
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kQ5Fm-0004pg-G8; Wed, 07 Oct 2020 04:56:54 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:33035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kQ5Fk-0004MM-CJ; Wed, 07 Oct 2020 04:56:54 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.120])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 3D45F69893DF;
 Wed,  7 Oct 2020 10:56:32 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 7 Oct 2020
 10:56:32 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0064fb63119-2f86-4692-b278-8ed45af44f34,
 A16E168222A5E88446A1C19725E79DC133334205) smtp.auth=groug@kaod.org
Date: Wed, 7 Oct 2020 10:56:30 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 3/6] spapr/xive: Add a warning when StoreEOI is
 activated on POWER9 CPUs
Message-ID: <20201007105630.64e2f0c3@bahia.lan>
In-Reply-To: <e8013373-4536-08e4-27c9-8c8b8f46f768@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201005165147.526426-4-clg@kaod.org>
 <20201006185826.65f8ff3b@bahia.lan>
 <e8013373-4536-08e4-27c9-8c8b8f46f768@kaod.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: edb4be9c-18ff-47e9-bdfa-e8cdd1207dec
X-Ovh-Tracer-Id: 9421530422748617123
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeeigddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 03:24:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Oct 2020 19:03:28 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 10/6/20 6:58 PM, Greg Kurz wrote:
> > On Mon, 5 Oct 2020 18:51:44 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> StoreEOI on POWER9 CPUs is racy because load-after-store ordering is
> >> not enforced.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/ppc/spapr_caps.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >> index b0a9d0227db2..9251badbdc27 100644
> >> --- a/hw/ppc/spapr_caps.c
> >> +++ b/hw/ppc/spapr_caps.c
> >> @@ -549,6 +549,15 @@ static void cap_storeeoi_apply(SpaprMachineState =
*spapr, uint8_t val,
> >>              error_setg(errp, "StoreEOI not supported by KVM");
> >>              return;
> >>          }
> >> +
> >> +        /*
> >> +         * load-after-store ordering is not enforced on POWER9 CPUs
> >> +         * and StoreEOI can be racy.
> >> +         */
> >> +        if (!ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOG=
ICAL_3_10,
> >> +                                  0, spapr->max_compat_pvr)) {
> >> +            warn_report("StoreEOI on a POWER9 CPU is unsafe on KVM.");
> >=20

The error message should mention XIVE KVM device actually since this only
depends on kernel-irqchip.

> > It all boils down to what "unsafe" really means here... if the outcome =
is
> > "very likely hang the guest" as soon as it starts doing I/O, shouldn't
> > we error out instead ? What is the motivation to use StoreEOI if the
> > processor doesn't really support it ?
>=20
> We use it in the lab on P9. We have never seen it failed even under stres=
s.=20
> But there is a possible race in the logic.=20
>=20
> C.

Thinking again. P9 boston systems on the field only use emulated XIVE and
we certainly want to be able to migrate to P9 systems that use in-kernel
XIVE and vice-versa. So, even if StoreEOI is technically supported by
the emulated XIVE, maybe we should disallow it anyway ?

