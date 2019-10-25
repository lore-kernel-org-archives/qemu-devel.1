Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA8BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861702084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ft9kqvVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861702084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzIL-00016Q-JG
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNzG4-0006Rd-S2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNzG3-0006pj-IN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:04:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNzG3-0006pT-CO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572008638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlFLM5j7DQtki2sjwtRwOXXFAm3jyY4JiI1p8RCexGU=;
 b=ft9kqvVgE3hz4V6T1tYeObGYQWIOb9TghZwjHoL/VfrqU7Z/BNJl+9nB7A5RILOiAf8InY
 yJ8gY8rdOPC3c2kLc0pZpO1H2pdl91K2OCNqtFouedyRHJWHoBKzA7V5qCKFUQe8tUZEta
 yeyMFuqlay0zK6eOXxHGK4B4Zyur99w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-iNo1AQHFPwK1JfhV0U1CCA-1; Fri, 25 Oct 2019 09:03:52 -0400
Received: by mail-wm1-f70.google.com with SMTP id i23so1108651wmb.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rjxW4p2hAKBYgy4TXLLojDsFJkPUTZCzy5Ou1SkLLAY=;
 b=sNtvRgl41i6stkNLeQjZU6asUvBXz4fJ5ALowfHm8FLeXhKZ61eoC5CiIX6xi2v2+v
 1gUDHWOy2YUUeARoV5wOalBEGVDjXmeNLTlOtGhsHWNbbiuEjOlIGI9NlSKMkZCsuebt
 vCREama7uOD7CTWE2wBTJxGHRWpP9AYvMTxpoqB1hTEc773X6QwMvKLrpqqzE4kXb1Mj
 0mxnUevrwUcWrTizleTl0DX9/lmRaV2BedIeYZf9gfcNvjpl9EoB7RbfysSKq5FZtPGy
 s3l2KS0PC5ekYOcDAbNvhsbbQYJui3q0CQBalTw5sshelaWGV4bELS11Q2M1aChwlODK
 7ZRA==
X-Gm-Message-State: APjAAAXt7Ol3IfGNp/oDSrFg1s6brI/IELDogopuaOoNiAjztkjA5vyI
 xZS3HNL9DkSOQcinDLPIld5rY6J0eIX7KlioRUWDR1/NM/2ciD1zKHQopoiolQMqmwlpvBSBkJT
 MtSKw7SzTPkxTwyA=
X-Received: by 2002:a05:6000:142:: with SMTP id
 r2mr2949497wrx.30.1572008631007; 
 Fri, 25 Oct 2019 06:03:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/NAa91vr2jA+vpI678hy49Tjy6ImDYfaFg8Zt1CgQl0UpwV1gf2/wJnHSyUePIIp/FlhsZg==
X-Received: by 2002:a05:6000:142:: with SMTP id
 r2mr2949466wrx.30.1572008630796; 
 Fri, 25 Oct 2019 06:03:50 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id r27sm2683703wrc.55.2019.10.25.06.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 06:03:50 -0700 (PDT)
Subject: Re: [PATCH v2 09/12] linux-user: Rename cpu_clone_regs to
 cpu_clone_regs_child
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ccd5a50-79ba-afad-2844-ecdb62ae0d53@redhat.com>
Date: Fri, 25 Oct 2019 15:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-10-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: iNo1AQHFPwK1JfhV0U1CCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 1:39 PM, Richard Henderson wrote:
> We will need a target-specific hook for adjusting registers
> in the parent during clone.  To avoid confusion, rename the
> one we have to make it clear it affects the child.
>=20
> At the same time, pass in the flags from the clone syscall.
> We will need them for correct behaviour for Sparc.
>=20
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Add flags parameter.
> ---
>   linux-user/aarch64/target_cpu.h    | 3 ++-
>   linux-user/alpha/target_cpu.h      | 3 ++-
>   linux-user/arm/target_cpu.h        | 3 ++-
>   linux-user/cris/target_cpu.h       | 3 ++-
>   linux-user/hppa/target_cpu.h       | 3 ++-
>   linux-user/i386/target_cpu.h       | 3 ++-
>   linux-user/m68k/target_cpu.h       | 3 ++-
>   linux-user/microblaze/target_cpu.h | 3 ++-
>   linux-user/mips/target_cpu.h       | 3 ++-
>   linux-user/nios2/target_cpu.h      | 3 ++-
>   linux-user/openrisc/target_cpu.h   | 4 +++-
>   linux-user/ppc/target_cpu.h        | 3 ++-
>   linux-user/riscv/target_cpu.h      | 3 ++-
>   linux-user/s390x/target_cpu.h      | 3 ++-
>   linux-user/sh4/target_cpu.h        | 3 ++-
>   linux-user/sparc/target_cpu.h      | 3 ++-
>   linux-user/tilegx/target_cpu.h     | 3 ++-
>   linux-user/xtensa/target_cpu.h     | 4 +++-
>   linux-user/syscall.c               | 4 ++--
>   19 files changed, 40 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


