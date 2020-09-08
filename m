Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1672166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1672166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFa2c-0001qx-AD
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kFa1M-0000e8-HY
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:34:36 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:56871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kFa1K-0002BK-Bs
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:34:36 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.188])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id D9FB058A7780;
 Tue,  8 Sep 2020 11:34:29 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 8 Sep 2020
 11:34:29 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006f9b59b35-966d-485a-931f-bda9cddf5dde,
 AF93E93A77CC729692FB0A4A7A23E877E51D815E) smtp.auth=groug@kaod.org
Date: Tue, 8 Sep 2020 11:34:28 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: disable msize warning for synth driver
Message-ID: <20200908113428.58c6dcb4@bahia.lan>
In-Reply-To: <4834247.Ya9cJq7G5r@silver>
References: <E1kEyDy-0006nN-5A@lizzy.crudebyte.com>
 <20200907142719.35a4f079@bahia.lan>
 <20200908101036.6b3a76db@bahia.lan> <4834247.Ya9cJq7G5r@silver>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 3d84c880-6ca9-4d26-850a-a49666aa769f
X-Ovh-Tracer-Id: 5775022097231747482
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeelvdejgfffkeeivdeuhfdtveelkedttefgjeehuedugfegheeutdejvedugeekteenucffohhmrghinheprhgvrgguthhhvgguohgtshdrihhopdhoiihlrggsshdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 04:11:08
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 08 Sep 2020 11:01:15 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 8. September 2020 10:10:36 CEST Greg Kurz wrote:
> > > > BTW, have you ever tried dealing with patchwork client's 'state' fe=
ature
> > > > for already transmited patches on the list (new, rejected, etc.)?
> > >=20
> > > Nope, never used patchwork's state at all and I've no idea on how it
> > > works... but I can ask to my former IBM colleagues at Ozlabs.
> >=20
> > It seems that you need to be a "maintainer" from a patchwork standpoint
> > to manipulate patch states.
> >=20
> > https://patchwork.readthedocs.io/en/latest/usage/overview/#maintainers
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Maintainers
> >=20
> > Maintainers are a special type of user that with permissions to do
> > certain operations that regular Patchwork users can=E2=80=99t. Patchwork
> > maintainers usually have a 1:1 mapping with a project=E2=80=99s code
> > maintainers though this is not necessary.
> >=20
> > The operations that a maintainer can invoke include:
> >=20
> >     Change the state of a patch
> >     Archive a patch
> >     Delegate a patch, or be delegated a patch
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > No clue how to upgrade to maintainer though...
>=20
> The command to change a patch state is, e.g.:
>=20
> 	pwclient update -s Queued 11759645
>=20
> When I do that I get this error:
>=20
> 	The update action requires authentication, but no username or password
> 	is configured
>=20
> So looks like it would require somebody to create an account somewhere,=20
> wherever that is.
>=20


Which patchwork site are you using ?

https://patchwork.ozlabs.org/ or https://patchwork.kernel.org/ ?

Anyway, both support self account creation:

https://patchwork.ozlabs.org/register/

https://patchwork.kernel.org/register/

This allows you to update your own patches, but you need
to be maintainer to update other's.

> Best regards,
> Christian Schoenebeck
>=20
>=20


