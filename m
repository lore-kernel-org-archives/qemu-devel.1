Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A63C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35EC2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF9m/ajU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35EC2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNba-0004MH-VH
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNZz-0002rw-VD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNZy-0004IK-Th
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:50:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23454
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNZy-0004Hz-P5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4qhppl8BmaWmO1z97F7c1ix18n/qkMPn1Cu5B4DWtU=;
 b=LF9m/ajURnRaEEGeITxRif0U6feRW1HU+aEmEPZNASMtk7ux1rKmLvZrKavMQLqnHwMsgU
 YPf+13MLxggzvzIr6ybwbcJ9e0GfLIpzlyZN0RoB+iVlksSuBiiTqbiy3goIyITzVp6qY6
 6nxgx4F4n0xoSU6h54+U5BDbo+PLC5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-ory3Jh_XOl-_6CiA9kNb2w-1; Wed, 06 Nov 2019 10:50:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55BC72F29;
 Wed,  6 Nov 2019 15:50:37 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F12B19D70;
 Wed,  6 Nov 2019 15:50:35 +0000 (UTC)
Message-ID: <679c642892636f2c60ee25fa953ac4d3d4e3ea8c.camel@redhat.com>
Subject: Re: [PATCH v2 16/21] iotests: Make 091 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:50:35 +0200
In-Reply-To: <20191015142729.18123-17-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-17-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ory3Jh_XOl-_6CiA9kNb2w-1
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
> The image end offset as reported by qemu-img check is different when
> using an external data file; we do not care about its value here, so we
> can just filter it.  Incidentally, common.rc already has _check_test_img
> for us which does exactly that.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/091     | 2 +-
>  tests/qemu-iotests/091.out | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
> index f4b44659ae..0874fa84c8 100755
> --- a/tests/qemu-iotests/091
> +++ b/tests/qemu-iotests/091
> @@ -101,7 +101,7 @@ echo "Check image pattern"
>  ${QEMU_IO} -c "read -P 0x22 0 4M" "${TEST_IMG}" | _filter_testdir | _fil=
ter_qemu_io
> =20
>  echo "Running 'qemu-img check -r all \$TEST_IMG'"
> -"${QEMU_IMG}" check -r all "${TEST_IMG}" 2>&1 | _filter_testdir | _filte=
r_qemu
> +_check_test_img -r all
> =20
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/091.out b/tests/qemu-iotests/091.out
> index 5017f8c2d9..5ec7b00f13 100644
> --- a/tests/qemu-iotests/091.out
> +++ b/tests/qemu-iotests/091.out
> @@ -23,6 +23,4 @@ read 4194304/4194304 bytes at offset 0
>  4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Running 'qemu-img check -r all $TEST_IMG'
>  No errors were found on the image.
> -80/16384 =3D 0.49% allocated, 0.00% fragmented, 0.00% compressed cluster=
s
> -Image end offset: 5570560
>  *** done
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky



