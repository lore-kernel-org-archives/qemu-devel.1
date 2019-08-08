Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC265C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C4C21874
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq/DOwMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C4C21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvfNZ-0002MA-Ug
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 06:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57537)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hvfNC-0001rZ-Ab
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hvfNB-0006WP-EX
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:10:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hvfNB-0006VO-7y
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:10:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id v15so1819755wml.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JB2wdKK7Ofdic56cqkotyGHhIA7f4O6eOG/E5vdYT2k=;
 b=pq/DOwMxC5sIpB2orpGhmoXCwh0XxTCjznLAjfNfM+krr/JXsVmXf/CiZ4IixUMd9t
 7iGjlEUJYe9Nab6LssqsssPbmuXy0KG81yRMojOooqj3VL9pgGjM7WGAr5nsGSCq7Oas
 1X17Vt+wTO7/riFI5uTxCyzGAwMB9pPpYzSnilQHwW+awJbsWT5lait95agWxvCqIFGf
 raqvF+e9oxW6QND9+wRBIko2hDCUQcoY3g0unTZd7n04+Q6UrDY4gMY7tg+5VhO9zGuf
 Ky1+Mv3HJ9yGiVFxi4HhexVqIlwoCJKGc9PktHp2Beb9iV7CCBknunVK98UZS/h01i6z
 ysyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JB2wdKK7Ofdic56cqkotyGHhIA7f4O6eOG/E5vdYT2k=;
 b=WFHjoZRTg+Z0JMZL7wpCf93MbHDlZb9juMUM5rel4kxsvgtSsvBavMj6v2m+F5INnb
 YfE6UXYpqT7LDeTMyu/EDscGGroKrb35ogGNclcdr8U5fUbO6bIWVAlTmRYxhdiXTUNC
 TbcI58csYxa4tfSZVTv6jz11vv7d4xjhVQh7OZKJWXKvPkUW3/jBc+qjtw4ktrZxMGQu
 bxrq/+dF1wNzfr7GPr+xtO4VHV405TPghRt4IYzTdxThICfIn/utz4ixBDDwYi9M6mVi
 QW0U7nRY9DyZsLFfgWrPnLwb0zLA+pYxIYcSkSDHes5xd8meNAVIxSayEynqEC9CJaXP
 dBiA==
X-Gm-Message-State: APjAAAXuN9119xAHjfqfmWqrDCd+ME5ClsKahJROmjstC1knwMzn6Whp
 xPuab2JgMiUFG8GHv5lNyrY=
X-Google-Smtp-Source: APXvYqztJugFPtriC4uWYlj863wgceH9/WXj7qY7pk2SXVUYsWPH0uVc9ugPbcKv7ek+dsHaX7b3Nw==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr3568469wma.120.1565259016120; 
 Thu, 08 Aug 2019 03:10:16 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u13sm6904637wrw.45.2019.08.08.03.10.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 03:10:15 -0700 (PDT)
Date: Thu, 8 Aug 2019 11:10:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190808101013.GD1999@stefanha-x1.localdomain>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
 <5839fa4e-b6f3-9547-e71d-50be75c4f9fc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <5839fa4e-b6f3-9547-e71d-50be75c4f9fc@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, Balamuruhan S <bala24@linux.ibm.com>,
 anju@linux.vnet.ibm.com, clg@kaod.org, Stefan Hajnoczi <stefanha@redhat.com>,
 hari@linux.vnet.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 12:20:47PM +0200, Philippe Mathieu-Daud=E9 wrote:
> > +void python_args_clean(char *args[], int nargs)
> > +{
> > +    for (int i =3D 0; i < nargs; i++) {
> > +        g_free(args[i]);
> > +    }
> > +}
> >=20
>=20
> Wondering about security, is this feature safe to enable in production
> environment? It seems to bypass all the hard effort to harden QEMU securi=
ty.

This seems like a feature that distros would not enable.  Only users
building QEMU from source could enable it.

Stefan

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1L9QUACgkQnKSrs4Gr
c8hEAgf/ZMrSd2DL0T8BXvmaGtrZYEjieHM33xaDpqbmgEpHmDPxjttdkVFNI/e8
PEWEyC71O3gkUIa2A8KVesHa35mqua1PWeQMKYCSwWoPo+nF16qQeUCoHD1Cmydz
0nVI2VyJ4iESE7HxIzoxKSMH1E8t+7hLlB3BB4W/ctnVGXZOjVbvueijnmpuilB6
CbD1UEnN6/lQSoqDqf1NwmXwVR9JDpRlzTTFCJzYGjbiXkaBaUogQ1P5xsT9m+Wm
OoZSnRGAiBrb+hKGSVU5KM/Qx7FmLLlM6EcvIxAJDTieqhtISctWxJPq8T2MRF/b
KvP1KiM/0yVW8PKAOkTOFS7aUcZkrA==
=AWfk
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--

