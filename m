Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEE2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 21:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C14207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 21:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMXAKCSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C14207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxd02-0005bG-56
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 17:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jxczK-0004lL-6t
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 17:06:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jxczH-0000nC-Em
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 17:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595279173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sTFUQujf1F06RHPsaLmzWXEoIT991385C+g7wt84aTI=;
 b=PMXAKCSZ5CC7f6fStXEkfELSw27tfNKZV/ueDmSnXpkC+rL3BSYCxFGX2/d7bvFpa8wMAk
 HhbW6W3vwG53FjbuZ5lUE1/Oq308nF2+nSM9s4s3UM9sBe8E5ojK3yNCrip136IUUZfDiC
 0h2jEcqpGdr7xmH4UIyAN6Ked843T2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-E0wVzKyCO6yrQWMmyFaN-w-1; Mon, 20 Jul 2020 17:06:08 -0400
X-MC-Unique: E0wVzKyCO6yrQWMmyFaN-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9424801A03;
 Mon, 20 Jul 2020 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A1883C67;
 Mon, 20 Jul 2020 21:06:07 +0000 (UTC)
Date: Mon, 20 Jul 2020 17:06:05 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add Python library stanza
Message-ID: <20200720210605.GA4027709@localhost.localdomain>
References: <20200710215718.13034-1-jsnow@redhat.com>
 <20200710215718.13034-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710215718.13034-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 17:06:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 05:57:18PM -0400, John Snow wrote:
> I'm proposing that I split the actual Python library off from the other
> miscellaneous python scripts we have and declare it maintained. Add
> myself as a maintainer of this folder, along with Cleber.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  MAINTAINERS | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6aa54f7f8f..fe1dcd5a76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2280,11 +2280,18 @@ S: Maintained
>  F: include/sysemu/cryptodev*.h
>  F: backends/cryptodev*.c
> =20
> +Python library
> +M: John Snow <jsnow@redhat.com>
> +M: Cleber Rosa <crosa@redhat.com>
> +R: Eduardo Habkost <ehabkost@redhat.com>
> +S: Maintained
> +F: python/*
> +T: git https://gitlab.com/jsnow/qemu.git python
> +

Thanks for this, and for that will come next! :)

Ack-by: Cleber Rosa <crosa@redhat.com>

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8WBzoACgkQZX6NM6Xy
CfPWxxAAjHnB4pfeUEunM/DW1OXmTkUdn0ZZylUXKfzJhFnC68j/ONcoNEuHrSOG
qiqis/wCAPuvD29SNHSZictxYjeTszTUhge6csiWAXCOzoyDqbnWFS52nmvR7oMH
eMJO5z18xo5dGbgjYSim1sTVAi6BMDqjhH4Y7GLqPk9cV5+unvtxN12RJxa/4RLg
cHSYqw8XBB4xJuOX0/QP8nbMip3id35zn0eSqjmjZuSfTFF4OlVhdXo/80WhLV5w
ROAmzwdFmhWja7DlF+T8b5l8ZObYhKcte7ovvJ0HCD3roji/wo6A8iCyLtc+bF7x
gyYFtTqKxSnm6CrTfo0LCPiPJAOBAnUjEYoyCGVtFCsMS0/nVv1ABEa9Yi77cfzt
L4B0m2FfPcyLESLYaYCIu07QUsIHmOXDr+II//PZvajDVvyzmPa6YCit5V+H3ypj
OhuK3H2ODpm+udSWf86XrWQ2opboBTb1wIlEBcp2YhCpWFhGuFsCm/W/fVPE6glY
KGsanUv/rzegsUUZmi1T3PKP5G1kXFUH9oX8iEiUt7OnOHy2qCTnhULjkfc221pQ
VuV3w/4UAFedgRhIqZw09pd+ow5dKmzGKNByXrg5j7J0eOuUjEB2YgdmRFjH5ozx
sudxFUgjHmO3I/P8MLN2iepmjk+2up4IT3krZKBfGAkcrBuoBjI=
=wDog
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


