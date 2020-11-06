Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40397C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703862078B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktlrVsxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703862078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5Sy-0003T3-De
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5RZ-0002Vp-1s
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:22:34 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:41757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5RU-0004cy-TU
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:22:32 -0500
Received: by mail-ej1-x62b.google.com with SMTP id cw8so2976027ejb.8
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ihyTT81qp+8FaUp+h0bwSRmqJJGyYtUeEBfeb7eL3/w=;
 b=ktlrVsxn3GiKqco0SvYmNItCwBjXlQh2IQJoQVAQaLk4hknQt8r19o1YahBrUhZ8lE
 NY6wNZmNybStwjGBFkOOrUsPDMBbdw5g9Qwdd+5ooLV/EE9MTrNh9enFHo3UMKhKpvIv
 v9qF8eQRtvpm+U8fLRBSBW5NniY2NGlhQufaABJz91Zq8tyOfry5kZPaDVyT0gDClt+N
 vulLiOqwrHi/vzOzvPtJ4eIkaMoOeAc4cBYAcdR0tsUl2oAs9elmdZTS03CADndBApTy
 twJ+CSIoAj0XRjhd/UgjKsfB35L1JhpAc/Dy9aPdNnIdNkY8sHIZHDrnihfYcgMhq9/q
 /JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ihyTT81qp+8FaUp+h0bwSRmqJJGyYtUeEBfeb7eL3/w=;
 b=QjRaFRcN8W7aV+XdtDD5rnF1JlbMYQiePQ8NVHTjJOycD0LlTf1ZxicIalfnymBamY
 HNNckx9A2487bPOUH/8DjEGGr/avIQoFmJB1ZKXz01ZWXNjwH32o1CiyA17GH6lxCB/9
 lNtmTqWJxlVGhyV4bPb3NXnPq5bZ93d46WmBwDDv9OAu0qdVX7NuRF0Jhr76a+vHxZSw
 oFZHqz1pl3iiQaVb5KRNw9FpRiLM5Qhno7zwxCit/VpIuN0hhrYxjhrT3YjDPyBIgTiX
 6tS3eeFrwffc9ZXM7Hcus59pw1IkZLHiKRAwP/RZTiFs2FuQgCuxunSi5bhoIDw/1BJU
 sQEg==
X-Gm-Message-State: AOAM532cEv6Qk8j2H+cdpZ+TqGcGMdBs2fKCmDHoFmPU8bzFdoOTJAjN
 Y9RvLOPMTvxPixlgI7wx1b/p9AoS59PJ+8TwCqoAUte8kx8=
X-Google-Smtp-Source: ABdhPJyAfArNwUJi/pTm+qM5EHIaokPJgGEG9d+aHoHW2KrWmN/2Xp6KyjrUf3URdV+0wf8XTYTMK7hBeyUubB9FAgg=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr3022574ejd.250.1604683345192; 
 Fri, 06 Nov 2020 09:22:25 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 17:22:13 +0000
Message-ID: <CAFEAcA8keTZEW3MLky3_HKh5cu2HR1O0iBax2c0hs0qSosNYSw@mail.gmail.com>
Subject: nbd: bitmap_to_extents() calls nbd_extent_array_add() without
 checking return value: coverity false positive?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; Coverity's "you usually check the return value of this function
but you didn't do that here" heuristic has fired on the code in
nbd/server.c:bitmap_to_extents() -- the function nbd_extent_array_add()
is called five times in server.c, and the return value is checked
in four of those, but not in the final call at the end of
bitmap_to_extents(). (CID 1436125.)

Is this a false positive, or should the caller be handling an
error here ?

thanks
-- PMM

