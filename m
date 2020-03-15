Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434ECC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 19:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0602120637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 19:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ac2Gpel3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0602120637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDZBG-0005A9-TY
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 15:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZ7k-0004OC-9U
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 15:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZ7i-0003mI-Cf
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 15:40:36 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDZ7i-0003eO-1V
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 15:40:34 -0400
Received: by mail-pl1-x644.google.com with SMTP id b22so6900391pls.12
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rWBBelztWn3l+5B9ii97cqEND3HA6vz9gtBRsg/4GDk=;
 b=ac2Gpel3xEJzjwabmHZif3J9mt9XgySciaQaRRBNrLq1iaaa3p9AKh5ZySm1pAY+Wp
 7WuKXI64uAFvtSkL5C5WMOU0SXkBEUSSjegxl9b+nKzqmfdNTORVxSH5t0+yjClmSp7W
 Tz2PrmPeQyvdCA36I6k/2Mcx3LO2c3duap5dCHTioRCJ4dKMKAO0p0dS8HHA9UJRElnF
 aT12x/VChm/7HI0GkzHeDaeyw0FiduEbnhJOq+o/FKUyuR//GmSpojfS+nWJPpDspKn8
 QxXseEw2BdchnUilkPznxWU+QuvOiusmC+9reybUUqly+PVtym2oHdmPZHHdTtvSEfdy
 OxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rWBBelztWn3l+5B9ii97cqEND3HA6vz9gtBRsg/4GDk=;
 b=FbopFlMQDhGKxRRzarZXYNjTypOW+Q7pB8Uieajw4pMWj0Wra44V3/2+cXWqkTx2bK
 9Gzp+Mx23QXrv+4O6DloMxPNgGUuIHZ6gcoeUUiP9lLRgi+Tx8cVF62Np3v0gdPI/R5r
 xDWsZdIeLrV7RCpGEg4YS0M2SuAo0NML3Ao6o5zpl9HaYIAVwVPOU8eH2fwJWFebkHVO
 pJVI0RRyNZSFSiutJVFA/SJxRzBGDWXO9VLUaikm+Dx1zqGNlqeucTX9hiJOM054/SLB
 Xx7gQcG4wSOFkc16ZJ5OjHjawASnvz9FPCDnKdQQpBs9Y37s+nZqvTPXrCOIzMnM9eq1
 e4/w==
X-Gm-Message-State: ANhLgQ3kaQs1NvRkWfRQu8/RzJjKItV+vTobU2N1NZEdM2P+Y7RbwSEA
 pAZZ/2vUhNa+a9/c/aTj9lEYlw==
X-Google-Smtp-Source: ADFU+vuMK7+04gVLvdHhAT2GvWb0irP3tImbd3yniMzCLD0R01olHGsz5yWjP1wd6/UMp1F5aiO4Dg==
X-Received: by 2002:a17:90a:a385:: with SMTP id
 x5mr22056292pjp.102.1584301232723; 
 Sun, 15 Mar 2020 12:40:32 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 m1sm13078527pjl.38.2020.03.15.12.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 12:40:31 -0700 (PDT)
Subject: Re: [PATCH 01/14] Makefile: Only build virtiofsd if system-mode is
 enabled
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-2-philmd@redhat.com>
 <8f73d608-d28e-b896-b1f0-f95d599502f0@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d9b29b2b-58ff-512c-c426-0ffe7bcad295@linaro.org>
Date: Sun, 15 Mar 2020 12:40:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8f73d608-d28e-b896-b1f0-f95d599502f0@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 3:28 PM, Laurent Vivier wrote:
>>  ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
>> -HELPERS-y += virtiofsd$(EXESUF)
>> -vhost-user-json-y += tools/virtiofsd/50-qemu-virtiofsd.json
>> +HELPERS-$(CONFIG_SOFTMMU) += virtiofsd$(EXESUF)
>> +vhost-user-json-$(CONFIG_SOFTMMU) += tools/virtiofsd/50-qemu-virtiofsd.json
...
> 
> Why don't you do that instead?
> 
>   ifeq
> ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)$(CONFIG_SOFTMMU),yyyy)

Seconded.

r~

