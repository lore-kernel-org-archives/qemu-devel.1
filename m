Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC20EC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 18:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A5922D6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 18:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A5922D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i08sC-0006Vw-JB
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 14:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i08rR-0005ee-1e
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 14:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i08rP-0000i7-49
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 14:28:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i08rL-0000ca-CE; Tue, 20 Aug 2019 14:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B2E4C0035C2;
 Tue, 20 Aug 2019 18:27:54 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A73A5C21F;
 Tue, 20 Aug 2019 18:27:49 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-8-mlevitsk@redhat.com>
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
Message-ID: <12c342c8-6ac8-3533-7a7b-e61826e9abb0@redhat.com>
Date: Tue, 20 Aug 2019 20:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814202219.1870-8-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i5WvR3RGj9lgmr8JbsnYohiizEkgJ2HQ4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 20 Aug 2019 18:27:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/13] block: add manage-encryption command
 (qmp and blockdev)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i5WvR3RGj9lgmr8JbsnYohiizEkgJ2HQ4
Content-Type: multipart/mixed; boundary="Exr5HmmcXqvgTfBzF7WNuN2lCmGE13reg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>
Message-ID: <12c342c8-6ac8-3533-7a7b-e61826e9abb0@redhat.com>
Subject: Re: [PATCH 07/13] block: add manage-encryption command (qmp and
 blockdev)
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-8-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-8-mlevitsk@redhat.com>

--Exr5HmmcXqvgTfBzF7WNuN2lCmGE13reg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.08.19 22:22, Maxim Levitsky wrote:
> This adds:
>=20
> * x-blockdev-update-encryption and x-blockdev-erase-encryption qmp comm=
ands
>   Both commands take the QCryptoKeyManageOptions
>   the x-blockdev-update-encryption is meant for non destructive additio=
n
>   of key slots / whatever the encryption driver supports in the future
>=20
>   x-blockdev-erase-encryption is meant for destructive encryption key e=
rase,
>   in some cases even without way to recover the data.
>=20
>=20
> * bdrv_setup_encryption callback in the block driver
>   This callback does both the above functions with 'action' parameter
>=20
> * QCryptoKeyManageOptions with set of options that drivers can use for =
encryption managment
>   Currently it has all the options that LUKS needs, and later it can be=
 extended
>   (via union) to support more encryption drivers if needed
>=20
> * blk_setup_encryption / bdrv_setup_encryption - the usual block layer =
wrappers.
>   Note that bdrv_setup_encryption takes BlockDriverState and not BdrvCh=
ild,
>   for the ease of use from the qmp code. It is not expected that this f=
unction
>   will be used by anything but qmp and qemu-img code
>=20
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/block-backend.c          |  9 ++++++++
>  block/io.c                     | 24 ++++++++++++++++++++
>  blockdev.c                     | 40 ++++++++++++++++++++++++++++++++++=

>  include/block/block.h          | 12 ++++++++++
>  include/block/block_int.h      | 11 ++++++++++
>  include/sysemu/block-backend.h |  7 ++++++
>  qapi/block-core.json           | 36 ++++++++++++++++++++++++++++++
>  qapi/crypto.json               | 26 ++++++++++++++++++++++
>  8 files changed, 165 insertions(+)

Now I don=E2=80=99t know whether you want to keep this interface at all, =
because
the cover letter seemed to imply you=E2=80=99d prefer a QMP amend.  But l=
et it
be said that a QMP amend is no trivial task.  I think the most difficult
bit is that the qcow2 implementation currently is inherently an offline
operation.  It isn=E2=80=99t a good idea to use it on a live image.  (May=
be it
works, but it=E2=80=99s definitely not what I had in mind when I wrote it=
=2E)

