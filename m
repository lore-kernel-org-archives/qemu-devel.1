Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F76C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2552078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGnhejbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2552078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPNzs-0005jk-2E
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPNz2-0005IX-LA
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:44:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPNz0-0000iC-5d
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:44:44 -0400
Received: by mail-wm1-x341.google.com with SMTP id d81so3046986wmc.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=asFF4xuOqruWnJ465GAFmTJhIZEOYwLh2RHPcQCiDYA=;
 b=DGnhejbvEvjpbq74Alp8iury6BvyINqoEud+Y/WsAXo2n717Qa9olPNR7HFq3xiJsm
 m8U11CdQER0XgNaE1ae2cJwvuvqbQw23eBSX18amgoXABujkr1HhnqSFoKlF7FnV8xIl
 5ZavsqW6ZADOfJxFZXBXvlvsb4zjtw58dDWpkfOStytp5xms6uP7jRL8FUnCwIf0WLx4
 dUrPDYI9M2cCdXWdLUGz6VaaZXADiV1bKiUSRZIjpoWv6Tqq0Tik2KzfJgxrIVC01Sfu
 jyWTSZpPOeICujD0U6ZtitQyAMBqt323aGfR3u4iZ+g8vaEXaa1S90UhDMA8FAER2Tl0
 5ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=asFF4xuOqruWnJ465GAFmTJhIZEOYwLh2RHPcQCiDYA=;
 b=CRoS1fhHsTyjCggp6iX/+gy3+cc0GMmk19VPp18RIyRDL22t11SOl9M0wuaw++d0w8
 kOshRr2j4JQtV+7Q9A28g4qvjEVZBWfgtpFFKYfvVA0U/u146CSR79YteESrsDCJPEDv
 cSaC9ZjW6NR6ZVAsBR5p0qNXBInEY0tOtN05C2aVA/DO9xRboQBmwwA840TSLF6Llni/
 wLvrpDr+7hR+QpdCtEBfUkNnIMWl/+rzGMSwKrVIUtdmaOrCFcFuyPYlI+lYLehPr3Cp
 THh3R0xi98J8jR6Z7HSd/1azClxYkOzhLjfJk1XpE8ZC7Ht3gvC2LN8R0wIpQpT0xQm6
 mWGw==
X-Gm-Message-State: AOAM532do6Aiyi8uR/biX+9UktfaVO9NR+uG7dPSvpimzKh7oWpfyKfa
 tafYDp59CaBvSmUJai9Ox3wKcg==
X-Google-Smtp-Source: ABdhPJy5nXQ1hu5BX2IiFz5zSUT3PiAPHprTtFhZUO2QHY/IinMcJmxQsNyRp2LAvU0VkD7/76ER6Q==
X-Received: by 2002:a1c:9894:: with SMTP id
 a142mr15772873wme.167.1601894680577; 
 Mon, 05 Oct 2020 03:44:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c1sm4314607wru.49.2020.10.05.03.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:44:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C78831FF7E;
 Mon,  5 Oct 2020 11:44:38 +0100 (BST)
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-5-luoyonggang@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 4/6] plugin: define QEMU_PLUGIN_API_IMPLEMENTATION first
In-reply-to: <20201001163429.1348-5-luoyonggang@gmail.com>
Date: Mon, 05 Oct 2020 11:44:38 +0100
Message-ID: <87sgat2bqh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yonggang Luo <luoyonggang@gmail.com> writes:

> This is used to distinguish from the qemu and plugin in
> header qemu-plugin.h
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  plugins/api.c  | 1 +
>  plugins/core.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/plugins/api.c b/plugins/api.c
> index bbdc5a4eb4..f16922ca8b 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -35,6 +35,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#define QEMU_PLUGIN_API_IMPLEMENTATION
>  #include "qemu/plugin.h"

This doesn't do anything in this patch. You should split the special
handling in the plugin header and combine it in this patch. Also I'm not
quite sure of the logic you are trying to achieve later on:

  #if !defined(QEMU_PLUGIN_API_IMPLEMENTATION)
  #if defined(QEMU_PLUGIN_IMPLEMENTATION)
  #define QEMU_PLUGIN_EXTERN
  #else
  #define QEMU_PLUGIN_EXTERN extern
  #endif

It seems to me you could get away with only one symbol - ideally just
defined in plugins/api.c so you don't need to churn the plugins with
changes, e.g.

  #ifdef QEMU_PLUGIN_API_IMPLEMENTATION
  #define QEMU_PLUGIN_EXTERN
  #else
  #define QEMU_PLUGIN_EXTERN extern
  #endif

But I'd still like to have a better answer as to why we need the extern?
Is this a limitation of the mingw compiler or some windows special?

>  #include "cpu.h"
>  #include "sysemu/sysemu.h"
> diff --git a/plugins/core.c b/plugins/core.c
> index 51bfc94787..7a79ea4179 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -12,6 +12,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
> +#define QEMU_PLUGIN_API_IMPLEMENTATION
>  #include "qemu/error-report.h"
>  #include "qemu/config-file.h"
>  #include "qapi/error.h"

I don't think we include qemu/plugin.h from this file although it does
raise the question of what happens when other parts of QEMU include the
internal qemu/plugins.h header.

--=20
Alex Benn=C3=A9e

