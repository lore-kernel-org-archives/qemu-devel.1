Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ACCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD172084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2hrkJy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD172084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzHo-00085A-JM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNzGK-0006YA-OS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNzGJ-0006uR-JG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:04:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNzGH-0006tC-KW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572008650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laHd1lN/1WJAJmLgLdH9yYZEwWDY+6a3wodOt82g1CU=;
 b=e2hrkJy1eVFeww8xLtaMfTIH4DNMk06yPLViv5U4xpEv3QQwch0ZQcMkWV88u9m25E8GKx
 8R+Lou+eyDaMXBsJgsK5yGQ1cjDGO16iHYn03vkpKhz/opTVuln8QazqCe0lTR22soKvzn
 CxX3CkEjKwmR4l3rSGYPKzkI4lmdwMw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-mOKIvREFMwGuZ3ctb5GY2A-1; Fri, 25 Oct 2019 09:04:07 -0400
Received: by mail-wm1-f72.google.com with SMTP id m16so932586wmg.8
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OlrWWmKOMPswt7fkZDBMkt62X5bt+20DXgn52UiUur8=;
 b=qEBbGKQyfWwqfTOfz9bK4kryIKlG2in2jzZXCNyoJvnif++6gNA4DS3Gszx1UyKcne
 Q6sb3+iwvoEw/PvcGuOcq0NK981bJV6WMzXZ6e2dr+lV7mOkcgIioflDMEQUVr1c1eCn
 ttFqaegSoeoIKlQO6dLV3W4gmrow3xVu+w48+bEBiQSYzyWuG9RMl+0DsA+NGG19YTo8
 M5dZ+u/Z2fOO1w22XuJJsHiIgpqBIlmoB553yZiREet5B8sASc9l4iXi/qSQAsQIVAJ0
 kmnMrcHpXUIiIVvpcvmVlelFvCmayx8ZxdFSSjERA8pxGF9ZfNogkhRcsT68wUeHa+oO
 iI0w==
X-Gm-Message-State: APjAAAUZP+lXYrQ1JV+OE8XnMiq6Wb4iU1Q/lLuXlpGe8qCigg3h6HEB
 IKYWRtvik0y+Vwo1nHLoT6/znw7GXZFhP4z5FfpIWHYcnnybct07U5JUOeYqicAWCKYeUXxm3fF
 5mMv31AeoEnOr7Ss=
X-Received: by 2002:adf:c105:: with SMTP id r5mr2957575wre.125.1572008646150; 
 Fri, 25 Oct 2019 06:04:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwlCieRhSjrhPtGhL1iU/veL9G8WQlqSFJPudEPHAGAacJx8cexRD3+6wb9GPKK4lwuW0G5nQ==
X-Received: by 2002:adf:c105:: with SMTP id r5mr2957552wre.125.1572008645973; 
 Fri, 25 Oct 2019 06:04:05 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id o4sm2488568wre.91.2019.10.25.06.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 06:04:05 -0700 (PDT)
Subject: Re: [PATCH v2 10/12] linux-user: Introduce cpu_clone_regs_parent
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f586f6c-9cc1-ab18-6335-55aa0bf2abca@redhat.com>
Date: Fri, 25 Oct 2019 15:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-11-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: mOKIvREFMwGuZ3ctb5GY2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> in the parent during clone.  Add an empty inline function for
> each target, and invoke it from the proper places.
>=20
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/target_cpu.h    | 4 ++++
>   linux-user/alpha/target_cpu.h      | 4 ++++
>   linux-user/arm/target_cpu.h        | 4 ++++
>   linux-user/cris/target_cpu.h       | 4 ++++
>   linux-user/hppa/target_cpu.h       | 4 ++++
>   linux-user/i386/target_cpu.h       | 4 ++++
>   linux-user/m68k/target_cpu.h       | 4 ++++
>   linux-user/microblaze/target_cpu.h | 4 ++++
>   linux-user/mips/target_cpu.h       | 4 ++++
>   linux-user/nios2/target_cpu.h      | 4 ++++
>   linux-user/openrisc/target_cpu.h   | 4 ++++
>   linux-user/ppc/target_cpu.h        | 4 ++++
>   linux-user/riscv/target_cpu.h      | 4 ++++
>   linux-user/s390x/target_cpu.h      | 4 ++++
>   linux-user/sh4/target_cpu.h        | 4 ++++
>   linux-user/sparc/target_cpu.h      | 4 ++++
>   linux-user/tilegx/target_cpu.h     | 4 ++++
>   linux-user/xtensa/target_cpu.h     | 4 ++++
>   linux-user/syscall.c               | 2 ++
>   19 files changed, 74 insertions(+)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


