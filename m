Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FDEC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD2F2070A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhboJshH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD2F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAdH-0006IJ-1M
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jAAcg-0005to-WB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jAAcg-0006Xz-0m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:54:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jAAcf-0006Si-Qm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:54:29 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so1800292wrn.6
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 02:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ty91UAM7hwMYXU1bLpuTftrHDBEENhgcAyl1PfJUQq8=;
 b=vhboJshHz/fZOWiKurq4YaRFTuCFcaC9beC53glqJtupw4Saoy05hJqMkJ9Eu9NeBm
 /SDlKLtiSuc8AWyZnc5JEtrwD6JtYnSWp9peR55tGs8dNW8NsDVMeqIeyrqEoWyP8WET
 MakwkJLlWftgl3yfEJv/BOnQ6xiRMc3B8CZZVSHyx/UvzSOm4+trNemA0tLKqPK5Ja3P
 agPnh4m4s4iHA5Oe8qQRymeSliSGlTHcrskyW3OzYzvFxrQDxPPeZDw2/DEQxyDn5OS6
 zeHcWxlWcCJHGrBY1Vb5+wUR/T6NOEWzC2bHVDlqaP3vbnWdgoRwBWYn0lgyZxvuDI5w
 isZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ty91UAM7hwMYXU1bLpuTftrHDBEENhgcAyl1PfJUQq8=;
 b=sBZ6pipPH034HFZDM1Q2dlVywET0z1WqiqHP9DwPacLvlttOcqMF8OoDMNhFF6ftSD
 wZbTB7Lgaq0Ha11dFAsPDrv6S1gu6eTmyGM0/zLMIpAPh/hBq/8HyqvskSEairH4i0iI
 UV25MYrIxiMSHu8XFzYsA90vpiwsLLfRQ0TqAforHEU72F30G1ngxun3PpLL8yT8p9BF
 aq+gbZIfbkmuIZhwXbJPTguM/bB9bejfWMSPTo5sGEw8T4HQiPFIWXPHX48qH/TnNZ1/
 OjWDxD6eW2AaUgXS3+HhnfVGPFwwcDo8xN4Q5l3KsXEeILff3ES5BMqjMmgU18aBfkEd
 5DTw==
X-Gm-Message-State: ANhLgQ15OTjVgDXeld5r7QWEL7POEc00Q+J1x9OrTDCK1rIDr2seblgJ
 t9MOAV0nwo73aBQCd4vgtWj2CeW80j8=
X-Google-Smtp-Source: ADFU+vun6t25bsilYBBvqqzSgW/wxOWbWo4RIa2n/ohahjj/nm09oJN4oX2S5uDjTXCK+FMJMcDQPw==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr3520380wrh.121.1583492068562; 
 Fri, 06 Mar 2020 02:54:28 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g187sm15341296wma.5.2020.03.06.02.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 02:54:27 -0800 (PST)
Date: Fri, 6 Mar 2020 10:54:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
Message-ID: <20200306105426.GH1335569@stefanha-x1.localdomain>
References: <CAATJJ0L+jdk3ggWx61=AGoTd-FZ64tJ1tzPK8Frgg9Ez+dv6XQ@mail.gmail.com>
 <20200304093946.18682-1-christian.ehrhardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline
In-Reply-To: <20200304093946.18682-1-christian.ehrhardt@canonical.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2020 at 10:39:46AM +0100, Christian Ehrhardt wrote:

Please start a new email thread.  Patches sent as replies to existing
email threads are easily missed by humans and tooling also doesn't
recognize them.

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5iK+IACgkQnKSrs4Gr
c8hudgf/d0qDq7jUFqqAR/mGKtq4mzxhL2XTOM8rEaV1xQPu/83sjMc6tFMrNnS9
mAAwd4xV5qTCfGUm5WeX92shN+z69+Sc+uzxAwrGzmS2p8YQRAurmc8pVutIBqhq
svXAaByUk0Va0y3zI+d1udeLxU9daOc5tnqZbENyUqBbawcO8KgohrdzgYesPNx/
sOE2Noq8mxY08pASYtFCmZdZf3Sf9pjOodRb4mtfRjGNLJ9AfoU3O/BIoe1FgCaV
XsH8K/sCSwlfl0ygpH1HUqXoVBEocRLw8iIwsP6k0ljO3hFxCDe3iRSq7r6H/rfn
mULkR54ELrWgo/P8nbERmk1ESMf0cw==
=J1eQ
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--

