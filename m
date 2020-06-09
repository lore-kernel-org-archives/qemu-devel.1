Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6234EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 05:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3A9207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 05:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHuqau1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3A9207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiWdb-0004YI-Du
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 01:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiWau-0002eC-Bh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 01:14:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiWas-0001kW-Tn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 01:14:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id d128so1721182wmc.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 22:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=prjhGMq0wkjij6IaSEwj1fgkvA3uV4TIbvQ0RSrjSVA=;
 b=UHuqau1+gXECyK/9xQKGhL87wf75SMNxiWakYI9GKkBh1vfBeoSR3wg4ETG6KfYief
 b4R0n31XctWtkmZ3fO+eGPnmy9Ui9wwREIuZTM4rqtYxKccpdCTTCxAQrvHit/3E3r+g
 KsRjE9dv8yaHmodtN5pkNEJHfZtjEi8G7f4SLkDrIPUtxDbhbDwP07Lydo5mOu/xmfEP
 +CGnwWm2PjBDXT2htejPxTvzeDdC5Ru5weC+JD99kERPlple+CDU0UDUp5HcTONl7CLx
 L4MHLROkiwdOiouPndM6D6oc8PcNmUPmDWvD40yykPId5dxSCJZvzb3AU7vwrRsE99RL
 kK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=prjhGMq0wkjij6IaSEwj1fgkvA3uV4TIbvQ0RSrjSVA=;
 b=irSOKEQTDV7zVwLhEUMxaZqZ84oOL+Hxz3bJtsvR5uy+AyVE4kyUv5iHdrICD+jaVd
 8DMfMwTVNgOm7NX37clN4Az4700/lNiqRcVfPY1nlJm5V5Gki2AHSsEYek/4o9saPx2w
 ffF1Io4EyOqyZCmVfzt1nXcBgsfBlfwcj636h54bcniwpxND+V7qF7QLfECwjEQhoPt5
 SiGc0HTgEVUzi3gFWG9zT4JTlOxFUgZKX8R4DwRJbpzswi549b574jqVl0b0R99MxLU1
 8m+Dl0m9zpyxpPUsn8f92aFkLPC1r4+kI1CsSQtT+jPYqS1hu9kCI8197gWa7yNFG64Q
 X/QA==
X-Gm-Message-State: AOAM532K+S0pxswvVcUrs0RuRy0dXRJddbgGEv16xPSoDP4jGw1hvRUY
 /Njqno83zizCqhvFHWf98m5o+PBC
X-Google-Smtp-Source: ABdhPJwt1U9qtq+ARC0VNcOTlR3IeCygtPM/xXTXQJ1ysqMDl4+74UhSYh5PVmXP9EE8kP3z/SXSKQ==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr2053545wmd.94.1591679677531; 
 Mon, 08 Jun 2020 22:14:37 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l2sm1910644wru.58.2020.06.08.22.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 22:14:36 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
To: qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <51d3c469-3963-c242-7f98-f34f71fcafe4@amsat.org>
Date: Tue, 9 Jun 2020 07:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331105048.27989-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jiri Gaisler <jiri@gaisler.se>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 12:50 PM, Philippe Mathieu-Daudé wrote:
> The Leon3Machine.test_leon3_helenos_uimage has been running
> erratically since some time now. Time to disable it (at least
> until we make it reliable).
> Few other patches added while tracking the issue.
> 
> Philippe Mathieu-Daudé (7):
>   tests/acceptance/machine_sparc_leon3: Disable HelenOS test
>   hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>     registers
>   hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>   hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>   hw/timer/grlib_gptimer: Display frequency in decimal
>   target/sparc/int32_helper: Remove DEBUG_PCALL definition
>   target/sparc/int32_helper: Extract and use excp_name_str()
> 
>  hw/misc/grlib_ahb_apb_pnp.c             | 24 ++++++++++++++++++++++--
>  target/sparc/int32_helper.c             | 23 ++++++++++++-----------
>  hw/misc/trace-events                    |  4 ++++
>  hw/timer/trace-events                   |  2 +-
>  tests/acceptance/machine_sparc_leon3.py |  4 ++++
>  5 files changed, 43 insertions(+), 14 deletions(-)
> 

Thanks, series applied to for the next (temporary) sparc-next pull request.

