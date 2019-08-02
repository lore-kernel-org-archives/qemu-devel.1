Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8EC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F78204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5SoncGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F78204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htcJ9-0008GI-B3
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 14:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59552)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htbyQ-0000Xb-8i
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htbyO-0005Nx-MS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:08:14 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htbyO-0005En-CD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:08:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id m30so36428122pff.8
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7acY56a+PDiMtL6UNCH6Fj20v/00iLU8b65HWqZw770=;
 b=L5SoncGlSagGnM4NngViH5oVNAJ5AYtSgoEjRUu39rCTfGsl48XoCTFrseb0dEpEAf
 MrCp3Oh4s5GtZNagmCa33Q3Kl6HDELMmuqo7rbcZ2fkUrZWv1QlH+lvpm0gHfGWnzNE8
 SgMFJwd+nBJYg+S/jBKeWEO4ViTLHKF9HfLIGm33dNch3dVOrZpbNSKEzgBOodJpjwgD
 BgSIg5NKbaLnLGEZjgQk6UJJfSXLnVTSeq6OIaXuLZfmNwf8DqLelnyod+u1mx00I5Hg
 ailN5XNkKbD3oQ0FMY1q9Ds6DkiLNnj51SRI4UetITNdnWArsaAgm1WNA6kJ/L1Nm1W6
 QcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7acY56a+PDiMtL6UNCH6Fj20v/00iLU8b65HWqZw770=;
 b=hCAeveiSlx+9z+REA5B3tYeB9KaGh8LUzgJB1PBA+x31Cn3DZzY5iCLOsvxdjgTBwC
 X33+ow7vjSDE8n3y9CH6h5cAHKhVMO4NKwzZCGnOT+/jEJzHXzdzzb+9beDwy3BEl1Cm
 ZOG4aq6UdtSmOLBCc640Fq6uAE8BUVwLVh/z/zls11DiNCF3DnRbEFQbgb0kdCVlckEN
 IP4LG4QFkKBnRZc9ubyRuZHP0hXb/4YUrXFLs9x8n2WuGY9UqNWgDMxVQnbA8w7gov6l
 BqH7Ayp3G9zwyIYldTYQCipouCPBjV2ClTMPVa7eq6/NTetzpwRPa1So/DokruDMW41k
 XNPg==
X-Gm-Message-State: APjAAAUXLmunIFdIPh7zYKroLc99366ZqCP1yrX0IjduaJkaiNhJUBET
 eMhxKEMaMT7Vse7P+OpVQdv9JA==
X-Google-Smtp-Source: APXvYqxO1aiC5zXZa+THxvqGryRsWnr7ChOHudCnMyw1ADq+lmYljnNg7odO8FWURfnG12NxW4E8Kg==
X-Received: by 2002:a17:90a:22aa:: with SMTP id
 s39mr5411398pjc.39.1564769277155; 
 Fri, 02 Aug 2019 11:07:57 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n7sm85573945pff.59.2019.08.02.11.07.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 11:07:56 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-12-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e41ee1a4-9514-8fe9-8761-f208c9bdcbf3@linaro.org>
Date: Fri, 2 Aug 2019 11:07:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802122540.26385-12-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 11/15] target/arm/kvm64: Add
 kvm_arch_get/put_sve
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

On 8/2/19 5:25 AM, Andrew Jones wrote:
> +/*
> + * SVE registers are encoded in KVM's memory in an endianness-invariant format.
> + * The byte at offset i from the start of the in-memory representation contains
> + * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
> + * lowest offsets are stored in the lowest memory addresses, then that nearly
> + * matches QEMU's representation, which is to use an array of host-endian
> + * uint64_t's, where the lower offsets are at the lower indices. To complete
> + * the translation we just need to byte swap the uint64_t's on big-endian hosts.
> + */
> +#ifdef HOST_WORDS_BIGENDIAN
> +static uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
> +{
> +    int i;
> +
> +    for (i = 0; i < nr; ++i) {
> +        dst[i] = bswap64(src[i]);
> +    }
> +
> +    return dst;
> +}
> +#endif

Maybe better as

static uint64_t *sve_bswap64(uint64_t *tmp, uint64_t *src, int nr)
{
#ifdef HOST_WORDS_BIGENDIAN
    int i;

    for (i = 0; i < nr; ++i) {
        tmp[i] = bswap64(src[i]);
    }

    return tmp;
#else
    return src;
#endif
}

and then the rest of the ifdefs can be removed.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

