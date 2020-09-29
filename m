Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67917C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8E720BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enAetAAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8E720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6gw-0006Q2-0t
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 23:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN6g4-0005xv-Un
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN6g3-0004e6-9A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:51:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601351479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cCLZnAnyKwQhGNh38cNUeL1wvY/2adqHXCLu5/2z8w=;
 b=enAetAAaRkESXXbUpWUrw25ILK65eSu8hCO7rtv0n5cawi1IPqty+iWmsiU7Y4Jr3PpEuh
 SjgXsH+2oibom7dOWcN2VMH5HUtcAOhw7LC+XJcyAGZh67WN0cvkqp0aBJN29GuArmvtZ+
 b5dm5W5XQKco0pT4Eybj17W74t5DjuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-wonvidWCNoyNMScTVzX4nQ-1; Mon, 28 Sep 2020 23:51:16 -0400
X-MC-Unique: wonvidWCNoyNMScTVzX4nQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E9C802B46
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:51:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09FA410013D0;
 Tue, 29 Sep 2020 03:51:14 +0000 (UTC)
Date: Mon, 28 Sep 2020 23:51:13 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 05/47] qapi/doc.py: Change code templates from
 function to string
Message-ID: <20200929035113.GF700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-6-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-6-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:18PM -0400, John Snow wrote:
> For whatever reason, when these are stored as functions instead of
> strings, it confuses sphinx-autodoc into believing them to be
> docstrings, and it chokes on the syntax.
>

Interesting...

> Keeping them as dumb strings instead avoids the problem.
>

I actually think it's a more honest approach, and easier to read.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/doc.py | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> index c41e9d29f5..d12eda9e1e 100644
> --- a/scripts/qapi/doc.py
> +++ b/scripts/qapi/doc.py
> @@ -8,26 +8,26 @@
>  from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
> =20
> =20
> -MSG_FMT =3D """
> +_MSG =3D '''
>  @deftypefn {type} {{}} {name}
> =20
>  {body}{members}{features}{sections}
>  @end deftypefn
> =20
> -""".format
> +'''
>

I know it doesn't make syntactic difference, but is there a reson for
also changing the quote style?

- Cleber.

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9yry4ACgkQZX6NM6Xy
CfOiAQ//S3ggsJ7iPalr3w7FlYh4tCgMjaO8EmisrehDDTYrnj9rm2zY2msJkTvy
xK9bzMMbuO2BdBsudsvwUdCIh7LhT7dr6KkMvtaQELu3nBonwb6tulw1bYmuL5HV
SzmkRYIHPUKQdFoY5yp8kMzNT3gt9w7k+YwF9skBR5/YjwOEAK77GiaxbOdNXDAO
DWNKU1n3qEgCz5tsw7pk1QNpgsCww+M2GHemWSk6WqDDZZLYx8bmGaxNrkiS2HmD
vDSqwPTFN0w4XBG0eSMoqxS3LHU7xg9XZZiJyINBTWxl5jODrUEKQW3T53Pgv1ww
Rh7zn5V/Zf7x5MIIb/6SWPcoKotonkebIS8IOEojkiJ717JfMIjMX/CM2D3zbHJX
h7f2L6DgfgUIxd2KKKHer2llorsLiZWhuEWDO7JNRMBlSjsVUvm0h1WknAXhJH9S
07IfEi1SYTFA/A335TBYI1Uhc8SjnwS2Ueh0yxGWHy0tO8y5w5/8y5xQpEqIhvE7
IBvhvWrvlXYAqFRXOS6embvI075PPX1DaFeF/gq0f40iyFYYX1Na2xl1x02rhtv6
O4ZokTLrWG4RK4muQzrWnkOzPBNuTP8TAVKmbaNuFfzr9qxq5605lnVW9OAQ+F3v
pBhn9YGCncrKgO6MB10b3k4aX9GTd4cL60QWrDmxvPTUu/PPN5k=
=Q5e8
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--


