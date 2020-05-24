Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92993C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 12:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DE3207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 12:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DE3207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcpxy-0002D4-EA
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 08:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1jcpx7-0001f8-3G; Sun, 24 May 2020 08:42:05 -0400
Received: from relay68.bu.edu ([128.197.228.73]:34029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1jcpx6-0006f5-2h; Sun, 24 May 2020 08:42:04 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 04OCfWig012398
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 24 May 2020 08:41:36 -0400
Date: Sun, 24 May 2020 08:41:32 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/display/omap_dss: Replace fprintf() call by
 qemu_log_mask(LOG_UNIMP)
Message-ID: <20200524124132.dri74sl5iei3aaxl@mozz.bu.edu>
References: <20200524103833.8188-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200524103833.8188-1-f4bug@amsat.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 08:42:02
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200524 1238, Philippe Mathieu-Daudé wrote:
> Replace fprintf() call by qemu_log_mask(LOG_UNIMP), which is
> disabled by default. This avoid flooding the terminal when
> fuzzing the device.
> 
Hi Philippe,
libfuzzer also lets you pass -close_fd_mask=[1,2,3] to close stdout,
stderr or both. As a side-effect, In this mode, libfuzzer will write the
crashing stacktraces to individual files ./.$PID, instead of to the
terminal's output. As far as I know, closing the FDs doesn't bypass all
of printf's allocation/formatting code, so getting rid of calls can
still be a good idea for performance, sometimes.
-Alex

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/display/omap_dss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
> index 32dc0d6aa7..21fde58a26 100644
> --- a/hw/display/omap_dss.c
> +++ b/hw/display/omap_dss.c
> @@ -619,7 +619,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_s *s)
>      if (s->rfbi.control & (1 << 1)) {				/* BYPASS */
>          /* TODO: in non-Bypass mode we probably need to just assert the
>           * DRQ and wait for DMA to write the pixels.  */
> -        fprintf(stderr, "%s: Bypass mode unimplemented\n", __func__);
> +        qemu_log_mask(LOG_UNIMP, "%s: Bypass mode unimplemented\n", __func__);
>          return;
>      }
>  
> -- 
> 2.21.3
> 

