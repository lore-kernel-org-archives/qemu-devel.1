Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE9AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E2720780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPeHJ05V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E2720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr5Fw-0002ax-Kk
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 15:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jr5FN-0002Ba-0w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:51:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jr5FL-0003VA-9x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:51:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id z2so7606888wrp.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cYNm6MhM6/js2uJBykXKSgOkIbbxdqZubpcdRpvG4Gk=;
 b=dPeHJ05VUvEuY/fG1mRlD6kpyKU7aPPCb9dWRxz7g6u/1RbdNQ4CdbWMiwOCiUvlrT
 Fv6MejPHyLV9/nLYN/zH0/aIK3ArD5vW17J/4DUPK0F18nJ+sbWmV9lZzEGYmIaCmhvZ
 dCdYsGAvYrQnBPuso8mheMoWMN2xJZkwWLtxx0tanrKN8UZBr+cPES9sio5Px6LVnLUN
 p89iW8cGX+YkmzRhjtjYPLF2ffPdjAzylikGaDdWDGl6+uwrUV1U9bAIY+/jlZZyQKE4
 F1Lj9AW+ty6C2fAtSS+0H1slQwsXU26d60dXYCQivjHNoM3GaCUWsFpOJkznmDkjldFA
 KnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cYNm6MhM6/js2uJBykXKSgOkIbbxdqZubpcdRpvG4Gk=;
 b=pdsjlBBFMUdN5xcuqaq+xgRV2pbUf0ufvM8RDHWcFbynaoTGYDtYbgkcKEHwoDtYts
 QPJtqeFrgOlkzOKhOPQ0UVGvu4vYMAd88ZQ/XhRtGHlxbLoffMIyHM7naeX/2jCL/1gI
 V6B7YnsmdZiPvAgkvZEStnwYaCZVbtrX3FXGDidl7IpBwIhMitS8Mp/bl24sU0RIJB/B
 DZOV7+HnEH1FTnvIGl26UUM+UaH/1ow39EWEtn8ApE0xSybvNR+MaA8tWQPJXVcTWPM9
 Kqf2Mzd8UWHeB+HD5pvRLk/HamgHEnkJuXEodvddrYnHm+S1cRcPx+41QbCmTS+yVckq
 90Hg==
X-Gm-Message-State: AOAM530Wbw7p3ZKSEBdSJeitEdZKyZr6nHWLh84LTTE2F19iLXDjSmgt
 5lw4/yWWEwABzc5FmmrCnz/MrA==
X-Google-Smtp-Source: ABdhPJztbNs9Q30hbGPDrM9F75fXqxSH+jvaAsc92oWeNUFjHu/r0Cp+Nj0IQ2nlU5vqfSCW98/apA==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr3615080wrt.24.1593719505508; 
 Thu, 02 Jul 2020 12:51:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm10914058wmc.26.2020.07.02.12.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 12:51:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CAD931FF7E;
 Thu,  2 Jul 2020 20:51:43 +0100 (BST)
References: <20200626200950.1015121-1-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 0/2] tests/qht-bench: Adjust rate/threshold computation
In-reply-to: <20200626200950.1015121-1-richard.henderson@linaro.org>
Date: Thu, 02 Jul 2020 20:51:43 +0100
Message-ID: <87imf5pueo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: cota@braap.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Supercedes: <20200620214551.447392-1-richard.henderson@linaro.org>
>
> Thanks for Emilio's review of v1.  I've split "seed" from "rate"
> as suggested, left the comparisons alone, and expanded the comment
> in do_threshold.

Queued to testing/next, thanks.

>
>
> r~
>
>
> Richard Henderson (2):
>   tests/qht-bench: Adjust testing rate by -1
>   tests/qht-bench: Adjust threshold computation
>
>  tests/qht-bench.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)


--=20
Alex Benn=C3=A9e

