Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49321C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212F520840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212F520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWg1-0002O8-DO
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58101)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxWeh-0000a9-OL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxWeg-0003Rw-FV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:16:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxWeg-0003Qm-3A
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:16:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so107705744wrf.11
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4S14T60NDwHCvYsNCw9lNVLA3zrprDkhHzAZ5IgVw5o=;
 b=K+01ZQDqMN8eDA3yUdp3VimRUmRqCvwMYCFUcIDcXcawBcU/9J6a4qcQlS9V1GQYjG
 2OfdpxasLYP0TdH++mSQV3wt73fRdDMbZFGWr7UZPR6T+HODz+OsCJLjNvmKh6awhalN
 TlXsrpQwpHpPjtwCaC2Gv2yuwWdbnHn/bzRIBN7xIiz3/sxHkGDZ+YcIruRl5VqcVeTC
 M3b3cZIHOXMfYL6KI8eprIsxoDVmbLmkUoj1o23EZoos6Yl8pjNywrD3yUXFibwRBbPK
 7CQRziyavJM+jnYfpl2G9ziw9sAtkVKPsNb3rT1jy8/rDt9KJj4ULx/eyLKTTYU9jUTM
 Dpqw==
X-Gm-Message-State: APjAAAUzxQ1M+wBOowmU/XHJzjEva/dCwzlx2XpIQpz5nr5GCOsgAozt
 4r55Z5LvM2/yTqes+s7CdGZKRw==
X-Google-Smtp-Source: APXvYqx0o5kSeiyU28PtSoeBZE+qEna9TFIFDyhUs0oSdErkbGkvAfcDVVb3VvvYMKQfkkWHMGI8Cw==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr28083959wro.19.1565702160531; 
 Tue, 13 Aug 2019 06:16:00 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id x20sm236909203wrg.10.2019.08.13.06.15.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 06:15:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9a39d301-e0c9-bcee-606f-e379461cd7f8@redhat.com>
Date: Tue, 13 Aug 2019 15:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 13/13] targets (various): use
 softfloat-helpers.h where we can
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
Cc: David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, armbru@redhat.com,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 2:49 PM, Alex Bennée wrote:
> Generally the cpu and non-FP helper files just want to manipulate the
> softfloat flags. For this they can just use the -helpers.h include
> which brings in a minimal number of inline helpers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/alpha/helper.c   | 2 +-
>  target/microblaze/cpu.c | 2 +-
>  target/s390x/cpu.c      | 2 +-
>  target/sh4/cpu.c        | 3 +--
>  target/tricore/helper.c | 2 +-
>  target/unicore32/cpu.c  | 1 -
>  6 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 93b8e788b18..c6998348df4 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -21,7 +21,7 @@
>  
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-types.h"
>  #include "exec/helper-proto.h"
>  #include "qemu/qemu-print.h"
>  
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 0bec54b2f8a..9cfd7445e7d 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -28,7 +28,7 @@
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "exec/exec-all.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-helpers.h"
>  
>  static const struct {
>      const char *name;
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 736a7903e22..5db016672bb 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -42,7 +42,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/tcg.h"
>  #endif
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-helpers.h"
>  
>  #define CR0_RESET       0xE0UL
>  #define CR14_RESET      0xC2000000UL;
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 816d6d7f311..d0a7707991f 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -25,8 +25,7 @@
>  #include "cpu.h"
>  #include "migration/vmstate.h"
>  #include "exec/exec-all.h"
> -#include "fpu/softfloat.h"
> -
> +#include "fpu/softfloat-helpers.h"
>  
>  static void superh_cpu_set_pc(CPUState *cs, vaddr value)
>  {
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index a6803368506..d5db7b2c03f 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -19,7 +19,7 @@
>  
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-helpers.h"
>  #include "qemu/qemu-print.h"
>  
>  enum {
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index 802e2f1eba5..b27fb9689ff 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -17,7 +17,6 @@
>  #include "cpu.h"
>  #include "migration/vmstate.h"
>  #include "exec/exec-all.h"
> -#include "fpu/softfloat.h"

target/unicore32/cpu.h has to include "fpu/softfloat-types.h" (use of
float_status).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
>  {
> 

