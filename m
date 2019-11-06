Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FDBC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E52B2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlkLnsrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E52B2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNhl-0002se-Cs
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNao-00045z-DX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNam-0005E4-89
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:51:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNam-0005Df-3b
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAmCG1Yvnq7dxPejSRzVxwl6pfTKam+Q1y3LG3jXATw=;
 b=GlkLnsrDez/ukD1xEaw3d2fFF1YeLQpbS41Sog9GuO0jE5U8rW5p2hZspEIjdsvO4NfrOO
 Ww3ehiT1EvLRhg5jZO0NDwZvDeAxyzmTRl/I7oDzP5JPasYlp4CVNfz/LQ+DhFUFVxDzjx
 OIXvEBXVQ6qXcUodhsAE0L8GuHVAFUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-3Czc7_TsOkKO9bW117pjAw-1; Wed, 06 Nov 2019 10:51:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15054800C72;
 Wed,  6 Nov 2019 15:51:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB46B5D9E1;
 Wed,  6 Nov 2019 15:51:22 +0000 (UTC)
Message-ID: <ea8a42408f6228eb0572ac6db699f6c8b26e6c47.camel@redhat.com>
Subject: Re: [PATCH v2 19/21] iotests: Make 198 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:51:21 +0200
In-Reply-To: <20191015142729.18123-20-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-20-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3Czc7_TsOkKO9bW117pjAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> We do not care about the json:{} filenames here, so we can just filter
> them out and thus make the test work both with and without external data
> files.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/198     | 6 ++++--
>  tests/qemu-iotests/198.out | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
> index c8f824cfae..fb0d5a29d3 100755
> --- a/tests/qemu-iotests/198
> +++ b/tests/qemu-iotests/198
> @@ -92,13 +92,15 @@ echo
>  echo "=3D=3D checking image base =3D=3D"
>  $QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-spe=
cific \
>      | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' =
\
> -          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
> +          -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/=
 D' \
> +    | _filter_json_filename
> =20
>  echo
>  echo "=3D=3D checking image layer =3D=3D"
>  $QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format-sp=
ecific \
>      | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' =
\
> -          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
> +          -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/=
 D' \
> +    | _filter_json_filename
> =20
> =20
>  # success, all done
> diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
> index e86b175e39..831ce3a289 100644
> --- a/tests/qemu-iotests/198.out
> +++ b/tests/qemu-iotests/198.out
> @@ -32,7 +32,7 @@ read 16777216/16777216 bytes at offset 0
>  16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  =3D=3D checking image base =3D=3D
> -image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
> +image: json:{ /* filtered */ }
>  file format: IMGFMT
>  virtual size: 16 MiB (16777216 bytes)
>  Format specific information:
> @@ -74,7 +74,7 @@ Format specific information:
>          master key iters: 1024
> =20
>  =3D=3D checking image layer =3D=3D
> -image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
> +image: json:{ /* filtered */ }
>  file format: IMGFMT
>  virtual size: 16 MiB (16777216 bytes)
>  backing file: TEST_DIR/t.IMGFMT.base


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


