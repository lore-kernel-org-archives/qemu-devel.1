Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF0C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A3E2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imUZC8dG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A3E2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNds-0007zc-Rf
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNaH-0003I5-BD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNaF-0004Ub-W5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:51:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNaF-0004UE-S3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rXRsio6THzXthnvTXeERZl/MoQJ79f6FKpx4SI4Lko=;
 b=imUZC8dGM+EYXzIyd5uXuXpjU+HQumoi5mbjfVl8HgB/16HddvHCKZT59W734RfoBdQyOu
 OmPCbJzdaib4R8YUhY74VB+zbZtI9Va62HL4iqbLAQi0bTumc/NFuXjC6nY7ctgrzYWXJb
 StY8LQyVKVSNXfd7juud+xF9pQKTP7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-6AZ4BFqmOyOUD7bJ2Qc7Zw-1; Wed, 06 Nov 2019 10:50:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E060107ACC3;
 Wed,  6 Nov 2019 15:50:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0689F600C4;
 Wed,  6 Nov 2019 15:50:51 +0000 (UTC)
Message-ID: <fbe3e4cbe3f3160cfb5c2d9654f3576e033b8660.camel@redhat.com>
Subject: Re: [PATCH v2 17/21] iotests: Make 110 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:50:51 +0200
In-Reply-To: <20191015142729.18123-18-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-18-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6AZ4BFqmOyOUD7bJ2Qc7Zw-1
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
> The only difference is that the json:{} filename of the image looks
> different.  We actually do not care about that filename in this test, we
> are only interested in (1) that there is a json:{} filename, and (2)
> whether the backing filename can be constructed.
>=20
> So just filter out the json:{} data, thus making this test pass both
> with and without data_file.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/110     | 7 +++++--
>  tests/qemu-iotests/110.out | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
> index f78df0e6e1..139c02c2cf 100755
> --- a/tests/qemu-iotests/110
> +++ b/tests/qemu-iotests/110
> @@ -67,6 +67,7 @@ echo
>  # Across blkdebug without a config file, you cannot reconstruct filename=
s, so
>  # qemu is incapable of knowing the directory of the top image from the f=
ilename
>  # alone. However, using bdrv_dirname(), it should still work.
> +# (Filter out the json:{} filename so this test works with external data=
 files)
>  TEST_IMG=3D"json:{
>      'driver': '$IMGFMT',
>      'file': {
> @@ -82,7 +83,8 @@ TEST_IMG=3D"json:{
>              }
>          ]
>      }
> -}" _img_info | _filter_img_info | grep -v 'backing file format'
> +}" _img_info | _filter_img_info | grep -v 'backing file format' \
> +    | _filter_json_filename
> =20
>  echo
>  echo '=3D=3D=3D Backing name is always relative to the backed image =3D=
=3D=3D'
> @@ -114,7 +116,8 @@ TEST_IMG=3D"json:{
>              }
>          ]
>      }
> -}" _img_info | _filter_img_info | grep -v 'backing file format'
> +}" _img_info | _filter_img_info | grep -v 'backing file format' \
> +    | _filter_json_filename
> =20
> =20
>  # success, all done
> diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
> index f60b26390e..f835553a99 100644
> --- a/tests/qemu-iotests/110.out
> +++ b/tests/qemu-iotests/110.out
> @@ -11,7 +11,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IM=
GFMT.base)
> =20
>  =3D=3D=3D Non-reconstructable filename =3D=3D=3D
> =20
> -image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_aio=
", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": =
"blkdebug", "set-state.0.new_state": 42}}
> +image: json:{ /* filtered */ }
>  file format: IMGFMT
>  virtual size: 64 MiB (67108864 bytes)
>  backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
> @@ -22,7 +22,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D671=
08864 backing_file=3Dt.IMGFMT.b
> =20
>  =3D=3D=3D Nodes without a common directory =3D=3D=3D
> =20
> -image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file"=
, "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_DI=
R/t.IMGFMT.copy"}], "driver": "quorum", "vote-
> threshold": 1}}
> +image: json:{ /* filtered */ }
>  file format: IMGFMT
>  virtual size: 64 MiB (67108864 bytes)
>  backing file: t.IMGFMT.base (cannot determine actual path)

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


