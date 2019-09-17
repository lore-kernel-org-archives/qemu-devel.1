Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D8EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2931C20665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2931C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGUh-00074k-At
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAGQR-0002qj-Oi
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAGQP-000163-Iv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:33:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAGQO-00015R-57
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:33:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7BBBE3082B1F;
 Tue, 17 Sep 2019 16:33:55 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCC5F60852;
 Tue, 17 Sep 2019 16:33:54 +0000 (UTC)
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
References: <cover.1568735079.git.pkrempa@redhat.com>
 <249a9ca557108397b313625593bc83f161f32a16.1568735079.git.pkrempa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <8eae6ac1-bbc1-63ba-14b2-779ed3f42a29@redhat.com>
Date: Tue, 17 Sep 2019 11:33:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <249a9ca557108397b313625593bc83f161f32a16.1568735079.git.pkrempa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u8bHxKdo8blA4LTDoQuG0F263UghsTdaK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 17 Sep 2019 16:33:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: Allow introspecting fix for
 savevm's cooperation with blockdev
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u8bHxKdo8blA4LTDoQuG0F263UghsTdaK
Content-Type: multipart/mixed; boundary="RtVaAf2nDUQogmsobrsPxGueNaxnIAt8a";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <8eae6ac1-bbc1-63ba-14b2-779ed3f42a29@redhat.com>
Subject: Re: [PATCH 2/2] qapi: Allow introspecting fix for savevm's
 cooperation with blockdev
References: <cover.1568735079.git.pkrempa@redhat.com>
 <249a9ca557108397b313625593bc83f161f32a16.1568735079.git.pkrempa@redhat.com>
In-Reply-To: <249a9ca557108397b313625593bc83f161f32a16.1568735079.git.pkrempa@redhat.com>

--RtVaAf2nDUQogmsobrsPxGueNaxnIAt8a
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/17/19 10:49 AM, Peter Krempa wrote:
> savevm was buggy as it considered all monitor owned block device nodes
> for snapshot. With introduction of -blockdev the common usage made all
> nodes including protocol nodes monitor owned and thus considered for
> snapshot. This was fixed but clients need to be able to detect whether
> this fix is present.
>=20
> Since savevm does not have an QMP alternative add the feature for the
> 'human-monitor-command' backdoor which is used to call this command in
> modern use.
>=20
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  qapi/misc.json | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 6bd11f50e6..e2b33c3f8a 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1020,6 +1020,11 @@
>  #
>  # @cpu-index: The CPU to use for commands that require an implicit CPU=

>  #
> +# Features:
> +# @savevm-blockdev-monitor-nodes: If present, the savevm monitor comma=
nd
> +#                                 correctly handles monitor owned bloc=
k nodes
> +#                                 when taking a snapshot.

Is it worth adding a '(since 4.2)' on when features are added?

> +#
>  # Returns: the output of the command as a string
>  #
>  # Since: 0.14.0
> @@ -1047,7 +1052,8 @@
>  ##
>  { 'command': 'human-monitor-command',
>    'data': {'command-line': 'str', '*cpu-index': 'int'},
> -  'returns': 'str' }
> +  'returns': 'str',
> +  'features' : [ { 'name': 'savevm-blockdev-monitor-nodes' } ] }

We could, of course, actually implement a QMP 'savevm' and use _that_ as
the introspection.  But that's a bigger can of worms, so this is
reasonable enough for the 4.2 timeframe.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--RtVaAf2nDUQogmsobrsPxGueNaxnIAt8a--

--u8bHxKdo8blA4LTDoQuG0F263UghsTdaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2BCvIACgkQp6FrSiUn
Q2qXjgf+NXdcvMI+/duZYxXKyu0JVKkE/xaVAruNX4iMf0KPpXRY6uq1vpckD3l1
sUXO9HfLO5CzxP3pySIVGoJmMmbokAqKmam9/K1pk2Ac98hB6ArhV4xrXQutFEJ+
j1CMhAf/Qq8Bv+FfCRG2rCp6vIneYzEZe9P18SR3eChfStzU4GNFJ/yq3rEbr4la
I912nkZMLod6iKfiI9cprpdZhKN2RWdVaWwsShvaSP3mp2UTWgkZN6wrOLQI4klX
70GSzVaiHolv0Vt0JGZ97kXnN+69onTwXDq46h0QKMu3wyjhpn7/1+GK+ExUXS+e
pLC1XGBH5TuKdWG/5uwijzc2Yo7Dbw==
=r9Sb
-----END PGP SIGNATURE-----

--u8bHxKdo8blA4LTDoQuG0F263UghsTdaK--

