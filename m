Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25598C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB91206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oT5j086l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB91206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTle7-0007wO-5A
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:12:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTldI-0007Tc-GE
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTldH-0006xw-Ji
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:11:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hTldH-0006wn-Ea
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:11:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id f10so5816271wre.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=NJw3I/kv4Zmtp1ZlFsYOIFmCHe8jldO3DrmLno073WM=;
	b=oT5j086lO8YQoG6VWHoo2i5D8Jxh/eRKqeEJHydPQk3CrxpVTQayB1lrEaTX6n2CQU
	OrC+JZfUhMOPVVe9eR9dG50L93z/a8qfGx9K7nePbzB8Vl+m9n5YVUAysAOw4EIRjFoh
	IX213XF1g8sA0MGhtIMR6Hyje43S4cq0vrHetuWS2CekTqVUiRmNHsCaq5HX/C6cvJf2
	1l8b3lDJrsjt2euxF2U6EYyLpVaBiFHzEbkV1c3KVSS08ZSBgrKf/tG4ss2qmKEuv6A/
	MidGQ+ANGE5V2QCmhgCslJoPu9CPmaWLesB7q2/OOEHVIDDBHeIp3n6ZcbMiGptwwPJI
	bivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=NJw3I/kv4Zmtp1ZlFsYOIFmCHe8jldO3DrmLno073WM=;
	b=mQuKRU8q5fS9l9RfsJWzS/1GMEAnWU3JWy7NBBUdEdXhWNN8C07CYAtC9f9HPy7BQO
	yphg8CVh89ismc42N0tntouNe80WB0r2Hh+SAzSvdCGIxJbwDnlre1+iCVt/ZBUARCJz
	gfVwjh0vzMISF1Tp+c2cCehrOG5ra20TUpGqZIGOLGX62M/rC8jkiC4jOfgk8WU4XypT
	t0u8T3BSg1IVLcvI8hjPpAFfPR4GAhSYahjJFONV72CtjqMjlA77Ynacmw80c1KnAPh3
	wgm+6gm9hTXyfdOXjphYdpbYsYl7y2UTulVDlO2oxzZFuUvR8RGNeqarepLLVHV7VkJg
	gCsA==
X-Gm-Message-State: APjAAAUyGHM8ZVD/SV2hS2ZOc5LZp6K2Z2rpkrmsgsufpH6ytlkKgezi
	85f1UNl4AsFTi8C2y1e2+iU=
X-Google-Smtp-Source: APXvYqyH6hcfXE+bsMvUx3meX5E6CkdNNiTm+jl/FPD5Z2nkUwCbBhbrE6s1dilLIVM6ruy+m728bA==
X-Received: by 2002:adf:9ccc:: with SMTP id h12mr26109658wre.21.1558609892450; 
	Thu, 23 May 2019 04:11:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id a9sm11555994wmh.5.2019.05.23.04.11.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 04:11:31 -0700 (PDT)
Date: Thu, 23 May 2019 12:11:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jag Raman <jag.raman@oracle.com>
Message-ID: <20190523111130.GF26632@stefanha-x1.localdomain>
References: <20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190308095036.GC12318@stefanha-x1.localdomain>
	<20190326080822.GC21018@stefanha-x1.localdomain>
	<e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
	<CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
	<c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
	<20190425154421.GG17806@stefanha-x1.localdomain>
	<fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline
In-Reply-To: <fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
	John G Johnson <john.g.johnson@oracle.com>,
	sstabellini@kernel.org, konrad.wilk@oracle.com,
	Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org, ross.lagerwall@citrix.com,
	liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kanth.ghatraju@oracle.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jag and Elena,
Do you think a call would help to move discussion along more quickly?

We could use the next KVM Community Call on June 4th to discuss
remaining concerns and the next steps:
https://calendar.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ

I also hope to include other core QEMU developers.  As you know, I'm
skeptical, but it could be just me and I don't want to block you
unnecessarily if others are more enthusiastic about this approach.

Stefan

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzmf+IACgkQnKSrs4Gr
c8ifeAf+JgsTw5g/cN28WehjM+lrm3SAjhe3Ufr1iEP/6MJdMC6WARHbPiNl3Bov
1f+jj272Q5I07thyhFgZENl+C3vNfPPaRjeb2aUJ/MRR53qwbfrUp0tAwo3zfeqE
CcOgMjBSnwYnEzYv9W95DCsLbYC4/kYsHdEh+kYaQtbRVMVg5PKbHCw8AbrEy6t1
bfqHzd7JgnV1j1LTFYD4+FPpsSpituYmZh8o0DWKYEuavbtUT0fj1R5yyzTeBKlk
9cI84cA6PGpdfrJQuMpRjRlPMboPZothtvqKaLVKKt7V0LZElLUgMtNMkDRYiveX
1YWuouTfhYfU1bDDD7b3ZpxmC0uu7A==
=W306
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--

