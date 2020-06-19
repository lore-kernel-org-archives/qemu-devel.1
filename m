Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FCDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023E4206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+wgvJk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023E4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHZC-00077w-8O
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHXr-0005Oc-JY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:59:03 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:44658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHXp-0001zC-2E
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:59:03 -0400
Received: by mail-oo1-xc43.google.com with SMTP id e8so1905731ooi.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wu1YLiwwCFElbX/aw3sZKz/7Ig1T3KZntvRMG52vCYg=;
 b=j+wgvJk7sbwgCtV/iMgsvoftk9pTkr+GwN8VkZ2cN017wCT+abKEiRr43qftxJhHYU
 KX3OPsqsv0ZB7RbIKFZisflWvQqvH1iMzOp8Ajd7+yBNoys9Z4mEORlaiQUUrsjgrYKn
 4NUWV4rDaYoOF8T2TAiC8SwwwmWT1etVvyN6pv2OMMXcP8rfJgJzoIn6K/ZxkvH6dKwn
 ohhe50rACyvjhkTFi6qYyorch+l7vzH8HtyxUZZeC4XfyICwkGXTJeG6qGevp9nxy23o
 OnLgUK002NfANwyN7thgAhy6rjYjPZiWATs6QySCj3m08T18IqMHooxrfxTnpqFUtGvr
 zWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wu1YLiwwCFElbX/aw3sZKz/7Ig1T3KZntvRMG52vCYg=;
 b=p2k+b1pcygMb36P/AIB5Y+wjmfFfGcetBHqhg6vS5fO4I3AVvZGkVv0P2BpE6g6mTm
 QF4tHNd0UTXjgH5+eyRBWrVvbfgvyzol31tjwuo9qEZ30K5xLSaGSDo6GlbcSgUa+8xO
 N1DUebCe4Dro/Xe8EPGY2vdM+6cVFHG1ao9PcWr8Szgp/RNJ8jHq7IYwmc7mtRinlEVb
 QuIqZw7sJzt5Tc0HKH/SdWQZbmdEhpzYNLpVBJNF/6/T7MQjhkfeeFSMj39dJv6ZfpTs
 KPPFTPUh1IWBRYWXCi+wmufh/opIWq6hCCvEAQdlAbwCZV97zBKEonr4AAiJKQcaFEuq
 fTTw==
X-Gm-Message-State: AOAM533ho5VBF2DcEz//D7EEqQt3U89BX8wForjS+fa8axlpCisuc15x
 5o+TrG1ziSB6X4Ab4yBj5I5CZxTXf+IYgMptI1Bzng==
X-Google-Smtp-Source: ABdhPJyQxMYyd1WBWtGPayRDQ+TUSP63XY6mv5lCbsTN4dgepOnVpOY06idfOe9Exi0QUH9eFl2P1oQ9nU4NFwzIJeM=
X-Received: by 2002:a4a:a20b:: with SMTP id m11mr3383543ool.20.1592575139746; 
 Fri, 19 Jun 2020 06:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-29-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 14:58:48 +0100
Message-ID: <CAFEAcA8ZYhqbO-A=FkVzgKkcTm1tVVZSB0C9HOFAnYG7jaFPpA@mail.gmail.com>
Subject: Re: [PATCH v7 28/42] target/arm: Use mte_checkN for sve unpredicated
 loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Commit message suggests we should be just adding an MTE check
but patch contents appear to be moving insn implementation from
inline codegen to a helper function? If you want to do that
it would probably be easier to review done separately from
adding the MTE check.

thanks
-- PMM

