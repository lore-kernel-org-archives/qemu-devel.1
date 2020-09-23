Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F36C47423
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEB0206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHcoqRsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEB0206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7Jp-0000uy-6i
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL7D5-0001uZ-MP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL7D0-00040A-1R
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600876887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vu5g24Rh6j74cjW6bv9MqZB0FTdfMAWjwy5CAcIXf8c=;
 b=VHcoqRsZsccQd0lpBS0M9lf3/8mlE23KGomYAPz94nteXW0j1PWzZO3N8U7BNCJtXty9Ow
 6dJWW3U6yy1Gc9K8umC2496OJk/e2okxdUjY3yNaDOUQ01PDkgbtfnKBb6EJ4RnHlWhC0d
 6tff1+sYUEFGhr77z27x+N3doqJVtbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-RTGXK5-MOJ-EIJEL9fAodQ-1; Wed, 23 Sep 2020 12:01:22 -0400
X-MC-Unique: RTGXK5-MOJ-EIJEL9fAodQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC96801ABF;
 Wed, 23 Sep 2020 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC9B7702E7;
 Wed, 23 Sep 2020 16:01:20 +0000 (UTC)
Date: Wed, 23 Sep 2020 12:01:19 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 10/38] qapi/common.py: delint with pylint
Message-ID: <20200923160119.GJ191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-11-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-11-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="apbmkPN6Hu/1dI3g"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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

--apbmkPN6Hu/1dI3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:33PM -0400, John Snow wrote:
> At this point, that just means using a consistent strategy for constant n=
ames.
> constants get UPPER_CASE and names not used externally get a leading unde=
rscore.
>=20
> As a preference, while renaming constants to be UPPERCASE, move them to
> the head of the file. Generally, it's nice to be able to audit the code
> that runs on import in one central place.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/common.py | 18 ++++++++----------
>  scripts/qapi/schema.py | 14 +++++++-------
>  2 files changed, 15 insertions(+), 17 deletions(-)
>=20
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index e0c5871b10..bddfb5a9e5 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -14,6 +14,11 @@
>  import re
> =20
> =20
> +EATSPACE =3D '\033EATSPACE.'
> +POINTER_SUFFIX =3D ' *' + EATSPACE
> +_C_NAME_TRANS =3D str.maketrans('.-', '__')

IMO _C_NAME_TRANS is solely the concern of the c_name() function, and
should not be a global.  If you're concerned with speed (which I don't
think you should) you could still do:

   def c_name(name, protect=3DTrue,
              name_translation=3Dstr.maketrans('.-', '__')):
      ...
      name =3D name.translate(name_translation)

Keeping in mind that you're adding a mutable type to a function
argument *on purpose*.  I'd really favor having that statement within
the only function that uses it, though.

- Cleber.

--apbmkPN6Hu/1dI3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rcUwACgkQZX6NM6Xy
CfMV/BAAoX0+YQTz/oUAA7JKVyxl4edlZAvA/N6aVvINRZ33rSqK0WUtw6j4Lkd7
Fv2Rn0LUbq0TwztD3x9Ykc2FrSNZjpK1Fc0SpBMgsV3uhSg6gnHm38qbLumex/sx
uLHS8skLXkmXN8arWmywnEW2i/CWS8WMdduuMVC5UtUA2RvxRL8PnXQk3g2lZBLv
i6iNG8FqBJgd9Oyu7QkgBRUKXBkkt3US9uj8fT51tIL8cPvDjmP1sWeh3+78aGso
sQwXyRALB1k54EgPrhykDsj1/0PaY7/VLbIZ4AsReO8VoNwoJcK+blrvMme+LtjG
8tU7QbcHajwvQiFVqxiDwTK121jwYODCJiifSNKEeioIXQmoVMruQkETN/C9CAye
yYwg9eYJn668V/DH18FgOiM1XRhRjTmF/CVY/Ko/4hFScsEhm0WQvrS4i6LqtLv3
Kf1VIWTlBjf/LS2NMXswmlvjy+ZHGRKLWH1c9aWoIfvisKXRFiQuhjUTqiXk/VmZ
9jWupUQjJGJuVpiX9YqJ61bW0jWk2XxI8XChRD+VkG5xjL1t/yz/DyIeB7hvz+yu
/Y0w0iG+SthXfyVF+r0xv2S6gIZftHIoTGuelX/EtzSa4fqBTCsnbSg3HhUXq2Sw
BouOLReryxcYX11EvKx9pH9dYzMDwwbzrZLO52mt4o2LxosyOZQ=
=IY6z
-----END PGP SIGNATURE-----

--apbmkPN6Hu/1dI3g--


