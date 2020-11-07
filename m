Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00AEC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 16:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180E620885
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 16:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180E620885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbQu1-0008Uu-R1
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 11:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kbQsV-0007qi-Ge
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 11:15:47 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kbQsR-0007ol-He
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 11:15:47 -0500
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHFsE-1kX5Hn1WVs-00DJgD; Sat, 07 Nov 2020 17:15:39 +0100
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106235109.7066-1-peter.maydell@linaro.org>
 <20201106235109.7066-3-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 2/2] hw/m68k/q800.c: Make the GLUE chip an actual QOM
 device
Message-ID: <4869f5df-05de-3bcc-f7b9-05fb96c5b287@vivier.eu>
Date: Sat, 7 Nov 2020 17:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106235109.7066-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V15CYnCeMnBn8xORkaS8YGZJBtSYWiGMWXN1u1rA5umhz5KCUU3
 miWowCuYQrncyIxTt1eaIvZ0DjjSeTZj36wb4E26qoygAsY2KXAr1V1w/XuNy8Gm44KcmE4
 SCNoBW3vYH3TJRCcgStEFvhOrcq+7wxdzo43blZujytUlys4tN+6XSnhV5xbZfqHT6bYpZn
 NCQbsM6C/WBHvdu+LcHAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a2WFY20zYTU=:Svi8GWz2gvuz8ip51P5xqc
 Ooc+0kUROBQspFikMaDOjTjgarAv11YEvwU10JKUYb2oyUB0aszmKM+GIZDWqCByGQ1ccyBey
 Vhh6qzuhEQeHh22+z460h/b5IhCq23fPEyAbMCYx3ojrI4GgYNo+X9/aCvZZJXORkibH7RaVZ
 3GSTUerNkm/S7Ay5qyfGU5y+5/6MAdGIku7sTHjCakBIx8JmhnpTdXHr8tNlAmh9kUUJi0uF0
 K5m5FibaTfTtuJlI9UxGfQkzmOZpLSFR9fUZEvNcZBKbtczhYFNt+0+veXOkuPy4xYlTCdmN5
 vK/WRuXYiey8QiltA1XHxHMVVNFoiKsQom51rWCBL39RUM9JlgHDyG5RmjzAzOxiywHDqf5/6
 N5k++hsIYcSycyPJ8EfJ/Tjz7neHDot5dZU+e3IKQtgneNJOxhhqsPsdBartvXJfR2DjNQR36
 +0vH7+UwlQ==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 11:15:40
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
> The handling of the GLUE (General Logic Unit) device is
> currently open-coded. Make this into a proper QOM device.
> 
> This minor piece of modernisation gets rid of the free
> floating qemu_irq array 'pic', which Coverity points out
> is technically leaked when we exit the machine init function.
> (The replacement glue device is not leaked because it gets
> added to the sysbus, so it's accessible via that.)
> 
> Fixes: Coverity CID 1421883
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/q800.c | 82 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 12 deletions(-)
> 

Reviewed-by: Laurent vivier <laurent@vivier.eu>

