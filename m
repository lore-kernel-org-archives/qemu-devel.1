Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A1C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86245221E8
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP0Occ9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86245221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVhU-0001b9-OP
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVga-0000xe-0E
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:33:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVgY-0005zM-18
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:33:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id w2so2429772wmi.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 04:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zACBbkyoDMQvkjs81ee4kpE6MrjpE9NbVDn9qdgYmck=;
 b=iP0Occ9ww6afWly0Vb21tI24Zk3pCjrC19Ge+99yq1fiQ0B5GBSFe5NSQ6TL7ale0S
 N1CEpudLGRP7BvbNiOvt9Ez8XkLSMgOgOIn1+PlAddVvxCNZMJyD5Uh1OXWil4ySEH1+
 F/uk/T8mS80tn3eGZ52zdVcNWMYawCTgjaVvSu+CIUtty7lUV1DPhBqxJCinSdXPvMPE
 hPVk3iboUr9JiluRLt1/qKF9aLgnaAhg1Nhb2vtJoSmThFs7Jqn04A0yrF0ZIa7NXkAR
 /WKaYzjiqs1aFWxiNiB+TqcRnCZipIPQuGeh6ynJCNaBuYyTivmyDbtOye3fuLRVo05B
 +BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zACBbkyoDMQvkjs81ee4kpE6MrjpE9NbVDn9qdgYmck=;
 b=SfBETE1GD0cvjHM6JVug6hxe7Si21zSaqBDxS6x/BxWndB9EYpFwFU+OSxQDKG9dzX
 DEQmZLYKVjf6oaCvihhWno7fO3lME3ZGYbRgeTx5J25TC9Qt61hI3IixHsHeJHSTRj5t
 iAE/w0gvH6OSg8oXCK4A1UqFdIAiXS7AH8jpEpBn1We9HFOiYXocJasE8ywIlKrdkh2i
 /7GthJSojRV5oCEPibKQQ+VyTGbFMM9D2apqy4HdTbVMfgJogp26qCt74rrSySkHoBu0
 PtDkMktz/JCfKxQJGpsmiVV/sgoYPouycYqKLwo06WNs0RlCnP/s1d2aM/3jkb/Hmvuf
 Yu7Q==
X-Gm-Message-State: AOAM531Am8Q4S8X3lDaFAOwvCeGIBG4wi1aVMGMLDgqI6CcODyNyWjoX
 BnPVE5NBBIhwZuLNvXAvpUY=
X-Google-Smtp-Source: ABdhPJy+AKc8XXy67Ek2BgrZ6CcX9jNMAxJ0uG4DX6zi3H9jjvmiMJ2f6vCYVSgdpFt51PPEkOg/5g==
X-Received: by 2002:a05:600c:21c4:: with SMTP id
 x4mr4341001wmj.107.1600255992504; 
 Wed, 16 Sep 2020 04:33:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l8sm31777385wrx.22.2020.09.16.04.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 04:33:11 -0700 (PDT)
Date: Wed, 16 Sep 2020 12:33:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1895471 <1895471@bugs.launchpad.net>
Subject: Re: [Bug 1895471] Re: compilation error with clang in util/async.c
Message-ID: <20200916113309.GD756728@stefanha-x1.localdomain>
References: <160002337216.747.16078826830052525094.malonedeb@chaenomeles.canonical.com>
 <160008073620.20744.1634136206585369571.malone@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline
In-Reply-To: <160008073620.20744.1634136206585369571.malone@wampee.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x331.google.com
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


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2020 at 10:52:16AM -0000, Amey Narkhede wrote:
> Ok. So I attached the util_async.o file below

It looks like you can work around this issue with ./configure --disable-linux-io-uring.

I'll investigate what can be done to solve the interference between
<stdatomic.h> and QEMU's "atomic.h" next week.

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h9/UACgkQnKSrs4Gr
c8jb5Af7BFFcAJdYZsfI/AW/GRuEL3EKBFJQZIqM2AHoiDB80TFChQd9JqWChEO/
BdzVEvXiYsMTPTqNJ3OOK3FtcOxZ1r6R3H42oj4KpHL/j3D8JH2GgSIKtfzSQbGv
T7amQLhCif1qitLfSvDr7pAVJ7ALqojyo+d1WRjwvOBxBcWwvsr1NXC1tLVyIPpb
DlYgEhmw55nRou8q5adoCpzBqnDAl1GwajVOfnS5mb4IT7Qvvp4JbjRI5V9J8YKm
a57dWIEX6ZXSm+9+DXnZ8nZWxgqJ/ZvXinhOexkBXVXM3+CupFYgbcMvCR2mlFdO
dSP8JDP+TfiLxczEJa+uPJN+S0YRsQ==
=7qFb
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--

