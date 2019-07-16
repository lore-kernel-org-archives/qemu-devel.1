Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7745C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EB820880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="al2p3+f5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EB820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOh6-0006Bi-UT
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46945)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hnOgv-0005hR-V2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hnOgu-0001Uk-Uf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:44:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hnOgu-0001U4-Oz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:44:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id u17so9558679pgi.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Kczy4XhR59CmZmo/Q9k0OosiZSdrviGgI0Zw62uoeac=;
 b=al2p3+f5V2ZqZFn3PwS4i9gWynKmH2nOqKxGjW7svJrHuZzlf4c+YGv/KMVq+c11DW
 zkVMnd4ASw6xCo8PpZgB5GPkN/BvV5E68He6T9Ubkc8BB4n2PL/D4wOZy+BQs4v3XMf/
 9OXVfmhwJ44ZxipM8M23HEHS+j9eza4oeYrMk8MOgMFD13+EBi8zWK8dQFgAmPAz8Ydw
 dnez9xNXEDdr5Edyzi3acSo27c0Tgv/ELD79us9HUDaIAqSfiPwfu6j6hoU4WAJ1Qfsl
 9TKScf7BXogkdJThWZy9+bYaLU2GuTuyU4DP38WHuge1fBb58V6HQKbN+hNTR7I+Hrvx
 T9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kczy4XhR59CmZmo/Q9k0OosiZSdrviGgI0Zw62uoeac=;
 b=lOWiGKnXolXL3aeO55Qban6UL/gM1l0pE37mB7rgrK8vPplUIVLASM5hmFtEkjIHcm
 oiOjlMcBXLRd2cvKdn2qCwS1gmxgk8IyvG5SrRYDyXWXBeBTPFALbxEI1xy457U9sNie
 mQMjNCQvdK7/DVT6xlVC2qBSsD7YNQ0pH9c2K4/XlAT8KM/tV7+tFOZof9GVaTdryZpY
 ilEMcrEYN5UN6/QJXeIHI2nj8CKxX6PT4lCgLRQ72ohuFtg9IXZTuOzNi5EHcN7q8/Jj
 53btDTqJust2Jvk+SJywV2QeU0eXhTf7JHCDVAlprTX5bFxx2BqZ2MKL2NpeoZdnELk4
 iyIQ==
X-Gm-Message-State: APjAAAX3dyOZPWLnehGphnhJXCui4BGifNfWCU2dYjGgKPaPQlY4v1ok
 ATeJbzLi79JKfUj3iMSrdGrqHOgqRTE=
X-Google-Smtp-Source: APXvYqyKEqRAvmBXkiBvc+XwkFcmlTrNE/IIB5q+c7l6Xx9BQyMNV6bkD1G/MbRWtxJvlwwo/6JpVw==
X-Received: by 2002:a63:c748:: with SMTP id v8mr3028728pgg.418.1563288267449; 
 Tue, 16 Jul 2019 07:44:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.gmail.com with ESMTPSA id r188sm35915436pfr.16.2019.07.16.07.44.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 07:44:26 -0700 (PDT)
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
References: <156326547324.51324.17260886524634041718.stgit@lep8c.aus.stglabs.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <58500cfb-cacb-17e9-f993-4107289a5f44@linaro.org>
Date: Tue, 16 Jul 2019 07:44:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <156326547324.51324.17260886524634041718.stgit@lep8c.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix some memory leaks
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 8:24 AM, Shivaprasad G Bhat wrote:
> @@ -827,6 +827,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
>          Object *obj;
>          SpaprDrc *drc;
>          SpaprDrcClass *drck;
> +        const char *drc_name = NULL;
>          uint32_t drc_index, drc_power_domain;
>  
>          if (!strstart(prop->type, "link<", NULL)) {
> @@ -856,8 +857,10 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
>          g_array_append_val(drc_power_domains, drc_power_domain);
>  
>          /* ibm,drc-names */
> -        drc_names = g_string_append(drc_names, spapr_drc_name(drc));
> +        drc_name = spapr_drc_name(drc);
> +        drc_names = g_string_append(drc_names, drc_name);
>          drc_names = g_string_insert_len(drc_names, -1, "\0", 1);
> +        g_free((char *)drc_name);

This sort of casting means that you got the original type wrong.

r~

