Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829AAC388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC8922242
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsx5tsU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC8922242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvJq-0003BU-5g
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kUvIq-0002Ng-G1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:20:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kUvIo-0007Nl-W4
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:20:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id o3so1465998pgr.11
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OJaT/gWQ7CVQn/guZdW5cSvzxn/dmlhvAAfAg2b+hrM=;
 b=jsx5tsU8PvUhGh1xQnZnHtI645dOP3riR3Sz9ws3Lt75/GL7fzeUnsRu67LsMy74k9
 sqrhaB5hAcH0AiadaipyAvIWkYNXc8/dKAiuDhIyiEZwkRkliXW7Nj0NOz+IoxFyHYQB
 PCF4c/f4zVnhd2Nmj9aYUF5B8TrPmjyw15YTbEV+Gw/YPysRJo+aXv1+w3g7Dl0d5+JP
 1oZs4r8PVxE69N4gHUX8em6mH4Z/QNA6r672/9byhteHu+2duxMSOrasi3d5EiPad1Ru
 qiVpXKJ0i20wwja/Ji4Syx43lF8V84bCE1vWKFisUcY/hYbOxHJ8iFIQE1XhV1cM0uLi
 W2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OJaT/gWQ7CVQn/guZdW5cSvzxn/dmlhvAAfAg2b+hrM=;
 b=lUonmIAYQ5uhFX0gTN4YUEL7Hw4RVcFhepbnC4mf6+Rx3E8gkSdNxNOfvMdGuWI6Ew
 sSl+w1ajimBtNYFAjkO/AF2cOxJcXsYoVrM9zKFX22C2V7tC0h4EIltMt6RyhBeYn6oJ
 +IA8FXScS8LziHMN81H14zZNxW4YSw9+9ujEvlP6FoHtCvsnjHT7wMT/6RfV2CoAeb4y
 kHMZroAhSXE3I4SohYsyi5w9N7PBUmYlLUmlJH4SI4wgFLjBFEVhlxUelZaGhp3g3DU8
 FHhflHBJj4kGOGO4Gpgib0TZk2o8Q5rapRMXENpJYoK6kmY5PHv2hTrrEpjzYJ5EvAV2
 quUQ==
X-Gm-Message-State: AOAM531D5FXEaIDpP5Al1VMfTqnq1AJD/ggIBCrtsz2jvWZ8FSILiaFB
 rTios7ZN3Zig45xv2f2eNXPKlWSV1o4=
X-Google-Smtp-Source: ABdhPJzNbyZo7AX7U3/1QkgRamM1Y1mBHMhypORLXgD927dui38oiCORuqSFqsu6iMddBtd+7J03fw==
X-Received: by 2002:a65:5c85:: with SMTP id a5mr3676428pgt.145.1603214401189; 
 Tue, 20 Oct 2020 10:20:01 -0700 (PDT)
Received: from localhost ([103.248.31.132])
 by smtp.gmail.com with ESMTPSA id e5sm2937653pjd.0.2020.10.20.10.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:20:00 -0700 (PDT)
Date: Tue, 20 Oct 2020 22:49:54 +0530
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: qemu-devel@nongnu.org, ameynarkhede03@gmail.com
Subject: Re: [PATCH 0/2] KVM: Introduce ioeventfd read support
Message-ID: <20201020171954.gdvex7h7tsce5gqf@archlinux>
References: <20201020170056.433528-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="54lynyrd7wnargh7"
Content-Disposition: inline
In-Reply-To: <20201020170056.433528-1-ameynarkhede03@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=ameynarkhede03@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--54lynyrd7wnargh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 20/10/20 10:30PM, Amey Narkhede wrote:

Please ignore this mail. I meant to send
this mail to stefan but due to me being careless
I forgot that I previously configured git-publish
for qemu and didn't check the final
message before hitting send.
> The first patch updates linux headers to
> add ioeventfd read support while the
> second patch can be used to test the
> ioeventfd read feature with kvm-unit-test
> which reads from specified guest addres.
> Make sure the address provided in
> kvm_set_ioeventfd_read matches with address
> in x86/ioeventfd_read test in kvm-unit-tests.
>
> Amey Narkhede (2):
>   linux-headers: Add support for reads in ioeventfd
>   kvm: Add ioeventfd read test code
>
>  accel/kvm/kvm-all.c       | 55 +++++++++++++++++++++++++++++++++++++++
>  linux-headers/linux/kvm.h |  5 +++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
>
> --
> 2.28.0
>

--54lynyrd7wnargh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAl+PHDoACgkQBBTsy/Z3
yzbu8Af/VWob6+Qtimu+vw19ib97m4K5ZkzxTVOfB3h4GklzsxNI8OMg6EB9ZOBo
oKMx380YGDkSwfeGGANoj/vZ8ywb1bmmC2pl/0k2946br52ueGj8q9d4UFVA+d0I
tGUjZmbMfjpKsLCzkkMi+1Xbhd4gUuynEFaHBfWzOo89Y9hq+sYOlgEdlw4YkVhz
dHiU3sO1k9hLKzyciz79ksOog7I4sVIcvthuhgG0sbdxcYUXhwo3Xlff6uJktEp+
RrDbGIEoFC1ztl3v+mZZWGBvoZBFcM5UGAdtcfwyRBbuWQevxghGHiRBiM0Tuxi/
qFwJXtJdjWiCWFodsYNpfz0oJrQH1A==
=EyVC
-----END PGP SIGNATURE-----

--54lynyrd7wnargh7--

