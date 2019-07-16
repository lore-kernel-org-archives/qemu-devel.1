Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE11DC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A588620693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A588620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPWY-0005mT-TO
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnPWL-0005HR-CN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnPWK-000245-6R
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34681)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnPWH-00022M-N6; Tue, 16 Jul 2019 11:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E82B330C1321;
 Tue, 16 Jul 2019 15:37:32 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 440876013C;
 Tue, 16 Jul 2019 15:37:29 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-4-thuth@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <9393fcfe-14be-b49f-33e1-7cbfce3b5504@redhat.com>
Date: Tue, 16 Jul 2019 17:37:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716122836.31187-4-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kKv36XOPnRco6UaA8G8Po1M21e2Sm694U"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 16 Jul 2019 15:37:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/4] tests: Run the iotests during "make
 check" again
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kKv36XOPnRco6UaA8G8Po1M21e2Sm694U
Content-Type: multipart/mixed; boundary="Ra79HDGZDHTu8lmmeH4sbHYSmJ9soHpP0";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <9393fcfe-14be-b49f-33e1-7cbfce3b5504@redhat.com>
Subject: Re: [PATCH v2 3/4] tests: Run the iotests during "make check" again
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-4-thuth@redhat.com>
In-Reply-To: <20190716122836.31187-4-thuth@redhat.com>

--Ra79HDGZDHTu8lmmeH4sbHYSmJ9soHpP0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 14:28, Thomas Huth wrote:
> People often forget to run the iotests before submitting patches or pul=
l
> requests - this is likely due to the fact that we do not run the tests
> during our mandatory "make check" tests yet. Now that we've got a prope=
r
> "auto" group of iotests that should be fine to run in every environment=
,
> we can enable the iotests during "make check" again by running the "aut=
o"
> tests by default from the check-block.sh script.
>=20
> Some cases still need to be checked first, though: iotests need bash an=
d
> GNU sed (otherwise they fail), and if gprof is enabled, it spoils the
> output of some test cases causing them to fail. So if we detect that on=
e
> of the required programs is missing or that gprof is enabled, we still
> have to skip the iotests to avoid failures.
>=20
> And finally, since we are using check-block.sh now again, this patch al=
so
> removes the qemu-iotests-quick.sh script since we do not need that anym=
ore
> (and having two shell wrapper scripts around the block tests seems rath=
er
> confusing than helpful).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> [AJB: -makecheck to check-block.sh, move check-block to start and gate =
it]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include      |  8 +++----
>  tests/check-block.sh        | 44 ++++++++++++++++++++++++++++---------=

>  tests/qemu-iotests-quick.sh |  8 -------
>  3 files changed, 38 insertions(+), 22 deletions(-)
>  delete mode 100755 tests/qemu-iotests-quick.sh
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fd7fdb8658..e868dc1b9c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include

[...]

> @@ -1092,8 +1092,8 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
> =20
>  QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D=
 tests/qemu-iotests/socket_scm_helper$(EXESUF)
> =20
> -.PHONY: check-tests/qemu-iotests-quick.sh
> -check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-im=
g$(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
> +.PHONY: check-tests/check-block.sh
> +check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) qem=
u-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)

Does this need to depend on a full qemu binary, too?

Max

>  	$<
> =20
>  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))


--Ra79HDGZDHTu8lmmeH4sbHYSmJ9soHpP0--

--kKv36XOPnRco6UaA8G8Po1M21e2Sm694U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0t7zgACgkQ9AfbAGHV
z0D0swf/WRl8JyXSOIRdc58duM16xGQsdUdlKieojPh25Uss867DLd8u377+ryMr
l5OWRRsq+OjKVNy6p+8D74/NXfffL3mj3sFT5hoVKI1jgfORYepyyrG/L3plYA0S
54AMjgUUGHxju+BLcryKccglNzp60og7UaAAb17nWJuMmxEdOfmAt3kL59kA7ALj
sbyhx2EDjJwohnq5Xmh36F7vLRXp3b7apxZ2bBvwTMb6BS/o+KjL9eJ5WPIO4tGZ
zDoI8UPJ7+bfIOzNpzqLwPjGSLUAwH/9+ZuLXG8qi17MoT0RDR2yjBs7cPZg6jIG
I3sBtC6LWiKtGKZB0nPAQvSdZUWxOQ==
=30JL
-----END PGP SIGNATURE-----

--kKv36XOPnRco6UaA8G8Po1M21e2Sm694U--

