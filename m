Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F7BC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD786206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD786206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMn9Y-0000bX-1r
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 01:24:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMn8i-0000E8-B6
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMn8e-0003Bx-EW
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:23:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMn8d-0003AO-Jy
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:23:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so4596379wrb.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9eOLzGN7pzprpvTtMLEiO2UWRP7rG9AwJo7pYclFFg4=;
	b=O+xSc4t0ScTtZKbqPyYiYbOmSNVinBosxR43M/wtYEt08K2Nfj7z92/pxdk/MF3wyS
	I0Hju92OUrKVfCX/KzYydZB9YTuClrOFEiq+zg6Sn7wmi0/cVG+Tnans4SATgAkSK9O0
	qgTnqbnqlRO/X7C9GZcvLrMIeJwKfu/3ymzadqzaFhv4S66gGWlTMQlEI8Ybt+3/vz17
	tPeR0sSbiA46ggm8Jg9huKWOJPYQDqXBWRRCVlPWBUQlsDOKNjv+exCqFJ74cDuWKWrK
	4J0oINLOJQfCGeLT23g0aKBnCkN+/JVd/RglMSjWdR+XrdPpd8u2wRb8S96I7d5HSDSp
	nlqA==
X-Gm-Message-State: APjAAAWzyO3tyYAgc0FDlkGq5FzBp7ssBV1WX2TL0ZfnEBvt28cxUwbJ
	Lp3IJkxge9y0DQKuhD9+Wqm1vg==
X-Google-Smtp-Source: APXvYqxb6NHKVTloeDN0shm05GQRA7dZf8H9FJvV+132gkn4mX1tJ+X+bBuasg7/IG3KKeCvLEtT5A==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr9589784wrr.237.1556947383703; 
	Fri, 03 May 2019 22:23:03 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	t27sm10521943wrb.27.2019.05.03.22.23.02
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:23:02 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190503120448.13385-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <40488c65-1aae-60c7-4d62-52e754f8f026@redhat.com>
Date: Sat, 4 May 2019 07:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503120448.13385-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Stop using variable length
 array in dc_zva
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504052302.NyXqt3wMbj3I_DgvsuWDaP-fD4OLkLJ0TCVk1UqZwKs@z>

On 5/3/19 2:04 PM, Peter Maydell wrote:
> Currently the dc_zva helper function uses a variable length
> array. In fact we know (as the comment above remarks) that
> the length of this array is bounded because the architecture
> limits the block size and QEMU limits the target page size.
> Use a fixed array size and assert that we don't run off it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * use ARRAY_SIZE() instead of sizeof()

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  * add a comment to make it a bit clearer that the
>    expected size of hostaddr[] is only 2 entries
> ---
>  target/arm/helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 81a92ab4911..10444d12b18 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1,4 +1,5 @@
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "target/arm/idau.h"
>  #include "trace.h"
>  #include "cpu.h"
> @@ -13099,14 +13100,17 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
>           * We know that in fact for any v8 CPU the page size is at least 4K
>           * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
>           * 1K as an artefact of legacy v5 subpage support being present in the
> -         * same QEMU executable.
> +         * same QEMU executable. So in practice the hostaddr[] array has
> +         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
>           */
>          int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
> -        void *hostaddr[maxidx];
> +        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
>          int try, i;
>          unsigned mmu_idx = cpu_mmu_index(env, false);
>          TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
>  
> +        assert(maxidx <= ARRAY_SIZE(hostaddr));
> +
>          for (try = 0; try < 2; try++) {
>  
>              for (i = 0; i < maxidx; i++) {
> 

