Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD0C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E74206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZNRKMHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E74206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igqaZ-0002Fg-Ia
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igqZq-0001Vx-3u
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igqZp-0006Oa-0N
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:38:21 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igqZo-0006Hg-PL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:38:20 -0500
Received: by mail-oi1-x244.google.com with SMTP id c16so2563234oic.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bOiOQS281XKOtaM1Cfka5yGcYTvl+GxoBwrv7dXPzRE=;
 b=uZNRKMHNPtZbu+4KvM8MpcX4OG/0UGhqrucOETxh2Qn3b4EQ7GuAqmv3TzqG/FrOQi
 LxpamBdf+KRO92/tXtvaC8wHtOt0iC9HsfeogKO25dz20Gg1ADKL7ZVFsV8+LcODIXvj
 k61L6YX/Wt3bdGuwc7QE+NuAT1EUNuCCfBfuEaOxWCi6ZH5CDpXEl9cWy2zov54U3DNE
 4VJMBP2ypuHT9TvQzGyY4rTHuvw9aPuFpqWwHb+Jp3M9QyycjoFjPIgvg/Q1R3W6TlrX
 5KJOr05Nk/F7IyWhspXEgJJAeJXQUIzKOs7IXBb9bSDu/QMz7bxS91u0vFqp6OwRmUbo
 o+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bOiOQS281XKOtaM1Cfka5yGcYTvl+GxoBwrv7dXPzRE=;
 b=Cx78o5SUJvm3fvVtRQjgWyMPECu4nQlDjeCRlz2u6DRmvb0d+oZ4ZlBUWUVSEZGcEr
 SUjXeG75AcdwINifC1ph/uWo5/e2nmgFAIKvoYlWcrZmY8i1ofk30pfxN5/yu+s/7Gkx
 b91DlN0O8b/NmTS09bZJStXwSSf7cYalggKY5yVo5ODVp5hTghdvBr1xIpVaqN7G9tqX
 3laqWckM2qYRIiuFz9LAWL0+dM4K4A3yvOcQmKYNy2SDqMmdgiP4S+pC6Ydonyx9cnoi
 kwUqz0161A0lE2aq82vqKDWxsH5SQZY3sp9/gnd0UjSUJ5jxAS7125ZJOU3mSWA1GLsu
 L+tQ==
X-Gm-Message-State: APjAAAV/Pp6TtKyc/cZxJ/6Sbi8eNwb1QxtzsuI0vbZXPqUViLsxUg5B
 h6qledqoLD5gAttBpXdLh5X63q8ssouHemrZmy6K2A==
X-Google-Smtp-Source: APXvYqyTTxGrF/DBC+wnwjgOgqQgtg9ZauusSN/Nf8cHy6jYbWWOyLnaGadiTTHaQl3gjL8+WVUpOZsMDqpZpbnB48Q=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr9820741oih.98.1576503499739; 
 Mon, 16 Dec 2019 05:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20191212114734.6962-1-alex.bennee@linaro.org>
In-Reply-To: <20191212114734.6962-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 13:38:08 +0000
Message-ID: <CAFEAcA8aXE7aZXzVgVE9NxZgPug_M_QxJ+ngfjsncpOKKge8dA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: ensure we use current exception state
 after SCR update
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 at 11:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> A write to the SCR can change the effective EL by droppping the system
> from secure to non-secure mode. However if we use a cached current_el
> from before the change we'll rebuild the flags incorrectly. To fix
> this we introduce the ARM_CP_NEWEL CP flag to indicate the new EL
> should be used when recomputing the flags.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20191209143723.6368-1-alex.bennee@linaro.org>
>
> ---



Applied to target-arm.next, thanks (I added a cc-stable).

-- PMM

