Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 10:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222872173E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 10:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222872173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1q7g-0006In-9s
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 06:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1q2c-0005SF-CN
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 06:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1q2b-0002Yp-AT
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 06:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1q2W-0002Wx-Bl; Sun, 25 Aug 2019 06:46:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BAF6307D91F;
 Sun, 25 Aug 2019 10:46:27 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 661115D6A3;
 Sun, 25 Aug 2019 10:46:21 +0000 (UTC)
Message-ID: <2b79327d996663c2e435187684a7a3aca5891583.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 13:46:20 +0300
In-Reply-To: <c594d9e7-95c2-aba4-11b7-3433f5a74ca5@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
 <4d242249-f823-7465-4b31-64fce484679f@redhat.com>
 <98bce17338318a95b94e053731864ce1caaeab4c.camel@redhat.com>
 <c594d9e7-95c2-aba4-11b7-3433f5a74ca5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Sun, 25 Aug 2019 10:46:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/13] qcrypto-luks: misc refactoring
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
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 16:32 +0200, Max Reitz wrote:
> On 22.08.19 01:59, Maxim Levitsky wrote:
> > On Tue, 2019-08-20 at 19:36 +0200, Max Reitz wrote:
> > > On 14.08.19 22:22, Maxim Levitsky wrote:
> > > > This is also a preparation for key read/write/erase functions
> > > >=20
> > > > * use master key len from the header
> > > > * prefer to use crypto params in the QCryptoBlockLUKS
> > > >   over passing them as function arguments
> > > > * define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME
> > > > * Add comments to various crypto parameters in the QCryptoBlockLU=
KS
> > > >=20
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  crypto/block-luks.c | 213 ++++++++++++++++++++++----------------=
------
> > > >  1 file changed, 105 insertions(+), 108 deletions(-)
>=20
>=20
> [...]
>=20
> > > > @@ -410,21 +430,15 @@ qcrypto_block_luks_essiv_cipher(QCryptoCiph=
erAlgorithm cipher,
> > > >   */
> > > >  static int
> > > >  qcrypto_block_luks_load_key(QCryptoBlock *block,
> > > > -                            QCryptoBlockLUKSKeySlot *slot,
> > > > +                            uint slot_idx,
> > >=20
> > > Did you use uint on purpose or do you mean a plain =E2=80=9Cunsigne=
d=E2=80=9D?
> >=20
> > Well there are just 8 slots, but yea I don't mind to make this an uns=
igned int.
>=20
> My point was that =E2=80=9Cuint=E2=80=9D is not a standard C type.

There are lot of non standard types, like the u8/u8/u32/u64 I used to use=
 in the kernel,
so I kind of missed that. Won't use that type anymore :-)


>=20
> [...]
>=20
> > > > @@ -930,6 +922,17 @@ qcrypto_block_luks_create(QCryptoBlock *bloc=
k,
> > > >              luks_opts.has_ivgen_hash_alg =3D true;
> > > >          }
> > > >      }
> > > > +
> > > > +    luks =3D g_new0(QCryptoBlockLUKS, 1);
> > > > +    block->opaque =3D luks;
> > > > +
> > > > +    luks->cipher_alg =3D luks_opts.cipher_alg;
> > > > +    luks->cipher_mode =3D luks_opts.cipher_mode;
> > > > +    luks->ivgen_alg =3D luks_opts.ivgen_alg;
> > > > +    luks->ivgen_hash_alg =3D luks_opts.ivgen_hash_alg;
> > > > +    luks->hash_alg =3D luks_opts.hash_alg;
> > > > +
> > > > +
> > >=20
> > > Why did you pull this up?  Now @luks is leaked in both of the next =
error
> > > paths.
> >=20
> > This is because the purpose of these fields changed. As Daniel explai=
ned to me
> > they were initially added after the fact to serve as a cache of into =
to present in qemu-img info callback.
> > But now I use these everywhere in the code so I won't them to be corr=
ect as soon as possible to minimize
> > the risk of calling some function that uses these and would read garb=
age.
>=20
> I get that, but I was wondering why you pulled the allocation of @luks
> up above the next two conditional blocks.  Allocating and initializing
> there should have worked just fine.
Yea, I didn't have to, just thought that putting the initialization as ab=
ove
as possible is a good thing for future.


>=20
> Max
>=20

Best regards,
	Maxim Levitsky


