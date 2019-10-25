Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD9FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0168020679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0168020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO014-0005de-Dv
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iNzuZ-0002rA-4b
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iNzuW-00082a-Cu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:45:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iNzuW-00080c-4l
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:45:48 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56E2385543
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:45:46 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 67so1159769wrm.18
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Ndd2+X9PbmIzVTIQNEkt6U1CiuoscxQzVbnOIJfZ/fk=;
 b=Ka4v+WidgOGlnzF9/+k2k6NR+QhVQZZ32B8lHNmT2d/x2JGFEovp6lEeGsrU1Ln/uK
 ogtSY0ReL7NXdFQzAVVKqukq5OuWc/aWw4pmQzJtf89KOEPZQpEAkdDeawd6iMCPiiJk
 Xg0lYWm9Tlz3jjU9W55lSBXcNPak2NWKDCw4W6GTNDYzpPYmQMBa8HzorSNlDaSqmd0n
 ZMdH9LCib2ZUxB0XisLNY0jPjAU0Tph4LPJGJJ6rkDqTNOkaDR2FAFVm7AgHTZJ2+qWA
 8a4rfWgSAqJ3FL73rIHLQ/znfMU0japSWuusp1DkNJpP2Ck5nUc+sg96KWgO3tUiFeNP
 O/Lw==
X-Gm-Message-State: APjAAAVYEjUqiSPcoxkytXJTuC29wbjR64U7QfcYdCjlTnZeAAexdsbz
 t07VgbLJZExeZIeW9uchwU5ZgthOn82UtPWu9CTIPQKdyFxsp4aqWSFpIWbIdX6Rt+aK0AddYyA
 uuzYtwDvCEEApwHY=
X-Received: by 2002:a5d:6892:: with SMTP id h18mr2957418wru.370.1572011145067; 
 Fri, 25 Oct 2019 06:45:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYhieNT7Ext5ffOPkZ1T/UBChU/d+WVLDDImi49ARJZy/C3YM8KE/yup8gSmXul29YUrZ9PA==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr2957397wru.370.1572011144775; 
 Fri, 25 Oct 2019 06:45:44 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id q12sm2413443wrj.87.2019.10.25.06.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 06:45:44 -0700 (PDT)
Date: Fri, 25 Oct 2019 15:45:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 1/4] tests: allow filtering crypto cipher benchmark tests
Message-ID: <20191025134542.zyxfzntlrzldgfen@steredhat>
References: <20191017145654.11371-1-berrange@redhat.com>
 <20191017145654.11371-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191017145654.11371-2-berrange@redhat.com>
User-Agent: NeoMutt/20180716
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 03:56:51PM +0100, Daniel P. Berrang=E9 wrote:
> Add support for specifying a cipher mode and chunk size as argv to
> filter which combinations are benchmarked. For example to only
> benchmark XTS mode with 512 byte chunks:
>=20
>   ./tests/benchmark-crypto-cipher xts 512
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  tests/benchmark-crypto-cipher.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-c=
ipher.c
> index 67fdf8c31d..3ca31a2779 100644
> --- a/tests/benchmark-crypto-cipher.c
> +++ b/tests/benchmark-crypto-cipher.c
> @@ -161,15 +161,26 @@ static void test_cipher_speed_xts_aes_256(const v=
oid *opaque)
> =20
>  int main(int argc, char **argv)
>  {
> +    char *alg =3D NULL;
> +    char *size =3D NULL;
>      g_test_init(&argc, &argv, NULL);
>      g_assert(qcrypto_init(NULL) =3D=3D 0);
> =20
>  #define ADD_TEST(mode, cipher, keysize, chunk)                        =
  \
> -    g_test_add_data_func(                                             =
  \
> +    if ((!alg || g_str_equal(alg, #mode)) &&                          =
  \
> +        (!size || g_str_equal(size, #chunk)))                         =
  \
> +        g_test_add_data_func(                                         =
  \
>          "/crypto/cipher/" #mode "-" #cipher "-" #keysize "/chunk-" #ch=
unk, \
>          (void *)chunk,                                                =
  \
>          test_cipher_speed_ ## mode ## _ ## cipher ## _ ## keysize)
> =20
> +    if (argc >=3D 2) {
> +        alg =3D argv[1];
> +    }
> +    if (argc >=3D 3) {
> +        size =3D argv[2];
> +    }
> +
>  #define ADD_TESTS(chunk)                        \
>      do {                                        \
>          ADD_TEST(ecb, aes, 128, chunk);         \
> --=20
> 2.21.0
>=20
>=20

--=20

