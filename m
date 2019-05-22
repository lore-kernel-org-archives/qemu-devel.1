Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C12C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C28220879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm8WIGO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C28220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTYt-00014O-Fl
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:53:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTTQu-0003HL-LT
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTTQt-0002ui-NF
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:45:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hTTQt-0002rO-Fi; Wed, 22 May 2019 11:45:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id c77so2741539wmd.1;
	Wed, 22 May 2019 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=LSVXXXxPTmwCGJg7fJ7Euv+jTFlOOiuQVD1BvtLsrQk=;
	b=Sm8WIGO4ohPNUUzE5O78I3p8DVgucxpyeE2PQeJmtRLEtdcYt/0hguN5m2UzkKwafG
	ApPUOR1pwsFCjF1eiexpUuBwzs6C+AiyR7PKdcII+wfm8u3emkYK0KeDLDM1fBufw1yD
	2qSRG035mYRHC332G2LQcwxj9GV//C/lXtyVEy1MBfP7x8JJEVE3qP1Erl+m0jfcH4hB
	+f3H9gDCStL+65PsK+fBnd95wDhkwmga1JQDjxgvZuK3fq4ei203w5jb6bjcuza58NAg
	YJJWvMfNCLZZoCTbOPMprgOEdTRuKZHPI0Jtqcm+2vX3ZmFeUMIA9tqL2X/t8s+lonFX
	FAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=LSVXXXxPTmwCGJg7fJ7Euv+jTFlOOiuQVD1BvtLsrQk=;
	b=Dr1K8oJYqyNV01flntuYHvprIi9qegGau2VQ5mGfnz95DYiERNvyeSL18j74lvbWGm
	nIdUXDdXI7azYt+Uhbjyh1Eqc6+lbGW4SveG8fxFU7w0Ox4waOYBYAuh8tGCKhdhLLEA
	rS0SoWGAB7waZEhSZPUmgsj/vFwCk5pg2xSeA2AxCl/gE607qB9Zy/fQY+i+bbNmDNmQ
	JKf60ROKWCs/bdSJj0nfI38e3zVUgXoB5vxX03fP6rEGAdN2WVral3Zx+2S9FB+2Kmrn
	RlEoA+WqNL5ZMXOhboNuME+zn8MiK+71skNj7U8z0XPE+F3ub1xW/gOs/1APjuzCltMv
	bhzQ==
X-Gm-Message-State: APjAAAWBsc0YduJLBh6VkN/Q7cn28sAQkNZj6Q04ZwcoJkt1vLQNGrFi
	k2KUTOS4o1pFO/UxEnrmoRA=
X-Google-Smtp-Source: APXvYqzeMvSJK07X1iZEkMc7LY89M1T7BJNXfyPkEh1bNSgBWSnVgSBoLe/YSAkxloG3z0QXTaZmMg==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr8463719wmd.110.1558539934557; 
	Wed, 22 May 2019 08:45:34 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	c131sm7848489wma.31.2019.05.22.08.45.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 08:45:33 -0700 (PDT)
Date: Wed, 22 May 2019 16:45:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190522154532.GN27900@stefanha-x1.localdomain>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-9-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AA9g+nFNFPYNJKiL"
Content-Disposition: inline
In-Reply-To: <20190521235215.31341-9-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH 8/9] block/file-posix: extends to use
 with io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AA9g+nFNFPYNJKiL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 05:22:14AM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  block/file-posix.c | 63 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 1cf4ee49eb..41952217a4 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -154,6 +154,7 @@ typedef struct BDRVRawState {
>      bool has_write_zeroes:1;
>      bool discard_zeroes:1;
>      bool use_linux_aio:1;
> +    bool use_linux_io_uring;

:1 for consistency with the surrounding bool fields.

--AA9g+nFNFPYNJKiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzlbpwACgkQnKSrs4Gr
c8hlAQf/UO6fMZG+0VPNi7PsAFZ/cO81l736sdJ7oYvf1q8NRbd2yfVtl630Vwl1
g+TI9lghPFUIm1THTlv2zgHDyGxoIh8dGluW6marbR8SQdCdjW3+2pmMfjMtJ5Tk
jGFa2OLBHjRByd438qlINB8M64eZAjaPfEutLuX2jIMCZWVgvyAp29lgXsB/flRe
JQ5lrl4Od62KRceleZy4x2SxjEY7yFB2Da2o2+avIWKcb+g8cUsTrWB2IKZTjDvd
cKeIhEOyxkSZaYGUs0stfXxD86ggePc5oywZf52WIsO/q7vkuf0CGSU0CkaO+wuT
1rAYRN2OTrNscppa1JUEzsZ4OHq8GA==
=5uK1
-----END PGP SIGNATURE-----

--AA9g+nFNFPYNJKiL--

