Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77C2C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADD0216F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADD0216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv7EP-0005wW-VU
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 17:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hv7DV-0004vS-OO
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hv7DT-0006CS-19
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:42:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hv7DR-0006BU-4g
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:41:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so89381508wrs.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 14:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1CYu7Mek86EfTJ9NgPT/fCj9NUcIOu8Sf7iL3Hlb4jM=;
 b=IIjjmPyX4RVLO7/MaY+yknuFUWbkAW4edeN14aoUw7EVjrwb6BWVHOcVT2gHGe8hUv
 Bgl4ibOZ8iR3IzV9FamkACRMzWXJu2mK2zPBRLsB1rLOivwf3l2ZwHNpVBAcArVXoHki
 BkkGOurrlxG8nBCaPNxNdscPtCp/GbhejuDA8K/0BPbQN6t8Wfi2bxmlATr4+wUniCZE
 7yN/W+xhOQWEGV00YayOgkq/x/fRuzNyRUxv1my5KtlTfFPljzfDzwRyfQ0FlS+NAyrp
 qcZImcaPbbLxT+9pXiP9zkwOoeQwJn1ec1+vSAcNReEO7f5IHgZtA+I5NO/iYPM1kXQ/
 j6cw==
X-Gm-Message-State: APjAAAWUjrrRFDkzvSTE1enOsGHwanYGEC35n3+TCCEntE9Aq8XVTj1k
 Ccd9m/vNcy2odwJn18Wi8oShqg==
X-Google-Smtp-Source: APXvYqxV11UyCJh3O+WojDYq3LEro0A0l+sN3bPVMBNuAvyBUFSaScmHNCeUuQv0tOt0VXYF/9CSWQ==
X-Received: by 2002:adf:82c3:: with SMTP id 61mr5339774wrc.150.1565127715697; 
 Tue, 06 Aug 2019 14:41:55 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id l17sm65920071wrr.94.2019.08.06.14.41.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 14:41:55 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <38e14303-9ae6-437b-5875-4e6d930834ed@redhat.com>
Date: Tue, 6 Aug 2019 23:41:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726175032.6769-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 11/67] target/arm: Add stubs for aa32
 decodetree
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 7:49 PM, Richard Henderson wrote:
> Add the infrastructure that will become the new decoder.
> No instructions adjusted so far.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c       | 45 +++++++++++++++++++++++++++++++++++-
>  target/arm/Makefile.objs     | 18 +++++++++++++++
>  target/arm/a32-uncond.decode | 23 ++++++++++++++++++
>  target/arm/a32.decode        | 23 ++++++++++++++++++
>  target/arm/t32.decode        | 20 ++++++++++++++++
>  5 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/a32-uncond.decode
>  create mode 100644 target/arm/a32.decode
>  create mode 100644 target/arm/t32.decode
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 36419025db..4738b91957 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7715,6 +7715,33 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
>      }
>  }
>  
> +/*
> + * Include the generated decoders.
> + * Note that the T32 decoder reuses some of the trans_* functions
> + * initially declared by the A32 decoder, which results in duplicate
> + * declaration warnings.  Suppress them.

Ah! This has been bugging me with the various MIPS ISA for some time
too... Which makes me wonder if this shouldn't be "generated" using some
option when calling the decodetree script. Or have it notice the target
has dup declarations and automatically emit the guard.

> + */
> +
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic push
> +# pragma GCC diagnostic ignored "-Wredundant-decls"
> +# ifdef __clang__
> +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> +# endif
> +#endif
> +
> +#include "decode-a32.inc.c"
> +#include "decode-a32-uncond.inc.c"
> +#include "decode-t32.inc.c"
[...]

