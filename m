Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9536020828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/xuotIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9536020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2uTW-0000Cb-Os
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2uSQ-0007mM-3B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2uSP-0003ru-7W
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:41:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i2uSP-0003rO-1J; Wed, 28 Aug 2019 05:41:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id t17so1035141wmi.2;
 Wed, 28 Aug 2019 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8tHbk/7GYsEkuYImYs5vaayJtUHKlUGQ4VmQCbalpBw=;
 b=B/xuotIRY28BxrSufCodqVFl1B/+2kONJwxprNnTBwh+t2f8066MXjxXkick2O0Loo
 pHFvCuKwvl+P7rRAOY0SWM9AZJZOblvBcoLl08Tu8k66Dwlb1/ai4Soss+qtZJ5LUAy+
 lMoq/o7nComv4xIX8upTZj5xVzyyDnx3ZkOx4YAmWasgpWv6wCrrNEV7ML/FZQFaDEyl
 snUexoRu6oUveT9r3Gi/um7Btpc5nwRSEWNQkBM4kkSocvEACMEm9hEOTwwLkVsT2Psd
 7tCa0WmgSYzg7H3DYyYd8k5ZYs+h1+CACi0kEh/48DMWr/q4P9BJG2Z+g++X1Abv7Lr5
 0uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8tHbk/7GYsEkuYImYs5vaayJtUHKlUGQ4VmQCbalpBw=;
 b=W9lw1fpEqRXZC0pcAg7vEAzhMYRmm0DndxieqIzcYaq7yG0/2MAlGuuDdXZ3oo3HZg
 pWtwi7cxuWHp1YhQq2pm42FcjQpU7LyAkbgefUWDtP6cLVMFbFAYYcDPuRQrsBq5GIXK
 SBwbY/lY594MJSmScjZXGLdXw8fb2J/tjXEy0jiJ2K8lqXfSWknRUnX523YaW2hBRdUJ
 /BGjWbII7w0REizwf5TWLoy0SHV1ann1pr+lewZvonoo4pxuc9ert2lHzcWpkgavxEwt
 lIPD6BShCHbvn1WMbVyW0MpnifJR9jFUbYJ3+Fc4IlDWvO+mHephdTLiNc/tSYRzJ5fH
 o6tA==
X-Gm-Message-State: APjAAAWsnNHBrg+f10+QClLMP+ERDPj+iKsYMaWLZTK4DC6FagSb8HUP
 eqFb9FjsJBi1cGXkXOdH+bg=
X-Google-Smtp-Source: APXvYqyVwRoyPN1rr/i/vnMQsCNJHqvQ4pszWB7GnHUmjCJwMwO2B0bMwq9Jh3gFWoMIw/xWduVENQ==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr3956652wmf.0.1566985295911;
 Wed, 28 Aug 2019 02:41:35 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a26sm2264353wmg.45.2019.08.28.02.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:41:35 -0700 (PDT)
Date: Wed, 28 Aug 2019 10:41:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-ID: <20190828094133.GG5573@stefanha-x1.localdomain>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 0/4] virtio/block: handle
 zoned backing devices
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 03:49:23PM -0400, Dmitry Fomichev wrote:
> Dmitry Fomichev (4):
>   block: Add zoned device model property
>   raw: Recognize zoned backing devices
>   block/ide/scsi: Set BLK_PERM_SUPPORT_ZONED
>   raw: Don't open ZBDs if backend can't handle them

The overall approach looks good.

I wonder if bdrv_get_zoned_info() is really needed since zone_model is
part of BlockLimits and is already fetched via bdrv_refresh_limits().
Was it introduced because the block limits haven't been or cannot be
fetched when zone_model is queried the first time?  It would be nice to
get rid of bdrv_get_zoned_info() if possible.

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mTE0ACgkQnKSrs4Gr
c8j2OAf/Y7DRpo9i37gHkkRfkYSf4WFSCsHeikL6dO2Ppt701E2BRzjreqizEnNh
+6YUrG+nWUElGcl8YhvJuRm3musFDbiyzCCYY21/TMa1pqDO82V3ZdyAIPNM1F8u
ITdFtdxWjBswdwZStd37zFBJ0/CI+A7jcHmWE021SF+dgf0/hLLFHDFnPnGpKzzQ
SWAiMz53Y3opZ94UokNWFARkORrnNRr+/4oV3kOx5PS2oV6WDnAmjq7iI9o9Rwd9
mVtIh5269gUhWjGq26Ahd8sgA5/qmd9Ra1BjSNB7m7a7LUfX6jhgh8/JUkOkjK3N
alnMzp/fsFHGC4vNiAVfR5hr2NjHfA==
=zDQG
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--

