Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B9FC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22233206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaeeYexm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22233206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcHw-00027e-Qu
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNcGt-0001UW-PM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNcGp-00057M-BF
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:35:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601472945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SM4qbPoTJarQdrL4j2WhN1KjtnCn/ukF5SOSHp8+PFE=;
 b=NaeeYexmsN93LLFSTLQmwc016H/t7gtN0I9EdB1w+VlEQeV6RtWxDGjjXnsVBWKyoid6aY
 mtnEJ+TTx8RuHutqP/Pu4fV5wsOdIZ3xZpYyNvSCAKvNf2kJ/8o0zFZ5YWdHdFQKZm+11R
 fqhutWefB5g7DqlF5uXhVEbe35AhpLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-lcJvMLGCOAi3qV0nemsLoQ-1; Wed, 30 Sep 2020 09:35:41 -0400
X-MC-Unique: lcJvMLGCOAi3qV0nemsLoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59771019637;
 Wed, 30 Sep 2020 13:35:39 +0000 (UTC)
Received: from [10.3.112.131] (ovpn-112-131.phx2.redhat.com [10.3.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6069E7EB8F;
 Wed, 30 Sep 2020 13:35:39 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] keyval: Parse help options
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200930124557.51835-1-kwolf@redhat.com>
 <20200930124557.51835-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 mQENBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAG0HkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPokBOgQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6uQENBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAGJAR8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4PpkBDQRL
 x8lsAQgAsOw8LECIdJAG1F8qoX4igCjk1bujojBn38NsPdBoK6eG3VSpgmhF5a1S1MaYQTPJ
 m/sLBZFPqavWEettVl6PURGFSJdBcSnkKPXckAWf175lDJGuDTph7RYO+J75KSRQg01Dc5qn
 3I3SoXxVdHez/4sSkHma9lj9cTHI5gEGOWL0NpVKBz+N5vE7aQdS5I8mAQqHXfi5FRpgsdga
 KdS0m5W726zptmyqWXQT453ETaG+93k6SFxLrbxGhx+9i86c5LH3CjPjNfHMkR/pz7AHffMS
 G1Y5tyZuJOHeaEMhNh8Drq/ra5NhHMU4Hade0Gqblj8DH4Wjat67p2l+8d+M4QARAQABtB5F
 cmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT6JATcEEwEIACEFAkvHyWwCGwMFCwkIBwMF
 FQoJCAsFFgIDAQACHgECF4AACgkQp6FrSiUnQ2oiZgf/ccRzSLeY7uXWCgNhlYgB1ZdDkGgB
 oITVYrq6VE78zTDQn/9f+TCA3odhnwwoLuQPWDjbR+d0PS10s/VAKcgnDWf1v8KYtP0aYjPK
 y9aPX6K+Jkcbu5BBQ+2fHO2NLqKCZMqMVSw96T1CI9igwDSDBoGsr/VPIarhr9qHgQKko83B
 9iVERjQUDaz5KnyawDD6WxqVYJaLGo2C4QVFn4ePhtZc5F0NymIlplZPJORhnx05tsiJrEW2
 0CnRmICOwIyCc24O0tNjBWX6ccoe8aMP9AIkOzs4ZGOOWv04dfKFv21PZYhHJgc1PSorz4mi
 Gs2bCdUKzBxrJ+bxoAPUZ6a2brkBDQRLx8lsAQgAxpDBcxY5psqgBJ+Q/jLeD8z3TvDWrbA8
 PEIrd0Zs7vpFMoMcmG8+dmTuNFlLuxIEOZA0znkT50zne2sFg0HJdYBgV4K5EaQJUNJdEXju
 e0NHoJRcnSzIuW5MGIX2Pk8AzzId2jj+agV5JuKiGErMW/APotND+9gKhW/UO98Hhv35cUjw
 KS2EBOalhkl4zpFyb+NjRkuqOoHeEZg+gKeXvAAqNZUjD306Rs15beGkZAX72zQnzbEIpC2c
 xWAy20ICgQN9wQ3lerzSfQo9EoBBjpGMnneCOgG1NJCMtYRwJta+vrAJxHSCo3B4t8Vh/1D6
 2VuX5TPCqqNeDkw5CPRLZQARAQABiQEfBBgBCAAJBQJLx8lsAhsMAAoJEKeha0olJ0NqtN8I
 AJkRRg3l83OfDV9Daw4o1LtM8dy57P6mfVa5ElmzWQRY6Vimni9X3VXhOEwxpiOZkUSLErY0
 M3NkfW/tlQVIZQKmNZwIgQ79EJ7fvXC4rhCAnlMJcpeNmHcKZmNBC3MufrusM5iv48a2Dqc1
 yg8C6uZOF/oZhrkjVlgDd4B4iapiWT5IRT1CKM2VAnhHO+qUvyFDe9jX6a2ZhQ6ev0A4wxbX
 0t/Wx0llylWVG6mjD6pY/8+lIJNNu/9xlIxx6/FpHi9Xs1nqWA2O1kqF8H6AC9lF2LDAK/7l
 J3EipX47wK4bHo9EuM26optmWOkvGkVsPeCd20ryUfjcG7N+Bj0w+D4=
Organization: Red Hat, Inc.
Message-ID: <001c321e-7400-f680-45ce-c920f078d5d8@redhat.com>
Date: Wed, 30 Sep 2020 08:35:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930124557.51835-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iCRVnLLV5BKK3egYYXF2478tQYZfxsxEV"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iCRVnLLV5BKK3egYYXF2478tQYZfxsxEV
Content-Type: multipart/mixed; boundary="Jk3vYMdwy6G15inPIXj9XtQL4362k7ODE";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <001c321e-7400-f680-45ce-c920f078d5d8@redhat.com>
Subject: Re: [PATCH v2 1/4] keyval: Parse help options
References: <20200930124557.51835-1-kwolf@redhat.com>
 <20200930124557.51835-2-kwolf@redhat.com>
In-Reply-To: <20200930124557.51835-2-kwolf@redhat.com>

--Jk3vYMdwy6G15inPIXj9XtQL4362k7ODE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/30/20 7:45 AM, Kevin Wolf wrote:
> This adds a new parameter 'help' to keyval_parse() that enables parsing
> of help options. If NULL is passed, the function behaves the same as
> before. But if a bool pointer is given, it contains the information
> whether an option "help" without value was given (which would otherwise
> either result in an error or be interpreted as the value for an implied
> key).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +
> +    /* "help" is only a help option if it has no value */
> +    qdict =3D keyval_parse("help=3Don", NULL, &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "help"), =3D=3D, "on");
> +    g_assert_false(help);
> +    qobject_unref(qdict);
> +
> +    /* Double comma after "help" in an implied key is not a help option =
*/
> +    qdict =3D keyval_parse("help,,abc", "implied", &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_false(help);
> +    qobject_unref(qdict);

Worth checking qdict_get_try_str(qdict, "implied") for "help,abc"?

> +
> +    /* Without implied key and without value, it's an error */
> +    qdict =3D keyval_parse("help,,abc", NULL, &help, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* "help" as the only option */
> +    qdict =3D keyval_parse("help", NULL, &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 0);
> +    g_assert_true(help);
> +    qobject_unref(qdict);
> +
> +    /* "help" as the first part of the key */
> +    qdict =3D keyval_parse("help.abc", NULL, &help, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);

Worth checking qdict_get_try_str(qdict, "help.abc") for "on"? (at least,
that's my guess as what happened)

> +
> +    /* "help" as the last part of the key */
> +    qdict =3D keyval_parse("abc.help", NULL, &help, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);

[1]

> +
> +    /* "help" is not a value for the implied key if &help is given */
> +    qdict =3D keyval_parse("help", "implied", &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 0);
> +    g_assert_true(help);
> +    qobject_unref(qdict);

Worth checking that the qdict does not contain "implied"?  Perhaps by
checking qdict_size() =3D=3D 0?

> +
> +    /* "help" is a value for the implied key when passing NULL for help =
*/
> +    qdict =3D keyval_parse("help", "implied", NULL, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "help")=
;
> +    qobject_unref(qdict);
> +
> +    /* "help.abc" is a value for the implied key */
> +    qdict =3D keyval_parse("help.abc", "implied", &help, &err);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "help.a=
bc");
> +    g_assert_false(help);
> +    qobject_unref(qdict);
> +
> +    /* "abc.help" is a value for the implied key */
> +    qdict =3D keyval_parse("abc.help", "implied", &help, &err);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "abc.he=
lp");
> +    g_assert_false(help);
> +    qobject_unref(qdict);
> +
> +    /* "help" as the last part of the key */
> +    qdict =3D keyval_parse("abc.help", NULL, &help, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);

duplicates [1]

> +
> +    /* Other keys before and after help are still parsed normally */
> +    qdict =3D keyval_parse("number=3D42,help,foo=3Dbar", NULL, &help, &e=
rror_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 2);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "number"), =3D=3D, "42");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), =3D=3D, "bar");
> +    g_assert_true(help);
> +    qobject_unref(qdict);
> +
> +    /* ...even with an implied key */
> +    qdict =3D keyval_parse("val,help,foo=3Dbar", "implied", &help, &erro=
r_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 2);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "val");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), =3D=3D, "bar");
> +    g_assert_true(help);
> +    qobject_unref(qdict);
>  }
> =20

