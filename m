Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1AFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83A9214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83A9214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwU6-00081V-TQ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kRwMZ-0007na-MY; Mon, 12 Oct 2020 07:51:35 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:58823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kRwMU-0000qU-Q9; Mon, 12 Oct 2020 07:51:35 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.6])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id C09DD6B45515;
 Mon, 12 Oct 2020 13:51:26 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 12 Oct
 2020 13:51:25 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002945f91d3-b3a9-48fb-b972-694582631925,
 830CACE26F9FD03FB18D3405BC9B9D6A151429CC) smtp.auth=groug@kaod.org
Date: Mon, 12 Oct 2020 13:51:24 +0200
From: Greg Kurz <groug@kaod.org>
To: BALATON Zoltan via <qemu-ppc@nongnu.org>
Subject: Re: [PATCH qemu v9] spapr: Implement Open Firmware client interface
Message-ID: <20201012135124.214ccc11@bahia.lan>
In-Reply-To: <3a81d5-9553-9a9a-ec4a-5c47607f54c0@eik.bme.hu>
References: <20200513035826.14205-1-aik@ozlabs.ru>
 <e5ddf04a-0d68-3cb8-2b84-47a43e234a59@ozlabs.ru>
 <f7e9ff41-de7a-c0d5-f004-51a2046ce0a0@ozlabs.ru>
 <434cdf49-5b80-5620-2635-079ee4b4ebad@ozlabs.ru>
 <86e79b6a-0032-56da-a066-9f02df361298@ozlabs.ru>
 <20200716132249.GB5607@umbus.fritz.box>
 <24e83a34-6788-d9ee-ca07-6833778d81df@ozlabs.ru>
 <35aeefc4-bdfc-65c5-afe5-1cd2579db3e4@ozlabs.ru>
 <3a81d5-9553-9a9a-ec4a-5c47607f54c0@eik.bme.hu>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 489d14e8-8e97-4f0e-8ab7-83e6dbd49907
X-Ovh-Tracer-Id: 4845310252588308899
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrheejgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 07:51:28
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 13:40:33 +0200
BALATON Zoltan via <qemu-ppc@nongnu.org> wrote:

> On Mon, 12 Oct 2020, Alexey Kardashevskiy wrote:
> > On 29/09/2020 20:35, Alexey Kardashevskiy wrote:
> >>=20
> >> On 16/07/2020 23:22, David Gibson wrote:
> >>> On Thu, Jul 16, 2020 at 07:04:56PM +1000, Alexey Kardashevskiy wrote:
> >>>> Ping? I kinda realize it is not going to replace SLOF any time soon =
but
> >>>> still...
> >>>=20
> >>> Yeah, I know.=C2=A0=C2=A0 I just haven't had time to consider it.=C2=
=A0 Priority
> >>> starvation.
> >>=20
> >>=20
> >> Still? :)
> >
> > Ping?
>=20
> +1, I'd like to see this merged and experiment with it to emulate firmwar=
e=20
> for pegasos2 but I'd rather use the final version than something off-tree=
=20
> which may end up different when gets upstream. Is there a way I could hel=
p=20
> with this?
>=20

This patch is a bit _old_ ;) I haven't checked the details but it might
need some rebasing. Especially it should be ported to using meson if
someone wants to experiment with it.

> Regards,
> BALATON Zoltan

