Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0EF206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUwcGGuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0EF206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEkX-0000rn-JK
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEjl-0000C8-5A
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:10:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEjj-0006pN-Th
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:10:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id u26so13917110wmn.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CFLkkRe5R78zISyMfQx2iwT6rlTWBW7gfv/cT5N0YcQ=;
 b=mUwcGGuRlnX6y98hTxSP8GEdcHZX195Sq7EwqSbMOdWHuLKQ4vhaJ93b1xPwo7LjYQ
 sVfzAJ9zlEIxqpDIZZu158jiS+IrW3Bv/QT7QEZvBTYCRatstoYJcTnEm8TLJRGOjwT+
 1/B4JDhOQFj7ZTt/hUpg3rPMHt+SKCn6ZOZrusy6csm+PKvG//8D8SQkpvbtyxK/T6hT
 nl1eP0xphQR8FK7EgYF7Q+fQXInFEygewM7iwXEVZils6kD8Jel8rgmv3HNscTS+Bjex
 0AXN5/sK+eDWONBro3Qyck+EuuNjzRVXeZKj38B6HLGxIjfpPlbnm1s3KbEvXR5TB/V2
 BsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CFLkkRe5R78zISyMfQx2iwT6rlTWBW7gfv/cT5N0YcQ=;
 b=clgjzNp+vcK+P51RjHQr/KPEnckKKLzskwR/XmsYCcffAgxO2IOS3+PUY4ubw2S8/S
 TvzNGf8Xirdoq67tHICEF5rYQyUZMpnZDRKfMuc8T20YP8Pqq8ysovylz/vVx2ZpWtNH
 3N6bcxcqu0VKQCUGCKi19q5pgxAg638hLpCrb/x5VYxcuMMt72S5ZQabjRaBRPmx2nSI
 g1tBzNVVx/vlgnIE/9fCydkDePKKw4M1hTwxmOc2cyttTycjOjTzeM0jM7SBnniBU3tQ
 NWIvR3IqEtlNo02wSpXe99US5fwv/gUC9DFkZmbGtr34CzsUqs/XO7PGibnIVFBHkZuR
 Wgeg==
X-Gm-Message-State: AOAM530EsIRcW+SG5Re6Nryx3yYmIYWh/14kloBXN3bnnQwy2eK29xEH
 t05Bmz0x8p7KotHMJ1v1B1AGDRjX3a0=
X-Google-Smtp-Source: ABdhPJy83EDaTwyXmYVNjQ0OkwjlwF9Oyz1IOwlixj+xkUulYzzt9VYIPeEb2K3wV6q5rBOfOVoTqA==
X-Received: by 2002:a05:600c:645:: with SMTP id
 p5mr15227258wmm.156.1591611030159; 
 Mon, 08 Jun 2020 03:10:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c16sm8360096wml.45.2020.06.08.03.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 03:10:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2FE9F1FF7E;
 Mon,  8 Jun 2020 11:10:28 +0100 (BST)
References: <20200605093256.30351-1-philmd@redhat.com>
 <20200605093256.30351-6-philmd@redhat.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 05/11] rules.mak: Add base-arch() rule
In-reply-to: <20200605093256.30351-6-philmd@redhat.com>
Date: Mon, 08 Jun 2020 11:10:28 +0100
Message-ID: <87r1up7trf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Add a rule to return the base architecture for a QEMU target.
>
> The current list of TARGET_BASE_ARCH is:
>
>   $ git grep  TARGET_BASE_ARCH configure
>   configure:7785:TARGET_BASE_ARCH=3D""
>   configure:7795:    TARGET_BASE_ARCH=3Di386
>   configure:7813:    TARGET_BASE_ARCH=3Darm
>   configure:7846:    TARGET_BASE_ARCH=3Dmips
>   configure:7854:    TARGET_BASE_ARCH=3Dmips
>   configure:7864:    TARGET_BASE_ARCH=3Dopenrisc
>   configure:7871:    TARGET_BASE_ARCH=3Dppc
>   configure:7879:    TARGET_BASE_ARCH=3Dppc
>   configure:7887:    TARGET_BASE_ARCH=3Dppc
>   configure:7894:    TARGET_BASE_ARCH=3Driscv
>   configure:7900:    TARGET_BASE_ARCH=3Driscv
>   configure:7920:    TARGET_BASE_ARCH=3Dsparc
>   configure:7925:    TARGET_BASE_ARCH=3Dsparc

This seems backwards. We encode the base architecture in configure.sh
because this is where we can make such distinctions. We then:

  echo "TARGET_BASE_ARCH=3D$TARGET_BASE_ARCH" >> $config_target_mak

Precisely so the make system can know what it is for any given target.
So:

> +# base-arch
> +# Usage: $(call base-arch, target)
> +#
> +# @target: the target architecture.
> +#
> +# This macro will return the base architecture for a target.
> +#
> +# As example, $(call base-arch, aarch64) returns 'arm'.
> +base-arch =3D $(strip \
> +		$(if $(call startwith,aarch64,$1),arm,\
> +		  $(if $(call startwith,arm,$1),arm,\
> +		    $(if $(call startwith,microblaze,$1),microblaze,\
> +		      $(if $(call startwith,mips,$1),mips,\
> +		        $(if $(call startwith,ppc,$1),ppc,\
> +		          $(if $(call startwith,riscv,$1),riscv,\
> +		            $(if $(call startwith,sh4,$1),sh4,\
> +		              $(if $(call startwith,sparc,$1),sparc,\
> +		                $(if $(call startwith,xtensa,$1),xtensa,\
> +		                  $(if $(call strequal,x86_64,$1),i386,\
> +		                    $1\
> +		                   )\
> +		                 )\
> +		               )\
> +		             )\
> +		           )\
> +		         )\
> +		       )\
> +		     )\
> +		   )\
> +		 )\
> +		)

Seems like a replication of information already calculated in configure
and prone to breakage if we add a new one (or come up with some franken
architecture at a later date).

--=20
Alex Benn=C3=A9e