So I=E2=80=99ll still take a quick glance at the interface here.

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..53ed411eed 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5327,3 +5327,39 @@
>    'data' : { 'node-name': 'str',
>               'iothread': 'StrOrNull',
>               '*force': 'bool' } }
> +
> +
> +##
> +# @x-blockdev-update-encryption:
> +#
> +# Update the encryption keys for an encrypted block device
> +#
> +# @node-name: 	  Name of the blockdev to operate on
> +# @force:         Disable safety checks (use with care)
> +# @options:       Driver specific options
> +#
> +
> +# Since: 4.2
> +##
> +{ 'command': 'x-blockdev-update-encryption',
> +  'data': { 'node-name' : 'str',
> +            '*force' : 'bool',
> +            'options': 'QCryptoEncryptionSetupOptions' } }
> +
> +##
> +# @x-blockdev-erase-encryption:
> +#
> +# Erase the encryption keys for an encrypted block device
> +#
> +# @node-name: 	  Name of the blockdev to operate on

Why the tab?

> +# @force:         Disable safety checks (use with care)

I think being a bit more verbose wouldn=E2=80=99t hurt.

(Same above.)

> +# @options:       Driver specific options
> +#
> +# Returns: @QCryptoKeyManageResult
> +#
> +# Since: 4.2
> +##
> +{ 'command': 'x-blockdev-erase-encryption',
> +  'data': { 'node-name' : 'str',
> +            '*force' : 'bool',
> +            'options': 'QCryptoEncryptionSetupOptions' } }
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index b2a4cff683..69e8b086db 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -309,3 +309,29 @@
>    'base': 'QCryptoBlockInfoBase',
>    'discriminator': 'format',
>    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> +
> +
> +##
> +# @QCryptoEncryptionSetupOptions:
> +#
> +# Driver specific options for encryption key management.

The options do seem LUKS-specific, but the name of this structure does no=
t.

> +# @key-secret: the ID of a QCryptoSecret object providing the password=

> +#              to add or to erase (optional for erase)
> +#
> +# @old-key-secret: the ID of a QCryptoSecret object providing the pass=
word
> +#                  that can currently unlock the image
> +#
> +# @slot: Key slot to update/erase
> +#        (optional, for update will select a free slot,
> +#        for erase will erase all slots that match the password)
> +#
> +# @iter-time: number of milliseconds to spend in
> +#             PBKDF passphrase processing. Currently defaults to 2000
> +# Since: 4.2
> +##

Does it really make sense to use the same structure for erasing and
updating?  I think there are ways to represent @key-secret vs. @slot
being alternatives to each other for erase; @iter-time doesn=E2=80=99t se=
em to
make sense for erase; and @slot doesn=E2=80=99t seem to make sense for up=
date.
Also, I don=E2=80=99t know whether to use @key-secret or @old-key-secret =
for erase.

All in all, it seems more sensible to me to have separate structs for
updating and erasing.

Max

> +{ 'struct': 'QCryptoEncryptionSetupOptions',
> +  'data': { '*key-secret': 'str',
> +            '*old-key-secret': 'str',
> +            '*slot': 'int',
> +            '*iter-time': 'int' } }
>=20



--Exr5HmmcXqvgTfBzF7WNuN2lCmGE13reg--

--i5WvR3RGj9lgmr8JbsnYohiizEkgJ2HQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1cO6QACgkQ9AfbAGHV
z0C/bQgAtOzxiyDF4S8+HXySdADAhf7OdBxeC/GKg9UwY05Sj7yasDDkqG2YOevr
mKBxYTnhxMEZLiftIMDswYLNY+5T3DGAh1nTnBQ1wpk3Ilch00kVTQBQvmeRMGyc
OoW/ULjrS7gjtlrmS/HkZD8lco3zeRYGCGLedz93nxDfewONXOz1P1SfTi29a25K
uy45I3qvSxohvQt8DgG1wnJmvgmh3mzycxyNJ0TBrsFwLdZzAUPxyW4kphOVy+hc
+aXVNAVmT0x3Q4wmcRqiBgQ62TD6ZjtvwRhofUzT1+TC069osvc/C4M3lD1zKw8S
9eqKaJN4/ztef6Uam6VRDCPdpGT4xw==
=YzBj
-----END PGP SIGNATURE-----

--i5WvR3RGj9lgmr8JbsnYohiizEkgJ2HQ4--

