Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFBFC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E01F2086A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E01F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcLq-0004gP-Hs
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc7k-0000Xg-Jf
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc7j-0002pX-FM
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:32:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc7g-0002ko-UX; Sun, 29 Sep 2019 12:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35EECA44AD8;
 Sun, 29 Sep 2019 16:32:36 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F186C600F8;
 Sun, 29 Sep 2019 16:32:34 +0000 (UTC)
Message-ID: <0248fced83c8248dfc1434ad5525051b728aec00.camel@redhat.com>
Subject: Re: [PATCH 05/18] iotests: Add -o and --no-opts to _make_test_img
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:32:34 +0300
In-Reply-To: <20190927094242.11152-6-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-6-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Sun, 29 Sep 2019 16:32:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> Blindly overriding IMGOPTS is suboptimal as this discards user-specifie=
d
> options.  Whatever options the test needs should simply be appended.
>=20
> Some tests do this (with IMGOPTS=3D$(_optstr_add "$IMGOPTS" "...")), bu=
t
> that is cumbersome.  It=E2=80=99s simpler to just give _make_test_img a=
n -o
> parameter with which tests can add options.
>=20
> Some tests actually must override the user-specified options, though,
> for example when creating an image in a different format than the test
> $IMGFMT.  For such cases, --no-opts allows clearing the current option
> list.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.r=
c
> index 3e7adc4834..f3784077de 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -287,6 +287,7 @@ _make_test_img()
>      local use_backing=3D0
>      local backing_file=3D""
>      local object_options=3D""
> +    local opts_param=3Dfalse
>      local misc_params=3D()
> =20
>      if [ -n "$TEST_IMG_FILE" ]; then
> @@ -307,6 +308,10 @@ _make_test_img()
>          if [ "$use_backing" =3D "1" -a -z "$backing_file" ]; then
>              backing_file=3D$param
>              continue
> +        elif $opts_param; then
> +            optstr=3D$(_optstr_add "$optstr" "$param")
> +            opts_param=3Dfalse
> +            continue
>          fi
> =20
>          case "$param" in
> @@ -314,6 +319,14 @@ _make_test_img()
>                  use_backing=3D1
>                  ;;
> =20
> +            -o)
> +                opts_param=3Dtrue
> +                ;;
> +
> +            --no-opts)
> +                optstr=3D""
> +                ;;
> +
>              *)
>                  misc_params=3D("${misc_params[@]}" "$param")
>                  ;;


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


