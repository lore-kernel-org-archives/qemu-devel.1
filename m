Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801F6221E5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISEDhDy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801F6221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVih-0002WV-IV
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVhj-00020U-6K
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:34:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVhg-00066K-W7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:34:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id z4so6557053wrr.4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=39Yh7WvnMUHO8U2HwGDZ9APJKe/qVKadkuEKShwpdao=;
 b=ISEDhDy53+hWAG2O0i8wtcLxI0sCD9eUeBrL5RQt5y1G5c/SOlKHoUmlKluWVEgeVd
 b65E0V6/7CaCkalM0TtOgpkcfbR5mHSpiC9ygUGBlL0pFiXR/XYS+8qmgmOPHXYTzlNm
 CIE3TzH5fLRDRgipkVbUfEGgwDcwxE8NZiUh5N8Zou+FQgHpPY01on8/KdzQhFuVr2jK
 KKrZX45J77gAz9yQhrt2VB85utg/0d2EdHj2Bm80dcroX8rIlKwYiuAMVbUCSXzfmdVF
 lK9q1w3plqnw7aAXSL3rmKU0qBhrIom1Hgn/XaKX6kq2J3fRNi2ufwN6VjpOglPSWJ2h
 IjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=39Yh7WvnMUHO8U2HwGDZ9APJKe/qVKadkuEKShwpdao=;
 b=e3LKFE6GzD5UxW8EDmnuYe8F9hzbj9/uWPw8c3CrwAsY1rfDJZyF/Nb5kXXCIcid3W
 YSjOjCsrDSoeX2ddiEMR1VmYXbDMxMzJju/3H44M6Z77gkhsWsuyyWFBC8mUdn6BXz9m
 c5g6Muaf9vB2xNRXbPFiWNZvq2Ahmc2mh2k8Y3WzJvifacxpE9YVKMp4REHTbzzWzK4y
 BY9HwmiFfzAnjb+ZTYAr35Q6o65W3RLqqwouQuPCts/priyuD+N7Y1ggCIoiQIfSvXGK
 BvFuPPI4J0lXz7IldROzTzQzHil1i8iiy0ypxd3bTDN4KoAh33Y2IJYCeIUaoUzM2ljE
 j6uQ==
X-Gm-Message-State: AOAM530EvX4H3nnxwQp/NNi4ordRRQXKIlBKWN006ZbGV8bim8d42S+w
 z87FwiA478RMYRPDjh143QEk7tY8GxNNLA==
X-Google-Smtp-Source: ABdhPJyAAxp4/Yvap7+pl2nJ9DwOr6KXSyakR9e82HQOrIQ+MyStMcURJBgGyRkBpxmOsWyd1UpyBA==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr3349007wrm.101.1600256063365; 
 Wed, 16 Sep 2020 04:34:23 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e1sm25683077wrp.49.2020.09.16.04.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 04:34:22 -0700 (PDT)
Date: Wed, 16 Sep 2020 12:34:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1895399 <1895399@bugs.launchpad.net>
Subject: Re: [Bug 1895399] [NEW] Docfix: add missing virtiofsd cache default
 'auto'
Message-ID: <20200916113420.GE756728@stefanha-x1.localdomain>
References: <159992963448.16886.7579356964954187024.malonedeb@soybean.canonical.com>
 <20200914100806.GC579094@stefanha-x1.localdomain>
 <5d7c2982-4282-d521-82d7-196468b45fee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline
In-Reply-To: <5d7c2982-4282-d521-82d7-196468b45fee@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 02:53:57PM -0000, Harry Coin wrote:
> OK.=A0 First time for everything:
>=20
> Signed-off-by: Harry G. Coin <hgcoin@gmail.com>

Thank you. I posted your patch to the QEMU mailing list with your
authorship information:
https://patchew.org/QEMU/20200916112250.760245-1-stefanha@redhat.com/

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h+DwACgkQnKSrs4Gr
c8gLNwgAkIqE4kY1Wwh07wENPBfa2OuWJXL9sCcL6FZP0y9pP8AAPh3DvrUPE7wN
V7KUu5tmCzO9H2/oMk+7rdfpghMoutgdwODNwv9+0RwRYITfXXqsQL9Xm41RsJZt
BayREG/6bSI5xG/UuY5vI3lHGxxxpM3SwJ9jgjLDEJxQlisvYbbFubp32Re8luyg
5yiowAfrZnz5oOVBAAPuEZLsviV5JAbkJSc2DhE7J5z8YLmLV5orZTpV9yzVZRr8
VvZ477BvOJj0Vhre1e1SSu9uJDcGNpRvbGq3m8sz1hOkgsF1liu93cjehs3V82tZ
/ArliB4sLbSTD7TFJMcmZQ1teB8nHg==
=Xzp6
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--

