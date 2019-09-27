Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE8C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 18:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF4521655
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 18:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+OmP2xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF4521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDuxg-000800-TC
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 14:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuvT-0007GD-2R
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 14:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuvR-00006d-ND
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 14:25:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDuvR-00005g-Fp
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 14:25:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id y35so3948781pgl.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3TZc76GACQJzND2GVX4LxMSgXpVkGMy4FAsnK17rNSM=;
 b=O+OmP2xyImXEn6s45WxuQ9+7KZ/kRyAFeDfwA03ov1rWAKvyvHIfLostSu6fAMgF6g
 fMNh9VD9gCUuz2gsMv27QRVMDfVNNPqF3rfOIg5JzfMNrJ72FN9cOlij9XPlrjK3spAb
 8NPaHJxJtJ4J0b7hioXO3kUYZAdH+fiZTvnBU+EU0CBq9NgU+stSIUbAuk/qPbn5JDw6
 F6DTIZYI6O75lOOJgCbikDnKHWxK0d7CbphrW/jaZGkWnQICeCUGXdoG2Bt/unxCmwLF
 pa7MLsW5gPEFacWXuI7Wti/osbFrsEuTE16abNwYxPMxLg4eudDE1P7lNiJPv27YsKXo
 7CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3TZc76GACQJzND2GVX4LxMSgXpVkGMy4FAsnK17rNSM=;
 b=OEy/zNGeMEJ1xXklWGG8TWBmFCSZl3Ls18lpHEISTnTVbVUNHCmfUb3L/Zh7bnh8rz
 N5For6hNV2R2ErhVo8WWxyH+TmdYhFGQ5nsSIzzxXnd/23WPn7xWcfUofVsLOy58sty+
 JJsQ+bHRoq2X6QYeALOI80BIA5XNeV10CuakgonEiBKrX1QAPHmSQr211clHfHI2po4P
 44FwzzO+jqRpVg0aceQpzWCwnI8SIedsEgPVlJ+po2QiLOdZyX4knHk3r1TTNxaOdJYW
 PEGfKeUgM4xOzVG0Y8b94eZYjSi+AeUvvDYfX1zS/+H1GVI4cfE+VYtxZQlnF1H+OE3R
 JDkQ==
X-Gm-Message-State: APjAAAXoikic2PK2t2xC/4puSXMuiRfGz8sYpypQUePRiniF50C8y9sP
 OkoF4S/MYmRHilKeEiNwh4DSRg==
X-Google-Smtp-Source: APXvYqyKs1gMZZDE+vOXc7IJavAfk5hCM5BNAImJKlhkhLKym8iqjS5oe97Qwmp+vAkDopChroUE8Q==
X-Received: by 2002:aa7:8f14:: with SMTP id x20mr6092666pfr.223.1569608703871; 
 Fri, 27 Sep 2019 11:25:03 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id s24sm4944436pgm.3.2019.09.27.11.25.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 11:25:02 -0700 (PDT)
Subject: Re: [PATCH v3 01/18] target/s390x: Truncate 32-bit psw_addr before
 creating TB
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190926162615.31168-1-richard.henderson@linaro.org>
 <20190926162615.31168-2-richard.henderson@linaro.org>
 <bc398595-cdc8-80bd-a7f9-56ae01b35674@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ad93614e-6114-1f45-1965-88f8207377b7@linaro.org>
Date: Fri, 27 Sep 2019 11:24:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bc398595-cdc8-80bd-a7f9-56ae01b35674@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 3:23 AM, David Hildenbrand wrote:
>> +    pc = env->psw.addr;
>> +    if (!(flags & FLAG_MASK_64)) {
>> +        pc &= 0x7fffffff;
>> +    }
> 
> If you're fancy, you could also add 24-bit addressing mode wrapping.
> 
> Maybe unlikely(!(flags & FLAG_MASK_64)), but not sure how big the gain
> will actually be.

So, it appears that this patch, and the existing code in
s390x_tr_init_disas_context, are wrong.

Page 4-7 of the v11 PoO says that we must generate a specification exception
and not wrap.  I believe that the only way to force this to happen is with an
explicit LOAD PSW EXTENDED instruction.  Branches and sequential instruction
execution both wrap the addresses before writing back to the PSW.

I will drop this patch for now and we'll look again at instruction address later.


r~

