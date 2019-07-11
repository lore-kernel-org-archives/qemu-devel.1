Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A0CC74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 08:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893D1208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 08:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893D1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlUcr-0002M6-CA
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 04:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hlUcN-0001ke-PW
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 04:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hlUcM-000365-IB
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 04:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hlUcJ-0002t9-Gb; Thu, 11 Jul 2019 04:39:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 027BA83F3B;
 Thu, 11 Jul 2019 08:39:50 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A028A5C1B5;
 Thu, 11 Jul 2019 08:39:47 +0000 (UTC)
Message-ID: <096a8bcf57997c594e1d5d7ea9606029909b81fc.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 11:39:46 +0300
In-Reply-To: <3e82ff24-6f84-9de8-d3ab-c34966f875f0@redhat.com>
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <3e82ff24-6f84-9de8-d3ab-c34966f875f0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 11 Jul 2019 08:39:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-07-10 at 23:52 +0200, Max Reitz wrote:
> On 10.07.19 23:24, Max Reitz wrote:
> > On 10.07.19 19:03, Maxim Levitsky wrote:
> > > preallocation=3Doff and preallocation=3Dmetadata
> > > both allocate luks header only, and preallocation=3Dfalloc/full
> > > is passed to underlying file, with the given image size.
> > >=20
> > > Note that the actual preallocated size is a bit smaller due
> > > to luks header.
> >=20
> > Couldn=E2=80=99t you just preallocate it after creating the crypto he=
ader so
> > qcrypto_block_get_payload_offset(crypto->block) + size is the actual
> > file size?

I kind of thought of the same thing after I send the patch. I'll see now =
it I can make it work.


> >=20
> > > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
> > >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  block/crypto.c | 28 ++++++++++++++++++++++++++--
> > >  1 file changed, 26 insertions(+), 2 deletions(-)
> >=20
> > Hm.  I would expect a preallocated image to read 0.  But if you just
> > pass this through to the protocol layer, it won=E2=80=99t read 0.
> >=20
> > (In fact, I don=E2=80=99t even quite see the point of having LUKS as =
an own
> > format still.  It was useful when qcow2 didn=E2=80=99t have LUKS supp=
ort, but
> > now it does, so...  I suppose everyone using the LUKS format should
> > actually be using qcow2 with LUKS?)
>=20
> Kevin just pointed out to me that our LUKS format is compatible to the
> actual layout cryptsetup uses.  OK, that is an important use case.
>=20
> Hm.  Unfortunately, that doesn=E2=80=99t really necessitate preallocati=
on.
>=20
> Well, whatever.  If it=E2=80=99s simple enough, that shouldn=E2=80=99t =
stop us from
> implementing preallocation anyway.
Exactly. Since I already know the area of qemu-img relatively well, and
this bug is on my backlog, I thought why not to do it.


>=20
>=20
> Now I found that qapi/block-core.json defines PreallocMode=E2=80=99s fa=
lloc and
> full values as follows:
>=20
> > # @falloc: like @full preallocation but allocate disk space by
> > #          posix_fallocate() rather than writing zeros.
> > # @full: preallocate all data by writing zeros to device to ensure di=
sk
> > #        space is really available. @full preallocation also sets up
> > #        metadata correctly.
>=20
> So it isn=E2=80=99t just me who expects these to pre-initialize the ima=
ge to 0.
>  Hm, although...  I suppose @falloc technically does not specify whethe=
r
> the data reads as zeroes.  I kind of find it to be implied, but, well..=
.

I personally don't really think that zeros are important, but rather the =
level of allocation.
posix_fallocate probably won't write the data blocks but rather only the =
inode metadata / used block bitmap/etc.

On the other hand writing zeros (or anything else) will force the block l=
ayer to actually write to the underlying
storage which could trigger lower layer allocation if the underlying stor=
age is thin-provisioned.

In fact IMHO, instead of writing zeros, it would be better to write rando=
m garbage instead (or have that as an even 'fuller'
preallocation mode), since underlying storage might 'compress' the zeros.=
=20

In this version I do have a bug that I mentioned, about not preallocation=
 some data at the end of the image, and I will
fix it, so that all image is zeros as expected

Best regards,
	Maxim Levitsky


>=20
> Max
>=20



