Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F9C388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 19:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A4320882
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 19:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coK1HcUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A4320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6yg-0007MD-PY
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 14:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kb6xh-0006cU-QF
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:59:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kb6xf-0000ta-90
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604689184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/vCqJHxlcJObO4yyVw3nunOnPHVHStUEmt47s8sGQU=;
 b=coK1HcUQ1ijX7xFta7uJxI5HfKj7G3W9gyDrdboavsTZHPG5yzu7KgtqndWEldtrs4l2gl
 7f60tAZ0e8tNsen+f56WWqSbIHEf4fPAP+Y9PGmqYwA41knAb7DV5oxXq3D/7vhZbMc6Q3
 NAwmz7OHj7osLKcelqbTsGJrY9TONSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-t1JqVgExMsmaCyIGU1yjaw-1; Fri, 06 Nov 2020 13:59:42 -0500
X-MC-Unique: t1JqVgExMsmaCyIGU1yjaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78BA41009E35
 for <qemu-devel@nongnu.org>; Fri,  6 Nov 2020 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-213.rdu2.redhat.com
 [10.10.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2E215C5DE;
 Fri,  6 Nov 2020 18:59:40 +0000 (UTC)
Date: Fri, 6 Nov 2020 13:59:27 -0500
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 04/11] qapi/introspect.py: add assertions and casts
Message-ID: <20201106185927.GA91536@localhost.localdomain>
References: <20201026194251.11075-1-jsnow@redhat.com>
 <20201026194251.11075-5-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-5-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
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

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 03:42:44PM -0400, John Snow wrote:
> This is necessary to keep mypy passing in the next patch when we add
> preliminary type hints. It will be removed shortly.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+lnQsACgkQZX6NM6Xy
CfNIPQ//bavlsDvnCxYZjEv4ynZzXGmNFUMz7PjteQd2piAD2zkJoE0sGcLatAJu
DdxPSH86Ak0iHqGiAzaAwPNk5fhyvJpl/5/ef72JPxlnbFWpGycaS4dZn8Miauqy
mnz619R9NO1vl8LSGoXsEgMyjOqRvkBR6ll0rXX6Uixi4w2xqAmMVr5wd9cZs6wR
uIPpL8JZ0EQLsF/Q5H87gD4zdMXCSIRjnJVTm3PPeUaVhjE/GX/0FzbdFlr5w/RZ
BQxUc+TFWNg1iDMb0yQT8BFqfniwShklCcHcn5S2xvuXhVQXJxRigf5tZI0pasMQ
r+zV7JN3+1DU1V4vKyxdTyPIX0/lfhItCWYWd3swovdrOIAFEcQtOFU+9E3iT0jD
Pb3ZauMfoGzajeequxAmermWrHz82tJqxiqKp1Q6UgbWMl7/nwvoaW/5InHpGZ8P
l0wJsu9oyChNW7jbdKSmFYeUObL/PQdS5KuSEPUZJ1M/3ZYx4lOaru0FveTcr23x
oYMuyvm1s5Al+THjCUhrnDsDyQbLbNAqZbzgl9DU1so21vowKzlwKy06l56ThWy2
Cx7czWMeCYag0+rgeqe5AIKiRT+mUkyOK/ATeoj+LcawnLD9XjeZJ1/ikl3UpzU7
DgrMnS8yiq011WCd+9d0lGULhvSTTSYagWfJalP/v+AbvfVTNZg=
=G/r+
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--


