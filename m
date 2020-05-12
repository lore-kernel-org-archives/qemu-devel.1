Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A2C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A109B20722
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFkbxv4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A109B20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVcZ-00065b-Si
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVbv-0005Rw-Kg
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:10:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVbu-0000eA-1Z
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:10:19 -0400
Received: by mail-ot1-x341.google.com with SMTP id z25so10547853otq.13
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a2qFyBFgJDCcJv4Fmj9uYf/QWQsmSXujp9IalpuMvlg=;
 b=kFkbxv4jU+oXbZkdV70jVkbG966BXrchkEe7Df7/ugCfL53DhWBrzPkZBnMNCwsMKC
 1siDSTwFxATqRMjDHtGevq8rxW6U/YIUxezkRWSkU6pFrMcLCSPR8H5u84vCxpKgw2z9
 ODpSS43xzXL6dax7TM3LU9IKuovvuXNf/z+16ydqnkRFAGk9kGxu8osd6rxmbdqAGDPN
 hZMsDB9W34LdqXILdP09DRtQv0CcT4p/okvdU2yheFafbYtMYkbg60mvpbTq/WMc0T5D
 iqCaoR1kzSugqcXviqAodAdVZ7rtJ4zaOssJdQ7ULyTGRASlKmGTOBDwUj5CHnJua1uz
 g3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a2qFyBFgJDCcJv4Fmj9uYf/QWQsmSXujp9IalpuMvlg=;
 b=DJ3AAhdbil3880SWegr3GjrSic+GWEONPamszOnky/dEXFhHY2yx+vKPFa7CHgfSa8
 AHPnyo+R0dU3ENfi1uxOpIAb1QMssuBfW6X+lKgd1QpxfiRz/EmVtKP9hiKIzZQKNo1/
 DDh6vQLhfltJhfrGpuM1DGG7Hmzf5r313Q3WcwKioH1YAFVhSWSZYPdpqGN3Wn10lnSZ
 iZ4Ewb8iumlxzOy6/bvG1EF6iVBS7WxUIfZT1pTfHQxHxsRonMVz0KqVzltjvwYF9mQ/
 ODDn29X/ZU/Nqq5IrQBwLjg+7s9BJaugjbzEMi0064X8VkFLlKP5Sphh95McAKrRkVMI
 NR8w==
X-Gm-Message-State: AGi0PuaC5KQ9xjo1NTrTMpM71tf4C+9sE87ok8m6udMy3vPpvrJiQ8RN
 kqMnDI4MUGmDe4sGdFETBEwedyksdFwk9rLSO8kVgA==
X-Google-Smtp-Source: APiQypK92mUScQi0H7QZmkNFrwoo88UVFf+rCTi8WNoEAv1WAqMUV69I4A7O2gpJ6RrXXlDkBi+HUfXIWAXY17jNLGs=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr15989416otc.221.1589292616370; 
 Tue, 12 May 2020 07:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-7-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:10:05 +0100
Message-ID: <CAFEAcA92s2H7wjUWs6ho7CpCtqUXdv9ZLHVCU9MAwdVDCfYqxQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] target/arm: Create gen_gvec_{ceq, clt, cle, cgt,
 cge}0
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a functional interface for the vector expansion.
> This fits better with the existing set of helpers that
> we provide for other operations.
>
> Macro-ize the 5 nearly identical comparisons.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> --


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

