Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCA6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAA12072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPt6SLEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAA12072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jniUn-0006g5-4o
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jniTz-0005kH-Jm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:56:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jniTx-0000Od-PJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:56:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id b6so20403174wrs.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nnpLd83bWklK2pNwfgBOgT20gPFk97hrgA3LNvh8Ass=;
 b=SPt6SLEcE8LJs7cvd99Kp1OntgQYSpuUMAfTFwOvobar5gf908RfLiT6sG5v7TVKtX
 P3d/qhyLszz/3Y8XHQw2kvO55ZTO6G8xFwkqdTSf8gghPhPwR/v3lJJwtqQMCzqqeUfq
 HK2pCtAAFvicIoP3Jj9eW1NLrKaoPooJOJUVnwYqCc3WIpfpXJVXGfex5sE+lAq1vjuZ
 nuRROdDqMYBVHCWWS6xFLZe6+CpEQc5dM9ioRbCyq/DRng9br/MokEn6EFvE3moZr7zy
 V2KNI+dBaAHPjiEEXqXwXV8xzZ7fZL18fpc/wpQ7RWuBrHAKuZ+U5oKTLRtSGP4vWpxi
 BAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nnpLd83bWklK2pNwfgBOgT20gPFk97hrgA3LNvh8Ass=;
 b=rFnB/CMUvEZsCNy0PMPcmhth8Kz9s75o046Hy1tdIHcfMLZTGyin8PQmLHUUIfGyRO
 nV1XUUaIcv1tIVckUb5diCC47IfGEz6bJPYz5nWFoii4w/jZyPHPisaHKCSxbO7h48Cc
 vfltH6+Zoj8YMJ5+xEhW60morEY0/csuXrukIDLikXpG7PyAtSRYYskshiDgRr79sxuL
 CNvSBYWLMzhc4O3xKEeijc9b7xRyFm8jUv3F3L5QOpX2rsF4MIMfsy74hXS6IEhhUtRu
 ETiVc1y5xRuh5lCacja0e0ks9UclqcnPUnjyynBLfz8ykqiIBgM7sabKLvlsS5ylsXvd
 xuog==
X-Gm-Message-State: AOAM533PbHFEfh7QZ22KJrcd3hr0Gv635OwbH9IgVrMs9fW813Oj2RE+
 icKNdxisfYbfTRbBooZgHVs=
X-Google-Smtp-Source: ABdhPJxPv85+2QJyNM1VOTadKPZEu/Wt36BooGztkIr9bcks5w4iTE0bBKY6EgYhBj7q2AM91dCQEQ==
X-Received: by 2002:adf:df03:: with SMTP id y3mr23792894wrl.376.1592917015831; 
 Tue, 23 Jun 2020 05:56:55 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id j14sm22543245wrs.75.2020.06.23.05.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 05:56:54 -0700 (PDT)
Date: Tue, 23 Jun 2020 13:56:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1882241 <1882241@bugs.launchpad.net>
Subject: Re: [Bug 1882241] Re: file transfer over cifs to 64bit guest
 corrupts large files
Message-ID: <20200623125653.GI36568@stefanha-x1.localdomain>
References: <159136023930.32294.17616621945608188739.malonedeb@gac.canonical.com>
 <159240575569.16985.2747320831416406615.malone@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Content-Disposition: inline
In-Reply-To: <159240575569.16985.2747320831416406615.malone@chaenomeles.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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


--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2020 at 02:55:55PM -0000, timsoft wrote:
> thanks for the suggestion. I tried using netcat (nc) to transfer a large file from host to guest, and also from fileserver to guest with the problematic i82551 emulated network adapter on the host and the files transfered reliably. (correct md5sum 3 out of 3 attempts)
> I also tried md5sum of the same file mounted on the guest fs as before and it still corrupts the data.
> this seems to imply there is something in the cifs implementation which reacts adversly with this particular combination of virtual network hardware, the fact it works with the vmxnet3 emulated card, would support that conclusion.

I'm not sure if someone will look into it because the eepro100
(i82551) NIC device is old an not used much nowadays.

However, if someone does decide to investigate and wants to brainstorm
debugging ideas or needs help, feel free to contact me.

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7x/BUACgkQnKSrs4Gr
c8gQ6Qf/UC2rZiT7cCFrZU/UtDP1PLa+1dwGe6tICd6gpaJa7CixhI/8W8dsPq1i
X6S/WCZlCniHG7IhxFl8k6yuPn/49GXC1Yme7rn/jYbM3ACikU4/2zIwuQgbzLQv
6Rtlikm2BrIeyoymhO75wlh2s9B9Z25IwfJwy/hoNNdc1ytJ/U6wvEwQwBVbqjwI
Rr5zN8ezvzihnCZYFQrpYbaCBsweMTCuQTXYGVAxvye2BYRRBkYuDwbC8GX1aW01
iHTYJ8hv9aqYdX2A2MzPjzEPZ+CPIDYaB+FH6j+Qs20I2+gKP4XGK3TA88HSLAv8
olS2K2DypNIgNnNOpjc/WJA4kLankA==
=Ej71
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--

