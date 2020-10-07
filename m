Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B4C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404132168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKX10M25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404132168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDN1-00055R-9k
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQDGH-0007I0-8X
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQDG9-0000DT-Cq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602091788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/uqYLS1LbopoDC7KHGQFupjQLbU0LuRB3iE7nDesYug=;
 b=SKX10M258WXSyLkh3sKiOgEBA9dJ7G/rVPsFwsVFrI0qs9GTagQX4A0tQjL2gEuID17vLK
 l/tQSInR8r/VS7rxFORpBd3xk/KWAOc2G8W+OJzP8WzcDk20sD+CGYHXlGKpGLzLbqWqfH
 6JA5JgzfgGzfzKTWnZz+t2PX7wYBv14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-UCjDbaqCNJaTw-Zy1ZSJdQ-1; Wed, 07 Oct 2020 13:29:43 -0400
X-MC-Unique: UCjDbaqCNJaTw-Zy1ZSJdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE6E804013;
 Wed,  7 Oct 2020 17:29:41 +0000 (UTC)
Received: from [10.3.113.66] (ovpn-113-66.phx2.redhat.com [10.3.113.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 509F31002382;
 Wed,  7 Oct 2020 17:29:41 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] keyval: Parse help options
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20201007164903.282198-1-kwolf@redhat.com>
 <20201007164903.282198-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <609ce08c-35d5-ca85-ac15-bdbc56c28465@redhat.com>
Date: Wed, 7 Oct 2020 12:29:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007164903.282198-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mOnHv6AIaNSAyKPLsDD2PcEhZB0sdEpeR"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mOnHv6AIaNSAyKPLsDD2PcEhZB0sdEpeR
Content-Type: multipart/mixed; boundary="LSvaU345wtI4cfSCaJs3nEj4cgElx57gP";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <609ce08c-35d5-ca85-ac15-bdbc56c28465@redhat.com>
Subject: Re: [PATCH v3 1/4] keyval: Parse help options
References: <20201007164903.282198-1-kwolf@redhat.com>
 <20201007164903.282198-2-kwolf@redhat.com>
In-Reply-To: <20201007164903.282198-2-kwolf@redhat.com>

--LSvaU345wtI4cfSCaJs3nEj4cgElx57gP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/7/20 11:49 AM, Kevin Wolf wrote:
> This adds a special meaning for 'help' and '?' as options to the keyval
> parser. Instead of being an error (because of a missing value) or a
> value for an implied key, they now request help, which is a new boolean
> ouput of the parser in addition to the QDict.

output

>=20
> A new parameter 'p_help' is added to keyval_parse() that contains on
> return whether help was requested. If NULL is passed, requesting help
> results in an error and all other cases work like before.
>=20
> Turning previous error cases into help is a compatible extension. The
> behaviour potentially changes for implied keys: They could previously
> get 'help' as their value, which is now interpreted as requesting help.
>=20
> This is not a problem in practice because 'help' and '?' are not a valid
> values for the implied key of any option parsed with keyval_parse():
>=20
> * audiodev: union Audiodev, implied key "driver" is enum AudiodevDriver,
>   "help" and "?" are not among its values
>=20
> * display: union DisplayOptions, implied key "type" is enum
>   DisplayType, "help" and "?" are not among its values
>=20
> * blockdev: union BlockdevOptions, implied key "driver is enum
>   BlockdevDriver, "help" and "?" are not among its values
>=20
> * export: union BlockExport, implied key "type" is enum BlockExportType,
>   "help" and "?" are not among its values
>=20
> * monitor: struct MonitorOptions, implied key "mode"is enum MonitorMode,

missing space

>   "help" and "?" are not among its values
>=20
> * nbd-server: struct NbdServerOptions, no implied key.

Including the audit is nice (and thanks to Markus for helping derive the
list).

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/util/keyval.c
> @@ -14,7 +14,7 @@
>   * KEY=3DVALUE,... syntax:
>   *
>   *   key-vals     =3D [ key-val { ',' key-val } [ ',' ] ]
> - *   key-val      =3D key '=3D' val
> + *   key-val      =3D 'help' | key '=3D' val

Maybe: =3D 'help' | '?' | key =3D '=3D' val

>   *   key          =3D key-fragment { '.' key-fragment }
>   *   key-fragment =3D / [^=3D,.]* /
>   *   val          =3D { / [^,]* / | ',,' }
> @@ -73,10 +73,14 @@
>   *
>   * Additional syntax for use with an implied key:
>   *
> - *   key-vals-ik  =3D val-no-key [ ',' key-vals ]
> + *   key-vals-ik  =3D 'help' | val-no-key [ ',' key-vals ]

and again for '?' here.  Actually, this should probably be:

key-vals-ik  =3D 'help' [ ',' key-vals ]
             | '?' [ ',' key-vals ]
             | val-no-key [ ',' key-vals ]

>   *   val-no-key   =3D / [^=3D,]* /

This is now slightly inaccurate, but I don't know how to concisely
express the regex [^=3D,]* but not '?' or 'help', and the prose covers the
ambiguity.


> @@ -410,6 +442,14 @@ QDict *keyval_parse(const char *params, const char *=
implied_key,
>          implied_key =3D NULL;
>      }
> =20
> +    if (p_help) {
> +        *p_help =3D help;
> +    } else if (help) {
> +        error_setg(errp, "Help is not available for this option");
> +        qobject_unref(qdict);
> +        return NULL;
> +    }

This part is a definite improvement over v2.

I'm assuming Markus can help touch up the comments and spelling errors, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--LSvaU345wtI4cfSCaJs3nEj4cgElx57gP--

--mOnHv6AIaNSAyKPLsDD2PcEhZB0sdEpeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl99+wQACgkQp6FrSiUn
Q2oqdgf8Dsr7Y/c2sRMnoww9t32pROcG5NEqQJ/Khv6NliOXxsvp/ySmHzloRqEv
MCBpidrAfDfkiJOjvhxM3iGJdFPkrziB83nLnpvwohyWhC3aV1B1VPgKBYZHK0+h
ZCPQsFzO8ZMpN75SFrzstORekztSC6d/Pc9ZkzdJX/rwFbVt2xbcNiUiC4sr2haU
VhoMttPQHBAXox44MlGvuG3QlPWqepPwlfhr6OC0W0Q89hcjRzDsYMu4ddFgte7h
1FMZQoagLM52wQJHypuGl9hboWBgtFTkYpM2OQ0ZQ6x1BlklV+etDxktombl/CSt
k9d9th/eegvF11Rijw1O7yCs/LerqQ==
=My2a
-----END PGP SIGNATURE-----

--mOnHv6AIaNSAyKPLsDD2PcEhZB0sdEpeR--


