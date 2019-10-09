Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064FDC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C759420679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ0SMT/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C759420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHAF-0006EU-E4
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iICvc-0001Vk-Gt
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iICvb-0000GV-9L
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:27:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iICvb-0000GM-0j
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:26:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id j18so3257788wrq.10
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eOawJf6q/+UFwfOoRC9bwTO5px5t0w7SRVs0lKxE1ro=;
 b=OQ0SMT/Cb9PN78EeKjExIyl7xaHGDwYLOE28Q/0U9L66pEMldDp7RrhVkzYP2jey0h
 YneuDWaw3oTRWvEv/Q68sAGexHfUtjAIyu1wfQIWKMtT5FOUVZ6ciQPnybp0tzAV3joL
 SHEWiVHKvjyik1DzkHW41bK4mOeZSFzi0CVy2gecwGLtliFTHl/s0ltl813Md6DtdgA+
 orAwpgf1sTBO38PhMlcWWn2EPGKVc2o6y5/l3/P4WY0y6eDqikElYyOGRHjrxsf4gfFY
 IDOPiNAxpoG8+e8kmwKerF6miiV/TCpfopwnhrzrkvcFFg6Ts6svl3DP/OEbA2PxRHpP
 xB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eOawJf6q/+UFwfOoRC9bwTO5px5t0w7SRVs0lKxE1ro=;
 b=P9n6cGSZ/J7Xm0bAHGTUwel+4IXtJ/rjSZPAEAX9CIW0rDIAf7jbUWuo24zjFArqEg
 RZNWQ2jOyPsb8KZj7xF3FQH72m7lRXlVtA/xMckNBIWp4lD5j5cTN/wzyjtcezm6m8Eu
 qZbqRYob7h6gE9G0KXW3fWAuxWUf3bhqx+EJAeFjr6I+m0KP6uBCgnoYWNC6SZE+QGor
 5TFAdFxuma2TZh6fBUO5aiCcMFTEC2XQ+aWwKVNlIdQNRICd9+uwyXEEpz9QOtgZKQeT
 NIx9IKZ8w21nvgGGbg/tDHcRRwt62knBAMBNgMkJuAasMZoNTgD3S1i8Zkfx89ZWTIPA
 R5yA==
X-Gm-Message-State: APjAAAV+vbm7Vr3+x7uHMYvGxcqHrU+hgs9vBAcbc0IBRalPZIuj68tz
 +6hgtAL9Sr0gtgXJu5BevAjEDKpQqQU=
X-Google-Smtp-Source: APXvYqyb9wOHvSU02qB2MTTDsTMPaQEocpU4yrngd7RVH3XJwwgmfZSRgJSdVEQyqqpSthakEzULbQ==
X-Received: by 2002:a5d:522f:: with SMTP id i15mr3022102wra.257.1570631217497; 
 Wed, 09 Oct 2019 07:26:57 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c9sm2578736wrt.7.2019.10.09.07.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 07:26:56 -0700 (PDT)
Date: Wed, 9 Oct 2019 15:26:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, rth@twiddle.net, alxndr@bu.edu
Subject: Re: Qemu/KVM fuzzing - next steps
Message-ID: <20191009142655.GT5747@stefanha-x1.localdomain>
References: <20191003104928.crwjanhymtmwdboc@starbug-mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cUjMc5fB5G+GsIM6"
Content-Disposition: inline
In-Reply-To: <20191003104928.crwjanhymtmwdboc@starbug-mbp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cUjMc5fB5G+GsIM6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2019 at 11:49:28AM +0100, Darren Kenny wrote:
> How would you like to move forward? Is there an ordered list of
> device or machines that we'd like to focus on anywhere? If not,
> could we create one?

Feel free to claim a device (I recommend either a popular virtio device
or one of the on-board i440fx or q35 devices).

After Alexander's patches land I hope we can figure out Google oss-fuzz
integration so that QEMU has continuous fuzzing.

Stefan

--cUjMc5fB5G+GsIM6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d7i8ACgkQnKSrs4Gr
c8h3uggAraQbbffXElNsYeYetI3Hjl/7LiLnc6Mh2N2dWRTeR4lXHxHkWdgAB4Z7
HiAtOJpkDiSZ84Ix2q/YR9FeVJ6fAjZ+oE2cSvMMvQqIhTS69q0fbPwljxtzr3Jt
11WXkPy9G8FtguSscSWsO0xjwLVZ/fhJ3ag0idN6EVsfiTdIG8S4TDzTKa0cBQpY
PNK623s/v/FaU5Y2RDDfeMkHzCfDzMNEwLUA6iC06ZozGnqWtt5b9Ky0nSHYHh10
EcvJ6JRsDnKcCJOQL/DESmwM18SLD+MzRl9J/zY0ubJpbCzqoh6w4/YaP6IdnzKN
loR6DxdJ9CkQ2utjSq3LAY5eI/P2uw==
=/QYT
-----END PGP SIGNATURE-----

--cUjMc5fB5G+GsIM6--

