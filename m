Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64678C2D0F8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3361B20784
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oyts7iMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3361B20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZwg-0006ne-Ba
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYZtJ-0003HV-GG
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:44:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYZtI-0004UF-Cj
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:44:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id k12so23158655wmj.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6hv6Z+ErM2Tx/RhfYkWQgackaDiVa+y6R62kWHd6a3E=;
 b=Oyts7iMKxXCUpW8TOcnr46fA2W7ESqPP+TnbbmjHpsRwPKktxl59fSzgYpXDg9snsF
 3j6LZml20RuocZyHMjvQBFIjqZgIANAgZeAh2Pgg6tXOfCDAMvJ3HzSxc95AfFMWaTnK
 ueSKux0mPha6dXHChKrKR3+LUhAkf37FVv9pqk/s0kTb9880FtLEWOZMzlLsENAF1plo
 4xX6EGgm6DNIAOBpVeRONblrrM5U5NM/1QgFH3f7cVAYiwa6QCHXV5PLF+Tte4DWUtRp
 EFkeFc9RrEm8n2t86JCaIb4/PhbBk/fQQiM43rVq7ZarUHp8Wz4+1A/SkmSyxW6SScjP
 93aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6hv6Z+ErM2Tx/RhfYkWQgackaDiVa+y6R62kWHd6a3E=;
 b=QIqErD9wbMCimg8IWOGS/fu8BlL5lGSP7qUk6ldg1n69sBLSXEnhZbn0fU4vPhRvS4
 mN6BjdkbbCzUaq+fMrj5PInhe4W76UwfVNen5uO5FFdfmdHSfqA/NcPaULTPP0qOxvF4
 0jHRt1m2SMiLcDhp6/zRZdOA5fqWNqoNtNj5Va0yUppCX/enzZgvNYWsuWdaToljdkUL
 1Ag9HNEPPW0nxWAv2OAuvd3+lHbsTLSCGclXsqtY4bo4cC94UaG/h2z+MMOoO1M/OEHr
 IFo/q/r18dmQG4Odi362fAn2i0QS3JwxQzappFCtHngFdzN03L09GZITNdFBPKCfWQG5
 dpjw==
X-Gm-Message-State: AGi0PuZpGL+R/IK/tseYdMb4Lf7Bs81byVndc20dDX8Rdu1Dkn2nmdCp
 oDR7WGKqaE6V6UifdnukaazfgQ==
X-Google-Smtp-Source: APiQypLp/8L+AA8czA0tacaHBGBGuCJxTJm/ORum0IC7FEMfm6hukYhIAtc9t+goSHvbozJJU/6ryg==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr37492346wmc.74.1589309070722; 
 Tue, 12 May 2020 11:44:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l13sm7617836wrm.55.2020.05.12.11.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 11:44:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 898C61FF7E;
 Tue, 12 May 2020 19:44:28 +0100 (BST)
References: <20200510171119.20827-1-f4bug@amsat.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/3] plugins: Move declarations around and rename
 'hwaddr' argument
In-reply-to: <20200510171119.20827-1-f4bug@amsat.org>
Date: Tue, 12 May 2020 19:44:28 +0100
Message-ID: <875zd1f0xf.fsf@linaro.org>
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
Cc: qemu-trivial@nongnu.org, "Emilio G . Cota" <cota@braap.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Rename qemu_plugin_hwaddr_is_io() 'hwaddr' argument to later
> allow declaration of the 'hwaddr' type to be poisoned (see [*]).
>
> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02254.html
>     "exec/cpu: Poison 'hwaddr' type in user-mode emulation"


Queued to plugins/next, thanks.

>
> Philippe Mathieu-Daud=C3=A9 (3):
>   qemu/plugin: Trivial code movement
>   qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
>   qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io() hwaddr argument
>     const
>
>  include/qemu/plugin.h      | 65 ++++++++++++++++++--------------------
>  include/qemu/qemu-plugin.h |  2 +-
>  plugins/api.c              |  4 +--
>  3 files changed, 34 insertions(+), 37 deletions(-)


--=20
Alex Benn=C3=A9e

