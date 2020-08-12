Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEEDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8555620781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Op5Usonm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8555620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rXf-0004vD-OY
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5rWN-00034j-Rm
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:14:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5rWK-0001Sc-FD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:14:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so2199373wrl.4
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Y9PJZPxuFj03Tta6HauHoX9FGhAG+P1HJCTgWdBdjjQ=;
 b=Op5UsonmdqDprCSrKvcAHZIyQLFdXRFLv84fIfF7czaoKTBZjcRKqLoENpgiqBz4oN
 2rKLMg1C2C9i77INg+sbRCwJxMOElg6d/7IeAnnqec/hkqq+X5oGI8biJEuamz08AA0P
 eFI+q2UvpxP+2/iPXWfOnrLXZrnX0PYcFlrLR4kS3ZacGChl9r90dbrnhzPBqGrv5f7B
 HWuSn597/z8PP3f85PXcftRhLzYBkJd62byiXvu7zTlv5KxMZnsg3KIFy6EvA/iDL/XH
 ilG43MyYuIV89blHz633QMt6SYv8M00AOkWYEMBDDAtzJS/0Zm26LELtG6oJWP9vaRdU
 JTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Y9PJZPxuFj03Tta6HauHoX9FGhAG+P1HJCTgWdBdjjQ=;
 b=NV6So7QkDUYI/qpWW4thyFCUuv4OzurRKEPDjJgKonDF9DKXpjSNmUtYE8ucUV2TsT
 PbsTqTAi2m7l46qHZISj3Vi82iW21qV91e/rWaewlxRsjk2WqQUd65+4YRK6aTd3Y7z1
 NMhWvXztqvHyMZhM5Qo/vMR+NPKTpeN3pKX0i492oeAP9PvLxFKdeJwgmSmEA7BwC0nQ
 TgZHehH2ztDG0+fgmZ6G1AoWZK4BFDEKzL/IJpwX7ixuvRRa+gMRR9QHfUJ4EmMxaBh2
 3gXosI9oyIU1+z+TC+2/8ESXWP3mMv99WtXctgeYGbM8x08ekpMwd3Lvdv17Zliyc0Lw
 v1Ww==
X-Gm-Message-State: AOAM531x2W3vUUAhWao9LZ/0KDhZyP80+++uMu6zY1Y6GOzN1qVQNPa9
 uxVYIeksHoxe8gfw7SQwM6LDLw==
X-Google-Smtp-Source: ABdhPJxvqC7bSp0oZq5KRVftVrIzy+cYSgrRe/k+fC8tXVmsgq4dUdsXTvEzrOBpnZhtzMxEX1O/6w==
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr32978475wrw.31.1597241662825; 
 Wed, 12 Aug 2020 07:14:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l11sm3810944wme.11.2020.08.12.07.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 07:14:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F12081FF7E;
 Wed, 12 Aug 2020 15:14:20 +0100 (BST)
References: <20200812101500.2066-1-zhaolichang@huawei.com>
 <20200812101500.2066-6-zhaolichang@huawei.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: zhaolichang <zhaolichang@huawei.com>
Subject: Re: [PATCH RFC 05/10] util/: fix some comment spelling errors
In-reply-to: <20200812101500.2066-6-zhaolichang@huawei.com>
Date: Wed, 12 Aug 2020 15:14:20 +0100
Message-ID: <878sek0x4z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


zhaolichang <zhaolichang@huawei.com> writes:

> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the util folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

