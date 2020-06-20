Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF35C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4162405E
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoR8B86U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4162405E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmhgG-0008Sl-Kq
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 13:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmhfd-0007jl-Hn
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:52:49 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmhfb-0007nq-QQ
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:52:49 -0400
Received: by mail-pj1-x1044.google.com with SMTP id m2so6095620pjv.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qpAgmNhbCbxUxrAmLV98KdjwQUGX2CR0rzvnM/hRZ+k=;
 b=LoR8B86UifyfMX1YONc0s6XUQUgIFuK0jWwIP4BnoLPAUveTQfJjRCFhcvL5F2gXi8
 ZS5P0MhPtNe8FasrOkHxtZddQ9e96JLHZKMIDZV3zptYlOdgeRHJRjDPFlZuBpHpcYRO
 1w+hGiuwPXYbRD9nBLYRLGnvL0MeViHRDMh7+nSdYPQtZFpZwUEsoLpa+0/DgxgUoUam
 o8Up6AMxtLlqUL1Asg7HuVWu6U0D7El2658zUKXzVWmvnj+ihycfRImYtZUkn38WPq7h
 JT8jJK9sLStKj7b3o64ks0cWoNnRyR7rY02wuO7fJQsmsyuU8zx7weFX2WFWYIenvpuc
 iOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qpAgmNhbCbxUxrAmLV98KdjwQUGX2CR0rzvnM/hRZ+k=;
 b=CcwHHijsGwXaWPlkN8TADSp8xZA4IvRNXpqlruh68Nn1hcME8zAoh6WpdRoIKdKcsw
 zHietU6Rv2WEZ/5voJAgBBj9UDohIzXMVe77EaSl1Wbod6l7nTt4qLJoT0TAsh1DzfL4
 1kJX7tML1wd7D/zFfkrVxX28lRHZftNe3VX/uOf7/p8kyLwdgl5PL2w7nUJ5fwHkXilt
 hzrF+WrFmXmtFOXpn/nOCl4U8ghfHDmamULRtqfeXduOCj9humzGjzmJdi2w5WVSSC/T
 JyeAlsAubVzLEtG0K5Kt39wzplUIqE7XbDCPj0e8ukFfr53doQNtZrOJGz3PxH2wE2RG
 ehuQ==
X-Gm-Message-State: AOAM532acz6of2TpDqNWXymsJIyjoqIBhgS4pCeTNZVm7a8xICY5Yl60
 O8PPoNkwNE/AJ/79/c+FlVk4pA==
X-Google-Smtp-Source: ABdhPJzCKQy43OgS0L043sMCFXLmIPQ6E5xYbz//vSAqKEumm5qMAHU4R5SAZnUj06+X9sPAveUE/g==
X-Received: by 2002:a17:90a:b383:: with SMTP id
 e3mr9907964pjr.57.1592675566263; 
 Sat, 20 Jun 2020 10:52:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d6sm8857237pjh.5.2020.06.20.10.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 10:52:45 -0700 (PDT)
Subject: Re: [PATCH v9 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200615103457.25282-1-philmd@redhat.com>
 <20200615103457.25282-2-philmd@redhat.com>
 <20200616153122.GN550360@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc57c3d1-020e-8e48-228d-c9a31104ab3a@linaro.org>
Date: Sat, 20 Jun 2020 10:52:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616153122.GN550360@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 8:31 AM, Daniel P. Berrangé wrote:
>    fw_cfg_add_file(s, filename, g_byte_array_steal(data, NULL),
>                    (guint)g_byte_array_get_size(data));

FWIW, you can't both read the size and steal the data in the argument list like
this -- the evaluation order is unspecified.


r~

