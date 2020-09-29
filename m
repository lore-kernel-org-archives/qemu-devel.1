Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB28C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6351F208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1vzcNYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6351F208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJkw-00081R-6e
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNJib-00071o-28
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNJiY-0007Vn-ME
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:47:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601401629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BupxoHdjbL2TpBh8a0BYS6QeDupOHyjF9X61wUjeE88=;
 b=h1vzcNYOWfnqQc7aW06N0wK3L0WxlbqCgymHa4ALa42jeO4W4/mfqp9SncKn1qYnc6onsk
 n2et2gaNYj8L5AfwU4AdayHLhJ76gQ4DVjuboNaHH6aywPLUxEjA2BV4RyjfmZCiFI3mY2
 Cy209GzzAlFQX0MhDZYauUDaRKAI8k8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-mhlVNHKxNqaAOdDfy24XWg-1; Tue, 29 Sep 2020 13:47:06 -0400
X-MC-Unique: mhlVNHKxNqaAOdDfy24XWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97FB91084C9B;
 Tue, 29 Sep 2020 17:47:05 +0000 (UTC)
Received: from [10.3.112.208] (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 159297BE49;
 Tue, 29 Sep 2020 17:46:57 +0000 (UTC)
Subject: Re: [PATCH 1/4] keyval: Parse help options
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200929172649.158086-1-kwolf@redhat.com>
 <20200929172649.158086-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <b28cad72-d344-78fa-fc07-b4a6a63fbc50@redhat.com>
Date: Tue, 29 Sep 2020 12:46:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929172649.158086-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w2YOyLmZAwuYhMOSNcpdwm64oy3c16HLh"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w2YOyLmZAwuYhMOSNcpdwm64oy3c16HLh
Content-Type: multipart/mixed; boundary="lY49hzTHYNWwghw4gYUqNOQw0pzjHPI1A";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Message-ID: <b28cad72-d344-78fa-fc07-b4a6a63fbc50@redhat.com>
Subject: Re: [PATCH 1/4] keyval: Parse help options
References: <20200929172649.158086-1-kwolf@redhat.com>
 <20200929172649.158086-2-kwolf@redhat.com>
In-Reply-To: <20200929172649.158086-2-kwolf@redhat.com>

--lY49hzTHYNWwghw4gYUqNOQw0pzjHPI1A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/29/20 12:26 PM, Kevin Wolf wrote:
> This adds a new parameter 'help' to keyval_parse() that enables parsing
> of help options. If NULL is passed, the function behaves the same as
> before. But if a bool pointer is given, it contains the information
> whether an option "help" without value was given (which would otherwise
> either result in an error or be interpreted as the value for an implied
> key).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/util/keyval.c

Might be nice to see this before the testsuite changes by tweaking the
git orderfile.

> @@ -166,7 +166,7 @@ static QObject *keyval_parse_put(QDict *cur,
>   * On failure, return NULL.
>   */
>  static const char *keyval_parse_one(QDict *qdict, const char *params,
> -                                    const char *implied_key,
> +                                    const char *implied_key, bool *help,
>                                      Error **errp)
>  {
>      const char *key, *key_end, *s, *end;
> @@ -179,6 +179,16 @@ static const char *keyval_parse_one(QDict *qdict, co=
nst char *params,
> =20
>      key =3D params;
>      len =3D strcspn(params, "=3D,");
> +
> +    if (help && key[len] !=3D '=3D' && !strncmp(key, "help", len)) {

What if the user typed "help,," to get "help," as the value of the
implied key?

> +        *help =3D true;
> +        s =3D key + len;
> +        if (key[len] !=3D '\0') {
> +            s++;
> +        }
> +        return s;
> +    }
> +
>      if (implied_key && len && key[len] !=3D '=3D') {
>          /* Desugar implied key */
>          key =3D implied_key;
> @@ -388,21 +398,33 @@ static QObject *keyval_listify(QDict *cur, GSList *=
key_of_cur, Error **errp)
> =20
>  /*
>   * Parse @params in QEMU's traditional KEY=3DVALUE,... syntax.
> + *
>   * If @implied_key, the first KEY=3D can be omitted.  @implied_key is
>   * implied then, and VALUE can't be empty or contain ',' or '=3D'.
> + *
> + * If @help is given, an option "help" without a value isn't added to
> + * the resulting dictionary, but instead sets @help to true. If no
> + * help option is found, @help is false on return. All other options
> + * are parsed and returned normally so that context specific help can
> + * be printed.
> + *
>   * On success, return a dictionary of the parsed keys and values.
>   * On failure, store an error through @errp and return NULL.
>   */
>  QDict *keyval_parse(const char *params, const char *implied_key,
> -                    Error **errp)
> +                    bool *help, Error **errp)
>  {
>      QDict *qdict =3D qdict_new();
>      QObject *listified;
>      const char *s;
> =20
> +    if (help) {
> +        *help =3D false;
> +    }
> +
>      s =3D params;
>      while (*s) {
> -        s =3D keyval_parse_one(qdict, s, implied_key, errp);
> +        s =3D keyval_parse_one(qdict, s, implied_key, help, errp);
>          if (!s) {
>              qobject_unref(qdict);
>              return NULL;
>=20

I like it, but wonder if you are missing one corner case.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lY49hzTHYNWwghw4gYUqNOQw0pzjHPI1A--

--w2YOyLmZAwuYhMOSNcpdwm64oy3c16HLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl9zcxAACgkQp6FrSiUn
Q2pFEQf9EOTNu/bqCQvFIf25aLN2iqRaD45aJvGMPUf2BlIIULPY0Z2HUcsVJQvy
1U8NsqcWrSIFSLnTd5+i9EUY+fW0LmkntYoNPj1Oc4TLvWbZWAvGrxFyut1/d41c
G8sEPu0Yg3d+jklG+PItwkJr/Q/BYdutir0szwc1Ytko7naCsK8FdDrrkJKoVfKb
r92q66sNPruHEgoCL/pcmPNKTssh5KIaKPqmaFBXh11lJUMFJp0dbZm0HxqiE+R0
WiiT/Dd3DqC4nnR35a9HOEciXHctzRcCwyV1OCZKq7lZEZzi3/LTOHm94RfDp00F
EJC0KMVinTFC0QDSyle6e1Vc3Sgplg==
=h6cY
-----END PGP SIGNATURE-----

--w2YOyLmZAwuYhMOSNcpdwm64oy3c16HLh--


