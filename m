Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725BAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE63222C4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leUeKVZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE63222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ozn-0006UK-Fn
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j8ozB-00064P-57
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j8ozA-0007hG-5F
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:36:09 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j8oz9-0007fg-Sn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:36:08 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y17so797758wrn.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Yuhy5LNf5q078tt3iOPeyGhvCMYeCQryY6iUPFx5sJE=;
 b=leUeKVZXo8VXlQmWQV0D5dsAtDWJVlNROraoXYd9a0Cvbpjnpc9fy5Dna/edAeBGkF
 trE1Nkr8W6Ajiv/JUIJq7uf9+bLiS4v12tTC0gUqb3ouePQApO/7JsST5ctwWL1I2dO+
 PVBwZASdhFm9867mYRzLc5SN5XZGfgbVEQOfbLbTn7dGH2CzoO0O3pa4xE6p9ZePbx2v
 mAUUzEZa6MoUVOXnprgYCkZUxau7OEL00Nzla6rVanmSeMDCCeZ6pLXWXcZ/u+Du+uSk
 XcYVkSBvqMvH6cowR8CBSFq5DX57Qst0Yr3fTS10VlPvU5l9UsyRdaHWCShvY1gGyHZq
 ZPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Yuhy5LNf5q078tt3iOPeyGhvCMYeCQryY6iUPFx5sJE=;
 b=g70F6tsUmp3pTgbDMNapS8BWSFht1EhImVUB9kVjF44VoVT03MxY3jwt++0pxMZkeU
 tm5jYAZgk2dPnwknoIj1s/XA47/yviqhYsREAy793bT40Np6wIgumUEFOzkiC8+G4kpV
 rTmw7CNP1ICiZ/SlJZFoHL7Kx3sz9+vh4qtsf6pzPHDQjr0+2UJ/q340uSTlhnbXUwgu
 R8GJ1ZYU6rg+wobULY2ZDbnvy3vTMZCiuZ/U/9cpm6UJx/tB/TrQD5mcPWWeBJ1ee2ZU
 ZBpoHTYtPrFXDzZk98usPJqVLUMojIBVDRXvUniAZi1OT8fHki94dwWAdMNO1b9gj5XG
 QN1Q==
X-Gm-Message-State: ANhLgQ0fonNx48DfkbhOYf03rco2yzLMougMxrYNRh6bjIoLX4jVLtn9
 9rSNhJPynNbUxvtULSAzBTg=
X-Google-Smtp-Source: ADFU+vs4ZZnRU1CdM+hqzUcNY7KvE3xVVh4TXKYnCf/ysDQwblZIVDAK987EA8EBdl475K70jBVhGA==
X-Received: by 2002:adf:bc0e:: with SMTP id s14mr656929wrg.364.1583170566705; 
 Mon, 02 Mar 2020 09:36:06 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c4sm161517wml.7.2020.03.02.09.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:36:05 -0800 (PST)
Date: Mon, 2 Mar 2020 17:36:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Subject: Re: New Hardware model emulation
Message-ID: <20200302173604.GB682016@stefanha-x1.localdomain>
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2020 at 05:27:44PM +0530, Priyamvad Acharya wrote:
> I have created a virtual device in Qemu.
> Now I want to run Qemu with the virtual device,so how to do it ?

Hi,
It's unclear what you mean.  Please provide a bit more background on
what you are trying to accomplish.

For example, are you trying to run a VM and need help with QEMU
command-line parameters to configure devices?  Or are you writing code
to emulate a custom device (please include a link to the code)?

Stefan

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5dRAQACgkQnKSrs4Gr
c8iEPgf/SDYGy+e+7sTdT/l7cYEcJ4yGR8ds1wQC4yozKoQawv/oDwB37pUb4ca1
kEy9v3aYcPil+9D00z1ubOC/wt0aYz2Xu2NyRSS3wlef9ipbwrBhOax77zCptobI
hhPRUW+izpZeU85hayaFjDu79ATYO2LHc6xfi2uSSyrHlFDJiDILFiKrFlQeAjRT
uVEG216Lw0tuPTHsKfDQ985UJl177lN1ef1AEVYmrxVwVQU6kbf/bFXbWR/agLut
SW4HsGhAl/4KPnvHusenZcY4uR4unKboz6QKt/gvIfDpzB374bVzwrL/CMt+Adio
zRyZqetto0+HKkrtbeYZ6AjaHd6zXA==
=t9At
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--

