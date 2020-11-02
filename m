Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8AFC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 19:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D4C2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPGgNyAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D4C2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZfuy-0002Tx-PD
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 14:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZfuP-00022K-MK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:54:29 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:36756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZfuN-0001nD-Sm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:54:29 -0500
Received: by mail-ed1-x534.google.com with SMTP id l16so15602716eds.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 11:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=IMnaQHPJyIWk9HesfAiUpFReMmHFGCd0aTr6/9osafc=;
 b=sPGgNyAPlprRXS1Qvh4+YjRvxWtzW2tE4E5E3AEP/OQIy3eMkOa1alMfA7nT5NWzsS
 vNok0lmAX4Mo0cWFr+1t4SZzVbS7ZzfxBjXXR3dwpT1bHBR0ABDETwDJ3pFssfo6AAUI
 iTCxmZlDP9L0mkVcCUavk3RlN7CgYEA0gvxFMpURvfoX5qFeEDSVaL7FH+Q2f5RExLfD
 hYU4bJrHX7pzwbmpdop65VBWQaaPrOYdgxg2Xp61n/6SNApJZEkHYpGpJkYSYxOgAYXf
 Pf2yFCmpqJb6Gn8GLpVStY2QY2L5jHGhhmZVL3ffj0yhoFqKeFG4b3LMVui0AUSAZgtM
 YaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=IMnaQHPJyIWk9HesfAiUpFReMmHFGCd0aTr6/9osafc=;
 b=dLXRshr6PQdtxUZi5SPdG+pnMMElnqoZk3a7IQjQ7ZYo5NXWN2BrJEYsqqReDvpI3b
 /uX5/umpVFm27pd2eRbH64H7LaJly6x7OwdO/Gd4TK0dpyELl7/pMsIFh+dBKxxjit8v
 iqGXCOUwBxWpPTJvhb60d4CBLycaz1ouLSiaz4zgLpeXNRqux32mD5Q/ERkw8FEjZ7PI
 TATNFLu3galvlc6ELShL64RLRN3983/4ovoxGlS3r6ZgZlC8N1KvZ6jgwg80xvSdCypa
 MUwTUdW01WChlJ76bPW2U4IzzG2aHxHf6waYmgzcFmkFxRMPTqSsaLEKNiriZwgDbLtC
 49bw==
X-Gm-Message-State: AOAM533aDAcNeqXLjaStoMdhjr5Xzj1uYBWOzI/XN5XOZgzKvyigFySe
 bh9/6Ti1M7W+WaJ3kCr4Dt3GNzIpa6my9lXqDxFW6by/o+w=
X-Google-Smtp-Source: ABdhPJzVu2W/Kn9h04ji6YBynSIGINbHag3565jRodanGPnxXy2OtXdp0qElzl2vMXf7c7WhXMFfVV5HX/9xQE7wZ0o=
X-Received: by 2002:a05:6402:4c6:: with SMTP id
 n6mr18642513edw.204.1604346865495; 
 Mon, 02 Nov 2020 11:54:25 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 19:54:14 +0000
Message-ID: <CAFEAcA93d5VKj+jbJQcyxsG+54G32r1k53DPT8rGRqZcROU2hA@mail.gmail.com>
Subject: Does QEMU's coverity-scan run need to track coverity issues in dtb or
 slirp ?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently QEMU's Coverity-Scan project has a bunch of unresolved
issues in code in dtc/ and also in slirp/. (I suspect most of them
are actually false-positives that got re-reported when we switched
to Meson and the filenames changed, or some similar event.)

Do dtc and slirp as upstream projects already track Coverity issues
(in which case we can just close the issues in the QEMU tracker as
irrelevant, or do we need to investigate these and potentially
forward them into whatever upstream bug tracker is appropriate?

thanks
-- PMM

