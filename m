Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C52C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1922075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZa8SZfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1922075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRRd-0006TT-SW
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 14:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iSRQQ-0005G9-6e
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iSRQO-000666-Az
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:57:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iSRQO-000647-2j
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573070220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JkeTiEXzhg5woMS2GNbW2G4AUnPNMMK6VGvG2E+qtNM=;
 b=fZa8SZfJ/xWf0iXcOgshZgVELJnOVY3VXdx07qQyANNSPeurlAc+Yk2sLI4Aa8Vi2zSK0t
 NcClQM8NIEuLlMCUzSM2w3R/Whb7h3/dO1z6N87dGyGXANjafiHJrdB1k7iu/TYPR5ePGe
 VGk2NUuKTWoAgVeC893UFJKyULEeilI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-vpom6cJtO56LUXYi6ZtQZA-1; Wed, 06 Nov 2019 14:56:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 733BE1800D53;
 Wed,  6 Nov 2019 19:56:51 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 750541001B2D;
 Wed,  6 Nov 2019 19:56:47 +0000 (UTC)
Date: Wed, 6 Nov 2019 16:56:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v14 01/11] util/cutils: Add qemu_strtotime_ns()
Message-ID: <20191106195645.GQ3812@habkost.net>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-2-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191028075220.25673-2-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vpom6cJtO56LUXYi6ZtQZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 jingqi.liu@intel.com, fan.du@intel.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com, jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 03:52:10PM +0800, Tao Xu wrote:
> To convert strings with time suffixes to numbers, support time unit are
> "ns" for nanosecond, "us" for microsecond, "ms" for millisecond or "s"
> for second. Add test for qemu_strtotime_ns, test the input of basic,
> time suffixes, float, invaild, trailing and overflow.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v14:
>     - Reuse the codes of do_strtosz to build qemu_strtotime_ns
>       (Eduardo)
>     - Squash patch v13 01/12 and 02/12 together (Daniel and Eduardo)
>     - Drop time unit picosecond (Eric)

Suggestion for the next version: if you are refactoring existing
do_strtosz() code, please refactor it in one patch, and add new
functionality in another patch.

> ---
>  include/qemu/cutils.h |   1 +
>  tests/test-cutils.c   | 204 ++++++++++++++++++++++++++++++++++++++++++
>  util/cutils.c         |  89 +++++++++++-------
>  3 files changed, 262 insertions(+), 32 deletions(-)
>=20
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index b54c847e0f..ff2b3f4614 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -182,5 +182,6 @@ int uleb128_decode_small(const uint8_t *in, uint32_t =
*n);
>   * *str1 is <, =3D=3D or > than *str2.
>   */
>  int qemu_pstrcmp0(const char **str1, const char **str2);
> +int qemu_strtotime_ns(const char *nptr, const char **end, uint64_t *resu=
lt);
> =20
>  #endif
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index 1aa8351520..d6a0824efd 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
[...]
> +static void test_qemu_strtotime_ns_trailing(void)
> +{
> +    const char *str;
> +    const char *endptr;
> +    int err;
> +    uint64_t res =3D 0xbaadf00d;
> +
> +    str =3D "123xxx";
> +
> +    err =3D qemu_strtotime_ns(str, NULL, &res);
> +    g_assert_cmpint(err, =3D=3D, -EINVAL);
> +
> +    str =3D "1msxxx";
> +    err =3D qemu_strtotime_ns(str, &endptr, &res);
> +    g_assert_cmpint(err, =3D=3D, 0);
> +    g_assert_cmpint(res, =3D=3D, 1000000);
> +    g_assert(endptr =3D=3D str + 3);
> +
> +    err =3D qemu_strtotime_ns(str, NULL, &res);
> +    g_assert_cmpint(err, =3D=3D, -EINVAL);
> +}

This is better than the test case in v13, where trailing strings
were not handled consistently.  Good.

