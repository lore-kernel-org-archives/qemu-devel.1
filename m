Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42AC2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 03:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144F02076E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 03:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9Vb+sAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144F02076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM1eo-0000Uu-4J
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 23:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jM1e0-0008M7-U0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 23:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jM1dz-0007A4-Sm
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 23:44:52 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jM1dz-00079P-MB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 23:44:51 -0400
Received: by mail-pg1-x544.google.com with SMTP id k191so2707735pgc.13
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3sPnUgtnsn447rSXIkb4GREpIcVx9RemGWkOwlnGd7M=;
 b=J9Vb+sABlgvzCw2fGHShhoel0jQWF0CHYN9IfmsOgsFPIEGTNXY9WGVMSQRsyNZ6ee
 7T5Xox20tPimwcyvP++sKXkgPmt4lU9d2bZGYHz8jTNz1v0tsJVxzB1gjgfjGG1df0Pl
 JPQHuk+a8VHN+ykSi+U8FSDcDm9zM52RljRM/3t1J3VdnXuo7PXudqUalSVpP+WXmfTa
 +8JFfVodCRtO24uiav8x2M/7OAnDTYlSJB2rEz/LrwC8ZKAyxLQOcYzYsuQvSwm/MPRU
 MxtWpVbSJd3xdUmNWL5751rgELKdKMt3twlK0DKSZpNjv3R1CupL3mBGP9i/EJeVAaV1
 YbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3sPnUgtnsn447rSXIkb4GREpIcVx9RemGWkOwlnGd7M=;
 b=Vmyk2pOBP241t6mR2ZJRl5oCYfE0PFJb7zFXmBc/NmxxUPQGFoYKZBOpM+g8wVIzXf
 VIyiebj+U8Qmu92Lp20tzrCdbY8ws1YJrNimcfIWy16uFAn0Ln2vFXcSA8yFbWlqLsUK
 OVLrPtahNUVr7ICQKcUWb7bHZ3KztB6Mny1sXFS6kL9AVjzs62ExBfg9c94lygzSifA5
 aLxBKuLJqv5o1wHahxG+TqBih5ck7ZMY5xqYoRI5hP4FvhB8+t6wkwBhreXr9Jqanoq1
 Be2sQWVYMmJVaGUoo5tftCXL7TWjmhmVAs/yN+u2zdeBmAgTja3s2mC/8bTT68JEoQKs
 yfQg==
X-Gm-Message-State: AGi0Pub1jUzVANNf9A1NPHlf6blk7hN+vLZJEG+FQqx7XE5NpVtudyH0
 fAp7sZaWwXhQIhEozbFRHMudOg==
X-Google-Smtp-Source: APiQypJJr48jDKLqFokDqIQaO6VHsGTL5BxzV1vtOGLs9gNK/2QrLNXA3DDq5KecXe3GUrLpJsnHqw==
X-Received: by 2002:a63:ff53:: with SMTP id s19mr5225141pgk.247.1586317490554; 
 Tue, 07 Apr 2020 20:44:50 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y30sm15323488pff.67.2020.04.07.20.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 20:44:49 -0700 (PDT)
Subject: Re: [PATCH for-5.0?] linux-user/ppc: Fix padding in mcontext_t for
 ppc64
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200407032105.26711-1-richard.henderson@linaro.org>
 <20200408021006.GB44664@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d0f45182-024f-db52-440c-d2aa9b597812@linaro.org>
Date: Tue, 7 Apr 2020 20:44:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408021006.GB44664@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: alex.bennee@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 7:10 PM, David Gibson wrote:
>> Should we in fact disable ppc64abi32?
>> I can't see how it could work enough to be useful as-is.
> 
> Yeah, I think so.  Last time we had a problem in this area, I couldn't
> even figure out what ppc64abi32 was supposed to *be*, let alone what
> the use case for it is.  Given that, it's hard to imagine it's been
> working (whatever that means) any time recently.

What it's *supposed* to be is a ppc32 binary running on a 64-bit cpu, e.g. a
32-bit binary on power7 with the kernel's compat syscalls.  You get to do
native 64-bit arithmetic and have 32-bit pointers.

I guess there's a kind of a use case there somewhere, but it's rather niche,
and someone has to care more than they have until now.


r~

