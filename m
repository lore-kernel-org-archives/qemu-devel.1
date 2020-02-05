Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D81C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8F42072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugta+wzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8F42072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIBE-0004wr-6F
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izIAb-0004Ti-HR
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izIAa-0002PL-II
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:44:33 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1izIAa-0002JE-BY
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:44:32 -0500
Received: by mail-wr1-x42a.google.com with SMTP id y17so2076204wrh.5
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 02:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UDP4yvDaevuO+NuXdoKn7yFjzBPtApJ+Ua8Gvw04QuA=;
 b=ugta+wzQhi93wHXl8EXwaNh0lEg8jYxNk8BTZ4PrrdDBa2nUmKcHY2RWs5tcbQKJcM
 A998KZ5rOuKem6UQTi1kEzlYBAqwgY1G7VoAF8Qo1dIJ0STSfiulg644Cf0TjBsrVMCo
 DAC7OgdGMMf7qM5OijXAfL2xh0hi/axwFlO4QwAgCij3BARkuhwLSblXLZjRkyIfzOgl
 Nmi91aSEbRvlQ79lVW3v5hE6cIGHg2j8TJluDbgMV9tXqskr4OGlz7I6XON5V9/jztnG
 RR6BiGs87XO1AEw9qxKcSkN4gd7h8IXo6+XqfeL0+6ExfmddBc65f8hA/EDnpuhEWEoo
 0cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UDP4yvDaevuO+NuXdoKn7yFjzBPtApJ+Ua8Gvw04QuA=;
 b=LmFdRCJPBJ8qLgD3xrLKUjzKRNd1ac0I9a++NV9bLgy00VyxphBFecSc7hcDdOWP3p
 ll5s73EvxeczPmMmTwxNaz5CMtrPEozQm6+tLSo1YBiSZ7AvR9YmWJdYQ80wLNwYM4iQ
 LYR8BNE5hmgbBbAvB39BTu2SfKKEpgMNuxKnsir/ISjVEsIHgKiSlHM4u+lCCq8Ebcsk
 j2qcR2iwOb/5/oMJyB1gkm8Sld2NrTVjvc7IL741VCVjfn+w8ouYmyfl/6ChWZOMI1Qp
 LZ/1FEVjBukKxi9MYD1A5krzAU0I97slWzpX//qNlcXxjOpu9JCaJVUqqRAUBjuHQfvg
 GOEA==
X-Gm-Message-State: APjAAAUvN75Ou5/JdKzHgrfS2HGhBt3CPKBODeXmmIBnnMWs3ay1C67b
 mP7c449t81TtF3tUHW/qjwk=
X-Google-Smtp-Source: APXvYqwX15Kyt8fv3FmfcY8gMW+1FYt/cYC+vdkPqyOW7pT1lbeZJb2kiSss516rzOljQudXDN7TdQ==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr26536161wrq.243.1580899471245; 
 Wed, 05 Feb 2020 02:44:31 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n3sm7705712wmc.27.2020.02.05.02.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 02:44:30 -0800 (PST)
Date: Wed, 5 Feb 2020 10:44:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
Message-ID: <20200205104429.GB58062@stefanha-x1.localdomain>
References: <324a-5e231180-7-6946d180@169257031>
 <20200120145024.GJ345995@stefanha-x1.localdomain>
 <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
 <20200122112818.GA663955@stefanha-x1.localdomain>
 <CAL1e-=hJ=vD6Ngy0_w-kGA2X4EP-yni+S0ZTkPKW36moqaBozg@mail.gmail.com>
 <20200129153937.GA157595@stefanha-x1.localdomain>
 <CAL1e-=h+G+8ZWxHpS0WenxLLrfwBOVxv+xaL9KkGO1JqM=ksTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <CAL1e-=h+G+8ZWxHpS0WenxLLrfwBOVxv+xaL9KkGO1JqM=ksTA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 05:52:09PM +0100, Aleksandar Markovic wrote:
> >
> > Please go ahead and add this project idea to the wiki:
> > https://wiki.qemu.org/Google_Summer_of_Code_2020#How_to_add_a_project_i=
dea
> >
>=20
> Hi, Stefan,
>=20
> I set up the proposal wiki page:
>=20
> https://wiki.qemu.org/Google_Summer_of_Code_2020#Performance_Measurement.=
2C_Analysis.2C_and_Presentation
>=20
> Anything else I need to do?

Thanks!  Your idea is included in QEMU's GSoC 2020 effort.

Stefan

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl46nI0ACgkQnKSrs4Gr
c8i0MQf+JVmOj70mTLMKFGODU+8LQFF6v6hSOKCe5/jNtMKAPHdeQn4onh2iwGF6
Q//0EDfkaxKvZoS0w50JEKKHIT3wOzuHR6gjkP5rWHRs30jsPMeXC89pNP+nyO5T
xfllSG0hSXWDfvMng32Tw9yhjr+76bKCMoFTQCAFE6aQrY3cQ84BmXp3AYR0P0dA
p3DlYlxniwYF3nMWYxB6/cFIlpdQ9Ic1egiAMxlzsTkqXT1v5ZbL8CXn8w2RGGar
rrr8ZtlnR9zWIL8dbTISE05CaPmogNp2AK6XBC28rG5EGDdqZx4ybf4VjlwwEYIw
gWAHN5hJyjTyfOrAC9lv+xTfipi3mA==
=5VuJ
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--

