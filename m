Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D49C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F04820759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOZXGBE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F04820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdxS-000497-En
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNdkY-0002Pe-Av
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNdkV-0005pP-Kw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:10:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601478629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ynUlXyxL9uuUAoJtgV9hw5/sZUuPlF6mB7LdFcASkWU=;
 b=FOZXGBE+1hC/24kMLItpyhch3VcJUnMF45q9RoF2t+YwPJDqHi5fKQLpqOi6xlR9FEbN8h
 wuJMaY7hhctXlY6g6yq7H+xMS4SJG+djJQQaK/GZcDTe6UQB2f/jrMOW9lvQgkfXnfgfJc
 v/9EcmzXMCXET7lB1idW4iYPNufXxyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-PK4e6RCVPXeFMW2eGCbQUA-1; Wed, 30 Sep 2020 11:10:10 -0400
X-MC-Unique: PK4e6RCVPXeFMW2eGCbQUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 265631DE0E;
 Wed, 30 Sep 2020 15:10:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-128.ams2.redhat.com [10.36.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D659B619B5;
 Wed, 30 Sep 2020 15:10:07 +0000 (UTC)
Date: Wed, 30 Sep 2020 17:10:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/4] keyval: Parse help options
Message-ID: <20200930151006.GF9292@linux.fritz.box>
References: <20200930124557.51835-1-kwolf@redhat.com>
 <20200930124557.51835-2-kwolf@redhat.com>
 <001c321e-7400-f680-45ce-c920f078d5d8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <001c321e-7400-f680-45ce-c920f078d5d8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 30.09.2020 um 15:35 hat Eric Blake geschrieben:
> On 9/30/20 7:45 AM, Kevin Wolf wrote:
> > This adds a new parameter 'help' to keyval_parse() that enables parsing
> > of help options. If NULL is passed, the function behaves the same as
> > before. But if a bool pointer is given, it contains the information
> > whether an option "help" without value was given (which would otherwise
> > either result in an error or be interpreted as the value for an implied
> > key).
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
>=20
> > +
> > +    /* "help" is only a help option if it has no value */
> > +    qdict =3D keyval_parse("help=3Don", NULL, &help, &error_abort);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> > +    g_assert_cmpstr(qdict_get_try_str(qdict, "help"), =3D=3D, "on");
> > +    g_assert_false(help);
> > +    qobject_unref(qdict);
> > +
> > +    /* Double comma after "help" in an implied key is not a help optio=
n */
> > +    qdict =3D keyval_parse("help,,abc", "implied", &help, &error_abort=
);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> > +    g_assert_false(help);
> > +    qobject_unref(qdict);
>=20
> Worth checking qdict_get_try_str(qdict, "implied") for "help,abc"?

Yes, this makes sense.

> > +
> > +    /* Without implied key and without value, it's an error */
> > +    qdict =3D keyval_parse("help,,abc", NULL, &help, &err);
> > +    error_free_or_abort(&err);
> > +    g_assert(!qdict);
> > +
> > +    /* "help" as the only option */
> > +    qdict =3D keyval_parse("help", NULL, &help, &error_abort);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 0);
> > +    g_assert_true(help);
> > +    qobject_unref(qdict);
> > +
> > +    /* "help" as the first part of the key */
> > +    qdict =3D keyval_parse("help.abc", NULL, &help, &err);
> > +    error_free_or_abort(&err);
> > +    g_assert(!qdict);
>=20
> Worth checking qdict_get_try_str(qdict, "help.abc") for "on"? (at least,
> that's my guess as what happened)

The keyval parser doesn't support boolean options like this (I think
this is intentional because it would be ambiguous with implied keys).

This is an error case, and I don't think the QDict has defined content
then. But if anything, we would want to check that it's empty.

> > +
> > +    /* "help" as the last part of the key */
> > +    qdict =3D keyval_parse("abc.help", NULL, &help, &err);
> > +    error_free_or_abort(&err);
> > +    g_assert(!qdict);
>=20
> [1]
>=20
> > +
> > +    /* "help" is not a value for the implied key if &help is given */
> > +    qdict =3D keyval_parse("help", "implied", &help, &error_abort);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 0);
> > +    g_assert_true(help);
> > +    qobject_unref(qdict);
>=20
> Worth checking that the qdict does not contain "implied"?  Perhaps by
> checking qdict_size() =3D=3D 0?

Already there, the first line after keyval_parse(). :-)

