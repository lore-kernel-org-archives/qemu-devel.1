Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F97C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7118120663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/0yJbJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7118120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg54N-0002m2-Hn
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hg52Y-0000WV-J4
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hg52X-0004oW-CV
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:20:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hg52W-0004m7-VJ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:20:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id c6so1513970wml.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AJROqdVuF3MKSOUxZEUUzGgPgREzKz04HNRZCztinVY=;
 b=m/0yJbJnx4fCTEXTrOgsHsxrl3hX6Nzptdr0Xe26prTmK2ZDFA0XdZa8s5s75Isp4U
 913az60WI8i8qtgY/UaxzPfXwQ8KRKKcEsrUpD7Z1ErwX7vRnMK8qQig2EPAnTne+/wQ
 KCCFCBCmZzCsZhLmvfIH9SnBRYazVjMT5DU1xZu3L6kzLWpsfaINVtO6vbHlVy2tdINv
 9xAOIy5JcXlcJ57lU46oBEqCphw2gkB4KUzrOXUH83bNi75Y0spv2XTX541HUsgXTYFk
 c6IdTEAGwOEgKRgyDIB9CQ6/2iORi7uweh7bqwfSXOnBWJVZQDuNKLa0b6OazaJ8mlhK
 0d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AJROqdVuF3MKSOUxZEUUzGgPgREzKz04HNRZCztinVY=;
 b=j5U+RbyZlh2cicF+fQ/8H0KIVcaRO/EMhy4mQKZhjx5YJ0W7M5gvO/JVVBgkpOlWDI
 PtpteP+oPgD2FGlynMsuLmNBryOrcJ4DIcpIp08dAcXbbS+iw/VtMb5nSJiPXWvngb0c
 xMtqNd0dbX5WaqaoxMe09fDFhBr+oN056A1PguhOuiGGfSl4BSoxothyG9DfUOKf16V1
 DAugypcV90HJMa6MCDgNV/b3QJ5qflDjpaiLBKe8F3cRNNr/RTI9tWoSdfBOQ8IuWMWg
 C+quHbMpwCcF7c+RblPo7UZp+EnQJVIp/Ehrf7zEOZSVQQwnOSPqfzFZd7YvFd8ryfxu
 EO6Q==
X-Gm-Message-State: APjAAAW8ocW+TVfqMgtTnSGJIwT7xkhcQuywPtrWjhCEOFKN0tT0Bdla
 fTI8BOf0TRGuPXN+4mFYEm9n2A==
X-Google-Smtp-Source: APXvYqzMkSfavkM8g6Ou7HsrjGV1NSrMZl0A/bF457+KLh7Huj0b7lFzlXoR3U5ptXC38GrIgDCGBw==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr2162544wmb.107.1561544431257; 
 Wed, 26 Jun 2019 03:20:31 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id a2sm3478001wmj.9.2019.06.26.03.20.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 03:20:30 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-7-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c794d810-fbaf-ff81-9833-3e40fb5a951d@linaro.org>
Date: Wed, 26 Jun 2019 12:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-7-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 06/14] target/arm: Allow SVE to be
 disabled via a CPU property
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 6:34 PM, Andrew Jones wrote:
> Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
> a CPU property") we can disable the 'max' cpu model's VFP and neon
> features, but there's no way to disable SVE. Add the 'sve=on|off'
> property to give it that flexibility. We also rename
> cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
> to follow the typical *_get/set_<property-name> pattern.

I think perhaps the new property should not be overloaded on cpu->sve_max_vq.

At present you are generating an error for

    -cpu max,sve=off,sve_max_vq=2

but not for

    -cpu max,sve_max_vq=2,sve=off

and then there's the issue of

    -cpu max,sve_max_vq=2,sve=off,sve=on

discarding the earlier sve_max_vq setting.


> @@ -1129,6 +1129,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          cpu->isar.mvfr0 = u;
>      }
>  
> +    if (!cpu->sve_max_vq) {
> +        uint64_t t;
> +
> +        t = cpu->isar.id_aa64pfr0;
> +        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 0);
> +        cpu->isar.id_aa64pfr0 = t;
> +    }


I suppse the isar bits are initialized too late for you to be able to re-use
the ID_AA64PFR0.SVE field *as* the property?


>  static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                        uint64_t value)
>  {
> +    ARMCPU *cpu = env_archcpu(env);
>      int cur_el = arm_current_el(env);
> -    int old_len = sve_zcr_len_for_el(env, cur_el);
> -    int new_len;
> +    int old_len, new_len;
> +
> +    assert(cpu->sve_max_vq);

Certainly there's no reason for this assert, given the above.


r~

