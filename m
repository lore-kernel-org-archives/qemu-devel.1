Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09442C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C3620767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C3620767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDW2O-0004ZL-3I
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDW1l-00047a-B8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:54:29 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:35507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDW1j-0007Ti-6W
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:54:29 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.89])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 34BFE56BEFF7;
 Wed,  2 Sep 2020 18:54:24 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 2 Sep 2020
 18:54:23 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0069a8956a0-4ac3-45c7-a853-35726744a954,
 AA3809B24A0F88596FE87CA7447536A9393A4537) smtp.auth=groug@kaod.org
Date: Wed, 2 Sep 2020 18:54:22 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Message-ID: <20200902185422.16b4ee28@bahia.lan>
In-Reply-To: <2877776.MzA8b4DPAS@silver>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com> <2812056.Ea3xXQFrjv@silver>
 <20200902141035.GK403297@redhat.com> <2877776.MzA8b4DPAS@silver>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: aaf74342-9b78-4beb-aa95-f1a6ca9e8656
X-Ovh-Tracer-Id: 14861878771014343133
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepteeffedvkeejkedvhfduudelheejgeegteeufefhheetgeejgffggedtteefveffnecuffhomhgrihhnpehqvghmuhdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 12:54:24
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 02 Sep 2020 18:03:12 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 2. September 2020 16:10:35 CEST Daniel P. Berrang=C3=A9 wrot=
e:
> > > Yeah, I know, but the problem is I don't see how I would squeeze the
> > > relevant information into only one log message; and even "what's a go=
od
> > > starting point" is already questionable.
> > >=20
> > > For that reason my plan was:
> > > 	- logging this warning
> > > =09
> > > 	- describing the 'msize' issue in detail on the QEMU wiki (what's the
> > > =09
> > > 	  point, how would you benchmark it)
> > >=20
> > > So my idea was: user sees the message, "what is 'msize?'" -> Google "=
msize
> > > qemu" -> click 'QEMU wiki' -> read all the details.
> > >=20
> > > But how about this: I put a QEMU wiki link directly into the log mess=
age?
> >=20
> > Rather than that, how about putting it in the QEMU man page, and then
> > just add  "See 'man 1 qemu' for further guidance".
>=20
> Well, I can do that of course. But somehow I fear users get lost by just=
=20
> pointing them to "man 1 qemu" in the log message. It already starts that =
e.g.=20
> on Debian there is no "man qemu", it is "man qemu-system" there instead. =
Next=20
> issue is that qemu man page is currently not structured in a way that wou=
ld=20
> allow me to directly point them to the relevant man heading like:
>=20
> 	man --pager=3D'less -p ^9P-msize' qemu
>=20
> So they would need to scroll their way through the entire man page by=20
> themselfes and find confusing sections like "-fsdev -device virtio-9p-pci=
" vs.
> "-virtfs", etc. I can imagine some people will struggle with that.
>=20
> With a link like "https://wiki.qemu.org/Documentation/9psetup#msize" the =
thing=20
> would be crystal clear within seconds.
>=20
> Just my opinion. Greg?
>=20

Fine by me for this patch.

For a longer term, maybe we should find a way to advertise some hint
for msize to the guest... Not sure how to do that though.

Cheers,

--
Greg

> Best regards,
> Christian Schoenebeck
>=20
>=20


