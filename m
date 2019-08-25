Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D7DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B822082F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B822082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1w2i-0007Fz-OR
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 13:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1w23-0006fv-Sm
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1w22-000137-EZ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1w1z-000126-JB; Sun, 25 Aug 2019 13:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC34EA28883;
 Sun, 25 Aug 2019 17:10:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68BF6600C4;
 Sun, 25 Aug 2019 17:10:14 +0000 (UTC)
Message-ID: <fab3803e8eb66ca68df809e296d0783551ce89d5.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Sun, 25 Aug 2019 20:10:12 +0300
In-Reply-To: <20190822113556.GR3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190822113556.GR3267@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Sun, 25 Aug 2019 17:10:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 12:35 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Aug 14, 2019 at 11:22:06PM +0300, Maxim Levitsky wrote:
> > Hi!
> >=20
> > This patch series implements key management for luks based encryption
> > It supports both raw luks images and qcow2 encrypted images.
> >=20
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1731898
> >=20
> > There are still several issues that need to be figured out,
> > on which the feedback is very welcome, but other than that the code m=
ostly works.
> >=20
> > The main issues are:
> >=20
> > 1. Instead of the proposed blockdev-update-encryption/blockdev-erase-=
encryption
> > interface, it is probably better to implement 'blockdev-amend-options=
' in qmp,
> > and use this both for offline and online key update (with some transl=
ation
> > layer to convert the qemu-img 'options' to qmp structures)
> >=20
> > This interface already exists for offline qcow2 format options update=
/
> >=20
> > This is an issue that was raised today on IRC with Kevin Wolf. Really=
 thanks
> > for the idea!
> >=20
> > We agreed that this new qmp interface should take the same options as
> > blockdev-create does, however since we want to be able to edit the en=
cryption
> > slots separately, this implies that we sort of need to allow this on =
creation
> > time as well.
> >=20
> > Also the BlockdevCreateOptions is a union, which is specialized by th=
e driver name
> > which is great for creation, but for update, the driver name is alrea=
dy known,
> > and thus the user should not be forced to pass it again.
> > However qmp doesn't seem to support union type guessing based on actu=
al fields
> > given (this might not be desired either), which complicates this some=
what.
>=20
> Given this design question around the integration into blockdev, I'd
> suggest splitting the series into two parts.
>=20
> One series should do all the work in crypto/ code to support adding
> and erasing key slots.
>=20
> One series should focus on block/ layer QMP/qemu-img integration.
>=20
> The block layer QAPI stuff shouldn't leak into the crypto/ code.
>=20
> So this will let us get on with reviewing & unit testing the
> crypto code, while we discuss block layer design options in more
> detail.
>=20
> Regards,
> Daniel


I think we need 3 series here.


1. All the re-factoring/preparation work I done in luks crypto driver, wh=
ich can be merged
now, pending minor changes from the review.
I think that it at least doesn't make the code worse.

2. Common code for the block layer to support key management this way or =
another,
   can be even added with not a single driver implementing it.

1,2 don't depend on each other mostly.


3. Key management in LUKS, which needs both 1,2, but thankfully is mostly=
 implemented,
and won't need to change much from the current implementation.


So I'll send 1 now, and I will star working on 2.

Last week we (I and Daniel) defined a draft of amend interface,
and if time permits we will work on that tomorrow to finalize the
interface.

Best regards,
	Maxim Levitsky


