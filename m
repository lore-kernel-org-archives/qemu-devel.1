Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A6C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B35E2494D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="mN4xO4dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B35E2494D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLUMp-0006p7-A6
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1jLUM3-0005wA-SC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1jLUM2-0005sj-CL
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:12:07 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::5]:14252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1jLUM1-0005r6-B4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586189521;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=I6L8uP2Gr2/jvaRWYRF1hrPI+0rFVWAVyPdvQV8wrXQ=;
 b=mN4xO4dKp1v9g0ZVkRL34jhfEMsFvsUuV51Tmij5mrJ9K2BwfYaRkHVNHUUh+BDn6Z
 DF7gM66OSHjc7u6xEBh97M84tmNOX6iTQZWjAL/fklPJhjlME30SXA1MLHtMr0dyk7k/
 YTKwBozuYMCN+pftwR349K51Zqzqbrrw1+lKzlnQonarBbw+wUl40PZ8YcdXEzvf+hf2
 EEnG3i2M9lxrFZAC1a3ShIhYazLqkcCMcBLuAALR3Qi3ZZrKFAMlGS0T1owt0VdFkkzh
 HHGNQV8npGk//ZZrj6yM4oZoenAiwH6NnqA8tmdjyypEkaKsqoYI/lWJaXO3ddIYOgKZ
 rBVQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYMluXQ=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
 with ESMTPSA id 204e5fw36GBmcdw
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 6 Apr 2020 18:11:48 +0200 (CEST)
Date: Mon, 6 Apr 2020 18:11:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4] piix: fix xenfv regression, add compat machine
 xenfv-qemu4
Message-ID: <20200406181134.6aa4600d.olaf@aepfle.de>
In-Reply-To: <5da3f7f5-02f7-d338-06f4-1a14caab4254@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200327151841.13877-1-olaf@aepfle.de>
 <90544ada-060e-169b-c0cb-94d869070d97@redhat.com>
 <20200328070906.GA7942@aepfle.de>
 <5da3f7f5-02f7-d338-06f4-1a14caab4254@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.LZKqC83TBk4O4YVvDPsvQa"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5300::5
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
Cc: Richard Henderson <rth@twiddle.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/.LZKqC83TBk4O4YVvDPsvQa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 6 Apr 2020 18:00:45 +0200
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> On 28/03/20 08:09, Olaf Hering wrote:
> > On Fri, Mar 27, Paolo Bonzini wrote:
> >  =20
> >> Looks good, I would just do the following adjustments to have more
> >> consistency between pc and xenfv machine types =20
> >=20
> > Do you want me to resend with this change? =20
>=20
> Had you tested this patch?  It fails qom-test, test-qmp and test-hmp
> because xenfv-qemu4 is not blacklisted.  Anyway I fixed it up and will
> include it in my next pull request.

I did not specifically test your follow-up change, it just renamed variable=
s.

I also got failures from automated testing.
To me they looked like unrelated general errors in the testing framework.
Sorry if I overlooked the essential piece of info that said it was a regres=
sion caused by the tested changes.

Olaf

--Sig_/.LZKqC83TBk4O4YVvDPsvQa
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl6LVLYACgkQ86SN7mm1
DoAq2g/+NaHjoqCn47Q4Xk8dqF6scasIC+/MvglWh9Hl/e0L4rlCGgDhTNxJQOPA
T5TEo3qfiw8Jc8kclNRF4eQYjz6lwzATrr9Fxuqu8hogHfE6Ujjg6hzflggdxg1n
oG6u/Kw+0OcQtiESyPe/fcoGiMVC3q4r30sur8OitjvVW3v0n3hnbmwn8NhpNFrE
4bXFARdkAHgJbzTtcurOS5vQAeJ+6ctmqmLyiJml5Iz2IbT6td15o06OhRtCxUDe
FK8wIK1iVxHrPF5EEGI89kcVFGpBNs6mKG73NfUoCxjUKYCzldI8QqSvA0bi5Qwx
i8litFTnhlvKsVx6O7wLIyq32HHNJF8Ya2OJNYBSKFmV5hV7OAYTIIR9ny1qhx1l
JNpTkjGG4WEo0jBMz9p4GGlETg0vDKtXbvuojOYjWjjgZaujuMoPRSqv3TgiK3AQ
YZIsAWn3MIWZcSukIlQ7EsW2IBYzL6uxq6MCMJZHu2H7+AZCaH8D1RB/oyqe8+zQ
zYqEzcIEJgbhYZBCHeajQw3SDZYZ8iCCfLsfyfs2U+eF6lwZIZsksowZkjZvCYic
tr5UmfMQtyinrkmDLWdn7U/GHd38SAdAfr4imqQQZ2eCtviSP3sEdQLkper+c0C3
eNtYJZbMdgriKJo/GSqMoJaxWq6apgbSkJwKQRBknXOQo/jjENQ=
=9lpR
-----END PGP SIGNATURE-----

--Sig_/.LZKqC83TBk4O4YVvDPsvQa--

