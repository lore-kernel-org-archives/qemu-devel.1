Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5197AC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0C8206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZXLo9Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0C8206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBfL-00017J-Pa
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYBbn-0004c8-Q1
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:21:08 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:45223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYBbi-0003vP-OI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:21:07 -0400
Received: by mail-ej1-x630.google.com with SMTP id dk16so4292956ejb.12
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=VMzUzeNQrIX2+vMe2GrHUdKkSTLfIXJeqymGGOEeFaE=;
 b=xZXLo9Qhz38LJhLyP9Q347WEck/6ovEM69I8FmSRijEK8/c9lsw6JwzTattPCVRd26
 7entz7tl+hsoMPO3a4O1UdeJNUIAwYGm4PqZexvL9+HfVwQPGzMpvekJBB8+chRY7B9r
 gem92Uh7Dj4pHpCNG/Lwosoyg+2Ypl7knWIta4LRXU44S1Z6meXUQEKGTlgH4DWT44AY
 g7gaRmumjaaILWzqW+mOJLtxI5UWWImFTSVeuc4yxxic24FtoaWwn8n2muWoZOivqAqR
 LoeJzRxGfGDQqg8cyOPMaJDHMjiBur69vKdw50TDakfF+/biRn0n138DMpLep4bgONgi
 y5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=VMzUzeNQrIX2+vMe2GrHUdKkSTLfIXJeqymGGOEeFaE=;
 b=VTFvJJscgLmNXTF7EOcNb8IhcjkihrXnd8EyY/uYY/BLUYW2r/Mhurlamqj/b1g/nk
 yikq3LS6FQUtwgi03gRmp/LNsmK8ZkiEqrwr3cJ7jtqfDncxauhSsv5XZBrfmuo7oa60
 Mj+lKNwz7lsOYbLYtPI/Cy+sq/KV4UNQkz1TN9aTDu8qZJnksoYy2/rYfA5Vo3LbI+d7
 BgCbRsL3xInaF6vl6UN+uXTGjWZ/D5xUG2ej2M8INGMMaUdGUuzgMj33ZrjAsbgk+S84
 WpTMqzAGrviM2N3PCkDJv4BjVIa5Qjfx60duT6nYIGxvuPseqkoROO8P7DWPr2jntgxc
 fIGQ==
X-Gm-Message-State: AOAM532PvI40OPmGwHfGLog7j6PRF/1W9Zx/gRaBNSWE+YpDyrzs+xud
 Vhid6+BtL5xIgzrU8NVIBt6GEAn1uWsNV1JqyFyaZAwviWE=
X-Google-Smtp-Source: ABdhPJy7ynLiIZLyfF4HgGiNR/Ow2zCXMyxXi+YVR21In+HUcKX0p1D9tibUQXRBxO1OSdAMvwZy8i1CtSxdXgJkk4M=
X-Received: by 2002:a17:907:9e3:: with SMTP id ce3mr5162416ejc.4.1603992060253; 
 Thu, 29 Oct 2020 10:21:00 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 17:20:48 +0000
Message-ID: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
Subject: recent flakiness (intermittent hangs) of migration-test
To: QEMU Developers <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

Recently I've seen the 'make check' migration-test developing an
intermittent hang; I've seen this now on aarch32 host several times
and also on s390x host. The symptom is that the test just hangs
with a couple of child qemu processes sitting around doing nothing.
^Cing out of 'make check' doesn't kill the qemu processes; they
seem to need a 'kill -9'.

Sorry for the low-information-density bug report, but I don't really
have time at the moment to debug failures in merge build test runs
because the queue of stuff still to merge is enormous...

thanks
-- PMM

