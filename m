Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC19C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D6820872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D6820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZhc-0007L8-Jb
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hlZgs-0006CO-6p
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hlZgr-00079a-1k
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hlZgo-000766-CL; Thu, 11 Jul 2019 10:04:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B643E3086268;
 Thu, 11 Jul 2019 14:04:49 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82B321001B0F;
 Thu, 11 Jul 2019 14:04:48 +0000 (UTC)
Message-ID: <a6f989550b25565551a1cc026f01f43575ae29c3.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 17:04:47 +0300
In-Reply-To: <aab36239-5717-e918-05c9-1876d87fd7a8@redhat.com>
References: <096a8bcf57997c594e1d5d7ea9606029909b81fc.camel@redhat.com>
 <20190711091127.12988-1-mlevitsk@redhat.com>
 <aab36239-5717-e918-05c9-1876d87fd7a8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 11 Jul 2019 14:04:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] LUKS: support preallocation in qemu-img
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

On Thu, 2019-07-11 at 15:43 +0200, Max Reitz wrote:
> On 11.07.19 11:11, Maxim Levitsky wrote:
> > preallocation=3Doff and preallocation=3Dmetadata
> > both allocate luks header only, and preallocation=3Dfalloc/full
> > is passed to underlying file.
> >=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> FWIW, do you see the implementation of block_crypto_co_truncate()?
> Like, how it just passes preallocation requests through to the
> underlying layer?  How I said it shouldn=E2=80=99t be done?
>=20
> Yes, that was me, in commit 7ea37c30660.
>=20
> So, er, yeah.
>=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 8237424ae6..cbc291301e 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
>=20
> [...]
>=20
> > @@ -534,12 +537,28 @@ static int coroutine_fn block_crypto_co_create_=
opts_luks(const char *filename,
> >      QCryptoBlockCreateOptions *create_opts =3D NULL;
> >      BlockDriverState *bs =3D NULL;
> >      QDict *cryptoopts;
> > +    PreallocMode prealloc;
> > +    char *buf =3D NULL;
> >      int64_t size;
> >      int ret;
> > +    Error *local_err =3D NULL;
> > =20
> >      /* Parse options */
> >      size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
> > =20
> > +    buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> > +    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
> > +                                   PREALLOC_MODE_OFF, &local_err);
>=20
> Please align such lines to the opening parenthesis.
True - I really need to invest some time to update the checkpatch.pl
in qemu source tree to be up to date, or find a way to use the kernel one=
,
it is so useful to let it catch these things instead of wasting your time=
.

>=20
> > +    g_free(buf);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (prealloc =3D=3D PREALLOC_MODE_METADATA) {
> > +        prealloc  =3D PREALLOC_MODE_OFF;
>=20
> There is one space too many here.
Oops, same thing as above.

>=20
> > +    }
> > +
>=20
> I think you also need to add a @preallocation parameter to
> BlockdevCreateOptionsLUKS and handle it in block_crypto_co_create_luks(=
).

I was under impression that with new qmp based blockdev-create api, the u=
ser
should pretty much do the preallocation itself on the underlying block fi=
le,
and then create the luks on it.

However I do see that qcow2 has a preallocation mode there, so I guess I =
was wrong.
Will do it now.

Best regards,
	Maxim Levitsky





