Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCC4C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F9820B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZr2G8bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F9820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrxN-00086e-Pf
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKrwS-00077n-41
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 19:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKrwP-0007Id-Ag
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 19:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600818199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1x4S4kpDMAmIo+xoNk6xLZUR3RC3l5UmCv4DfT31Vpc=;
 b=gZr2G8bNXvjwHrLvpdf5WKFhhlPJTlKSxAfDaqHIFNX2vT4Ks14vC6B8VcVWPpNM3aZTU9
 Uy5bBFoUI3WAVoF9WQmcDkT+8aDEjPF35fPWEo+b8z2x30gHH4u3Z6wqFO/pTQsvaihYo2
 31LAFjjkZeKWa5V0FD3Cbedu5IDInxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-iYSMxsb4OPGkDlo7XMjXuw-1; Tue, 22 Sep 2020 19:43:17 -0400
X-MC-Unique: iYSMxsb4OPGkDlo7XMjXuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F3651882FA7;
 Tue, 22 Sep 2020 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAE4755760;
 Tue, 22 Sep 2020 23:43:14 +0000 (UTC)
Date: Tue, 22 Sep 2020 19:43:13 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 01/38] [DO-NOT-MERGE] qapi: add debugging tools
Message-ID: <20200922234313.GA191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:24PM -0400, John Snow wrote:
> This adds some really childishly simple debugging tools. Maybe they're
> interesting for someone else, too?
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/debug.py | 78 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 scripts/qapi/debug.py
>=20
> diff --git a/scripts/qapi/debug.py b/scripts/qapi/debug.py
> new file mode 100644
> index 0000000000..bacf5ee180
> --- /dev/null
> +++ b/scripts/qapi/debug.py
> @@ -0,0 +1,78 @@
> +"""
> +Small debugging facilities for mypy static analysis work.
> +(C) 2020 John Snow, for Red Hat, Inc.
> +"""
> +
> +import inspect
> +import json
> +from typing import Dict, List, Any
> +from types import FrameType
> +
> +
> +OBSERVED_TYPES: Dict[str, List[str]] =3D {}
> +
> +
> +# You have no idea how long it took to find this return type...
> +def caller_frame() -> FrameType:
> +    """
> +    Returns the stack frame of the caller's caller.
> +    e.g. foo() -> caller() -> caller_frame() return's foo's stack frame.
> +    """
> +    stack =3D inspect.stack()
> +    caller =3D stack[2].frame
> +    if caller is None:
> +        msg =3D "Python interpreter does not support stack frame inspect=
ion"
> +        raise RuntimeError(msg)
> +    return caller
> +
> +
> +def _add_type_record(name: str, typestr: str) -> None:
> +    seen =3D OBSERVED_TYPES.setdefault(name, [])
> +    if typestr not in seen:
> +        seen.append(typestr)
> +
> +
> +def record_type(name: str, value: Any, dict_names: bool =3D False) -> No=
ne:
> +    """
> +    Record the type of a variable.
> +
> +    :param name: The name of the variable
> +    :param value: The value of the variable
> +    """
> +    _add_type_record(name, str(type(value)))
> +
> +    try:
> +        for key, subvalue in value.items():
> +            subname =3D f"{name}.{key}" if dict_names else f"{name}.[dic=
t_value]"
> +            _add_type_record(subname, str(type(subvalue)))
> +        return
> +    except AttributeError:
> +        # (Wasn't a dict or anything resembling one.)
> +        pass
> +
> +    # str is iterable, but not in the way we want!
> +    if isinstance(value, str):
> +        return
> +
> +    try:
> +        for elem in value:
> +            _add_type_record(f"{name}.[list_elem]", str(type(elem)))
> +    except TypeError:
> +        # (Wasn't a list or anything else iterable.)
> +        pass
> +
> +
> +def show_types() -> None:
> +    """
> +    Print all of the currently known variable types to stdout.
> +    """
> +    print(json.dumps(OBSERVED_TYPES, indent=3D2))
> +

Maybe the following will be cheaper (no json conversion):

   pprint.pprint(OBSERVED_TYPES, indent=3D2)

Other than that, I'd vote for including this if there's a bit more
documentation on how to use it, or an example script.  Maybe there
already is, and I did not get to it yet.

- Cleber.

> +
> +def record_locals(show: bool =3D False, dict_names: bool =3D False) -> N=
one:
> +    caller =3D caller_frame()
> +    name =3D caller.f_code.co_name
> +    for key, value in caller.f_locals.items():
> +        record_type(f"{name}.{key}", value, dict_names=3Ddict_names)
> +    if show:
> +        show_types()
> --=20
> 2.26.2
>=20

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9qjA0ACgkQZX6NM6Xy
CfNPpBAAipkqjuW6KnyPXiOmymMwQBUdimNw98yj7GRlKXgzg29ZlrQ0zalTRARi
N2ZGUuiV1OmwTYsjxHH7HMdr0loJ3YQaloWcSY6GOxEzTji4tDRhSFH+SZ9TMviT
rBilXZfhJA+q5YPXBsWQfe4FlmcpmakXvteI/QwtSTeCCDtW3I5RvHUH2vYL+MpD
OsxGghnRjtXRi6Tha/G3gXyjVNL+HX1QA2GeyKHfH/F8NsnblJbl6C0tFQ+lzBy7
ewOJ1iycXwcCKWY4yxLK8ykdt5Icdxpv704biXVU1XUkuTnhwNEsq7nfxjMUkg7u
vzX1Lokmug2LMOQG/ArQV77YdZRXzyXevkNVxLZhp/2MdSB4M1jvaX0TYZBDLn6g
LbYPvp5J4aekjw0UBxkIilxkCf7hce/GscEfo+keTKhs5pll/T6fczA7gPq9jccW
YkYaIrxLAPfKUBGgDvuHt20s0Ta//hl9l9xO2th2rAd62jCS9uuNkc6bAXczUEGz
V/BFAUcPMRfzT+DDcBcbIx1xg9F6BrciPXfX27MhrLMH79/Dl/G/OWkXf9v+0Vfk
jVOWzaUs1PVkwrMNfVIh0hNboQaycQvYVlay3MGMgMu9kzcW9cvDfq3L11c+3g23
dLKoWa1w5a3DsrcgyLVKk0ueRZk6hPaHonF7EXrO7e+jov6bO8Q=
=GuDQ
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


