Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BF0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F45D20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F45D20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDT0U-00035A-Ni
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDSzO-00027h-0B
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:39:50 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:49103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDSzL-0003ww-KM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:39:49 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.93])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 2270D5D322CF;
 Wed,  2 Sep 2020 15:39:36 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 2 Sep 2020
 15:39:35 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0038d030251-0506-4c25-a393-d95dab009a36,
 AA3809B24A0F88596FE87CA7447536A9393A4537) smtp.auth=groug@kaod.org
Date: Wed, 2 Sep 2020 15:39:34 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Message-ID: <20200902153934.5a2d7f86@bahia.lan>
In-Reply-To: <399764553.t4N7NBxW8t@silver>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com>
 <20200902122547.GH403297@redhat.com> <399764553.t4N7NBxW8t@silver>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 8d275dd4-f9ac-4989-b228-1cca56b4eee2
X-Ovh-Tracer-Id: 11571717771839052253
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 09:39:36
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

On Wed, 02 Sep 2020 14:52:33 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 2. September 2020 14:25:47 CEST Daniel P. Berrang=C3=A9 wrot=
e:
> > On Wed, Sep 02, 2020 at 01:22:49PM +0200, Christian Schoenebeck wrote:
> > > It is essential to choose a reasonable high value for 'msize' to avoid
> > > severe degraded file I/O performance. This parameter has to be chosen
> > > on client/guest side, and a Linux client defaults to an 'msize' of on=
ly
> > > 8192 if the user did not explicitly specify a value for 'msize'.
> > >=20
> > > Unfortunately many users are not aware that they should specify an
> > > appropriate value for 'msize' to avoid severe performance issues, so
> > > log a performance warning on host side in that case to make it more
> > > clear.
> >=20
> > What is a more reasonable "msize" value to pick instead of 8k ?
> > ie at what msize is I/O not several degraded ?
>=20
> A good value depends on the file I/O potential of the underlying storage =
on=20
> host side, and then you still would need to trade off between performance=
=20
> profit and additional RAM costs, i.e. with growing msize (RAM occupation)=
,=20
> performance still increases, but performance delta will shrink continuous=
ly.
>=20
> So in practice you might e.g. choose anything between 10MiB ... >100MiB f=
or a=20
> SATA spindle disk storage, and a much higher value for anything PCIe base=
d=20
> flash storage. So a user probably should benchmark and decide what's=20
> reasonable for the intended use case.
>=20
> > If there a reason that Linux can't pick a better default ?
>=20
> I was not involved when that default value was picked on Linux side, so I=
=20
> don't know why exactly this value (8192) had been chosen as default 'msiz=
e'=20
> years ago.
>=20

The original size back in 2005 was 9000:

[greg@bahia kernel-linus]$ git show 9e82cf6a802a7 | grep 9000
+	v9ses->maxdata =3D 9000;
+	if (v9ses->maxdata !=3D 9000)

which was later converted to 8192.

I couldn't find any hint on why such a small size was chosen.

Maybe you can try to contact 9pfs father ?

Eric Van Hensbergen <ericvh@gmail.com>

> It certainly (sh/c)ould be higher, as it is already close to the theoreti=
caly=20
> minimum msize of 4096. However how should a Linux guest automatically pic=
k a=20
> reasonable msize if it does not have any knowlege of host's storage featu=
res?
>=20
> But even if this will be addressed on Linux kernel side, I still think us=
ers=20
> of old kernels should be made aware of this issue, as it is not obvious t=
o the=20
> user.
>=20

I tend to agree. Until linux decides of a better default, we should only
warn the user if they decide to go below the current one.

Cheers,

--
Greg

> Best regards,
> Christian Schoenebeck
>=20
>=20


