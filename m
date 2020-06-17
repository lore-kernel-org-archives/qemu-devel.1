Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE73C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF589208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvjcO6vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF589208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVjI-0000e8-9e
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlVhr-0007Wg-RU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:54:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlVhp-0003jd-DZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:54:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so1838863wrt.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zoWa2zzk0/uUmGPJtdjO8zuI4L0r2C/p+Mo7E6u/ciE=;
 b=cvjcO6vnpyWsL+ZwZVBiZ3G3b/CW4F2LDGKYkdEtrXeJe572jnqw806URcP/TLI1Dc
 Ed+tEEABBMOiNGRh6lglJUZiRRPXKGg8p3S0dH1z2IHy6Ep0cY//p9b7qibV7FAcxInK
 6J6D+Eu66kHJtLMZPX68dXy3C62WPWQjavSLJ/nHs3JcMvTPU6ntTWBeSB5TOEjRQqmf
 ZM+j0fjZVqb/2hFgawNE228JAMPpnW26esMAA/L8JWSJxR5TIiAd0C6DCVvU8uMwDkgr
 U3pRHX0eRq0msTeXRn4MzMQGVnI7M7jBfs60I3ozdDbEn7gt0D/Ks8eqnPxd8SwhCzVW
 pMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zoWa2zzk0/uUmGPJtdjO8zuI4L0r2C/p+Mo7E6u/ciE=;
 b=HJSN7bfib1kIMaKWcD51/7sej5g1VZX2NrAuJNq80j300ZVoOQFHudWTfinAQIe50C
 34x6YSdBly7oDqGWDB6PSg8niwrSZIfufca998tu/Zojl5YdeXvNYGHzqaDAVhwucx+5
 F6lgzR6JeC361i1h/8pfMSQYjgqf+NTuMyGjzvHLONY11UbWTmxknrFoEolteqfwtBK0
 zXF9jth5UYoiskeLv0JkaY0kTPfSXfkri4DK6ivd4Tt/2p3q3AQi0ppMYqeLy1e0zGqs
 AFwQrgEhEmNh1F7xLF2vYwsD1UjAPBQzTg655qlvO6VmUIaZVyu2iJRR95SQ62vZmROM
 OkmA==
X-Gm-Message-State: AOAM532LrSWe3Uy6dR6QXLObRDuGjJGwORoSWMwumPmeZMhjrMTAMlBP
 7dKew6wCRH9zl3yJJnYc+HiMAg==
X-Google-Smtp-Source: ABdhPJwze4D0D9iPWBr2V3SCMM7NyYlcK7C5JAOp3WT5GHLAxbQKe6oL5X+QWJH0d6krx9mpLJjaOw==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr1269610wrp.32.1592391247521; 
 Wed, 17 Jun 2020 03:54:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v19sm7693542wml.26.2020.06.17.03.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 03:54:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C97471FF7E;
 Wed, 17 Jun 2020 11:54:05 +0100 (BST)
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
 <20200617043757.1623337-3-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 2/5] migration: fix xbzrle encoding rate calculation
In-reply-to: <20200617043757.1623337-3-richard.henderson@linaro.org>
Date: Wed, 17 Jun 2020 11:54:05 +0100
Message-ID: <87mu52x8s2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> From: Wei Wang <wei.w.wang@intel.com>
>
> It's reported an error of implicit conversion from "unsigned long" to
> "double" when compiling with Clang 10. Simply make the encoding rate 0
> when the encoded_size is 0.
>
> Fixes: e460a4b1a4
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

