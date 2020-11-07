Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F31C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 16:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144E920719
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 16:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144E920719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbQfv-0004XC-3n
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 11:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kbQf1-00045X-7D
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 11:01:51 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:35677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kbQez-000364-65
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 11:01:50 -0500
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MGi6m-1kWX6Y2z9W-00DkbS; Sat, 07 Nov 2020 17:01:44 +0100
Subject: Re: [PATCH 1/2] hw/m68k/q800: Don't connect two qemu_irqs directly to
 the same input
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106235109.7066-1-peter.maydell@linaro.org>
 <20201106235109.7066-2-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d1060464-03ad-e654-57de-9da077693fd7@vivier.eu>
Date: Sat, 7 Nov 2020 17:01:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106235109.7066-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XOfgCpWvbhn38+EHUpFVUWznN7hS8Mc/k4i4Jy7kE8kZZ82H66s
 bz5EWLyKyvT/tRgxQgnzTruGJV7zg++KKuK2vSlBeEHKqr9n1RYoJZqQdcUMjRd6h5copcu
 tuheON52Q9LK87YcIBcQVBMd/Jp3CA/8YjyWC44wto6wigmB5C9wZA8QHQqN+Xm0ixL7fNR
 Wv23JSXPaEVlPR3VrbD2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W902YljVwXQ=:kHSg6PKXjTmcO4e9Hg6yBq
 ExHSYyYUIDflFGZFDX2+Wm+sniDRNc/amVPYiI7Sd2yJbHvb639ZWStwNkhTgysQ+Hm+vbm2i
 u9M8V3vfm9PYss3xwKVMkUCoFtUeD6b9tT1aglJocPNt55wQAYDqsovBH30+dWOw9A4IYHFoH
 6mXMFZK2nzn26qpVYqWyM4XjmAUVCwCIPyBlUHzAO2Ia41cyiVpC2Hzk9tYWy7tlOgEetARke
 h4Z5qLhnQoBv6aqBpmL7ToR+tmwh8YS2iOShP1OV+9KyrJNvStcL7Kpxss4C+nljMuU1/mlZw
 KkQoSlXXlJVUvTcKn+cWI65+ZinEiTuQWbuya3nx1NBpLQVpU/mlTTcH2mB5soq6nQ0nhRqS6
 Ab/U523uSA54DgnwZDHPbOm3smLDBJsbGphHsUie93KOREra9fw5a9HVS6lEUo2DipluQtvDo
 8FA6YwQGjA==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 11:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 07/11/2020 à 00:51, Peter Maydell a écrit :
> The q800 board code connects both of the IRQ outputs of the ESCC
> to the same pic[3] qemu_irq. Connecting two qemu_irqs outputs directly
> to the same input is not valid as it produces subtly wrong behaviour
> (for instance if both the IRQ lines are high, and then one goes
> low, the PIC input will see this as a high-to-low transition
> even though the second IRQ line should still be holding it high).
> 
> This kind of wiring needs an explicitly created OR gate; add one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/q800.c  | 12 ++++++++++--
>  hw/m68k/Kconfig |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
...

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

