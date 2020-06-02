Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3954C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0F9206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RABucGXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0F9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxsr-00085F-N2
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxsE-0007aI-28
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:45:58 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxsC-0004hh-QF
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:45:57 -0400
Received: by mail-pf1-x444.google.com with SMTP id b201so318729pfb.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ItflNdMwIRaawQi3pcaC3Y6lcggQtCOHcO+2o5/8u9Y=;
 b=RABucGXppEqr6KP8YySKLXXwWfhW4TuuAqqX0clnVOZlWoR3IMmRs54S8ktD1x+qUH
 wkZKZNivTkp7c4bARAXNKTkGlmB/pX6aw4mcxI8NLB1uamfjYkSfly6FE0zYtRq3yGwn
 w/Pn4DAQkjd9m8IAUqKOhCcS81Q23wTFrv7U8+Zau9EICZMl6a3arB/XfTAY4/7gJCfV
 8J7FIBuF9sSjPWup0eKMK7FNm4NmhTQ8AgdSsPU4bLjoNdcAjkxclde8KC7mp2pmF4aG
 MgoUoWxIMV8RjCOujM9eQfqDnpUpOyqfRmk45QARp+1b7pXbibLEl/tlfUb3w1cuiLuy
 1KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ItflNdMwIRaawQi3pcaC3Y6lcggQtCOHcO+2o5/8u9Y=;
 b=R9heGFD59LgxB0cdnTvE3W56DtIdaUFRxCIZb+w4aC/qFpwAJBqhJ7D6HO75zqbKHN
 wj9Z4T2MKDWlwHLTrOdVR+nq3MPnRP1LH5RSuSdrkcGarC209eNzK5Y1aEgKafATyDSp
 8GhkZLrFCBNO2C5zXpmCmEnVlSJj+Kpn6Z+iSTiIxqPM4qHiKT7Mq3GdvJrhbFfRDsiD
 l0YqRPohIo73TnBKhC2+Zir58UqZQhDRALCMqFQRrjF8zaBh1mtEo5EH6Kta5cQUetaO
 izPur0HcbSl5KTBkKdE72UiCGObVrhxtaDHTB9gTtjIK4hiSAWKCFTVpgq9swqedk3uq
 jwPQ==
X-Gm-Message-State: AOAM5339sSxxPeieA22tRPMczS6iKuIKgrKNhcp5HkptCd7YWmldSfBA
 7W46OXh3ySlotocVLzweO2juDw==
X-Google-Smtp-Source: ABdhPJxbtCtKw8B937zuejhJH7SobzbyDGXbiVJ0onKcN68MtLpmF+MBKNAWPHGMs5R4PeXBDDQ6jA==
X-Received: by 2002:a63:5b63:: with SMTP id l35mr21756340pgm.34.1591069555169; 
 Mon, 01 Jun 2020 20:45:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x8sm747847pfm.202.2020.06.01.20.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:45:54 -0700 (PDT)
Subject: Re: [RFC v2 12/18] guest memory protection: Perform KVM init via
 interface
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-13-david@gibson.dropbear.id.au>
 <e0b5be25-db1f-ab7d-681b-bd8afdecf4e2@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a8eda0a-22de-57bf-254a-4289931a2293@linaro.org>
Date: Mon, 1 Jun 2020 20:45:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e0b5be25-db1f-ab7d-681b-bd8afdecf4e2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 8:39 PM, Richard Henderson wrote:
> On 5/20/20 8:42 PM, David Gibson wrote:
>> +        if (object_dynamic_cast(obj, TYPE_GUEST_MEMORY_PROTECTION)) {
>> +            GuestMemoryProtection *gmpo = GUEST_MEMORY_PROTECTION(obj);
> 
> This duplicates the interface check.  You should use
> 
>   gmpo = (GuestMemoryProtection *)
>     object_dynamic_cast(obj, TYPE_GUEST_MEMORY_PROTECTION);
>   if (gmpo) {
> 
> AFICT.

Or ignore this nit, since you clean it up in patch 14.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


