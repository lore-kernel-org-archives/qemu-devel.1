Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 16:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8694D2222B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 16:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8694D2222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUBxk-0002H5-FX
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 12:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1kUBwU-0001pH-PL
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 12:53:58 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:55610
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1kUBwS-0002CU-Bd
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 12:53:58 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 1B8E0DB19AF;
 Sun, 18 Oct 2020 18:53:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id 7P-gidpgFZ_H; Sun, 18 Oct 2020 18:53:52 +0200 (CEST)
Received: from macbook02.fritz.box (p57b42307.dip0.t-ipconnect.de
 [87.180.35.7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 438F9DA1507;
 Sun, 18 Oct 2020 18:53:52 +0200 (CEST)
Subject: Re: [PATCH v3] util/oslib-win32: Use _aligned_malloc for
 qemu_try_memalign
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201018164836.1149452-1-richard.henderson@linaro.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <dda15267-c3b3-53e1-69f7-bcff913a39f4@weilnetz.de>
Date: Sun, 18 Oct 2020 18:53:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201018164836.1149452-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=v2201612906741603.powersrv.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 12:53:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 18.10.20 um 18:48 schrieb Richard Henderson:

> We do not need or want to be allocating page sized quanta.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Include <malloc.h>; use g_assert not assert.
> ---
>   util/oslib-win32.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index e99debfb8d..29dd05d59d 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -39,6 +39,7 @@
>   #include "trace.h"
>   #include "qemu/sockets.h"
>   #include "qemu/cutils.h"
> +#include <malloc.h>
>   
>   /* this must come after including "trace.h" */
>   #include <shlobj.h>
> @@ -56,10 +57,8 @@ void *qemu_try_memalign(size_t alignment, size_t size)
>   {
>       void *ptr;
>   
> -    if (!size) {
> -        abort();
> -    }
> -    ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
> +    g_assert(size != 0);
> +    ptr = _aligned_malloc(alignment, size);
>       trace_qemu_memalign(alignment, size, ptr);
>       return ptr;
>   }
> @@ -93,9 +92,7 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
>   void qemu_vfree(void *ptr)
>   {
>       trace_qemu_vfree(ptr);
> -    if (ptr) {
> -        VirtualFree(ptr, 0, MEM_RELEASE);
> -    }
> +    _aligned_free(ptr);
>   }
>   
>   void qemu_anon_ram_free(void *ptr, size_t size)


Thanks.

Reviewed-by: Stefan Weil <sw@weilnetz.de>



