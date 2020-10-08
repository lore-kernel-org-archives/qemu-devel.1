Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0E9C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10999204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10999204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZgH-0000BA-05
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1kQZfK-0007nf-Vu
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:25:19 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:40136
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1kQZfI-000849-Je
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:25:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 84654DB3E7D;
 Thu,  8 Oct 2020 19:25:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id z-emlb_IuqX5; Thu,  8 Oct 2020 19:25:12 +0200 (CEST)
Received: from macbook02.fritz.box (p57b42307.dip0.t-ipconnect.de
 [87.180.35.7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 8260BDB3E77;
 Thu,  8 Oct 2020 19:25:12 +0200 (CEST)
Subject: Re: [PATCH v2] mingw: fix error __USE_MINGW_ANSI_STDIO redefined
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20201008165953.884599-1-marcandre.lureau@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d91d3254-3c39-b7dd-5c47-54815a67d265@weilnetz.de>
Date: Thu, 8 Oct 2020 19:25:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008165953.884599-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=v2201612906741603.powersrv.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 13:25:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.214,
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.10.20 um 18:59 schrieb marcandre.lureau@redhat.com:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Always put osdep.h first, and remove redundant stdlib.h include.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   migration/dirtyrate.c | 3 ++-
>   tests/test-bitmap.c   | 1 -
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 68577ef250..47f761e67a 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,8 +10,9 @@
>    * See the COPYING file in the top-level directory.
>    */
>   
> -#include <zlib.h>
>   #include "qemu/osdep.h"
> +
> +#include <zlib.h>
>   #include "qapi/error.h"
>   #include "cpu.h"
>   #include "qemu/config-file.h"
> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> index 2f5b71458a..8db4f67883 100644
> --- a/tests/test-bitmap.c
> +++ b/tests/test-bitmap.c
> @@ -8,7 +8,6 @@
>    * Author: Peter Xu <peterx@redhat.com>
>    */
>   
> -#include <stdlib.h>
>   #include "qemu/osdep.h"
>   #include "qemu/bitmap.h"
>   


Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thank you,
Stefan


