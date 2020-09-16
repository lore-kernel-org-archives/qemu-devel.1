Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D70FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED05221E5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcTDmNS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED05221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVcj-0005kq-9L
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVZK-0003Zu-4B
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:25:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVZG-0004zH-Ji
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:25:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so6545361wrv.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BKemsBXqykkoxsuHKetwSvyI2EBqPcQ2gtKOBVSKsKI=;
 b=XcTDmNS/RIfhUZCDGLyb9xXmbuO6r0CRl30/Aj498+dgbK/FwHzA7LR+2NaXMl1lI4
 MQ2hgomi2B6qGTJVaHOIc+f4eGm4aN2/UTkKT7A1IpsQobPFyvgpd7aQFeJ282A2GqW5
 B2eJybdKfBuMezo9bAlKLNrbYZmzzNpHxEgFRBYI2GovfK+e+jCaUaZY37t3n4lHTBuD
 uK3P1jRdIpROalW9tUQKvt4oK+F6WGu6Ps6fYtkDDUKXnuzBqVzBRZalDqfHfs3+brIE
 K0hu6HDuWIcf7O3DehOf+980Nj5PteDT6c1NRUJScuEr0j3gPyWfH163AJKmcquqQ92P
 AB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BKemsBXqykkoxsuHKetwSvyI2EBqPcQ2gtKOBVSKsKI=;
 b=skYiYjXQIp+sYdm3DVx355rnLToSQfxT5FYUxjwY9TjrXGQjPH60qljeVIZtqDrKFd
 xDUu0matuAKMnAfj1N+0B7u6R+yY+xXjn7uJKHJeE7IeCDgK17KqRq2XD0ZSmPGwXxPU
 pI4wRHP9hXHaY39FogORaZho7XIDV0oVyfbCiIb5/3NRhbuvFjKe+ka65YfsnoZcnICR
 EReHvW71BLKwCghTqCC9qWWxao8sPh1Q8Wfk7BZa4GR7feOlt9ft8PvcBn1eNPpUnMEA
 lsM/heyyNYU3xdDfybrGSoSVmgA+Kj4BubpbPZ+BKqQ19lOUmCYoHO1b2dfJBTY/BZWJ
 x1QA==
X-Gm-Message-State: AOAM531GjI6JHMEP6WdbLzZImuRsF/VW3OQiznGAB8S3P7uJ7KbAmwfc
 MhDzDcSM3KH/cQ7IF2rjuQskMwgmjOQeWQ==
X-Google-Smtp-Source: ABdhPJx2B/ID4UtXuihlEcPmtpokhviXX5UU3sJVUExbcwzZoXIuAL3Gx7H8VZTpeDGqReXTfEcULg==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr25220891wrm.136.1600255541227; 
 Wed, 16 Sep 2020 04:25:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m1sm4562825wmc.28.2020.09.16.04.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 04:25:40 -0700 (PDT)
Date: Wed, 16 Sep 2020 12:25:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
Message-ID: <20200916112538.GC756728@stefanha-x1.localdomain>
References: <20200913100534.22084-1-pbonzini@redhat.com>
 <20200914095753.GB579094@stefanha-x1.localdomain>
 <e661b2cf-0721-441c-3ce6-573b3eb7950a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <e661b2cf-0721-441c-3ce6-573b3eb7950a@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 12:27:59PM +0200, Paolo Bonzini wrote:
> On 14/09/20 11:57, Stefan Hajnoczi wrote:
> > On Sun, Sep 13, 2020 at 12:05:31PM +0200, Paolo Bonzini wrote:
> >> - because we parse command-line options before meson is available,
> >> the introspection output is stored in the source tree.  The output
> >> is slightly modified using the "jq" tool in order to ensure that it's
> >> stable and that modifications to meson_buildoptions.txt do not cause
> >> horrible conflicts.  This is the main reason for the unattractive
> >> diffstat (the number of JSON lines added is higher than the number
> >> of configure lines removed, though of course the latter are code
> >> that must be maintained manually and the former is not).
> >=20
> > Does this add a build dependency on jq? Is it possible to use a Python
> > script or even a command-line one-liner instead?
>=20
> No, only developers need jq and only if they add configure options.
> Using Python would certainly be possible, though probably it wouldn't be
> a one-liner as for jq.

I see. Avoiding the dependency would be nice but only if the alternative
is reasonable.

Stefan

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h9jIACgkQnKSrs4Gr
c8geDggAqz1zlbZWuKGU2gTYq+OL7sXswTWKJ5AtKjKmDqGtesPim1cZXPtq+K35
F3dFQLhPuS+O9IwFLhMlBe6ZN+dQ4NTi6izy0zg7ku2g3bslkPHRdK2Q/30v/txZ
NIlAOLuDK3N9MZUewM+m/35mesCbxgtqcxgOaAiFThwG0vD9jM1EVO6/43oVUI8S
pWbC+thJQY+493FzNDKcakuDR69u5kNAdhojdPDTYVSFcRfr+Ps3X8QsKec3OufJ
icZ09WdqikzhFP01Na9aSkvRpNh+2EMtnN+78DDUMc6noBcT8sTC34NuS1yLW/yQ
2jOjtc3lOUuY/MajKM5vu9pyTiWy2g==
=qGPb
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--

