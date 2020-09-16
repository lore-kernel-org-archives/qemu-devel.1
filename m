Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF0CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04D6221E5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyRLMw0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04D6221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVZv-0003sj-Jn
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVYH-0002u5-FU
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:24:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVYF-0004oO-Mb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:24:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id o5so6433459wrn.13
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uZ9qR0g2mR/fgFHjXvd1Fa7VGHURpbXktmGVk+bO5Is=;
 b=hyRLMw0Q9pen9zAXgA7nGL7bNmx9h2pf2UHDGthrpGiWEocXMa1AYlBMbE8LxtV1Gg
 lRsRXMSshgrNLao8Do56p7N7wqZpY2pR9uPZ5nLGCJmz9ZxzXpmdfAwX5wpktYMlGCzJ
 TqCGX7fIYK6qC7c8cFUos8Z8k0hVgEJWZVO+m/hxxjGAq9E6LJ27hnikD/wkx5QrqnIs
 xYDurdy3Abx3lVZ3Bhq3lNLacWj9bPDDDThnQawFSvNHLz7mC+xo+Znaftgd+EAgo2H3
 Q6NKuedmkDuT9cGXNyA0+jhoFhbfcImF38iVupozPBJN7xnqdkLseN6i96rGaM/cekE3
 G/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uZ9qR0g2mR/fgFHjXvd1Fa7VGHURpbXktmGVk+bO5Is=;
 b=sIfwOQpLR44G9pv4inQ8FrqoLTdU2sFV4nUjXe7lHLPkQsAHh+7muFQG0Kowqt17Qi
 MmxSRc/5A9rZGwFoOTGXQvLCuuPFQbOxXg0G3IdwtfJFtcg27zliKJkovChSbVP5JVLQ
 McrUxSzcVFuUNg/TCg94F7g3w3wP/7jkNQAlvhN/EwTGLErb6MpQ0jxpUxT7hTSj5KYQ
 hb3p8itsXtRcnqTsnU/nmCvBl5xTpX6YRIx+9AksDsSMypKy/v7STz1tXTF+B+NIG3eD
 v1qfJNbGRDkqC318IEGpNjD4ZQ4pwSEg2JAAS65cMCDVYetcfiRjf2JHTq1wLiBM2vYb
 P/xQ==
X-Gm-Message-State: AOAM532z7QIea6Unrp+nJ9T0uCHS014FMD+2TJJgW3qAibHjiN2LqY9g
 BU+KJSULv+LNdNiflyrHalY=
X-Google-Smtp-Source: ABdhPJy1ZaXKLjQH4lF7gVX0jv4y1i64AEwSKKTPFsO/aLgH65xoYiyR8tFi2EzWT9kSmsVSVYVU9A==
X-Received: by 2002:adf:fd01:: with SMTP id e1mr24488892wrr.44.1600255478339; 
 Wed, 16 Sep 2020 04:24:38 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 63sm5116987wrc.63.2020.09.16.04.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 04:24:37 -0700 (PDT)
Date: Wed, 16 Sep 2020 12:24:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
Message-ID: <20200916112435.GB756728@stefanha-x1.localdomain>
References: <20200913100534.22084-1-pbonzini@redhat.com>
 <20200914095753.GB579094@stefanha-x1.localdomain>
 <CAE2XoE_00RqJyMH2azqS6sFFtmf+G-moJOFOKDQLcyKSqnOr0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <CAE2XoE_00RqJyMH2azqS6sFFtmf+G-moJOFOKDQLcyKSqnOr0w@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 06:00:11PM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Yongg=
ang Luo) wrote:
> On Mon, Sep 14, 2020 at 5:58 PM Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> >
> > On Sun, Sep 13, 2020 at 12:05:31PM +0200, Paolo Bonzini wrote:
> > > - because we parse command-line options before meson is available,
> > > the introspection output is stored in the source tree.  The output
> > > is slightly modified using the "jq" tool in order to ensure that it's
> > > stable and that modifications to meson_buildoptions.txt do not cause
> > > horrible conflicts.  This is the main reason for the unattractive
> > > diffstat (the number of JSON lines added is higher than the number
> > > of configure lines removed, though of course the latter are code
> > > that must be maintained manually and the former is not).
> >
> > Does this add a build dependency on jq? Is it possible to use a Python
> > script or even a command-line one-liner instead?
> What's jq stands for, is that a perl script?

https://stedolan.github.io/jq/

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h9fMACgkQnKSrs4Gr
c8h4mAf/Q9EprRJna+1qQPLwb5504ap2MDg/RseeR/8d+slvQQL6+OYSZy0bpaT5
+NHQPTYM03wGykKG30xetFcGx0fDpBfqNRTgB5hLG2gC9AeZG9q3eRC8uTM6+4j/
nts5MFDUr4d8gUuWsXHkEy2P+MKvj4qJsc+1B1Dt7lmmg5njSvmggBJEkqUZenIj
4MMHE96nCaJCdV2Aqj4VqPeOMyX8d9OCjjaL3SHHeK9utd3tSbxmtl3l1gyvRXPq
e7woXyalVhLM5tt7GL3Zi58Gw66OUVrudowhdu3D2eM78O5oRRhEhZLStVVt6pOU
bYEuQFXBZIfjeuOVyREK80e/1GQvuA==
=Daug
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

