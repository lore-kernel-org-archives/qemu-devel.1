Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B32CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25970206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjeHV7Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25970206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0lYF-00063i-EZ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 08:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0lXc-0005eh-Is
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:50:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0lXa-00048v-EN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:50:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id q76so1626635wme.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dWNJJNoLz9UIS/0Cb3TcWysCZMK0g7bf33xG1BTyyo4=;
 b=WjeHV7Ax3xdwKJ3wcy3T+rzcMofxp3DnRB0H27URuViDH7g0VtpBAyJCDYlqwhzBWw
 cSJiJdPOq1bMqkCtOfL+V+TPYbKlys1Hqszix0N2z+knfudoHtSODmoBcmS86SXAm6HG
 mbr4JWot2V8g4ePFOBB+ZgfrDy2l0CKy7GcSydsa2ki8/7PLdfojFt1NqqZsSSWmo+vQ
 xgJRanapPBhCPC54Tc6jtoMF5TI/dhVgqsN8ky3elECJVwF4jCucMAj2qXRrK8Me9jAL
 BFl9kgYLgvfRAmX+j7X/7c55UNmfoBkrATQun3vgS/O9DKKGRtwAaymYz0mk2S710lrw
 3Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dWNJJNoLz9UIS/0Cb3TcWysCZMK0g7bf33xG1BTyyo4=;
 b=c8go5VcU02d+QxDHvt05Rd29HjZG2G/i3ge6ta5b2tGVjgHgUcbJV18pJfZNMWBr+f
 1mT88e10JYzYKdpyWrgdZsZvcPGGO2ma/hRN6qLerL3XF0fjmHLsVNmw0V6q8voK4afD
 AZuuG/W2j9KKMnCtfS+1YYkCNfxin/LAuw8HZCDT2Hr2nRo9oUlaOyZnH+I7YSlYNjOz
 hPmpTxmJ99YjlAxt9sJmedYMohsIQ6DT9m/pHHkg+TIkOkI2V/dnpI4VTYAt81s5Wi1w
 KHVO7WlZV7ZuWFWighvkhQ0pQX2Rp1EvtiWa33fOqo9qrZJciev1OpVwRQA2Jf7MzwHL
 Ny1g==
X-Gm-Message-State: AOAM531q0E5GHHsGnQLyCYPQbKz+TJMR+QFLn29JwBvzbBUH4I6mCKd/
 KjrWTUbqz9DEwrpiA60bsXh8Saatfzdi7w==
X-Google-Smtp-Source: ABdhPJyUmbg5Lr3mQaA49pgb4m/GOgEy7V2/sg3b8TSu9Tx8+drF4XQR2moHoIUSd4EXrhwm43EQtQ==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr9260441wme.177.1596027036845; 
 Wed, 29 Jul 2020 05:50:36 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c4sm5142992wrt.41.2020.07.29.05.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 05:50:35 -0700 (PDT)
Date: Wed, 29 Jul 2020 13:50:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Cole Robinson <crobinso@redhat.com>
Subject: Re: hw-display-qxl.so: undefined symbol: qemu_qxl_io_log_semaphore
Message-ID: <20200729125034.GG37763@stefanha-x1.localdomain>
References: <3a19e8c0-215a-bc18-9817-450affec7f08@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PpAOPzA3dXsRhoo+"
Content-Disposition: inline
In-Reply-To: <3a19e8c0-215a-bc18-9817-450affec7f08@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x32b.google.com
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2020 at 05:10:26PM -0400, Cole Robinson wrote:
> I'm trying to build qemu 5.1.0-rc0 in Fedora. I'm hitting some issues.

For anyone else reading this email thread, this was fixed in QEMU
5.1.0-rc1:

  commit d97df4b84bc42613cf9a03619de453ebd0be30b7
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Mon Jul 20 12:03:50 2020 +0200

      qxl: fix modular builds with dtrace

Stefan

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hcJoACgkQnKSrs4Gr
c8jUSQf/QkBBlAhshzVUXYSJtdvvEfs2bG0sJx5kEUzlM7TqeCBIPPuXZMuo+oOR
K5ZpSNcKvjpW2Jv6Nzgo/7vVf9shcuQSDv3BZqg45TCtHypMm5AMv07nSrrliEF/
LUReTKs2jvpftLfWE98PFXmO+7djGiLKuD0Nn9ZbNDqKa9GG+5XnT34nTJ1fRAdh
Uqa6kMK//7yfStbqB+fX+BRfwFtO0dAKLznyqgh7KlAMCAYweK4Xu7OiDKvo6Uw4
DxZ7XCIsvVIf96H1PK4EwoD1Fcl3548Pj8spQ9iNSo2byB2fe/Z/y+Yc2dw/RBsP
4hGZWEIzq6qxz0s9pxoMCimjORjvqQ==
=9HGN
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--

