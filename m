Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC312CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E66214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISMA6S0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E66214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwOt-0004aa-FG
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iMwMN-0002pU-Np
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iMwML-00021U-Pt
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:46:11 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iMwML-00020b-JN
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:46:09 -0400
Received: by mail-il1-x143.google.com with SMTP id z10so15874895ilo.8
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R1/1+7Md91Hq7JIEadkFQbLhX++CiuasU+Gk0+oBnZw=;
 b=ISMA6S0BVgaHS1z9CzfMidhqweschHi0F8RqCgg17TjEW6Y56k2X/2TQp6LNkrCQP0
 lQpLyXVIYof2TX5Tkzwq08vHrb/2plPLsCqrpiRTKse1u0z2Eq5yohHxh3prfEMan56e
 nYfhW5wJs1pcnmDWxT3/Xmzz6gT6Dh3eJ8Pz2ec3ZzRC50r9JwoGm02Tk5azHQZivpo7
 U7XXTEsIyDgxBxcj7KMc4uEndeEQCphV4d90bVdaJnp6esLnpjj+qEPtWq8QVfsI2LOz
 1pLd7RISm77JmMIpRbWRiJ/1Du4sWAkM2bFJfg03OdcbTA4ZSD3oqbfGxxHPcTxrWEJo
 ADXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R1/1+7Md91Hq7JIEadkFQbLhX++CiuasU+Gk0+oBnZw=;
 b=LgcQvF4iLGtxZTzCaqbb4tCBj7ShXkp6HwpvWBBKk0SaHe2r9R3WosDsVqn1qAOUWr
 OlUIsihgB4KHzPPKegZ6aq5AaXtdvt9yc/QX6R1Py41wDOzVzr/1IlMZZiUK9kpdPZyk
 SStJYx2ChxlHl35wpX3dj7hnPWE13D15zzrHpiJE+huQ9LecA8z2RjOO3FHJFnrHTmvf
 WsAYRsrunMHThH8N5w9KYmLTE8vQ05zeg8os/0OWpFOnzHUypwu18dpDE7paPxrC0fha
 ALO5yNTg6TR2Ap1DqceUyWVwaqTZ7p8fkTDNXZ8pUgWqFCmQ4Bt0BJ6KCQWsNVmqBRJh
 /FsQ==
X-Gm-Message-State: APjAAAXtlHFGETioZ0u9UofnDRjbh9fw8RBqdD+naJUrcMWVCZFRxJbL
 1Hw3eiV9YvNurmi6hhk6jDLgN0lAIKIC4b8bs5vjnQ==
X-Google-Smtp-Source: APXvYqxN+vp7nTy2MxPrGN5tWHsb1KGo8nRkrbkCTryoiCn4KFntgNNVa0RUQeKNo2ZeabNAeI9GYZEotKEpBONN7ko=
X-Received: by 2002:a92:2406:: with SMTP id k6mr34342536ilk.260.1571759168185; 
 Tue, 22 Oct 2019 08:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-8-drjones@redhat.com>
In-Reply-To: <20191016085408.24360-8-drjones@redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 22 Oct 2019 16:45:57 +0100
Message-ID: <CADSWDztWryn0uPwEo+Kd6JvF-NOGomt1CYu7N-+VYva-v817nw@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] target/arm/kvm: scratch vcpu: Preserve input
 kvm_vcpu_init features
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

HI Andrew

On Wed, 16 Oct 2019 at 09:57, Andrew Jones <drjones@redhat.com> wrote:
>
> kvm_arm_create_scratch_host_vcpu() takes a struct kvm_vcpu_init
> parameter. Rather than just using it as an output parameter to
> pass back the preferred target, use it also as an input parameter,
> allowing a caller to pass a selected target if they wish and to
> also pass cpu features. If the caller doesn't want to select a
> target they can pass -1 for the target which indicates they want
> to use the preferred target and have it passed back like before.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Beata Michalska <beata.michalska@linaro.org>

Thanks

BR
Beata
> ---
>  target/arm/kvm.c   | 20 +++++++++++++++-----
>  target/arm/kvm32.c |  6 +++++-
>  target/arm/kvm64.c |  6 +++++-
>  3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index f07332bbda30..5b82cefef608 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -66,7 +66,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>                                        int *fdarray,
>                                        struct kvm_vcpu_init *init)
>  {
> -    int ret, kvmfd = -1, vmfd = -1, cpufd = -1;
> +    int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
>
>      kvmfd = qemu_open("/dev/kvm", O_RDWR);
>      if (kvmfd < 0) {
> @@ -86,7 +86,14 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>          goto finish;
>      }
>
> -    ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, init);
> +    if (init->target == -1) {
> +        struct kvm_vcpu_init preferred;
> +
> +        ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
> +        if (!ret) {
> +            init->target = preferred.target;
> +        }
> +    }
>      if (ret >= 0) {
>          ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
>          if (ret < 0) {
> @@ -98,10 +105,12 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>           * creating one kind of guest CPU which is its preferred
>           * CPU type.
>           */
> +        struct kvm_vcpu_init try;
> +
>          while (*cpus_to_try != QEMU_KVM_ARM_TARGET_NONE) {
> -            init->target = *cpus_to_try++;
> -            memset(init->features, 0, sizeof(init->features));
> -            ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
> +            try.target = *cpus_to_try++;
> +            memcpy(try.features, init->features, sizeof(init->features));
> +            ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, &try);
>              if (ret >= 0) {
>                  break;
>              }
> @@ -109,6 +118,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>          if (ret < 0) {
>              goto err;
>          }
> +        init->target = try.target;
>      } else {
>          /* Treat a NULL cpus_to_try argument the same as an empty
>           * list, which means we will fail the call since this must
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 2451a2d4bbef..32bf8d6757c4 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -53,7 +53,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          QEMU_KVM_ARM_TARGET_CORTEX_A15,
>          QEMU_KVM_ARM_TARGET_NONE
>      };
> -    struct kvm_vcpu_init init;
> +    /*
> +     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
> +     * to use the preferred target
> +     */
> +    struct kvm_vcpu_init init = { .target = -1, };
>
>      if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
>          return false;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 850da1b5e6aa..c7ecefbed720 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -502,7 +502,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          KVM_ARM_TARGET_CORTEX_A57,
>          QEMU_KVM_ARM_TARGET_NONE
>      };
> -    struct kvm_vcpu_init init;
> +    /*
> +     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
> +     * to use the preferred target
> +     */
> +    struct kvm_vcpu_init init = { .target = -1, };
>
>      if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
>          return false;
> --
> 2.21.0
>
>

