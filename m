Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747DEC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4084820578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQRH+vgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4084820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58oi-0000CC-F9
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j58nv-0007YT-Te
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j58nv-0003pA-1Z
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:57:19 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j58nu-0003oC-R6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:57:18 -0500
Received: by mail-wr1-x443.google.com with SMTP id e8so2183942wrm.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vT4Jsw6xFU4dp0QrzccXp2iw01HbW7HCOa6Uy5j8pOg=;
 b=UQRH+vgIRjWjebVBuk62EQKoauamL4t0piFQVMvG/yTKAnNj3Hpr3xYCo38VmjKUvy
 I2bG9t8WsxC/Kv19ugCMs/anHmFMCyQ4u2eWSHSxDaGW+VqCrO1HME6Ny99pYNgegxWb
 TSGrtpCRDskhzfwXRkAaVjJoXzV5BLPae0Pz2Y19yB2aBSe1K37W5TRHNm3SnDBlMG/J
 ujVKcivMELAlID2bafwueqnMj9y5vYQPwff/RH6NMdxOAYDqUnHWVtAGJe+3OxKgpasV
 be8HffSOv2ka5QSAvsRS+8pZiHijgk0mqPZeQLkUi4qNUr39jzciLQwv7ZPH8mzeWRpC
 OoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vT4Jsw6xFU4dp0QrzccXp2iw01HbW7HCOa6Uy5j8pOg=;
 b=gNJgpKwYc+rtLE8L8n2GThODKF80WXwmjKdAp+G1fT3ldNctfzVtGTGnX+O2Di7VIm
 28BFrhkBSecS5gEMIl07Zmkjr+o9ZWl+P6ksrZiRkIuKhbv2QDYFryTb7obufSp5xEqB
 zschnsv9Vx0zk5IvKPGP/smOrD3XaLjAgXmNvcgPN0rm/i0nVVlJ8E/bxldjpqQ4TK6K
 BzhMI3Ajsnq014oKnPTF5Wsfmv9urtagj4BRBy05poUzF+YccXDkVGDe4idNm2A4O//5
 JXP5ld7dKonqs6njFjVae+XUWTPhoH9OoRoWD0UrFPHJBc6YkH0z7HsTzU/lC97xjeIt
 /0sQ==
X-Gm-Message-State: APjAAAUPaEyejSvnwnJzMIL7WlqDNIlC1USLH5YvxenVAzQCLCBzPv2v
 ADOqfBtngmciileK21RwkBc=
X-Google-Smtp-Source: APXvYqyap6CF7YW15OKkgFXp89lo9PP9VEkWQkLI3jPW61kNPEQ4rvlAQHtLnkLhh6dYAb845n3Lyg==
X-Received: by 2002:adf:e448:: with SMTP id t8mr48396698wrm.224.1582293437739; 
 Fri, 21 Feb 2020 05:57:17 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z19sm3573317wmi.43.2020.02.21.05.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:57:16 -0800 (PST)
Date: Fri, 21 Feb 2020 13:57:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v10 21/22] fuzz: add virtio-scsi fuzz target
Message-ID: <20200221135715.GQ1484511@stefanha-x1.localdomain>
References: <20200220041118.23264-1-alxndr@bu.edu>
 <20200220041118.23264-22-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jigfid2yHjNFZUTO"
Content-Disposition: inline
In-Reply-To: <20200220041118.23264-22-alxndr@bu.edu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jigfid2yHjNFZUTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 11:11:17PM -0500, Alexander Bulekov wrote:
> The virtio-scsi fuzz target sets up and fuzzes the available virtio-scsi
> queues. After an element is placed on a queue, the fuzzer can select
> whether to perform a kick, or continue adding elements.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/Makefile.include   |   1 +
>  tests/qtest/fuzz/virtio_scsi_fuzz.c | 213 ++++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+)
>  create mode 100644 tests/qtest/fuzz/virtio_scsi_fuzz.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jigfid2yHjNFZUTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P4bsACgkQnKSrs4Gr
c8ihIAgAnrC6bSYwF4CHKgWJT1HPEz0bhuApFg7xisyUz5mDJS2R3WQVXhzbxeth
Xn3m/Y9pe1K3Re8fNPgD/kAC778eQ8r842C/JvGT4wV5pIgeaYqlFHOINsgbcxno
L18NtOBECawS4HjfUxpt/DRiZEzDqTE4Ea4yBfm32/WjaV6D0B8YZDcyC7PUgAyE
p8P/ZA87/zIsilgxPP5fG2avQJp7pnwlTcRISHcUXyQdLCDxR0jo0A6xvv8tpv8b
Uy8tWpg7oFll7IBQJhqLlMf3voitX8++prFmsDDc9LCL/o71/Uof0TFR52URRvzb
dyKQsInL8Y6yzmlKmQ6B/pmDv6WFkw==
=+tAG
-----END PGP SIGNATURE-----

--jigfid2yHjNFZUTO--

