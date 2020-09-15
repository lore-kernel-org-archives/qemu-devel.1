Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB91CC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7642C221E3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7642C221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBQ2-00081o-J2
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kIBPF-0006tb-Os; Tue, 15 Sep 2020 09:54:01 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:49277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kIBPC-0005Pq-O6; Tue, 15 Sep 2020 09:54:01 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.237])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 7AA1761DE664;
 Tue, 15 Sep 2020 15:53:54 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 15 Sep
 2020 15:53:53 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006bf17b7e8-ff22-4bdd-b155-82a1f65ef268,
 DB33878D1665C97D8818E18A24225F630DB8C599) smtp.auth=groug@kaod.org
Date: Tue, 15 Sep 2020 15:53:52 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 10/15] spapr: Add a return value to spapr_set_vcpu_id()
Message-ID: <20200915155352.605b0e47@bahia.lan>
In-Reply-To: <740605ab-5310-d2fe-eb20-138b8def0b48@redhat.com>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-11-groug@kaod.org>
 <740605ab-5310-d2fe-eb20-138b8def0b48@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 4c863d59-5e4b-4bd1-9559-066ebbea1b7e
X-Ovh-Tracer-Id: 14371549365046122790
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtddtgdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 07:43:48
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 15:08:05 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 9/14/20 2:35 PM, Greg Kurz wrote:
> > As recommended in "qapi/error.h", return true on success and false on
> > failure. This allows to reduce error propagation overhead in the caller=
s.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  include/hw/ppc/spapr.h  | 2 +-
> >  hw/ppc/spapr.c          | 5 +++--
> >  hw/ppc/spapr_cpu_core.c | 5 +----
> >  3 files changed, 5 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index c8cd63bc0667..11682f00e8cc 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -909,7 +909,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run=
_on_cpu_data arg);
> >  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> > =20
> >  int spapr_get_vcpu_id(PowerPCCPU *cpu);
> > -void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
> > +bool spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
>=20
> If you have to respin, please add some doc, at least this would
> be an improvement:
>=20
> /* Returns: %true on success, %false on error. */
>=20

Yeah, most, not to say all, APIs in the spapr code don't have
doc in the header files... which uselessly forces everyone to
check what the function actually does. Not sure how to best
address that though.

Adding headers everywhere (ie. lot of churn) ? Only in selected places
where it isn't obvious ? Also for functions that return integers or
pointers ?

I'll cowardly let David decide ;-)

> Reviewed-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
>=20


