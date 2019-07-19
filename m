Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3AFC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD23B21872
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD23B21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoWaF-0002u1-7M
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 13:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoWa3-0002Nt-Qg
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoWa0-00050A-FY
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:22:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoWa0-0004yd-4v
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:22:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so29525094wml.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 10:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PbhLHDdRUx14ysCaVZJdG4IkpobtNSYGHjXGxn1nrzI=;
 b=QNXCsZNDoSvMv9yXAilnSllNlO8RrXgrXKbnnniHyMGYv9EI5ICbP5IB4IVXRCVcS6
 kfo26IXLwi+fHwZCpV8aRnwlWRqzwMsKGmlcNuwYBAFd3RVCVc+9gQyKdj+F9395CRTm
 WuuJLDwfkRL/dM3UXm7Q8QIpsPzroonD1lYxf3wZ5tsSQ7cHjYZRq5K0WUNiz20mWTdV
 yrd3Tt6X51rUeqhvFtsLMq4o0fLEY3vmUJxqYEx50HphgjFczvHyAdnVDAtn1VU7iJ7k
 qAQAFxJHz5WjJwD/Hmy4GcAtS3AhlfT/eVP4EzGoMUu091Bpi7sY/1CfpXX5Mg53XdKj
 nyUw==
X-Gm-Message-State: APjAAAW8/5XyPUMe0B8ICsoglIkiCnQc92LsSbMs95OcHPVljW9muRtw
 UySm4j3RSBELj0DwlpDmdFMspA==
X-Google-Smtp-Source: APXvYqwRk+/wRd4YpxLm/ztvOrmkyFqGsbOnC1KssjwCrbE2ZZOcBeHJf5OvDaU707qox/s4F/1PRg==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr51056912wmi.42.1563556917300; 
 Fri, 19 Jul 2019 10:21:57 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o11sm29424004wmh.37.2019.07.19.10.21.56
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 10:21:56 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190718125928.20147-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <40085853-280c-cd33-57ac-ccc9db6f9b36@redhat.com>
Date: Fri, 19 Jul 2019 19:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190718125928.20147-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Limit ID register
 assertions to TCG
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/19 2:59 PM, Peter Maydell wrote:
> In arm_cpu_realizefn() we make several assertions about the values of
> guest ID registers:
>  * if the CPU provides AArch32 v7VE or better it must advertise the
>    ARM_DIV feature
>  * if the CPU provides AArch32 A-profile v6 or better it must
>    advertise the Jazelle feature
> 
> These are essentially consistency checks that our ID register
> specifications in cpu.c didn't accidentally miss out a feature,
> because increasingly the TCG emulation gates features on the values
> in ID registers rather than using old-style checks of ARM_FEATURE_FOO
> bits.
> 
> Unfortunately, these asserts can cause problems if we're running KVM,
> because in that case we don't control the values of the ID registers
> -- we read them from the host kernel.  In particular, if the host
> kernel is older than 4.15 then it doesn't expose the ID registers via
> the KVM_GET_ONE_REG ioctl, and we set up dummy values for some
> registers and leave the rest at zero.  (See the comment in
> target/arm/kvm64.c kvm_arm_get_host_cpu_features().) This set of
> dummy values is not sufficient to pass our assertions, and so on
> those kernels running an AArch32 guest on AArch64 will assert.
> 
> We could provide a more sophisticated set of dummy ID registers in
> this case, but that still leaves the possibility of a host CPU which
> reports bogus ID register values that would cause us to assert.  It's
> more robust to only do these ID register checks if we're using TCG,
> as that is the only case where this is truly a QEMU code bug.

Agreed, this is clever and simpler.

> 
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1830864
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Laszlo, would you mind testing this on your setup? I don't have
> a system with an old enough kernel to trigger the assert. (The
> change is pretty much a "has to work" one though :-))
> 
>  target/arm/cpu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 1959467fdc8..9eb40ff755f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1369,6 +1369,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>       * There exist AArch64 cpus without AArch32 support.  When KVM
>       * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
>       * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
> +     * As a general principle, we also do not make ID register
> +     * consistency checks anywhere unless using TCG, because only
> +     * for TCG would a consistency-check failure be a QEMU bug.
>       */
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          no_aa32 = !cpu_isar_feature(aa64_aa32, cpu);
> @@ -1383,7 +1386,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>           * Security Extensions is ARM_FEATURE_EL3.
>           */
> -        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
> +        assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(arm_div, cpu));
>          set_feature(env, ARM_FEATURE_LPAE);
>          set_feature(env, ARM_FEATURE_V7);
>      }
> @@ -1409,7 +1412,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>      if (arm_feature(env, ARM_FEATURE_V6)) {
>          set_feature(env, ARM_FEATURE_V5);
>          if (!arm_feature(env, ARM_FEATURE_M)) {
> -            assert(no_aa32 || cpu_isar_feature(jazelle, cpu));
> +            assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(jazelle, cpu));
>              set_feature(env, ARM_FEATURE_AUXCR);
>          }
>      }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

