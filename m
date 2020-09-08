Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C03C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D262078B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="oiodW1e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D262078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFaUJ-0000fl-BI
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kFaTW-0008Se-Es
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:03:42 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:43279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kFaTU-0005b7-BA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=G3ZywB6CgjFc8xyybnBQKSzrfXy2sswFJhikakiQkXY=; b=oiodW1e61WSuO6qaRgRDe/WoTN
 wHOrBBd14Y8AvFonQYqXh2CVNAnkRZ/mnkMU046Qi6h4iP9VwYZ9lKoBZdbEgZ9ezeJwcKSq6j7kP
 eaeuGg0KenA0ro3NsrwHrd4KDhsmypx2+IX1OUwyYCGRAobTqjC2uCQqbRD0to3zr40/+DedFq0yG
 eEz9NuNZcr3l2IAPkZu2tQVLvJbJncUShiD2wUCx2//mUiAKE5sWv6W+U5uEtsQPqx1/Z0ahefVzO
 6H59CDIuuBXChsRovxuAf2fUP7Nvb478yIQgwVmJeSr1J3DLdN9kHfu29QT5YeEDGIjN1j+2TCR6+
 UZAN7x/A==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: disable msize warning for synth driver
Date: Tue, 08 Sep 2020 12:03:35 +0200
Message-ID: <3704436.dKkoYLHPp3@silver>
In-Reply-To: <20200908113428.58c6dcb4@bahia.lan>
References: <E1kEyDy-0006nN-5A@lizzy.crudebyte.com>
 <4834247.Ya9cJq7G5r@silver> <20200908113428.58c6dcb4@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 05:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 8. September 2020 11:34:28 CEST Greg Kurz wrote:
> On Tue, 08 Sep 2020 11:01:15 +0200
>=20
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Dienstag, 8. September 2020 10:10:36 CEST Greg Kurz wrote:
> > > > > BTW, have you ever tried dealing with patchwork client's 'state'
> > > > > feature
> > > > > for already transmited patches on the list (new, rejected, etc.)?
> > > >=20
> > > > Nope, never used patchwork's state at all and I've no idea on how it
> > > > works... but I can ask to my former IBM colleagues at Ozlabs.
> > >=20
> > > It seems that you need to be a "maintainer" from a patchwork standpoi=
nt
> > > to manipulate patch states.
> > >=20
> > > https://patchwork.readthedocs.io/en/latest/usage/overview/#maintainers
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Maintainers
> > >=20
> > > Maintainers are a special type of user that with permissions to do
> > > certain operations that regular Patchwork users can=E2=80=99t. Patchw=
ork
> > > maintainers usually have a 1:1 mapping with a project=E2=80=99s code
> > > maintainers though this is not necessary.
> > >=20
> > > The operations that a maintainer can invoke include:
> > >     Change the state of a patch
> > >     Archive a patch
> > >     Delegate a patch, or be delegated a patch
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > No clue how to upgrade to maintainer though...
> >=20
> > The command to change a patch state is, e.g.:
> > 	pwclient update -s Queued 11759645
> >=20
> > When I do that I get this error:
> > 	The update action requires authentication, but no username or password
> > 	is configured
> >=20
> > So looks like it would require somebody to create an account somewhere,
> > wherever that is.
>=20
> Which patchwork site are you using ?
>=20
> https://patchwork.ozlabs.org/ or https://patchwork.kernel.org/ ?
>=20
> Anyway, both support self account creation:
>=20
> https://patchwork.ozlabs.org/register/
>=20
> https://patchwork.kernel.org/register/
>=20
> This allows you to update your own patches, but you need
> to be maintainer to update other's.

Currently there are 3 maintainers registered for the QEMU patchwork project=
 on=20
ozlabs.org:

	https://patchwork.ozlabs.org/api/1.0/projects/14/

None for qemu on kernel.org:

	https://patchwork.kernel.org/api/1.0/projects/301/

My other test, setting state by email header didn't work BTW.

Best regards,
Christian Schoenebeck



