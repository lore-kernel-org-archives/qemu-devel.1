Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5409EC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA5A20885
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTgi3YE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA5A20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbHCh-0001r7-8C
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 00:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbHBl-0001PE-Ug
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:55:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbHBk-0000xZ-8w
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604728498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oRfLr2Osk93MJ1NcyLSXNYHd7E0mmzMT2Y5WAaOv9A=;
 b=gTgi3YE22uQmQUUAQCegPH6JKuhNoBfr9pPeQoyDKUxq534sbTja9Q9YEFzGoP/Kr1HROW
 NywP/PZYKTQ2iisrjPqjc8afFcXR/L0UOKGBhcoEpBJvH9jNMAHpFsdtAmeJim/daImxgC
 oBjXOFWuOuiqvl5wPQPBC/qzeLrGQKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-n3_Cx0GzOGa0FU_6GLMSpg-1; Sat, 07 Nov 2020 00:54:55 -0500
X-MC-Unique: n3_Cx0GzOGa0FU_6GLMSpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF6DF185A0CA
 for <qemu-devel@nongnu.org>; Sat,  7 Nov 2020 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-47.rdu2.redhat.com
 [10.10.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 251EA6EF6C;
 Sat,  7 Nov 2020 05:54:54 +0000 (UTC)
Date: Sat, 7 Nov 2020 00:54:52 -0500
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 10/11] qapi/introspect.py: improve readability of
 _tree_to_qlit
Message-ID: <20201107055452.GF2208@localhost.localdomain>
References: <20201026194251.11075-1-jsnow@redhat.com>
 <20201026194251.11075-11-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-11-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 22:10:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 03:42:50PM -0400, John Snow wrote:
> Subjective, but I find getting rid of the comprehensions helps. Also,
> divide the sections into scalar and non-scalar sections, and remove
> old-style string formatting.
>

It's certainly a matter of picking your favorite poison... but for the
most part I think this is an improvement...

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index a261e402d69..d4f28485ba5 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -100,7 +100,7 @@ def indent(level: int) -> str:
> =20
>          ret =3D ''
>          if obj.comment:
> -            ret +=3D indent(level) + '/* %s */\n' % obj.comment
> +            ret +=3D indent(level) + f"/* {obj.comment} */\n"
>          if obj.ifcond:
>              ret +=3D gen_if(obj.ifcond)
>          ret +=3D _tree_to_qlit(obj.value, level, suppress_first_indent)
> @@ -111,31 +111,36 @@ def indent(level: int) -> str:
>      ret =3D ''
>      if not suppress_first_indent:
>          ret +=3D indent(level)
> +
> +    # Scalars:
>      if obj is None:
>          ret +=3D 'QLIT_QNULL'
>      elif isinstance(obj, str):
> -        ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
> +        ret +=3D f"QLIT_QSTR({to_c_string(obj)})"
> +    elif isinstance(obj, bool):
> +        ret +=3D "QLIT_QBOOL({:s})".format(str(obj).lower())
> +
> +    # Non-scalars:
>      elif isinstance(obj, list):
> -        elts =3D [_tree_to_qlit(elt, level + 1).strip('\n')
> -                for elt in obj]
> -        elts.append(indent(level + 1) + "{}")
>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
> -        ret +=3D '\n'.join(elts) + '\n'
> +        for value in obj:
> +            ret +=3D _tree_to_qlit(value, level + 1).strip('\n') + '\n'
> +        ret +=3D indent(level + 1) + '{}\n'
>          ret +=3D indent(level) + '}))'
>      elif isinstance(obj, dict):
> -        elts =3D []
> -        for key, value in sorted(obj.items()):
> -            elts.append(indent(level + 1) + '{ %s, %s }' %
> -                        (to_c_string(key),
> -                         _tree_to_qlit(value, level + 1, True)))
> -        elts.append(indent(level + 1) + '{}')
>          ret +=3D 'QLIT_QDICT(((QLitDictEntry[]) {\n'
> -        ret +=3D ',\n'.join(elts) + '\n'
> +        for key, value in sorted(obj.items()):
> +            ret +=3D indent(level + 1) + "{{ {:s}, {:s} }},\n".format(
> +                to_c_string(key),
> +                _tree_to_qlit(value, level + 1, suppress_first_indent=3D=
True)
> +            )
> +        ret +=3D indent(level + 1) + '{}\n'
>          ret +=3D indent(level) + '}))'
> -    elif isinstance(obj, bool):
> -        ret +=3D 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')
>      else:
> -        assert False                # not implemented
> +        raise NotImplementedError(

This is an improvement, but doesn't fall into the *readability* bucket.
IMO it's worth splitting it out.

- Cleber.

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+mNqkACgkQZX6NM6Xy
CfPL3g/+PMHzqIB2IJ3zjVv2reOpiC4aa3pzmRFO9ZoK7jdbhCu9blKljxeFMT/F
AvEgczzlPb0/5mYANXYPnnYTCcSInZkD5vM1A6tLj0gsVup6Y9bf6AFU4wApT5xI
Jdd0Tb8ep1kVIs71d3eIPCfwUE7XJfIXbBKciAMO374HOcCB1XIyqtETaGlUJwqo
/1AxQfxLJjPg5mGTPdz+XQIBZ6FDAmrbkjmbUV6ESGIqRRmdMbiXgktqDiSlDFDv
P/iWon964XBkYA+BpmWQ7tib2UO6OiVZLp/a/353ja4Zcv4XncayH0LCemmMKePn
Z7ZrEfZZY1knWgzYMrVdtHV4KTujuQKZzSQ5iPqYZLPLjaVFCn5kx5AoWzcb+gpK
85SvZvdb+N9YcmDDIoyBjG7857IMa26Pn6TvznPclLRa2x2+ylNDn86CpCTXR2mW
Z2ebL93GFiJuhxa//stS8hPCsoMEiXPv8GZ5/LH4fu5OswPaD51KPf26sxf0vudo
eLkDbofW/8KsAo07WUphuKvCcjqhJGTAwMnDylv+OPdj9+AKDeD03ydkcjSoN7/D
MnpUGwV5ozaV4MVKS3qJphoP7cRynphN/0LdFRZn/nT2dHVFxzaCOzSWGP01HDg9
Fwe1qcF9cSz+jLUl6VRBTQ/KCklbhDpzRsjH7HsSok1YA3D3Px4=
=Wq+l
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--