Overall a nice set of additions.  You could tweak it further, but I'm no
longer seeing a hole like last time.

> +++ b/util/keyval.c
> @@ -166,7 +166,7 @@ static QObject *keyval_parse_put(QDict *cur,
>   * On failure, return NULL.
>   */
>  static const char *keyval_parse_one(QDict *qdict, const char *params,
> -                                    const char *implied_key,
> +                                    const char *implied_key, bool *help,
>                                      Error **errp)
>  {
>      const char *key, *key_end, *s, *end;
> @@ -238,13 +238,20 @@ static const char *keyval_parse_one(QDict *qdict, c=
onst char *params,
>      if (key =3D=3D implied_key) {
>          assert(!*s);
>          s =3D params;
> +    } else if (*s =3D=3D '=3D') {
> +        s++;
>      } else {
> -        if (*s !=3D '=3D') {
> +        if (help && !strncmp(key, "help", s - key)) {

Should this use is_help_option() to also accept "?", or are we okay
demanding exactly "help"?

> +            *help =3D true;
> +            if (*s) {
> +                s++;
> +            }
> +            return s;
> +        } else {
>              error_setg(errp, "Expected '=3D' after parameter '%.*s'",
>                         (int)(s - key), key);
>              return NULL;
>          }
> -        s++;
>      }

Assuming you can touch up the testsuite before the pull request, and
assuming we don't care about "?",

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Jk3vYMdwy6G15inPIXj9XtQL4362k7ODE--

--iCRVnLLV5BKK3egYYXF2478tQYZfxsxEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl90iaoACgkQp6FrSiUn
Q2pKNAf/e4O68kBWVSioFAg2G/NrFo3vI7uW+L5LdhsGG6EFCsx/N2CcQ+pDyW/O
GXcIXKLpwx7mjkqLlAODEfO4vDuQqhBC1P1ZAexUS1niBzsPFibMOY56jQHzWD2E
JDmQ3lzFE19KB9evAE8Q95VKJyCsTMTfZymnT2gyi9nLtEmR16SGsl6hP2itAQt/
4GHvn/PxGP61TJ1NgIm3204JvlsFfRqfbu7k6DTfdme8LshJ9N1wh3CwVzJsps17
XMyzbgmlOyVB6JSvAqwrA8ASzen7niak+QxzvnO/dkM4VzeoHqtpwQh3l4X6YriB
uxa/IYB5ATtLJXDDtHmqnrkUeJDJ/g==
=YAoZ
-----END PGP SIGNATURE-----

--iCRVnLLV5BKK3egYYXF2478tQYZfxsxEV--


