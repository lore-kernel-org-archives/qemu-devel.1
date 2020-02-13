Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A7C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBB1222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmpkQnSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBB1222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JL8-0001gA-Oq
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j2JGs-0004Ab-HI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j2JGr-0003bp-Ie
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:31:30 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j2JGr-0003Yy-Aa
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:31:29 -0500
Received: by mail-pg1-x542.google.com with SMTP id u12so3195714pgb.10
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
 :content-transfer-encoding;
 bh=e1B/DYZh4ud6jziUk6EW6H965tP5guCdaoUQ3+Ha3jQ=;
 b=SmpkQnSzhjpVoohMrKBe+I4Pi+O1Ie26fWJfUBW+gihdO23FwR5Zwg2vfiNnJQUZHx
 A3u4jkbimOYDRHnrkNWmOHs0vu+rZDLmR+/T9XwgGVQJ9/xZz1ju4YzHMyNM1aGnpMbK
 C+HBHT6N9jO/lMTjbd4iv9IRANY9EWaz9XMP0YLBHvUuNFy0KoDI+TgKlYpbyF5mWA/2
 bYfFspltR0e6rmaKD/VmcLAqldWNzPwlcD4y/WHJR/hW2/CAkmfHDvLrsBBR0R64fn22
 Ca8v0YVGbjFSSXQ7g4gdPyOfE4nh48RUPQDw7CVGnnHfJ+dq/5G1/vR/iEuTBj3JCXGa
 YXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
 :mime-version:content-transfer-encoding;
 bh=e1B/DYZh4ud6jziUk6EW6H965tP5guCdaoUQ3+Ha3jQ=;
 b=lJwFmxqCuL+ssSMg62C49a672R1MaeRpouHC4inDdlVyCcwtxTCHS1K9piYQVk5Jre
 cB6D/mKE7odXenmckolRhyDAh+lG1qMEfCxZKJmNdbPmDGMPjs0B2Z/bdMcUmOuVktDx
 OQHcK09Iwr1YSozn5lagdNK1cG/QutsSGEItE/QETs7AFsARuLymqE3qoSRqgXSZHT/L
 FClvsI1jDNtJ1bSD79b3OBodNwAwP6cYTh35s7u4411fvFqyAQBSnHCDgPt5IpJGle6h
 u+aKfJ7Vv1p50dNc+c/7HNmrjNDTwdVNkBIVEACmHFJbJifDyLRQhH+0KBIAwi8TO+c8
 KGTQ==
X-Gm-Message-State: APjAAAUjTBBT+0PZjhnqFGEJaQz0lPdhyUA39zFUEckDM3Yg9JqXYwSz
 zD+BkStjQ5UtmeIXBtxaKWMLDlRi9xQ=
X-Google-Smtp-Source: APXvYqwAwU37DkF4MiduiPYDVUXvJggcmf0+8uP3J+zA8IjMqYvEjnVs5mW9CXaTkeVFhA12OaPyPw==
X-Received: by 2002:a63:1f54:: with SMTP id q20mr18134875pgm.400.1581618687341; 
 Thu, 13 Feb 2020 10:31:27 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id q15sm3937679pgm.47.2020.02.13.10.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 10:31:26 -0800 (PST)
Date: Thu, 13 Feb 2020 10:31:26 -0800 (PST)
X-Google-Original-Date: Thu, 13 Feb 2020 10:31:24 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 25/35] target/riscv: Only set TB flags with FP status
 if enabled
In-Reply-To: <e8605241a8acc3ead0177d723f70a44d08234b24.1580518859.git.alistair.francis@wdc.com>
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-758094f5-1608-4295-942c-de47919a054b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

On Fri, 31 Jan 2020 17:02:41 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5b889a0065..aa04e5cca7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -332,7 +332,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>  #ifdef CONFIG_USER_ONLY
>      *flags = TB_FLAGS_MSTATUS_FS;
>  #else
> -    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> +    *flags = cpu_mmu_index(env, 0);
> +    if (riscv_cpu_fp_enabled(env)) {
> +        *flags |= env->mstatus & MSTATUS_FS;
> +    }
>  #endif
>  }

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

