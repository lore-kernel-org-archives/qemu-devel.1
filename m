Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A2D20679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A2D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzsx-0005ZB-Jb
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNzaU-0005TI-PE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNzaQ-0006LL-P5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:25:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNzaO-0006Jb-P9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:25:02 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F3B4859FB
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:24:59 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a6so1150775wru.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PGAaF7fZ+FAGqwyERuEGyI9MrT5cRBdtcQG0ZAjD5NM=;
 b=DD3EKzBHXGLDNAhHxKIEtcRZu1dJ7/tsHCOY3uLbb7PlQQIYPyRkU2ec58Qs35U2hL
 2Jwfzy4dLZAI+NQro/MWq/hvRsMKqE5x+HorRLQZ9xoEahG7EjuDwwdH/5Q0HQAVzemQ
 AlyJ1fTEhYw1Qjt0KGPtYpdpcrdzbh3DLI95DSWLuQwFOfa+W6M97xHc6hLYVjImJkUT
 rdF7mI0GMD4bLUTM+vFhDOSt6Yt+ef9A+OcDwQSc7OgfAuPnKA/Z6Zhm3iR0UkJkgtIR
 aaXzlUJzx0dMEpjpd4PuPpPtOgfY/cybNkVpxrfAzsXJUh9rQHxTcyEogNtK9Mtm1gux
 PoWA==
X-Gm-Message-State: APjAAAWbxSZTBCK1FNo+BdDmxjKYL+o53fz9PWlp9A+smN4lXgLLMsxP
 wW+zlsjMgmyFU4FG13yuOGkHyusKFVes7CSO06E8el0XZ0X5PVEUtOM00GpUzQQg/7T0xNB4Bdm
 fhozCtECfcDqymG0=
X-Received: by 2002:a1c:9c0c:: with SMTP id f12mr3536585wme.133.1572009897500; 
 Fri, 25 Oct 2019 06:24:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqznT5Uarlav4LxS1fyDs1JBshUeuczE45VPcliCuPTSxUSH5M3r2r2M7pwbEqI6k0LAynSdJg==
X-Received: by 2002:a1c:9c0c:: with SMTP id f12mr3536571wme.133.1572009897313; 
 Fri, 25 Oct 2019 06:24:57 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id s12sm2318212wrp.18.2019.10.25.06.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 06:24:56 -0700 (PDT)
Subject: Re: [PATCH 1/4] tests: allow filtering crypto cipher benchmark tests
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20191017145654.11371-1-berrange@redhat.com>
 <20191017145654.11371-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e54bbedb-8f6f-695f-bb38-df7b808d0f37@redhat.com>
Date: Fri, 25 Oct 2019 15:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017145654.11371-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 4:56 PM, Daniel P. Berrang=C3=A9 wrote:
> Add support for specifying a cipher mode and chunk size as argv to
> filter which combinations are benchmarked. For example to only
> benchmark XTS mode with 512 byte chunks:
>=20
>    ./tests/benchmark-crypto-cipher xts 512
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/benchmark-crypto-cipher.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-c=
ipher.c
> index 67fdf8c31d..3ca31a2779 100644
> --- a/tests/benchmark-crypto-cipher.c
> +++ b/tests/benchmark-crypto-cipher.c
> @@ -161,15 +161,26 @@ static void test_cipher_speed_xts_aes_256(const v=
oid *opaque)
>  =20
>   int main(int argc, char **argv)
>   {
> +    char *alg =3D NULL;
> +    char *size =3D NULL;
>       g_test_init(&argc, &argv, NULL);
>       g_assert(qcrypto_init(NULL) =3D=3D 0);
>  =20
>   #define ADD_TEST(mode, cipher, keysize, chunk)                       =
   \
> -    g_test_add_data_func(                                             =
  \
> +    if ((!alg || g_str_equal(alg, #mode)) &&                          =
  \
> +        (!size || g_str_equal(size, #chunk)))                         =
  \
> +        g_test_add_data_func(                                         =
  \
>           "/crypto/cipher/" #mode "-" #cipher "-" #keysize "/chunk-" #c=
hunk, \
>           (void *)chunk,                                               =
   \
>           test_cipher_speed_ ## mode ## _ ## cipher ## _ ## keysize)
>  =20
> +    if (argc >=3D 2) {
> +        alg =3D argv[1];
> +    }
> +    if (argc >=3D 3) {
> +        size =3D argv[2];
> +    }
> +
>   #define ADD_TESTS(chunk)                        \
>       do {                                        \
>           ADD_TEST(ecb, aes, 128, chunk);         \
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

