Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C258C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5733B20873
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FN4oihnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5733B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQEcf-00085P-EB
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 13:20:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQEbq-0007gb-Sg
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQEbp-0005Nj-Uf
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:19:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQEbp-0005Mg-Na
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:19:29 -0400
Received: by mail-pf1-x441.google.com with SMTP id n19so7554956pfa.1
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=XxwWa2ijAArGPWsus3mu2myK1b43gnq5vviw5SvdiQ8=;
	b=FN4oihnzdM8f84+djyrybamm1Ng0iNIvZ6UmimF/pZri7a2KA0y1hLKa0m1BiD8o0F
	r13ypMxzFXHb0+usZf+uaW0P3yK1S7Yy/+BbDgF7uWsMAgLmO1MFNzJSH68OlFuJ+PBO
	zkoINE1ExGEFkhUXae6JO717KO7Mv9y4+VJAaOUzL6/SE4SlFGNP/I+uyceYWN5d3Y83
	HWlm9IX0pb5SjdGu/0PAstcdxu+LgoPIES3hGV76NCH3erWoD6sm/1oumuvqqTLt1eNN
	xGUFMmELPQHrpjmXMTT6jXFDLxK3QH+7hCCgWesSIgqlApD049unmj6xtcODWeo36aQh
	7pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=XxwWa2ijAArGPWsus3mu2myK1b43gnq5vviw5SvdiQ8=;
	b=NJKxXGH4JThUp1hC+F5keGua4WPaldGzCw9MC990vhvArPh8kMsT7joekP2C/zxkCF
	BLctrLZjY3HPGpDcCJiP+zNKKZY3CGr2KKYOaCvNARIPx5nAMCfE0gGr/J8CfW0V3d8B
	0XgGlD2hPdwClV2fF239om9jdmDNa10l7YNW6zpaPKmJ/Qf+eJpD4pXeugkyptFEWgiQ
	ncNHXwyfV8JLn9LXIE6aAhhw5Q2GfuovWsijgW7kbvhcitRJlNZIBbI0EzfaUNrzJZxC
	HMGLVIKRrxxdjfnf2VqzEyK5cOY2WAb4IDmBMGtcTDQ1d1EjFw04e1Mrj1ah5bm1DXCB
	md4w==
X-Gm-Message-State: APjAAAWmKHLttCadTW5XURlBXMece6CMgv0sovRZ6Frb5L0b2Uh3NYs9
	M+CMOYq4jDU8/jobcCjxt6FiiQ==
X-Google-Smtp-Source: APXvYqzEm+QiUBlc5s2j+lc5i0gf6a65KtN2gNwwMM3HI1Dc+nE2vMoGGKIaLvtsLNXF016hAeeWXA==
X-Received: by 2002:a63:a08:: with SMTP id 8mr32301138pgk.46.1557767967909;
	Mon, 13 May 2019 10:19:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	a3sm18165859pfn.182.2019.05.13.10.19.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 10:19:27 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-8-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <50d07a50-d780-2c73-d9d8-f6eeff6a17c8@linaro.org>
Date: Mon, 13 May 2019 10:19:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512083624.8916-8-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 07/13] target/arm/kvm: max cpu: Allow sve
 max vector length setting
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
Cc: peter.maydell@linaro.org, abologna@redhat.com, armbru@redhat.com,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/19 1:36 AM, Andrew Jones wrote:
> @@ -292,7 +292,7 @@ static void aarch64_max_initfn(Object *obj)
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> -        cpu->sve_max_vq = ARM_MAX_VQ;
> +        cpu->sve_max_vq = -1; /* set in kvm_arch_init_vcpu() */

Perhaps a better comment is "unspecified, to be finalized in ..."

> +    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
> +                        cpu_max_set_sve_vq, NULL, NULL, &error_fatal);

as one can set it here, via the command-line.

> @@ -644,6 +702,24 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>  
>      if (cpu->sve_max_vq) {
> +        uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS];
> +        ret = kvm_arm_get_sve_vls(cs, sve_vls);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        if (cpu->sve_max_vq == -1) {
> +            cpu->sve_max_vq = ret;

You still cannot set a value larger than ARM_MAX_VQ, as that is the fixed
amount of space allocated within the cpu structure.


r~

