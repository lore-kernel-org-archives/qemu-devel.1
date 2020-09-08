Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630E8C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44E12087C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="jPmZ9YTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44E12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbPE-0004Hl-Tk
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kFbOY-0003oW-UA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:02:39 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:60711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kFbOV-00058Y-SM
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=xly57vjE/at7Tj9AbwVcSDmdpvOJTI69wXZkYbswQig=; b=jPmZ9YToJz4zuYn7MwRTkMvd5p
 m2i4LKMTT65YHONT1UasB9N4/VEvDDL5TiHoFqF20Po/0pH9t7twQeeI37Gv3pUEEFXII85bYvRmi
 I53PTUhFCX0nMMY5lkMtjqSzrOOWVLK4X8JFfmAmv0AtfsB4j6Vy5UDK19S8jrhsiso0eJFIvTfdJ
 UJVRagDPlNeMWjp74baega1dZP5TFD+SXF4Q84aWl5QLpdXoqQeTOvI+THnlP1q2tFTnmMk7Uyhqs
 2z/oRTYdTxs+Tis90ArI2WS4Oflss1gK6OeBKKp2p+Lx82R523h0FOPClG/1lTjSXSIvTbqPuab2e
 7g1KQ00w==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: disable msize warning for synth driver
Date: Tue, 08 Sep 2020 13:02:31 +0200
Message-ID: <2501070.KAsqTO3Te5@silver>
In-Reply-To: <3704436.dKkoYLHPp3@silver>
References: <E1kEyDy-0006nN-5A@lizzy.crudebyte.com>
 <20200908113428.58c6dcb4@bahia.lan> <3704436.dKkoYLHPp3@silver>
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

On Dienstag, 8. September 2020 12:03:35 CEST Christian Schoenebeck wrote:
> On Dienstag, 8. September 2020 11:34:28 CEST Greg Kurz wrote:
> > On Tue, 08 Sep 2020 11:01:15 +0200
> >=20
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Dienstag, 8. September 2020 10:10:36 CEST Greg Kurz wrote:
> > > > > > BTW, have you ever tried dealing with patchwork client's 'state'
> > > > > > feature
> > > > > > for already transmited patches on the list (new, rejected, etc.=
)?
> > > > >=20
> > > > > Nope, never used patchwork's state at all and I've no idea on how=
 it
> > > > > works... but I can ask to my former IBM colleagues at Ozlabs.
> > > >=20
> > > > It seems that you need to be a "maintainer" from a patchwork
> > > > standpoint
> > > > to manipulate patch states.
> > > >=20
> > > > https://patchwork.readthedocs.io/en/latest/usage/overview/#maintain=
ers
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Maintainers
> > > >=20
> > > > Maintainers are a special type of user that with permissions to do
> > > > certain operations that regular Patchwork users can=E2=80=99t. Patc=
hwork
> > > > maintainers usually have a 1:1 mapping with a project=E2=80=99s code
> > > > maintainers though this is not necessary.
> > > >=20
> > > > The operations that a maintainer can invoke include:
> > > >     Change the state of a patch
> > > >     Archive a patch
> > > >     Delegate a patch, or be delegated a patch
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > No clue how to upgrade to maintainer though...
> > >=20
> > > The command to change a patch state is, e.g.:
> > > 	pwclient update -s Queued 11759645
> > >=20
> > > When I do that I get this error:
> > > 	The update action requires authentication, but no username or=20
password
> > > 	is configured
> > >=20
> > > So looks like it would require somebody to create an account somewher=
e,
> > > wherever that is.
> >=20
> > Which patchwork site are you using ?
> >=20
> > https://patchwork.ozlabs.org/ or https://patchwork.kernel.org/ ?
> >=20
> > Anyway, both support self account creation:
> >=20
> > https://patchwork.ozlabs.org/register/
> >=20
> > https://patchwork.kernel.org/register/
> >=20
> > This allows you to update your own patches, but you need
> > to be maintainer to update other's.
>=20
> Currently there are 3 maintainers registered for the QEMU patchwork proje=
ct
> on ozlabs.org:
>=20
> 	https://patchwork.ozlabs.org/api/1.0/projects/14/
>=20
> None for qemu on kernel.org:
>=20
> 	https://patchwork.kernel.org/api/1.0/projects/301/
>=20
> My other test, setting state by email header didn't work BTW.

Looks like adding/removing maintainers is done by first getting the project=
's=20
current json data, e.g.:

	https://patchwork.ozlabs.org/api/1.0/projects/14/

and then HTTP putting the (entire) modified json data with updated=20
"maintainers" field:

	PUT /api/1.0/projects/14/ HTTP/1.1
	Host: patchwork.ozlabs.org
	Content-Type: application/json

	{
		<json-data-here>
	}

or by just sending the updated "maintainers" json field with HTTP "PATCH"=20
command instead:

	PATCH /api/1.0/projects/14/ HTTP/1.1
	Host: patchwork.ozlabs.org
	Content-Type: application/json

	{
		"maintainers": ...
	}

As documented here:
https://patchwork.readthedocs.io/_/downloads/en/latest/pdf/
[page 90, 92]

As far as I can see, this is currently not implemented in the client. So=20
that's manual, raw HTTP handling. No word in the docs though whether it's=20
sufficient being a project maintainer for doing that, or if you even need t=
o=20
have a patchwork admin account.

And unfortunately patchwork does not seem to have a concept of submaintaine=
rs,=20
so it seems to be all-or-nothing.

Best regards,
Christian Schoenebeck



