Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88E7C76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9672B22BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKzO/Chq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9672B22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0DG-0005AS-W2
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33291)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hr0D6-0004m2-Oq
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hr0D5-0005KB-RY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:24:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hr0D5-0005Jn-H8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:24:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so54420139wru.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GTIOUjsd2vjEQ6PV6b+viqSWK0ZPXZu3pJnyMa9AXH0=;
 b=fKzO/Chq6gli3mGS2TqyJnHvpXDZiZm9DwnM4YoeaofD5pzenjwDocFkOIfHhpbGxa
 b/D5YEW4xNefBrmOmLkElBeQGiYaRMuCoUA5xInB439BLBKLPxqjw4JPLRlkIA8QIFe6
 9BE8wpAz3Fvit+u8Rx3nR7Am9ubsOQEXmUR+s6ctlZS9a8Hh+k5hugwzhhsUXKfEuu85
 v9xx8oW/c0jYg//3v5VNWhMZ2glUaRfLwJkOPciuqjeUkNb4XBLQLtFgWrZek6tI/w19
 M1VxPKJdqzvHVEzynEoMMK07awIADrz+KTmIMwbZ8TQrqsqq0Vl3lMuPFcI+ywPwbCMI
 ddPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GTIOUjsd2vjEQ6PV6b+viqSWK0ZPXZu3pJnyMa9AXH0=;
 b=PMSWkjwtPtc4EILu/dT5dGhprfN+nfQRoKcHeG5lXXav7pe5xWn/BG82+EwLkbDxaz
 9fL153ygQwbaNmANlKuc1emvDUmXaGHsVqcu9z8JZ1WQ8dDAJnc55FI1d22ZwYSXeWze
 U2iIrzkmTpzld8sCj0XFv6S8aMjOpalnW6+lyxFzIBAzRk5v8lDpuws6x7QvNC5iLgEc
 u2O/3Bir+8TbZIhEs5oZgwSxIsH+vfe1ax8zhD/cbxMz5qb5nXbSKkV/1tLqFFIAQEPb
 gzIuBl6GAj5Syf6SuGV60z5b8IPUbkwlseMDTmUAhpFCZmrLkEX5PEaaINYtKB7XbBYG
 g1bg==
X-Gm-Message-State: APjAAAUSKOlTwAGvn/6Kaff0I7bWm8kbGxmDveRdYt6GRxk28qu2H7vn
 FmoGUzxeI2EU0UezZDzjK+g=
X-Google-Smtp-Source: APXvYqy002LWmGgCjuCKeuojGESvmVofQc/DHiXdPIa5ihd42xRwdE8gLCzxTkpr1ke01Ngch1Ze4Q==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr20116576wrj.118.1564147474143; 
 Fri, 26 Jul 2019 06:24:34 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v4sm50638794wmg.22.2019.07.26.06.24.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 06:24:33 -0700 (PDT)
Date: Fri, 26 Jul 2019 14:24:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190726132431.GJ25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdJFN6SSISdF2ksn"
Content-Disposition: inline
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC 00/19] Add virtual device fuzzing support
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 03:23:43AM +0000, Oleinik, Alexander wrote:
> As part of Google Summer of Code 2019, I'm working on integrating
> fuzzing of virtual devices into QEMU [1]. This is a highly WIP patchset
> adding this functionality.
>=20
> Fuzzers provide random data to a program and monitor its execution for
> errors. Coverage-guided fuzzers also observe the parts of the program
> that are exercised by each input, and use this information to
> mutate/guide the inputs to reach additional parts of the program. They
> are quite effective for finding bugs in a wide range of software.=20

Good start!  The overall approach is maintainable and not too invasive.
Some iteration on the current patch series will be necessary to clean
things up, but the fundamentals look promising to me.

Stefan

--sdJFN6SSISdF2ksn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl06/w8ACgkQnKSrs4Gr
c8hEAwf+L09zNe4yiVvv36x9PPoSq8RAqMzN578CKskUiBJyM4Jyqpl4mpUjr80I
OafKppzEOJRhRSU3oA6bxKqjlsBPer4Rkb2f3EIKX+hDkkicECnxmPtoXsb02ynR
bip/2NCmaGV12IeMbi11DnMpeCFMP6GIzL0eqcmAXj/zhsTiKjSRk8Wozdsr+79E
Lhh1vbqq9gku5JTmTnLLfffZF20tFqCkO3vko4ixBYzKI7pyX2nw4t0Fyvj4B/Py
B3TxsJeN4MZZrpNy+kDkh/Q0xyaW5IB5B2/GCGrxTfNBqi95suWvA2CWzk/FUQ00
o8Hp3NYHP/ikXhun7Cx/vIfpvdNTFg==
=+bGt
-----END PGP SIGNATURE-----

--sdJFN6SSISdF2ksn--

