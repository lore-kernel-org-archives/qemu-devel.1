Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107D7C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15E92084D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1qElfIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15E92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60295 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNXk-0008QN-D0
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNV6-0006S0-NX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNV5-0000PX-8O
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:45:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38786
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNV5-0000P3-4I
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CxiFgdTNph6mRmVyLIsmbjusQ2IuBp9fgSgg+mMgbww=;
 b=B1qElfILG/3oZ+OhTaEcrMxzT0u/p/cOMnTXVD248d6M5dpurwyIpqPrwT1EgJnAC3JlXu
 mVWBpzChAlH0JBcP2Yyx8gxF8cd7+w6aGZQbYD4KBxWoAKcefL4DQc0q/sj6v+O74epJ/s
 9O6dLSSvgWtIZVhmN74hfqega8f+gK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Jsvp4lgkP5mWBzFylmwL8Q-1; Wed, 06 Nov 2019 10:45:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC281800D53;
 Wed,  6 Nov 2019 15:45:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9325719C6A;
 Wed,  6 Nov 2019 15:45:34 +0000 (UTC)
Message-ID: <4d3ed1468e966b14aa5b6453327be0710bc26ed7.camel@redhat.com>
Subject: Re: [PATCH v2 05/21] iotests: Replace IMGOPTS by _unsupported_imgopts
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:45:33 +0200
In-Reply-To: <20191015142729.18123-6-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-6-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Jsvp4lgkP5mWBzFylmwL8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> Some tests require compat=3D1.1 and thus set IMGOPTS=3D'compat=3D1.1'
> globally.  That is not how it should be done; instead, they should
> simply set _unsupported_imgopts to compat=3D0.10 (compat=3D1.1 is the
> default anyway).
>=20
> This makes the tests heed user-specified $IMGOPTS.  Some do not work
> with all image options, though, so we need to disable them accordingly.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/036 | 3 +--
>  tests/qemu-iotests/060 | 4 ++--
>  tests/qemu-iotests/062 | 3 ++-
>  tests/qemu-iotests/066 | 3 ++-
>  tests/qemu-iotests/068 | 3 ++-
>  tests/qemu-iotests/098 | 4 ++--
>  6 files changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
> index 5f929ad3be..bbaf0ef45b 100755
> --- a/tests/qemu-iotests/036
> +++ b/tests/qemu-iotests/036
> @@ -43,9 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto file
> -
>  # Only qcow2v3 and later supports feature bits
> -IMGOPTS=3D"compat=3D1.1"
> +_unsupported_imgopts 'compat=3D0.10'
> =20
>  echo
>  echo =3D=3D=3D Image with unknown incompatible feature bit =3D=3D=3D
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index b91d8321bb..9c2ef42522 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -48,6 +48,8 @@ _filter_io_error()
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> +# These tests only work for compat=3D1.1 images with refcount_bits=3D16
> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6]\|$=
\)\)'
Looks like the reason for that is that the test hardcodes (or guesses that =
is) various qcow2 structures
thing I have seen few times already in the iotests.
Not now but sometime in the future it would be nice to extend qcow2.py (or =
something
like that) to dump location of all qcow2 structures so that the guesswork c=
ould be eliminated.

> =20
>  rt_offset=3D65536  # 0x10000 (XXX: just an assumption)
>  rb_offset=3D131072 # 0x20000 (XXX: just an assumption)
> @@ -55,8 +57,6 @@ l1_offset=3D196608 # 0x30000 (XXX: just an assumption)
>  l2_offset=3D262144 # 0x40000 (XXX: just an assumption)
>  l2_offset_after_snapshot=3D524288 # 0x80000 (XXX: just an assumption)
> =20
> -IMGOPTS=3D"compat=3D1.1"
> -
>  OPEN_RW=3D"open -o overlap-check=3Dall $TEST_IMG"
>  # Overlap checks are done before write operations only, therefore openin=
g an
>  # image read-only makes the overlap-check option irrelevant
> diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
> index d5f818fcce..ac0d2a9a3b 100755
> --- a/tests/qemu-iotests/062
> +++ b/tests/qemu-iotests/062
> @@ -40,8 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qocw2-specific low-level functionality
If you respin that patch for some reason, you could fix the typo above.
>  _supported_fmt qcow2
>  _supported_proto generic
> +# We need zero clusters and snapshots
> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
> =20
> -IMGOPTS=3D"compat=3D1.1"
>  IMG_SIZE=3D64M
> =20
>  echo
> diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
> index 28f8c98412..00eb80d89e 100755
> --- a/tests/qemu-iotests/066
> +++ b/tests/qemu-iotests/066
> @@ -39,9 +39,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qocw2-specific low-level functionality
^^ Same here
>  _supported_fmt qcow2
>  _supported_proto generic
> +# We need zero clusters and snapshots
> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
> =20
>  # Intentionally create an unaligned image
> -IMGOPTS=3D"compat=3D1.1"
>  IMG_SIZE=3D$((64 * 1024 * 1024 + 512))
> =20
>  echo
> diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
> index 22f5ca3ba6..65650fca9a 100755
> --- a/tests/qemu-iotests/068
> +++ b/tests/qemu-iotests/068
> @@ -39,8 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # This tests qocw2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto generic
> +# Internal snapshots are (currently) impossible with refcount_bits=3D1
> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
> =20
> -IMGOPTS=3D"compat=3D1.1"
>  IMG_SIZE=3D128K
> =20
>  case "$QEMU_DEFAULT_MACHINE" in
> diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
> index 1c1d1c468f..700068b328 100755
> --- a/tests/qemu-iotests/098
> +++ b/tests/qemu-iotests/098
> @@ -40,8 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> =20
>  _supported_fmt qcow2
>  _supported_proto file
> -
> -IMGOPTS=3D"compat=3D1.1"
> +# The code path we want to test here only works for compat=3D1.1 images
> +_unsupported_imgopts 'compat=3D0.10'
> =20
>  for event in l1_update empty_image_prepare reftable_update refblock_allo=
c; do
> =20


Reviewed-by: Maxim Levitsky <mlevitsky@redhat.com>

Best regards,
=09Maxim Levitsky


