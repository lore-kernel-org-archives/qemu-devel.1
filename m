Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0CFC76188
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 08:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3FC2084C
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 08:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3FC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp7Kh-0002EZ-GJ
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 04:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59196)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hp7KX-0001lx-Hw
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hp7KW-0003P4-J3
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hp7KU-0003KC-5x; Sun, 21 Jul 2019 04:36:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15C00859FB;
 Sun, 21 Jul 2019 08:36:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 737BA60BF7;
 Sun, 21 Jul 2019 08:36:22 +0000 (UTC)
Message-ID: <7a1f4f24223a0d095f281b0f11f599e6682264d1.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 21 Jul 2019 11:36:21 +0300
In-Reply-To: <cbff0508-834b-3c52-bbe7-35046485c1e9@redhat.com>
References: <20190716161901.1430-1-mlevitsk@redhat.com>
 <cbff0508-834b-3c52-bbe7-35046485c1e9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Sun, 21 Jul 2019 08:36:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5] LUKS: support preallocation
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-07-19 at 12:28 +0200, Max Reitz wrote:
> On 16.07.19 18:19, Maxim Levitsky wrote:
> > preallocation=3Doff and preallocation=3Dmetadata
> > both allocate luks header only, and preallocation=3Dfalloc/full
> > is passed to underlying file.
> >=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >=20
> > This is hopefully a revision without coding style violations.
> >=20
> > Note that I still haven't tested the blockdev-create code, other that
> > compile testing it.
> >=20
> > Best regards,
> > 	Maxim Levitsky
> >=20
> >=20
> >  block/crypto.c       | 30 +++++++++++++++++++++++++++---
> >  qapi/block-core.json |  6 +++++-
> >  2 files changed, 32 insertions(+), 4 deletions(-)
>=20
> Thanks, applied to my block-next branch for 4.2:
>=20
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next
>=20
> Max
>=20
> (The Patchew warning doesn=E2=80=99t look like it=E2=80=99s caused by t=
his patch.)
>=20

Thank you!!
Best regards,
	Maxim Levitsky


