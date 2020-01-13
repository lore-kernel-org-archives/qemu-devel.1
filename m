Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD0C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D08207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vR3xuleB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D08207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2dB-0001hj-Hx
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ir2bq-0000lf-2x
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ir2bo-0007Gt-SP
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:30:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ir2bo-0007Eh-Kt
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:30:32 -0500
Received: by mail-wm1-x32f.google.com with SMTP id 20so10374061wmj.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 08:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=D+Wx+HEwfg70nwq06ML8B9/UCg2j63W79fNEmZTpLB8=;
 b=vR3xuleBy9cK83m/lGNO5YavgHgs6gXWQGm5hlF83jXLTQHmfReusCrBCDvvwPlH4V
 63qESAtwvBZIdrsw/plPJftiyg03jSTMB+DUhk3JXMLdObm47M5YSAMDmCRLZk55AlVp
 PfjMu7Kp515XeJ8TQwB60XrkNObqPhANgi9d8H3y/wgdDYIaFyENUrLPMrG/iRwv10Nn
 KkYBl5eEvrbAS85Sjy38jpsOYbTOs/3S/44Ml+ZEVK9LMOnypgqU9rbKV0TsZ1tfcZll
 HVKF89LblhiLSBwyII7U5sFPLRxIqnW3JZ6zqPTlpFQ5U+KACawfzJskUGZDZfLnFHGk
 hB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D+Wx+HEwfg70nwq06ML8B9/UCg2j63W79fNEmZTpLB8=;
 b=L2oiyvEMFJkT9LCnsetOkDpC3wXOBPs5xpSciI9UEZ13m062M+VDTK+v0Kcxx1Z3pX
 D+L/px0Jjtkvr0xmPAVlTLOodhRQAFCxzweQCaOjqZjIzwStk92D0W3EVquf6h+48v/D
 VGZKj9n6IiMdf6ydXxCmHQjS30FgBa2lJazVn188HlOCv8agB9qseztYreXqS2gxlo7B
 u9DcTxbFyDalvq3dVMzvEx9aAdS1UeAqHguFFXHyuL8m4nPX7rKLm2AV05iq9vLSZCZq
 aNvNRNpcwEOSuG+R/Clc4no7BZGFl4DqR10lligi7HEOvzu+CIoLp3gQybMMOII7oA86
 XL9g==
X-Gm-Message-State: APjAAAX0O42VSnxyYOx0/FuNIHs4EHPZ3dCk2f4bw3sKNJE8YFBpKgCa
 GAQaK4pQ0mKJEP6Sn1RjG9A=
X-Google-Smtp-Source: APXvYqzb6VCd/hF8S6WXhVJ1exMtr0ZrAeEgIktg8svWVvFeN7yyXV99SKq2qpoMvf6IYxo73iSMxg==
X-Received: by 2002:a05:600c:24ca:: with SMTP id
 10mr20426686wmu.4.1578933030750; 
 Mon, 13 Jan 2020 08:30:30 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n3sm14972881wrs.8.2020.01.13.08.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 08:30:29 -0800 (PST)
Date: Mon, 13 Jan 2020 16:30:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200113163028.GB103384@stefanha-x1.localdomain>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 06:11:13PM +0100, Christophe de Dinechin wrote:
> > On 20 Dec 2019, at 17:13, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> So I think that Daniel is right. We may need at some point to start
> a NEMU-style offshoot that does not attempt to be compatible,
> but explores describing an increasing surface of the API using a
> new meta-language from which we can generate, in a consistent
> way, at least:
>=20
> - C bindings
> - Command-line options
> - Shell bindings (or =E2=80=9CHMP=E2=80=9D)
> - JSON schema or qom description
> - Bindings in other languages (Rust, Go, Python)
> - Networked versions of the API (socket, REST)
> - Client-side code e.g. for libvirt.
> - Serialization / deserialization, e.g. for configuration files
> - Documentation, including man page and API docs
> - Command-line help
>=20
> At the most fundamental level, I think we need to describe:
>=20
> - Values, e.g. how we represent names, sizes, paths, etc, possibly
> with some user-friendly aspects, e.g. path shortcuts, memory units,
> spelling shortcuts (e.g. being able to consistently say -blo for -blockdev
> if that=E2=80=99s the shortest option that matches)
> - Relations, e.g. how we represent =E2=80=9Ccontains=E2=80=9D, =E2=80=9Cd=
erives from=E2=80=9D, =E2=80=9Cneeds=E2=80=9D,
> =E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=E2=80=9D, =E2=80=9Catta=
ches to=E2=80=9D=E2=80=A6
> - States, e.g. how do we represent the machine configuration,
> or the desired new disk setting
> - Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=9D, =E2=80=9Cconnect=E2=
=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=80=9D,
> =E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D, etc. and how we descri=
be the kind of input they need.
> - Possibly more subtle things like support for transactions, commit/rollb=
ack,
> i.e. =E2=80=9CI want to add connect a virtual nic to some host vf, but if=
 anything
> along the way fails, I=E2=80=99d like all the cleanup to happen automatic=
ally)

Extending QAPI to achieve these things is a possibility.

If we afford ourselves the luxury of breaking backwards compatibility
then I would instead use the opportunity to eliminate complexity:
1. Get rid of the CLI
2. Get rid of HMP
3. No per-command C bindings, just a qmp_call() API
4. No configuration file, just a sequence of QMP commands

The new QEMU would be very different and solely focussed on QMP (or a
standards-based RPC system).

It's not very fun working on projects that have a lot of custom
infrastructure.  Making a one-time change requires a lot of learning
weird infrastructure that you won't use often.  We already have too much
of this and it slows down QEMU development.

Stefan

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4cmyMACgkQnKSrs4Gr
c8jZvggAxszC6ihsD7RYHWKixDuMCch3SHn5dJu7h3Z5Mwvx23AXwBhA+PLLeXPN
oNTIPkme4UQXO9k/8zNNoWS7Zzrr6v4g0qZpHysTJKJIQ1jUMoHMNOe7s48GW7rM
Hk5MbxYCacpH1oScSKFu5WoPVPH1sXyePxnLbiKcm1p9QOtAvTE7ZzILYRODi+MG
719PVDkT77Whgczka3zSdJD5iVZWVyvM/s6Cr79mdW0oQl2fgNfvUOr4xNT+CSpA
8hRkSxpRkc7SnS5DV0z6/8mP7m998F7njrDpnbpbZHzCPReagUjUckqIMSiUhJ8a
TuAapGHMflVejJWcwFjm62oP6XGRcg==
=ExeP
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

