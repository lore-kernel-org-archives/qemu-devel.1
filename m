Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26473C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E762082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E762082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6F68-0005s9-1k
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6F2K-0002yQ-9L
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6F2I-0004e6-Ry
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:16:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6F2F-0004cb-M8; Fri, 06 Sep 2019 10:16:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7FA13081D8F;
 Fri,  6 Sep 2019 14:16:22 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAF3B60F87;
 Fri,  6 Sep 2019 14:15:52 +0000 (UTC)
Date: Fri, 6 Sep 2019 15:15:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906141549.GS5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-3-mlevitsk@redhat.com>
 <20190906134917.GK5119@redhat.com>
 <5ffec079e9f1fb8db7e92eba9b4187de2676b207.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ffec079e9f1fb8db7e92eba9b4187de2676b207.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 06 Sep 2019 14:16:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/10] qcrypto-luks: extend the create
 options for upcoming encryption key management
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 04:57:22PM +0300, Maxim Levitsky wrote:
> On Fri, 2019-09-06 at 14:49 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Aug 30, 2019 at 11:56:00PM +0300, Maxim Levitsky wrote:
> > > Now you can specify which slot to put the encryption key to
> > > Plus add 'active' option which will let  user erase the key secret
> > > instead of adding it.
> > > Check that it is true for creation
> > >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  block/crypto.c             |  2 ++
> > >  block/crypto.h             | 16 +++++++++++
> > >  block/qcow2.c              |  2 ++
> > >  crypto/block-luks.c        | 26 +++++++++++++++---
> > >  qapi/crypto.json           | 19 ++++++++++++++
> > >  tests/qemu-iotests/082.out | 54 ++++++++++++++++++++++++++++++++++=
++++
> > >  6 files changed, 115 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/block/crypto.c b/block/crypto.c
> > > index 6e822c6e50..a6a3e1f1d8 100644
> > > --- a/block/crypto.c
> > > +++ b/block/crypto.c
> > > @@ -144,6 +144,8 @@ static QemuOptsList block_crypto_create_opts_lu=
ks =3D {
> > >          BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(""),
> > >          BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(""),
> > >          BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
> > > +        BLOCK_CRYPTO_OPT_DEF_LUKS_SLOT(""),
> > > +        BLOCK_CRYPTO_OPT_DEF_LUKS_ACTIVE(""),
> > >          { /* end of list */ }
> > >      },
> > >  };
> > > diff --git a/block/crypto.h b/block/crypto.h
> > > index b935695e79..05cc43d9bc 100644
> > > --- a/block/crypto.h
> > > +++ b/block/crypto.h
> > > @@ -35,12 +35,14 @@
> > >          "ID of the secret that provides the AES encryption key")
> > > =20
> > >  #define BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET "key-secret"
> > > +#define BLOCK_CRYPTO_OPT_LUKS_SLOT "slot"
> > >  #define BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG "cipher-alg"
> > >  #define BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE "cipher-mode"
> > >  #define BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG "ivgen-alg"
> > >  #define BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG "ivgen-hash-alg"
> > >  #define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
> > >  #define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
> > > +#define BLOCK_CRYPTO_OPT_LUKS_ACTIVE "active"
> > > =20
> > >  #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(prefix)              =
      \
> > >      BLOCK_CRYPTO_OPT_DEF_KEY_SECRET(prefix,                       =
      \
> > > @@ -88,6 +90,20 @@
> > >          .help =3D "Time to spend in PBKDF in milliseconds",     \
> > >      }
> > > =20
> > > +#define BLOCK_CRYPTO_OPT_DEF_LUKS_SLOT(prefix)           \
> > > +    {                                                         \
> > > +        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_SLOT,       \
> > > +        .type =3D QEMU_OPT_NUMBER,                              \
> > > +        .help =3D "Controls the slot where the secret is added/era=
sed",     \
> > > +    }
> > > +
> > > +#define BLOCK_CRYPTO_OPT_DEF_LUKS_ACTIVE(prefix)           \
> > > +    {                                                         \
> > > +        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_ACTIVE,       \
> > > +        .type =3D QEMU_OPT_BOOL,                              \
> > > +        .help =3D "Controls if the added secret is added or erased=
",     \
> > > +    }
> >=20
> > Do we actually need the "active" property for initial
> > creation. I think its only needed for amend, so perhaps
> > we shuold not register this at all ?
>=20
> Sadly we kind of do, since both amend and create use the same option li=
st currently.
> I tried to duplicate it, and it is possible, but then you end up
> with significant code duplication in qcow2 with its huge create option =
list.

Ah, I see now.

> I am now thinking that we could have had , 'create only' option list, '=
amend only' option list,
> and 'common' option list.
> What do you think?

I'm not too fussed - either way is fine with me.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