> > +
> > +    /* "help" is a value for the implied key when passing NULL for hel=
p */
> > +    qdict =3D keyval_parse("help", "implied", NULL, &error_abort);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> > +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "help=
");
> > +    qobject_unref(qdict);
> > +
> > +    /* "help.abc" is a value for the implied key */
> > +    qdict =3D keyval_parse("help.abc", "implied", &help, &err);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> > +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "help=
.abc");
> > +    g_assert_false(help);
> > +    qobject_unref(qdict);
> > +
> > +    /* "abc.help" is a value for the implied key */
> > +    qdict =3D keyval_parse("abc.help", "implied", &help, &err);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> > +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "abc.=
help");
> > +    g_assert_false(help);
> > +    qobject_unref(qdict);
> > +
> > +    /* "help" as the last part of the key */
> > +    qdict =3D keyval_parse("abc.help", NULL, &help, &err);
> > +    error_free_or_abort(&err);
> > +    g_assert(!qdict);
>=20
> duplicates [1]

So we can be extra sure!

Somehow I suspect I wanted to test another case here, but I'm not sure
which one. Maybe the same with an implied key? Or I can just remove it.

> > +
> > +    /* Other keys before and after help are still parsed normally */
> > +    qdict =3D keyval_parse("number=3D42,help,foo=3Dbar", NULL, &help, =
&error_abort);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 2);
> > +    g_assert_cmpstr(qdict_get_try_str(qdict, "number"), =3D=3D, "42");
> > +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), =3D=3D, "bar");
> > +    g_assert_true(help);
> > +    qobject_unref(qdict);
> > +
> > +    /* ...even with an implied key */
> > +    qdict =3D keyval_parse("val,help,foo=3Dbar", "implied", &help, &er=
ror_abort);
> > +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 2);
> > +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "val"=
);
> > +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), =3D=3D, "bar");
> > +    g_assert_true(help);
> > +    qobject_unref(qdict);
> >  }
> > =20
>=20
> Overall a nice set of additions.  You could tweak it further, but I'm no
> longer seeing a hole like last time.
>=20
> > +++ b/util/keyval.c
> > @@ -166,7 +166,7 @@ static QObject *keyval_parse_put(QDict *cur,
> >   * On failure, return NULL.
> >   */
> >  static const char *keyval_parse_one(QDict *qdict, const char *params,
> > -                                    const char *implied_key,
> > +                                    const char *implied_key, bool *hel=
p,
> >                                      Error **errp)
> >  {
> >      const char *key, *key_end, *s, *end;
> > @@ -238,13 +238,20 @@ static const char *keyval_parse_one(QDict *qdict,=
 const char *params,
> >      if (key =3D=3D implied_key) {
> >          assert(!*s);
> >          s =3D params;
> > +    } else if (*s =3D=3D '=3D') {
> > +        s++;
> >      } else {
> > -        if (*s !=3D '=3D') {
> > +        if (help && !strncmp(key, "help", s - key)) {
>=20
> Should this use is_help_option() to also accept "?", or are we okay
> demanding exactly "help"?

The comment for is_help_option() calls "?" deprecated, so I think we
don't want to enable it in a new parser.

> > +            *help =3D true;
> > +            if (*s) {
> > +                s++;
> > +            }
> > +            return s;
> > +        } else {
> >              error_setg(errp, "Expected '=3D' after parameter '%.*s'",
> >                         (int)(s - key), key);
> >              return NULL;
> >          }
> > -        s++;
> >      }
>=20
> Assuming you can touch up the testsuite before the pull request, and
> assuming we don't care about "?",
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Kevin

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl90n84ACgkQfwmycsiP
L9YGmA/+P+UVOYkmLdV7kjLq4wxQ4Se6StSmjwehGOJnWoVH4tvgarfmtGpFl+6Z
at159Wi5MSVTEBjTP2W13ZsTMkyxevex7A0KjqtfmXk6/r14rQ/lopvrNTd8Jrtp
/8HKfyXWU/vRRjKjj2yI5AorR9+HOIb2bqla7ITt2VDIKzR6LIm2oHpZbes+8ml9
rj80ah5FO2yhSbwTA+QqQK63gAxxu+1Unv2efur8pPMj0WBo9MtUKbnodyaVRcgY
3thoIfTWxHQcGC9J7Cn9/eZDwLdb1PavCa4yUrlxR8BhdP8YwKaraNgJtNWarDb0
0dQemT0hsp9DyPtp1MWYkfz8jwN8zXmUym90IPDktin6bwnKwQgeFp6rHmiQhIn7
OYU2NnrIfEKw2clKeiHorol/9Kep+A9Tvl5eSuaVifDXTQYclNl4a90f0wxtBtQD
HImzyRvTpr7JorujZU464H/l0DLhfmB/6CVAwCgwp+WAJk42wwtI5ZyvWEie56OB
ZseoLn0Q7kqSZ2fU+TWjRBN1RnFlA98f+fYXhJO/9aSLfrVeobB06IVYiCXwaxkx
Df0xr1O5ZWowvvlnWSKBBucA5yAR61gj8Xl0S6Iw7KhN9DifDTLpHwvDVoWy27Gr
xzvWhQ5PudDXZF0qtcWwRDb7WF7X+ninAOEfqUkVUj/1kNnCec0=
=qCi/
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--


