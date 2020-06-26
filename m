Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73F6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD6B2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1JtF5RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD6B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofcQ-0000h7-NL
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 00:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jofEM-0007RX-H5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:40:46 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jofEK-0005kb-I8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:40:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id w2so3561269pgg.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OL6gy2VaEYDw49xEIjB16DvTd2cICjONGLkIwRK+XzA=;
 b=B1JtF5RZ82qPxGJcktBH3uQ+jrmxTR38y5d5MnCRlfjtrkPzzUVit5DnQ5N/pKuMtY
 xu6nLEGBjwozSgnOosEHw8yFsv10yagIvBduumreolYwJJJuDFlgut+2vTNz8bNtx5bH
 kLYRfOknp4Rh2MGMU+Ow8Kq/ngt7MAMlqF+7JrV17Ml9GOF6aC49LU9OKPNGpxXtAvKk
 OHcRrxfKOz43u6aRB48ORNt3QmGAOOMdRZ8hm06jnny2iIe2rxTzkkx2w7nCXwVcbJLZ
 HGoAhQEO+ulidtBXyQ85Ho0o53In4hCjhR7D0PShqU3ApSICevhu3IMjFIB/ga5+rqHn
 5gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OL6gy2VaEYDw49xEIjB16DvTd2cICjONGLkIwRK+XzA=;
 b=kq2dLi/9qYVK4sqrNhHrwgen82Whp+LgyApWhSdGb2tF1z4ud1s58weC5Oes2I47S0
 kbcDcO+DtADiYNt8D2Bx/Nq2RWayo4SuXPWYqVGVx1nbiATQdcrGesNQQiDC5SRW2wE+
 nSSiXRZqbIhnsbf0UqaqoMb+ciWBp+xiw4Qu8Y1vyzGKxZAAg3PP1/jsBzYftghqP+1/
 L5iHvGucIk83ebhWCVRBh6nFRZxWlnqczZm68RDlSNADMESa/c1L9CD3OrxGPAvtILXr
 3JM1hnjXMPOt/rwGUvk3K3rz+a94l5XGmGAjAzEprnVVL4cK0vDhXi7hhN+qg7/GzgMc
 Cdww==
X-Gm-Message-State: AOAM530blf6GyJWr0UJoeu8t+rgl/4LwW7es4YwgupJD5mdAIPWHNd4S
 farmIxQkFPSA8lIlHQBo1wBvfA==
X-Google-Smtp-Source: ABdhPJw8tdfa5eyRO6v8i0JBFT4mFgRbSAIMA6d+sAeKx0mi4up9Kl5U7L5lKshd5QiowDZ/vQ3xPA==
X-Received: by 2002:a63:8c18:: with SMTP id m24mr966605pgd.289.1593142843302; 
 Thu, 25 Jun 2020 20:40:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b4sm24741611pfg.75.2020.06.25.20.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 20:40:42 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] target/ppc: Introduce Power ISA 3.1 flag
To: Lijun Pan <ljp@linux.vnet.ibm.com>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-2-ljp@linux.ibm.com>
 <bc918ea4-8023-9186-b603-27e9050ac8d2@linaro.org>
 <835A870F-32B8-4A36-ABC8-850365BE7827@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46ed6dba-9c69-5e75-4b4d-e3d0f8a0902f@linaro.org>
Date: Thu, 25 Jun 2020 20:40:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <835A870F-32B8-4A36-ABC8-850365BE7827@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 2:12 PM, Lijun Pan wrote:
> Do you mean not submiting the second patch until all the instructions are enabled in the future?

Well, I mean not *merging* the second patch until all of the instructions are
enabled.


r~

