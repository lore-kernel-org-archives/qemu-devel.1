Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D55EC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA5F2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlt0IdDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA5F2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isXEA-0002yl-Ta
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 14:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isXDS-0002CH-UT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isXDR-0000wo-K6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:23:34 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isXDR-0000w7-Cn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:23:33 -0500
Received: by mail-pl1-x642.google.com with SMTP id b22so10224338pls.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 11:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dSEuiJqYQ30ZMJaYDSf9700l5vq/Ni3wN+VvWX3tS0Q=;
 b=dlt0IdDMX5w7qwxVgIZg64A3iURm6B/hZLpmY6dHdxMwuoorKEK731hdBrrciPQjQY
 clt1WETYubkHZcwZ+qb2/qf5fVbPLXoroA3GP0+iftZCJVGP+2HM7JfltdaqtRgKOUEK
 etiO9if9hDu3zKvuZPjh+HENzg+XnT3XOjm1w90nmgM13hIzjLn2kUG5P+N+0nO6xLnf
 AnpfRSz64ywBBIcHIy8MUzPdY0V/8XgW10p8//VUzZyFDgC6EzlHH6HSM6qtW0ossq8D
 1YeiC+Riad6olGo/D1jAx88wHL4yie8oHO/vTQwFWQcePo3hyMcZvXc3RJoxYc3enBcw
 bUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dSEuiJqYQ30ZMJaYDSf9700l5vq/Ni3wN+VvWX3tS0Q=;
 b=Eqev9c72yj3YPJTF1UkrLjkAKkB5hO0UH8GwkoITrkrIIw/iUxHOeE6syqXsv5y974
 kWGjcf2lMn4BNVJTQ3CAl0R0hhCdKegPJMJkltzDd3qT2nptWlQyDof2SAiIOKFhyt0Z
 bsQ49BDuRbGqbQRRemXOWaoh7SahKeOgeObb9x9+IPcMBv6ODuL44UyEg3jcCd67u6hA
 sXtpcfni18CO3/S5wg0/avOKT85nb0OpRLz9wcQADxG8kDIeOjlBMWgJScdJdhFECI44
 TJ/QYvv6bwwcHEz2KaE0hPsKI+cIAS+hBfl29JMkCOiHG6u/2kVTmfC3CqNAMmr2g+az
 JBZA==
X-Gm-Message-State: APjAAAUw6T+HOEkKCbAls1EHj8Z7ZxQMM32ucpMC1g3XDliVMUWb4u+6
 9j0TctFBGElpbnHBsStq0w/FKw==
X-Google-Smtp-Source: APXvYqzojQOQx8UHVuK3ctiCfyWGSPYRgaZ0yacXALUrkRRYkyc1DqZK2mCWwnhAYjHQnarhYWWUhQ==
X-Received: by 2002:a17:902:8b88:: with SMTP id
 ay8mr692338plb.202.1579289012067; 
 Fri, 17 Jan 2020 11:23:32 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id r6sm30152490pfh.91.2020.01.17.11.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 11:23:31 -0800 (PST)
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200117015322.12953-1-richard.henderson@linaro.org>
 <CAP+75-WqE4j7kRkSae+fQHn9N0=L+OTZz5xUziZkn9Z-1uAs9Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ae03e9e6-af60-1b32-751f-68c08d0b3d51@linaro.org>
Date: Fri, 17 Jan 2020 09:23:28 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP+75-WqE4j7kRkSae+fQHn9N0=L+OTZz5xUziZkn9Z-1uAs9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Helge Deller <deller@gmx.de>, dave.anglin@bell.net,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 8:50 AM, Philippe Mathieu-Daudé wrote:
> On Fri, Jan 17, 2020 at 2:53 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The PA-RISC 1.1 specification says that LDCW must be aligned mod 16
>> or the operation is undefined.  However, real hardware only generates
>> an unaligned access trap for unaligned mod 4.
> 
> This Linux kernel commit seems relevant:
> 
> https://github.com/torvalds/linux/commit/14e256c107304#diff-e85862c7227599cb24e36494f75948d5R159-R164
> 
>   /* From: "Jim Hull" <jim.hull of hp.com>
>   I've attached a summary of the change, but basically, for PA 2.0, as
>   long as the ",CO" (coherent operation) completer is specified, then the
>   16-byte alignment requirement for ldcw and ldcd is relaxed, and instead
>   they only require "natural" alignment (4-byte for ldcw, 8-byte for
>   ldcd). */

It isn't completely relevant.  We don't implement hppa 2.0.

I added a TODO comment for HPPA64, as I said in reply to Dave Anglin elsewhere
in this thread.


r~

