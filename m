Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F39C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8523421D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8523421D20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYjV-0004Dn-KE
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kFYif-00039x-IB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:11:13 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:38321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kFYid-0000Cl-E7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:11:13 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.141])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4D432589B69E;
 Tue,  8 Sep 2020 10:11:08 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 8 Sep 2020
 10:10:38 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006a914b2df-f51a-4a46-a120-e0cb9b2b3644,
 AF93E93A77CC729692FB0A4A7A23E877E51D815E) smtp.auth=groug@kaod.org
Date: Tue, 8 Sep 2020 10:10:36 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: disable msize warning for synth driver
Message-ID: <20200908101036.6b3a76db@bahia.lan>
In-Reply-To: <20200907142719.35a4f079@bahia.lan>
References: <E1kEyDy-0006nN-5A@lizzy.crudebyte.com>
 <20200907115758.70366924@bahia.lan> <1773061.9aR6DczYlW@silver>
 <20200907142719.35a4f079@bahia.lan>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e68b95db-ed8f-4b35-9910-c0b09abc53e3
X-Ovh-Tracer-Id: 4358921492073191834
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevueegieehffdufeekudevgfffheehieeludffjedutdfgffegvdfgffejudeggeenucffohhmrghinheprhgvrgguthhhvgguohgtshdrihhonecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
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

On Mon, 7 Sep 2020 14:27:19 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 07 Sep 2020 13:55:52 +0200
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
>=20
> > On Montag, 7. September 2020 11:57:58 CEST Greg Kurz wrote:
> > > On Sun, 6 Sep 2020 18:50:32 +0200
> > >=20
> > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > Previous patch introduced a performance warning being logged on host
> > > > side if client connected with an 'msize' <=3D 8192. Disable this
> > > > performance warning for the synth driver to prevent that warning fr=
om
> > > > being printed whenever the 9pfs (qtest) test cases are running.
> > > >=20
> > > > Introduce a new export flag V9FS_NO_PERF_WARN for that purpose, whi=
ch
> > > > might also be used to disable such warnings from the CLI in future.
> > > >=20
> > > > We could have also prevented the warning by simply raising P9_MAX_S=
IZE
> > > > in virtio-9p-test.c to any value larger than 8192, however in the
> > > > context of test cases it makes sense running for edge cases, which
> > > > includes the lowest 'msize' value supported by the server which is
> > > > 4096, hence we want to preserve an msize of 4096 for the test clien=
t.
> > > >=20
> > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > > ---
> > >=20
> > > Heh, yes I guess it makes sense :)
> > >=20
> > > I guess you could maybe queue this patch before the other one.
> > >=20
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > Thanks!
> >=20
> > BTW, have you ever tried dealing with patchwork client's 'state' featur=
e for=20
> > already transmited patches on the list (new, rejected, etc.)?
> >=20
>=20
> Nope, never used patchwork's state at all and I've no idea on how it
> works... but I can ask to my former IBM colleagues at Ozlabs.
>=20

It seems that you need to be a "maintainer" from a patchwork standpoint
to manipulate patch states.

https://patchwork.readthedocs.io/en/latest/usage/overview/#maintainers

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Maintainers

Maintainers are a special type of user that with permissions to do
certain operations that regular Patchwork users can=E2=80=99t. Patchwork
maintainers usually have a 1:1 mapping with a project=E2=80=99s code
maintainers though this is not necessary.

The operations that a maintainer can invoke include:

    Change the state of a patch
    Archive a patch
    Delegate a patch, or be delegated a patch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

No clue how to upgrade to maintainer though...

> > Not that there were many 9p patches for actually needing that; just cur=
ious if=20
> > that's an LKML only feature.
> >=20
> > Best regards,
> > Christian Schoenebeck
> >=20
> >=20
>=20


