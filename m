Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFCAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC2B206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue/hFtBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC2B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbhtF-0001zz-84
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbhsY-0000eD-S4
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:52:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbhsX-0004uP-RD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:52:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so6044943wrt.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=z2fwFsGJLxMg88IpM5Dn/19a32GO79i9+5iBUkOayr0=;
 b=Ue/hFtBJe3xZR4RyiCR9BjoctdmR4Rod+AW8uJdJFznUlfjnHQJh/qdU2bBmKCwqY/
 i/PGk7daFdX0wyZH9Psg7bCnZDylIQZ4gfOMk0YJm/k5uDGGAyBpLgiLqFWlSwF8wCod
 NaMl1OQx2NVD2SeO45i5GzHiYGzQ2ngMX44CxQp/h2UMl6C7C/dl1S99XGR2DQRZLBJh
 yfkCFTiuJv98c8HA3JsuoOUlDOeLKCP9tBSGa4aWT/yuU0R5Ba8KklXT21Fd5PzMHROn
 GIbxEPvqGo2BUfNFx0ul0EhotUKKgexPC2uc32IvxrbMk7KePVf2tx7QpuejTSMt5Usf
 MaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z2fwFsGJLxMg88IpM5Dn/19a32GO79i9+5iBUkOayr0=;
 b=elXSMO4XR1BPp49sxoD5C+5Q9nu6xO/V37SOn6ehMUiGev3JxVjPrZohVwN7nL/ib9
 MFhd7Gh+hyNViEURei+r2ZXCdKK60Gc0sn2Z2A0AJpg0k6WJqU4dweCNC8FkPwOGn6zn
 j2juA9QXDMQ8mzZ0a9eDyQM+SG+2x6XlQNBAY+gi0Ay4zqWwEWZPW0+uZSI3mBeyoLbs
 /NwuvVGzu1nFkN9+AGSkG7kc4DHclue2DCA2owDBS4FmWTARZlev1hngQ1qAyj4RCxrU
 sf+fj0jL1npj1O1zzwcrVZ0Vx1DGIdx59czuVhwIi8VsiZkcauEZQ9kkrPjSgGLb2+8K
 OGow==
X-Gm-Message-State: AOAM531plNHZjypoDwSF6aP1/4xrNE41z3OWT/XhI0VEHpFHIMvE3A3x
 8jQLvJyElgw1C3t/rFxNTbI=
X-Google-Smtp-Source: ABdhPJz+2CDrVrEgjMPDeMEKzPgboc/gW36xlSsP9erpaGjq61wTYUWWQuMp5UrllBgsNms8D5kIJw==
X-Received: by 2002:adf:9f48:: with SMTP id f8mr7863660wrg.228.1590054759306; 
 Thu, 21 May 2020 02:52:39 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r11sm5754237wrv.14.2020.05.21.02.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 02:52:38 -0700 (PDT)
Date: Thu, 21 May 2020 10:52:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] configure: add flag to enable SafeStack
Message-ID: <20200521095237.GC251811@stefanha-x1.localdomain>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-4-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20200429194420.21147-4-dbuono@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 03:44:19PM -0400, Daniele Buono wrote:
> This patch adds a flag to enable the SafeStack instrumentation provided
> by LLVM.
> The checks make sure that the compiler supports the flags, and that we
> are using the proper coroutine implementation (coroutine-ucontext).
> While SafeStack is supported only on Linux, NetBSD, FreeBSD and macOS,
> we are not checking for the O.S. since this is already done by LLVM.
>=20
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>  configure | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Great, this can become Patch 1 and it can set CONFIG_SAFESTACK as
mentioned in my earlier reply.

> diff --git a/configure b/configure
> index 23b5e93752..f37e4ae0bd 100755
> --- a/configure
> +++ b/configure
> @@ -302,6 +302,7 @@ audio_win_int=3D""
>  libs_qga=3D""
>  debug_info=3D"yes"
>  stack_protector=3D""
> +safe_stack=3D"no"

The comment above this says:

  # Always add --enable-foo and --disable-foo command line args.

Please add --disable-safe-stack.

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GT2UACgkQnKSrs4Gr
c8jH1Qf/b04GO1zgdwlTQur57QOn/C3K0p+p/RwlOUKzVMPqFlsoBj/cM2M1tjfP
ryEg9/AbMPMxOUSXcDSH7NJWgQxF/RrXvTZ/c35rM/uJoPnBdta+q0e3KlUTLhg8
DaaHdpG7maP2N9sOewgZFan0FcUlqsnt8onvgZ8JxVMYEk4lJddsf2uJpmMY9W66
Hy9AJmI6mriTH3TPf1SGDs46hcRhYoNirMdl55cIshraq7xojyO8LrKvvi+9vVh6
Q992bxQVkZ2m3Qd2whNa48ae4pDQuCH3iJMzunFn3Xex1Pa/+Nz5g/2kYiaQMFUn
9pTi9hWSClRgzw0ThZ1JTTrWbfBA6Q==
=1M0l
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--

