Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65934C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3281D207E0
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9jxabQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3281D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLoU-0002mF-AC
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLnk-0002LH-QK
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLni-00040d-Qv
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:47:19 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLnh-0003t9-Vx
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:47:18 -0500
Received: by mail-pf1-x444.google.com with SMTP id x6so15464381pfo.10
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=un11ItUGL3UXcuCxg5SKdH17F54/6CzFcVWX6W2yUFE=;
 b=y9jxabQ/K8RyaN/8QAzbjGi/DBeVhdwDTjpc+7BpagT31fMOthH83dk/J2uHMwOLJ+
 CGWkL8GaqF/AsUMI9SVENk39EVO1dplrqW1hyoiVDhOCMW5GOQ3WAOPIRmDZ2cQn+dAb
 UOmdWnJ35MbCcu3QrHYNsWBnNyz3vvPYnWKrepxaTxUwVKh0KsZPGISmsCXgSymnkcvm
 SnN8twD0C2SjayeEGjpGgDvRlqQMb6JRezH3Ldk6iL8M68SXPnezZ5eKtUNvV/smALg1
 wGt16EaEi4D1arhi6VfDIjNEME75JrKuJ68T7hT3bH13whXCIiLPE7emRE9toEZVgPwv
 ybZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=un11ItUGL3UXcuCxg5SKdH17F54/6CzFcVWX6W2yUFE=;
 b=XfMCaiKCLL5C39QPgmiXrGQk1+rlmqcWeVngdGEJnFqg+r/YGjg8m7Scz6gq7u1zxE
 W8CuLUhBeG1KKUfmlRF/V1Nb1uYbD6KfQMGIuwlRJUCLMLm/Bjbn8KaFx/aTifnBobFS
 rOB3VIE3XKRYP4YUNhhIpojEkvz5fIwCa9icp3d6CiXiPtriKd0fTzwNg5dQe8XTJUg7
 pkf6uYEAbMYvpqPVFE9ioUt3FGqSOSVLKCHHQp2R9Qm/IPyonNXyHWWsNRMal53EQznq
 luTO5uj73ZwGE4S44ZpioZ9VV85gO4kN6YgrzahtitAjrhd9D2ygArbx6AwJ6qe73vRP
 Mf3g==
X-Gm-Message-State: APjAAAW3cSYB9lDsLAvyH6qdrg9nJ7mtJwBuK/UdAy0Uzra8Z2sQv9hl
 BNFXZ/hasZzLeI+QFzSaKwoxqg==
X-Google-Smtp-Source: APXvYqzoZYmnTpEiax9Kpcx9g1eVPBlj5eANv2XrtbTEbDU/4CjMA/MO4S9picWbSnc9dtPCh5hy6A==
X-Received: by 2002:aa7:93c2:: with SMTP id y2mr64225047pff.140.1577576836688; 
 Sat, 28 Dec 2019 15:47:16 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id 11sm46755210pfz.25.2019.12.28.15.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 15:47:16 -0800 (PST)
Subject: Re: [PATCH v6 05/11] hw/core/resettable: add support for changing
 parent
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
 <20191220115035.709876-6-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6ef0f159-0756-ce7e-1374-824186ec4c0d@linaro.org>
Date: Sun, 29 Dec 2019 10:47:07 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220115035.709876-6-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, edgari@xilinx.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:50 PM, Damien Hedde wrote:
> Add a function resettable_change_parent() to do the required
> plumbing when changing the parent a of Resettable object.
> 
> We need to make sure that the reset state of the object remains
> coherent with the reset state of the new parent.
> 
> We make the 2 following hypothesis:
> + when an object is put in a parent under reset, the object goes in
> reset.
> + when an object is removed from a parent under reset, the object
> leaves reset.
> 
> The added function avoids any glitch if both old and new parent are
> already in reset.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  include/hw/resettable.h | 16 +++++++++++
>  hw/core/resettable.c    | 62 +++++++++++++++++++++++++++++++++++++++--
>  hw/core/trace-events    |  1 +
>  3 files changed, 77 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

