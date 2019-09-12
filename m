Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215ADC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 07:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4D321479
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 07:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4D321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8JU6-0004gJ-2y
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 03:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8JT9-0003iN-W9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 03:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8JT8-0005TN-MJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 03:24:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8JT4-0005R0-Jf; Thu, 12 Sep 2019 03:24:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFD3B307D91F;
 Thu, 12 Sep 2019 07:24:36 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C8685D9CA;
 Thu, 12 Sep 2019 07:24:30 +0000 (UTC)
Message-ID: <37a596d2511b13a235a4705ca79637615dfa02ce.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 12 Sep 2019 10:24:29 +0300
In-Reply-To: <20190906131123.GF5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-10-mlevitsk@redhat.com>
 <20190906131123.GF5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 12 Sep 2019 07:24:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/13] qcrypto-block: extract check and
 parse header
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

On Fri, 2019-09-06 at 14:11 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Aug 26, 2019 at 04:50:59PM +0300, Maxim Levitsky wrote:
> > This is just to make qcrypto_block_luks_open more
> > reasonable in size.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 254 +++++++++++++++++++++++++-----------------=
--
> >  1 file changed, 146 insertions(+), 108 deletions(-)
> >=20
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index b4dc6fc899..cc9a52c9af 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -508,6 +508,148 @@ fail:
> >      return ret;
> >  }
> > =20
> > +/*
> > + * Does basic sanity checks on the LUKS header
> > + */
> > +static int
> > +qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error =
**errp)
> > +{
> > +    int ret;
> > +
> > +    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
> > +               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
> > +        error_setg(errp, "Volume is not in LUKS format");
> > +        ret =3D -EINVAL;
> > +        goto fail;
> > +    }
>=20
> Just 'return -1' here immediately - don't return an errno, as we're
> using Error objects for reporting.
>=20
> > +
> > +    if (luks->header.version !=3D QCRYPTO_BLOCK_LUKS_VERSION) {
> > +        error_setg(errp, "LUKS version %" PRIu32 " is not supported"=
,
> > +                   luks->header.version);
> > +        ret =3D -ENOTSUP;
> > +        goto fail;
> > +    }
> > +
> > +    return 0;
> > +fail:
> > +    return ret;
> > +}
> > +
> > +/*
> > + * Parses the crypto parameters that are stored in the LUKS header
> > + */
> > +
> > +static int
> > +qcrypto_block_luks_parse_header(QCryptoBlockLUKS *luks, Error **errp=
)
> > +{
> > +    g_autofree char *cipher_mode =3D g_strdup(luks->header.cipher_mo=
de);
> > +    char *ivgen_name, *ivhash_name;
> > +    int ret =3D -1;
> > +    Error *local_err =3D NULL;
> > +
> > +    /*
> > +     * The cipher_mode header contains a string that we have
> > +     * to further parse, of the format
> > +     *
> > +     *    <cipher-mode>-<iv-generator>[:<iv-hash>]
> > +     *
> > +     * eg  cbc-essiv:sha256, cbc-plain64
> > +     */
> > +    ivgen_name =3D strchr(cipher_mode, '-');
> > +    if (!ivgen_name) {
> > +        ret =3D -EINVAL;
>=20
> Again, don't use errnos - just return -1 in this method.
>=20
> > +        error_setg(errp, "Unexpected cipher mode string format %s",
> > +                   luks->header.cipher_mode);
> > +        goto out;
> > +    }
> > +    *ivgen_name =3D '\0';
> > +    ivgen_name++;
> > +
> > +    ivhash_name =3D strchr(ivgen_name, ':');
> > +    if (!ivhash_name) {
> > +        luks->ivgen_hash_alg =3D 0;
> > +    } else {
> > +        *ivhash_name =3D '\0';
> > +        ivhash_name++;
> > +
> > +        luks->ivgen_hash_alg =3D qcrypto_block_luks_hash_name_lookup=
(ivhash_name,
> > +                                                                   &=
local_err);
> > +        if (local_err) {
> > +            ret =3D -ENOTSUP;
> > +            error_propagate(errp, local_err);
> > +            goto out;
> > +        }
> > +    }
> > +
> > +    luks->cipher_mode =3D qcrypto_block_luks_cipher_mode_lookup(ciph=
er_mode,
> > +                                                              &local=
_err);
> > +    if (local_err) {
> > +        ret =3D -ENOTSUP;
> > +        error_propagate(errp, local_err);
> > +        goto out;
> > +    }
> > +
> > +    luks->cipher_alg =3D
> > +            qcrypto_block_luks_cipher_name_lookup(luks->header.ciphe=
r_name,
> > +                                                  luks->cipher_mode,
> > +                                                  luks->header.maste=
r_key_len,
> > +                                                  &local_err);
> > +    if (local_err) {
> > +        ret =3D -ENOTSUP;
> > +        error_propagate(errp, local_err);
> > +        goto out;
> > +    }
> > +
> > +    luks->hash_alg =3D
> > +            qcrypto_block_luks_hash_name_lookup(luks->header.hash_sp=
ec,
> > +                                               &local_err);
> > +    if (local_err) {
> > +        ret =3D -ENOTSUP;
> > +        error_propagate(errp, local_err);
> > +        goto out;
> > +    }
> > +
> > +    luks->ivgen_alg =3D qcrypto_block_luks_ivgen_name_lookup(ivgen_n=
ame,
> > +                                                           &local_er=
r);
> > +    if (local_err) {
> > +        ret =3D -ENOTSUP;
> > +        error_propagate(errp, local_err);
> > +        goto out;
> > +    }
> > +
> > +    if (luks->ivgen_alg =3D=3D QCRYPTO_IVGEN_ALG_ESSIV) {
> > +        if (!ivhash_name) {
> > +            ret =3D -EINVAL;
> > +            error_setg(errp, "Missing IV generator hash specificatio=
n");
> > +            goto out;
> > +        }
> > +        luks->ivgen_cipher_alg =3D
> > +                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
> > +                                                luks->ivgen_hash_alg=
,
> > +                                                &local_err);
> > +        if (local_err) {
> > +            ret =3D -ENOTSUP;
> > +            error_propagate(errp, local_err);
> > +            goto out;
> > +        }
> > +    } else {
> > +
> > +        /*
> > +         * Note we parsed the ivhash_name earlier in the cipher_mode
> > +         * spec string even with plain/plain64 ivgens, but we
> > +         * will ignore it, since it is irrelevant for these ivgens.
> > +         * This is for compat with dm-crypt which will silently
> > +         * ignore hash names with these ivgens rather than report
> > +         * an error about the invalid usage
> > +         */
> > +        luks->ivgen_cipher_alg =3D luks->cipher_alg;
> > +    }
> > +    ret =3D 0;
> > +out:
> > +    return ret;
> > +
> > +}
> > +
> >  /*
> >   * Given a key slot, and user password, this will attempt to unlock
> >   * the master encryption key from the key slot.
> > @@ -720,12 +862,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> >                          Error **errp)
> >  {
> >      QCryptoBlockLUKS *luks =3D NULL;
> > -    Error *local_err =3D NULL;
> >      int ret =3D 0;
> >      g_autofree uint8_t *masterkey =3D NULL;
> > -    char *ivgen_name, *ivhash_name;
> >      g_autofree char *password =3D NULL;
> > -    g_autofree char *cipher_mode =3D NULL;
> > =20
> >      if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
> >          if (!options->u.luks.key_secret) {
> > @@ -748,117 +887,16 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> >          goto fail;
> >      }
> > =20
> > -
> > -    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
> > -               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
> > -        error_setg(errp, "Volume is not in LUKS format");
> > -        ret =3D -EINVAL;
>=20
> I can't remember why I set ret to an errno in my original code.
> it is entirely pointless, as the caller of this method merely
> checks "ret < 0" and doesn't do anything else with the return
> value. IOW, we should just purge the errnors from this existing
> code entirely.

Nothing against that, I'll do that in a separate patch now.
Best regards,
	Maxim Levitsky