[...]
> diff --git a/util/cutils.c b/util/cutils.c
> index fd591cadf0..d83825f8b4 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -181,41 +181,38 @@ int fcntl_setfl(int fd, int flag)
>  }
>  #endif
> =20
> -static int64_t suffix_mul(char suffix, int64_t unit)
> -{
> -    switch (qemu_toupper(suffix)) {
> -    case 'B':
> -        return 1;
> -    case 'K':
> -        return unit;
> -    case 'M':
> -        return unit * unit;
> -    case 'G':
> -        return unit * unit * unit;
> -    case 'T':
> -        return unit * unit * unit * unit;
> -    case 'P':
> -        return unit * unit * unit * unit * unit;
> -    case 'E':
> -        return unit * unit * unit * unit * unit * unit;
> +static int64_t suffix_mul(const char *suffixes[], int num_suffix,
> +                          const char *endptr, int *offset, int64_t unit)
> +{
> +    int i, suffix_len;
> +    int64_t mul =3D 1;
> +
> +    for (i =3D 0; i < num_suffix; i++) {
> +        suffix_len =3D strlen(suffixes[i]);
> +        if (strlen(endptr) >=3D suffix_len &&

Is the strlen(endptr) check here really necessary?


> +            g_ascii_strncasecmp(suffixes[i], endptr, suffix_len) =3D=3D =
0) {
> +            *offset =3D suffix_len;
> +            return mul;
> +        }
> +        mul *=3D unit;
>      }
> +
>      return -1;
>  }
> =20
>  /*
> - * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
> - * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
> - * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
> - * other error.
> + * Convert string according to different suffixes. End pointer will be r=
eturned
> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on othe=
r error.
>   */
> -static int do_strtosz(const char *nptr, const char **end,
> -                      const char default_suffix, int64_t unit,
> -                      uint64_t *result)
> +static int do_strtomul(const char *nptr, const char **end,
> +                       const char *suffixes[], int num_suffix,
> +                       const char *default_suffix, int64_t unit,
> +                       uint64_t *result)
>  {
>      int retval;
>      const char *endptr;
> -    unsigned char c;
>      int mul_required =3D 0;
> +    int offset =3D 0;
>      double val, mul, integral, fraction;
> =20
>      retval =3D qemu_strtod_finite(nptr, &endptr, &val);
> @@ -226,12 +223,12 @@ static int do_strtosz(const char *nptr, const char =
**end,
>      if (fraction !=3D 0) {
>          mul_required =3D 1;
>      }
> -    c =3D *endptr;
> -    mul =3D suffix_mul(c, unit);
> +
> +    mul =3D suffix_mul(suffixes, num_suffix, endptr, &offset, unit);
>      if (mul >=3D 0) {
> -        endptr++;
> +        endptr +=3D offset;
>      } else {
> -        mul =3D suffix_mul(default_suffix, unit);
> +        mul =3D suffix_mul(suffixes, num_suffix, default_suffix, &offset=
, unit);
>          assert(mul >=3D 0);
>      }
>      if (mul =3D=3D 1 && mul_required) {
> @@ -259,19 +256,47 @@ out:
>      return retval;
>  }
> =20
> +/*
> + * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
> + * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
> + * other error.
> + */
> +static int do_strtosz(const char *nptr, const char **end,
> +                      const char *default_suffix, int64_t unit,
> +                      uint64_t *result)
> +{
> +    static const char *suffixes[] =3D { "B", "K", "M", "G", "T", "P", "E=
" };
> +
> +    return do_strtomul(nptr, end, suffixes, 7, default_suffix, unit, res=
ult);

[1] You can use ARRAY_SIZE(suffixes) instead of hardcoding the
array size.

> +}
> +
>  int qemu_strtosz(const char *nptr, const char **end, uint64_t *result)
>  {
> -    return do_strtosz(nptr, end, 'B', 1024, result);
> +    return do_strtosz(nptr, end, "B", 1024, result);
>  }
> =20
>  int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *resul=
t)
>  {
> -    return do_strtosz(nptr, end, 'M', 1024, result);
> +    return do_strtosz(nptr, end, "M", 1024, result);
>  }
> =20
>  int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *re=
sult)
>  {
> -    return do_strtosz(nptr, end, 'B', 1000, result);
> +    return do_strtosz(nptr, end, "B", 1000, result);
> +}
> +
> +/*
> + * Convert string to time, support time unit are ns for nanosecond, us f=
or
> + * microsecond, ms for millisecond and s for second. End pointer will be
> + * returned in *end, if not NULL. Return -ERANGE on overflow, and -EINVA=
L on
> + * other error.
> + */
> +int qemu_strtotime_ns(const char *nptr, const char **end, uint64_t *resu=
lt)
> +{
> +    static const char *suffixes[] =3D { "ns", "us", "ms", "s" };
> +
> +    return do_strtomul(nptr, end, suffixes, 4, "ns", 1000, result);

Same as above[1].

>  }
> =20
>  /**
> --=20
> 2.20.1
>=20

--=20
Eduardo


