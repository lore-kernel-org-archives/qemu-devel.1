Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5BFC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 07:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692232073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 07:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+b1xGtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692232073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVVyi-00087D-GQ
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 02:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iVVxL-0007fV-GN
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 02:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iVVxK-0007OG-2A
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 02:23:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iVVxJ-0007Mh-VA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 02:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573802624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M78NfFz3hwR7EO88l4LtRd0NEn6qWxByP1E6YXhdv3c=;
 b=O+b1xGtHoJqYLqNIXhulr0tR73lz0XB4I1HUEOt2vY3pMVX9aNMQerOztIGk9j0y/UKwSl
 eGwuxGrqLUEdBTvLz2QJoHxHIZ2ewqGQMz0hP348+F3owueuhSnBxRD7cPX5ATg2991QmC
 TVh4YjU6x3NGTcZkVNnUosRFpWZ/tm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-ZV0n4l6TNeihFqKOyjKSpg-1; Fri, 15 Nov 2019 02:23:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22BE31005502;
 Fri, 15 Nov 2019 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-84.ams2.redhat.com
 [10.36.116.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62F525DF3A;
 Fri, 15 Nov 2019 07:23:39 +0000 (UTC)
Subject: Re: [PATCH] Modify tests to work with clang
To: Taylor Simpson <tsimpson@quicinc.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
References: <1573792691-398-1-git-send-email-tsimpson@quicinc.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2853dc41-919d-f32c-e531-07fd1111d59a@redhat.com>
Date: Fri, 15 Nov 2019 08:23:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1573792691-398-1-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ZV0n4l6TNeihFqKOyjKSpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/11/2019 05.38, Taylor Simpson wrote:
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  tests/tcg/multiarch/float_helpers.c | 13 ++++++++++++-
>  tests/tcg/multiarch/linux-test.c    |  2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/tcg/multiarch/float_helpers.c b/tests/tcg/multiarch/fl=
oat_helpers.c
> index 8ee7903..437247c 100644
> --- a/tests/tcg/multiarch/float_helpers.c
> +++ b/tests/tcg/multiarch/float_helpers.c
> @@ -26,6 +26,17 @@
> =20
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> =20
> +/*----------------------------------------------------------------------=
------
> +| The macro QEMU_GNUC_PREREQ tests for minimum version of the GNU C comp=
iler.
> +| The code is a copy of SOFTFLOAT_GNUC_PREREQ, see softfloat-macros.h.
> +*-----------------------------------------------------------------------=
-----*/
> +#if defined(__GNUC__) && defined(__GNUC_MINOR__)
> +# define QEMU_GNUC_PREREQ(maj, min) \
> +         ((__GNUC__ << 16) + __GNUC_MINOR__ >=3D ((maj) << 16) + (min))
> +#else
> +# define QEMU_GNUC_PREREQ(maj, min) 0
> +#endif
> +
>  /*
>   * Half Precision Numbers
>   *
> @@ -79,7 +90,7 @@ char *fmt_16(uint16_t num)
> =20
>  #ifndef SNANF
>  /* Signaling NaN macros, if supported.  */
> -# if __GNUC_PREREQ(3, 3)
> +# if defined(__clang__) || QEMU_GNUC_PREREQ(3, 3)

IIRC clearly, Clang reports itself as GCC 4.2, so you certainly don't
need the defined(__clang__) here.
But additionally, we require at least GCC 4.8 to compile QEMU these days
(see the check in the configure script), so you can even remove this #if
statement completely, so that the following #defines are simply always used=
.

 Thomas


