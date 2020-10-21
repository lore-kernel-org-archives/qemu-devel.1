Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B0C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901CA21707
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="YdkVOXHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901CA21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVDHu-0005jD-EY
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 08:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1kVDGN-0004yz-Iu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:30:43 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:9000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1kVDGI-0004zd-5s
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603283430;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=HOTIRSXXurVWeiWuLg1bks8fd36SZseBU3h+TJXJcoE=;
 b=YdkVOXHtR+tzjSkqJIkjz1q1KcPKocLlcgNqE7Wt2dgsp8uCFtPObB+IeTHKDKtHw6
 wmYykvbDZhlF5uugjxX+v7H2FL5WkSsT9i0gTVf4BdgQQzPv2pMtkPv5A5u2erSriMh4
 DEMf3pd8PUr9MuxxumQwr3uLc1zju+St/xbZdFs2mGjBdJHe9zYvo8VOhiz1AxrUz1AN
 ULLbkrSsCXmDjfIJM8npDWDmb/ReSXGCyvpwH6E8Rza8An2Mcp+wEKhmRhTOF+NnmRdV
 ASIUgcHBGrft56Q9suibhvAXVLL4tUvX6KoXAbNUNvbBSxKv7Mu9ElFc+Vv2d3eb7s32
 ypfw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDXdoX8l8pYAcz5OTW+r+/A=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
 with ESMTPSA id e003b5w9LCUTHC9
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 21 Oct 2020 14:30:29 +0200 (CEST)
Date: Wed, 21 Oct 2020 14:30:15 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own
 submodules first
Message-ID: <20201021143015.3bd7faff.olaf@aepfle.de>
In-Reply-To: <46f7af9f-4a18-4352-dad2-cc176ed890e1@redhat.com>
References: <20201020091605.GA2301@aepfle.de>
 <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
 <20201020094419.GF287149@redhat.com>
 <0e196d48-6735-5116-ade5-a9b138020aea@redhat.com>
 <46f7af9f-4a18-4352-dad2-cc176ed890e1@redhat.com>
X-Mailer: Claws Mail 2020.08.19 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6P8iGFBQnj_edaWAxYkIk39"; protocol="application/pgp-signature"
Received-SPF: none client-ip=85.215.255.25; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 08:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/6P8iGFBQnj_edaWAxYkIk39
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 21 Oct 2020 14:05:18 +0200
schrieb Laszlo Ersek <lersek@redhat.com>:

> Olaf: if you build QEMU from source, why don't you build SeaBIOS, iPXE,
> edk2 etc *also* from their corresponding pristine upstream clones /
> checkouts, using your own dedicated build scripts / packagings?

=46rom my perspective it is like that:

I export xen/qemu/libivrt into an offline environment for building.
The "git clone/git export" is done without submodules, but each required su=
bmodule is of course cloned/exported as well into the target directory. In =
the end it is me who decides what is required or not, which means only a su=
bset of all submodules need to be provided. The build process sees the comp=
lete source, and as a result nothing needs to be downloaded.

With current master there are these two offending git commands. In my envir=
onment they can not do anything but fail. I guess once the next qemu-X.Y re=
lease becomes available as the usual "qemu-X.Y.tar.xz" release these git co=
mmands will fail as well with 'make -C roms efirom'.

As said elsewhere, the correct approach might be to check what is missing a=
nd download only these submodules. This should take the existing configure =
knobs into account.


Olaf

--Sig_/6P8iGFBQnj_edaWAxYkIk39
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl+QKdcACgkQ86SN7mm1
DoBMXA/+KjN5xksox8C70o3cA9kg2wUz8XVJwo0dQZ3sh6ckAm/Uz+Z+K8g7D52n
8OPGZc00qt7w76uaOz7A+7YvUuTlFHrIQTE294zjs2I5ha+Nb00mhfRsuAZj5hZw
Hqss7FNTDMRhodmLIjzZvnE5ILrgGH8Y+EaZ/098GWSZ7icrn/akKU5+EwcCR+qc
BtXSAzakpjcJp8mn7Rw4V1SlKSWP1e7Y7SrDIUS7/X6zxD9Id+GL1ZB6pef/ZiMH
0UCqv79j5HHxa4s9BQ0p12sDIotAJRIegQPRaPZ9X1xAFU+G9Xn6u01Siwy2VAxT
bBG+PxW5+YzPusf1uYCSnqBC6tKmGMZEI2qEHpiWgTXJDilga061Hrp8dWKPUES+
PgBXHZ1v81W3R9mSHy8qY+vS/2vGS8VGUNGxi7mwYprgr9sYx7xwN0tU6HwnY8ro
Dx9psva3ip3v17reL4D9vpLSq1Zgl1vd8EGDbSrgMmjf2glt3wfqm4NiF2G8tN2K
R7idna/jwhE5Mj3M1NLKkORfs/ygn2CnhncoWGc3kXfOruZot8xSJ1ah5kOg87kR
cPeRSvEX7NTP3nsEtdu+8ixWJ1z5P4uffneBqH3ySUNMkJoH2r6OKknHh0r2psMx
GbfWMfte1lLiucfbw5nrzyGstu09fLawyWuKPxB+MqxKjozj3s8=
=1ma+
-----END PGP SIGNATURE-----

--Sig_/6P8iGFBQnj_edaWAxYkIk39--

