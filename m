Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4728C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5668F2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmFv+jRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5668F2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNfS-00017F-Fn
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNaZ-0003k8-Gq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNaY-0004rk-2w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:51:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNaX-0004rW-VZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M307sUEFpGt+y0sWBjOkxqR0RgJO3sbDVkMNNRa2fqA=;
 b=LmFv+jRZkvNXCVq/EikFSJEKmxI27ZimTTf4vRS4cR0lw6XnwGFn7geu/E9WiSUdk/uPI1
 6/8qcqoIwfkD+LZ6BtuCzMK0VfP7juL1Zmos8pigjW02tAjs8yoPqqOcrv1pWeNW30uqvM
 igTI+hkhW5hXHjE8V+Z9F3JdUmWFeG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-O1Ik_-ulPBq9sf5B7K-8wg-1; Wed, 06 Nov 2019 10:51:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29C958017DD;
 Wed,  6 Nov 2019 15:51:13 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E671560CC0;
 Wed,  6 Nov 2019 15:51:09 +0000 (UTC)
Message-ID: <2a49d55dc3d7d366eede9bc5a356e49a1b5349ea.camel@redhat.com>
Subject: Re: [PATCH v2 18/21] iotests: Make 137 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:51:08 +0200
In-Reply-To: <20191015142729.18123-19-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-19-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: O1Ik_-ulPBq9sf5B7K-8wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> When using an external data file, there are no refcounts for data
> clusters.  We thus have to adjust the corruption test in this patch to
> not be based around a data cluster allocation, but the L2 table
> allocation (L2 tables are still refcounted with external data files).
>=20
> Furthermore, we should not print qcow2.py's list of incompatible
> features because it differs depending on whether there is an external
> data file or not.
>=20
> With those two changes, the test will work both with an external data
> files (once that options works with the iotests at all).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/137     | 15 +++++++++++----
>  tests/qemu-iotests/137.out |  6 ++----
>  2 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
> index 6cf2997577..7ae86892f7 100755
> --- a/tests/qemu-iotests/137
> +++ b/tests/qemu-iotests/137
> @@ -138,14 +138,21 @@ $QEMU_IO \
>      "$TEST_IMG" 2>&1 | _filter_qemu_io
> =20
>  # The dirty bit must not be set
> -$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +# (Filter the external data file bit)
> +if $PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features=
 \
> +    | grep -q '\<0\>'
> +then
> +    echo 'ERROR: Dirty bit set'
> +else
> +    echo 'OK: Dirty bit not set'
> +fi
> =20
>  # Similarly we can test whether corruption detection has been enabled:
> -# Create L1/L2, overwrite first entry in refcount block, allocate someth=
ing.
> +# Create L1, overwrite refcounts, force allocation of L2 by writing
> +# data.
>  # Disabling the checks should fail, so the corruption must be detected.
>  _make_test_img 64M
> -$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
> -poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00"
> +poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00\x00\x00\x00\x00\x00\x00"
>  $QEMU_IO \
>      -c "reopen -o overlap-check=3Dnone,lazy-refcounts=3D42" \
>      -c "write 64k 64k" \
>=20



> diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
> index bd4523a853..86377c80cd 100644
> --- a/tests/qemu-iotests/137.out
> +++ b/tests/qemu-iotests/137.out
> @@ -36,11 +36,9 @@ qemu-io: Unsupported value 'blubb' for qcow2 option 'o=
verlap-check'. Allowed are
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$=
@" )
> -incompatible_features     []
> +OK: Dirty bit not set
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> -wrote 65536/65536 bytes at offset 0
> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
> -qcow2: Marking image as corrupt: Preventing invalid write on metadata (o=
verlaps with qcow2_header); further corruption events will be suppressed
> +qcow2: Marking image as corrupt: Preventing invalid allocation of L2 tab=
le at offset 0; further corruption events will be suppressed
>  write failed: Input/output error
>  *** done


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


