Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF431C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFC020882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoc/1xtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFC020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrt7-0003v2-FH
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itrsE-00032O-An
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itrsC-00054Q-MI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:39:10 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itrsC-00052v-DK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:39:08 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so2821258wru.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 03:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=51vKCeNRdeQIAXtlfcPM41eG0DvMdV3q1KszkF8e6Tc=;
 b=aoc/1xtR1/+gpcooB22xd6CizdP3b+l9cMxfxCwU7+N0Gbvw3yy4O9JTbyXUdX6qpA
 ypH9ue7lx7DeSXPANiKTqSXBSXdoTI3ppGthgiP61Pg6l2h0AsGp+I0e6gCmVaf/HiKb
 tpygRstP1drZQiBfG8g8ZwPTiJZIY3vGB1iaNINlME6tbXDBY7pKqooYddwCgoy+Pl7X
 Oi13qssKkLP0NLYsQqx2Q330oXljCU2JtxN1E+hj+RA//xEprdnXE7py7OgAD/E6mWU5
 nm9k+RF3BKQh4v7PrJCngnoZWRnO5oJNay4f6eVquic9ojNHGBipYTcScpatCKapZwuW
 PBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=51vKCeNRdeQIAXtlfcPM41eG0DvMdV3q1KszkF8e6Tc=;
 b=frWwK5V22qfQGqtmNNcihBG/ETQRDZPs8o4jRmt5CdEnTx4yl6nU4zt/tKukzAbfpy
 0ruB3hLwq2zCypTBi6w1jkaRf+OfHvwXlt2+D2++PzkP95IhREvWJhVNUAk8HTe+Ox5l
 or8HOQXHc8wNWkmDeFXnj0V3BWy7NrXWbQInblDb2CZu/RdptGivRANgG2phwu/Om8NK
 cfPdetCrJjhz4nRidUdLT0WxOkuXr/XCRa0XwRHRnD4SjljRf4zgrOp3FXSRM3vw96no
 NnevmVG8830YybULrhX/l6+TcjrHVfNHFY9f1L8vxViwW7G/KNqOYhdPhIh0GzBQClYF
 UQVw==
X-Gm-Message-State: APjAAAVv8x/F4kPn8+Rjixe56C0nCTKgq4FLi1CWMHmAwvyAovP8Z7zl
 5S5xIs/uEeKDh7vmBJvpkwc=
X-Google-Smtp-Source: APXvYqy8ebBq4x6zQDzRdlBNajXPJBIszULawZO2TFjjNNXZsrK+VsjMD96ZQOr7UuHhunXNv+gmBw==
X-Received: by 2002:adf:df83:: with SMTP id z3mr4693832wrl.389.1579606746516; 
 Tue, 21 Jan 2020 03:39:06 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d16sm56172504wrg.27.2020.01.21.03.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 03:39:05 -0800 (PST)
Date: Tue, 21 Jan 2020 11:39:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/3] Use only trace_event_get_state_backends() to check
 trace enablement
Message-ID: <20200121113904.GG630615@stefanha-x1.localdomain>
References: <20200120151142.18954-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <20200120151142.18954-1-peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 03:11:39PM +0000, Peter Maydell wrote:
> Currently docs/devel/tracing.txt recommends checking the
> TRACE_FOO_ENABLED macro to see if the FOO event is enabled,
> for the purpose of skipping expensive computations that
> are only used in trace output.
>=20
> This is no longer the best way to do this; instead we
> should prefer trace_event_get_state_backends(), which
> checks both whether the event is compile-time disabled
> and also whether it is run-time disabled.
>=20
> Update the documentation, and also the 5 uses of the
> old style in the tree.
>=20
> thanks
> -- PMM
>=20
> Peter Maydell (3):
>   docs/devel/tracing.txt: Recommend only
>     trace_event_get_state_backends()
>   memory.c: Use trace_event_get_state_backends()
>   hw/display/qxl.c: Use trace_event_get_state_backends()
>=20
>  docs/devel/tracing.txt | 12 +++++-------
>  hw/display/qxl.c       |  2 +-
>  memory.c               |  8 ++++----
>  3 files changed, 10 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.20.1
>=20
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4m4tgACgkQnKSrs4Gr
c8j+2AgAw/5poYkOxqvpM6lIw6+i1RLhrCQnkR3D+/jY8Atx+9ZhzxiA4rF8Pm0I
27J/NhjAcgGnJCYUsPeQ/4Yi4wozrGcS0Fo+Vh7sFODqheIsYeyoFiHnU3/MgDUY
rHcy63rbTVol8jOOPoNlhD+dRBsbmzNM8dPafMdbXPHcaPVaEd9lR8HxDJ7eGNYB
6iSFJnjz1l8GvGfM1TgDzuQjJ+AA2JAaJWY/nZsoxOeuLzY3h9cTTB2B5o4ooa5W
YiTYyhGGXuSHf4ZIoN1cmk8nPMT1l+H8SMydpiEQ6Zr4mwcX/NbfjIqEaAgoRQz5
6v6570pZGDxq5wF1jfS6wArTF3QTAA==
=tGyH
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--

