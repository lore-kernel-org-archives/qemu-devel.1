Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0E2C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271582178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlnEXcWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271582178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNdQ-0007KJ-CT
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNZo-0002YA-Mf
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNZn-0003zs-IN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:50:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNZn-0003z8-DK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5eynXDf+UEc1A4ZfJQANoSiqnIir+CDCO3sV2tfLLs=;
 b=ZlnEXcWJW+dKfh577dE7ls6PJfZ87hKg9KrtEtyKPmrmHwQcVn37p1hTrYfJj6jvCMqTh2
 wsHJbp7NtIbFNQ//2+8T3xmVwXhGGegsqkFy5aMAzW2uBor1Jxlx66aYuI38E43wTTYv4y
 W2Q7cbFycr+ymAOja1tdkIshTwuUA7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-ooXftNUcOrSJgq_m7ir7Qg-1; Wed, 06 Nov 2019 10:50:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15CF18017DD;
 Wed,  6 Nov 2019 15:50:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D15A15C3FA;
 Wed,  6 Nov 2019 15:50:23 +0000 (UTC)
Message-ID: <1445776525ad25f089d8e595749889e303a5d24c.camel@redhat.com>
Subject: Re: [PATCH v2 12/21] iotests: Drop IMGOPTS use in 267
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:50:22 +0200
In-Reply-To: <20191015142729.18123-13-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-13-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ooXftNUcOrSJgq_m7ir7Qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> Overwriting IMGOPTS means ignoring all user-supplied options, which is
> not what we want.  Replace the current IMGOPTS use by a new BACKING_FILE
> variable.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/267 | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
> index d37a67c012..eda45449d4 100755
> --- a/tests/qemu-iotests/267
> +++ b/tests/qemu-iotests/267
> @@ -68,7 +68,11 @@ size=3D128M
> =20
>  run_test()
>  {
> -    _make_test_img $size
> +    if [ -n "$BACKING_FILE" ]; then
> +        _make_test_img -b "$BACKING_FILE" $size
> +    else
> +        _make_test_img $size
> +    fi
>      printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qemu "$@=
" | _filter_date
>  }
> =20
> @@ -119,12 +123,12 @@ echo
> =20
>  TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
> =20
> -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
> +BACKING_FILE=3D"$TEST_IMG.base" \
>  run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=
=3Dbacking-file \
>           -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
>           -blockdev driver=3D$IMGFMT,file=3Dfile,backing=3Dbacking-file,n=
ode-name=3Dfmt
> =20
> -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
> +BACKING_FILE=3D"$TEST_IMG.base" \
>  run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=
=3Dbacking-file \
>           -blockdev driver=3D$IMGFMT,file=3Dbacking-file,node-name=3Dback=
ing-fmt \
>           -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
> @@ -141,7 +145,7 @@ echo
>  echo "=3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D"
>  echo
> =20
> -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" _make_test_img $size
> +_make_test_img -b "$TEST_IMG.base" $size
>  cat <<EOF |
>  nbd_server_start unix:$TEST_DIR/nbd
>  nbd_server_add -w backing-fmt

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


