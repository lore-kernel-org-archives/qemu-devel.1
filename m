Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A48C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7292073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7UFwFPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7292073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLwu-0001UB-P8
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jKLvp-0000uE-PE
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jKLvn-0002Dz-Iz
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:00:21 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jKLvl-0002BR-KP
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:00:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id i19so7624586wmb.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oCm+0LEbc1iwPzx+wX4ntJSMpCei6Y8jzpjA/9HVd4Q=;
 b=O7UFwFPNXNFOFCAMynsyn9jYCsnBUb/a90gakYzS88k39J3In2SmBftXVWaAy2kXM+
 VTmesiZmfXR5JBhtkZ3hNass7mwNgJhRALEbVCnBiFywqtApbJxFeaj1FCHgUN+yWDZ7
 k3s8j0sea/rAW6ZnUzxRq3cSaVWwHm93YcBFfi3PWTHQZS48xpuwYQ502gQMJ6We2/nD
 84a3rd4ZHQqKYXrQUCaiZFFRRBODHpe3YIG+NFU7YVrZYl9+NoEzNrbvEPumJ1cLWDjU
 crOdaxRRzbpT9KANToJhHz7A2aVz5I17k/z8QXlAJHY1AZVSYWKgF4KZVJi9snbvYSmf
 NZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oCm+0LEbc1iwPzx+wX4ntJSMpCei6Y8jzpjA/9HVd4Q=;
 b=LONpdBGGaRC8UOs82RY4oP0RICzt8J3dWETy2xdKQ+ogsRpcqt4JPF+cQ1uGaiRoWU
 3RcUIVba3wRZsNjhm0uWnO9yQOaoXnK127uixFSf3HxD6MiSontJwEtsAi5AVp5StLJT
 F3nbgUnGHUvVy07sKIZoAP8EMskBgTymmVmGSQegs/rP/kt0Wk0iZ2R/7OQr7RRibSYp
 SUl5LAerS4qkCAaV2ssSg3HB+qF6HQ714DJhCs2qksRJx31RHgfKLNF3jg4b7bC4AGm8
 p4tV6EEh4OYs65HU48qONCXblU2uEiyghx7HwksVTnb0G2UTvyuwTRGwP/AnDr2sClA+
 f1xA==
X-Gm-Message-State: AGi0PuZPNUw5cA8DmzrhqiufP96IIs9ZHHDWyL1UM8eQrEYfp+LVSQ2C
 fQsFB1Aw2Pj6FtH94tzUmOVSk4vv
X-Google-Smtp-Source: APiQypL9IEE5V6+XLLv/vHKeonGvnwqCf6Fa8bjMsfEb0vMRrzn2TNMpDt76CdsajHhQ5JOvXECCiA==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr9050795wmj.156.1585918815884; 
 Fri, 03 Apr 2020 06:00:15 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i2sm11948038wrx.22.2020.04.03.06.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 06:00:15 -0700 (PDT)
Date: Fri, 3 Apr 2020 14:00:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] lockable: Replace locks with lock guard macros
Message-ID: <20200403130013.GE146016@stefanha-x1.localdomain>
References: <20200401162023.GA15912@simran-Inspiron-5558>
 <158576745359.20436.14792001046810935798@39012742ff91>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <158576745359.20436.14792001046810935798@39012742ff91>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: dnbrdsky@gmail.com, singhalsimran0@gmail.com, jusual@mail.ru,
 yuval.shaia.ml@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 11:57:34AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200401162023.GA15912@simran-Inspi=
ron-5558/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the asan build test. Please find the testing commands =
and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 NE=
TWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   CC      x86_64-softmmu/hw/i386/x86.o
>   CC      x86_64-softmmu/hw/i386/pc.o
>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
> /tmp/qemu-test/src/hw/rdma/rdma_utils.c:74:5: error: unused variable 'qem=
u_lockable_auto__COUNTER__' [-Werror,-Wunused-variable]
>     QEMU_LOCK_GUARD(&list->lock);
>     ^
> /tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from ma=
cro 'QEMU_LOCK_GUARD'

This patch series depends on Daniel Brodsky's "[PATCH v4 0/2] Replaced
locks with lock guard macros" patch series.  I think Daniel intends to
fix the unused variable warnings.

Stefan

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6HM10ACgkQnKSrs4Gr
c8jLRQgAs5oPwdABllSojpMc8aMbQYfF8cmxAE2vT0n+EXq/4oDfWfBdnGwpqM4v
JgHFweQovaC09fRz9+fYu8OJH5TbyYUd4mlzxD+IUvt5u1TzoyndFVVvNc7bV20q
n36+pZKNQUwAODQzSrRr61P11cIoDNs9f0bJeqGHFfyDDExbtovwz7t3CjuhRe0R
luQ/HeUbl60l1tf+G1IPwj9wBNNjB+7xDLieJm+V/cqYd9zqsaC2m9QDVpYspwUX
ddYSx/hN6dWCUjxGR/wlXq4mjzr+nwryrxHl1HINnbuhg5EaoZc3U7LsUninh0Ux
720n72Q1lQvFJRwIa2qugQpZEx8VGg==
=m1fn
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

