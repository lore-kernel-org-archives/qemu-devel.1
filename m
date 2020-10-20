Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90037C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A71222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="RqWmEFqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A71222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUo42-00065E-5Y
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1kUo3P-0005dp-LY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:35:39 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:14634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1kUo3N-0006A8-Er
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603186534;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=c5dxMUrcRrDEr02ipUI6N/QKbEkGkqX40EsMniFEi0Y=;
 b=RqWmEFqONwDD7QeRxwIcrWt5GFhMaHi/SLfE4ef1hfG3BS0J4QlEi4ly2VjoStOi9R
 sQIaMsMrBE+F0EXBTE/qN9xELNCVkq8GfnbAPqGCs9N/HRmQKBDDHaH9CHd1s6+7bYCz
 NMHWc6OVIfVjE6ZG4CH8FC9rPsPrKCEZomKFy/0yDXk+TWBeT1isBk/+xVoaS0/rd6D1
 H4ppoLmPB20zPdBgheuh1+sqRpxp1FBlFrejzH1g1DR9I1sVKdbMedpZqLk8NunlvvYw
 hrfarDnEXKriaiQFiyzI8IdC9V6qeUxLZwHzoj+EltzxerddZT8QyXWt1/5QHX9Wt1zY
 809g==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDXdoX8l8pYAcz5OTW+r+/A=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
 with ESMTPSA id e003b5w9K9ZXB0m
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 20 Oct 2020 11:35:33 +0200 (CEST)
Date: Tue, 20 Oct 2020 11:35:19 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own
 submodules first
Message-ID: <20201020113519.2d11bea6.olaf@aepfle.de>
In-Reply-To: <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
References: <20201020091605.GA2301@aepfle.de>
 <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
X-Mailer: Claws Mail 2020.08.19 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gtbut2mncC2N7kvVfQfzFWN"; protocol="application/pgp-signature"
Received-SPF: none client-ip=81.169.146.162; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 05:35:34
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
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/gtbut2mncC2N7kvVfQfzFWN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Tue, 20 Oct 2020 11:29:01 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> The EDK2 roms are only used for testing, we certainly don't want them
> to be used by distributions.=20

You mean 'make -C rom efirom' is something that must not be done?

Olaf

--Sig_/gtbut2mncC2N7kvVfQfzFWN
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl+Or1cACgkQ86SN7mm1
DoAOFxAAhMttczprrTOOHaKrqrra+u756BQ9DZ5QtXnOSFYv/hPLxyobjyJKOmX0
q9b76BJgakv8GQUsyKK/dqm8vpdQ9SfG73cyd8X31f46sJbn6Rub+/4RR36p4IT+
3ULin40hQMtVCYxxctx22Sr80q367XxRI11vxgLeYJruWpPvl5ClmKurfWqCwPwk
Rt/b/GJ2UvxJjwhIQmmEHK5u66WzjGia+ASfnsapPXgn1mhprLApfksJa02d9h3s
jgmsYoTmtLIQcAxNfaUkcQMgvjIymWzpkhrCLYTo62C1BgXTmEnqoGxl64j1jnWh
3wgJDs4D6Qtepg4KOaXwItMBb6M/Jq0qiAe5kplCjjUubfIi/LBHpLApQDtScy4Q
2gI6pMEIwMmbIBP2qzz2h3yuQ6+qNATcqPtw3iskjKnOLRZKU21Zc+/4DbQ09tXb
jo/EJFCyx62wka5rN90VWfaSjgoIw8QzFUWawV7ZvHlyCgh9+z8Zumoy4VM4uNmI
9EKGU34AUaHu2GwxRq10mQ18fjXPuaJaIPybXGQQeGG6xhMiMVD29YEMUPtUqtyQ
uYAxIVL2Gq496E3j1nVVU/jFBRixzMk5sZ4hDNfmigm1DJXKjpdmc2QGdYZnTWcZ
NGl5G5jqNF8lMPSRaoL9v7wd3Ou5VZP0Sbe23vq2w4X1hMQUtTo=
=rSnF
-----END PGP SIGNATURE-----

--Sig_/gtbut2mncC2N7kvVfQfzFWN--

