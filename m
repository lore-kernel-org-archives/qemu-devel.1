Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90272C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A2820842
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nxkQMJiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A2820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CZo-0000HA-Mr
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1CV5-000483-H8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1CV1-0005Ew-2G
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:05:35 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1CUz-0005C2-H4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:05:30 -0500
Received: by mail-pj1-x1042.google.com with SMTP id m13so7146pjb.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iM1vLWJPP0yWCV3ZxFs3mmdNJDy/+2jRoIP4IBofKgA=;
 b=nxkQMJiTJ4l6cXGt28TCQYe4vRCQbN0y+/zUKpy/9K6CCxEtjGgrDXjY93l6kTk5Mj
 MyqTL5V40tLFtt/fy8iJS0C2TPoa5XixqPEkqYFIFr1PnKsDrbleUW4kHpnX0RaeeAO1
 220ea/z4gCFBlfLgJqVIrnFusSqxvXpk9g7jigAjFa8gvzltTWJvT7p9E+mKoFjRdarq
 pM1ohFLzC6+pkyDWHfb4q4q2QVft8/PoKOzQvD7QTP8tCxlhC1OwZhIkyGzWqJv2lo+1
 DLt+CUN5CRYGh/b592wlq4Wgp/Fsb7bb2hX+t+Iv534IiSAyA0uW5W3ugEsEqk/0y9DG
 Uxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iM1vLWJPP0yWCV3ZxFs3mmdNJDy/+2jRoIP4IBofKgA=;
 b=j1RxB2zA6Q+h4WlpsjrEjdLQweOa1UYTxVRAVdm/5iKyuQAHdku7hLOYIwnTES54Sv
 cHNFSezCbMrzOulDUU8ZFvmNqDhZDBxPEHEflLVBLJfP6BTXDtFfVIBYQ34jtN7R4Khl
 /eYJwUuKcfY76h0QM8efZxPUCj4CcYbNCJaf6wy9hvDR9csgVRF3hRlEw1k/u03PZekt
 7pzRFnq8m7J58qsipCvRKFFymb9UGBE0Y8dHrvX6kv3839a1UP82OdIk2Wd5tPLISTDp
 VzD75CJPSd6aZw7R+yNgjaJ2fI3hV75NP5ZpD2s5MT3vzvxMSwnZ/Pao0z+VApJhyFK5
 gxvg==
X-Gm-Message-State: APjAAAW987MHxm4jbuen+wb1Srh3vjwPqhnmlh76tGLrNIkVOZKlVYo8
 R7onWHgfbnlN87J/KRO3WH3lH9hm7Ig=
X-Google-Smtp-Source: APXvYqw/VKLTij2fGGw1Tgb8oGVnqfyYgzlMuQ/X/mexfr17C5ofERjSS7/MTVctrP6gVClPXR8kzA==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr15833pjb.49.1581354327934; 
 Mon, 10 Feb 2020 09:05:27 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 k123sm686715pgk.48.2020.02.10.09.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 09:05:27 -0800 (PST)
Subject: Re: [PATCH] target/arm: Implement ARMv8.1-VMID16 extension
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200210120146.17631-1-peter.maydell@linaro.org>
 <875zge3a2b.fsf@zen.linaroharston>
 <CAFEAcA9d4XDaUQLwy4yYyTSz1nzQ49adTv9z4K8e29OsUh_21A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97c3e59d-8279-9cac-7102-1f99f828f700@linaro.org>
Date: Mon, 10 Feb 2020 09:05:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9d4XDaUQLwy4yYyTSz1nzQ49adTv9z4K8e29OsUh_21A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 1:19 PM, Peter Maydell wrote:
> On Mon, 10 Feb 2020 at 12:23, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> The ARMv8.1-VMID16 extension extends the VMID from 8 bits to 16 bits:
>>>
>>>  * the ID_AA64MMFR1_EL1.VMIDBits field specifies whether the VMID is
>>>    8 or 16 bits
>>>  * the VMID field in VTTBR_EL2 is extended to 16 bits
>>>  * VTCR_EL2.VS lets the guest specify whether to use the full 16 bits,
>>>    or use the backwards-compatible 8 bits
>>>
>>> For QEMU implementing this is trivial:
>>>  * we do not track VMIDs in TLB entries, so we never use the VMID
>>> field
>>
>> Not currently but does the VMID allow you to have per-guest page table
>> caching? Last time I chatted to rth about potential performance wins we
>> discussed how easy it would be to support this in the softmmu now we
>> have indirect TLB lookups anyway. Given how much time is currently spent
>> expensively re-populating tables we could keep the last couple of id
>> tagged tables around for faster switching between sets of tables.
> 
> Yeah, in hardware the whole point of the VMID is to have per-guest
> caching of VA-to-PA mappings in the TLB so you don't have to blow
> them all away when you switch VM (just as ASID does for processes).

Yep.

> The difficulty with QEMU has always been that adding the "and is this
> the right VMID/ASID" to the softmmu fastpath code would be expensive,

Yep.  My current half-baked idea for this does not involve changing the
fastpath, but swapping out softmmu tlbs in bulk.
Which is possible now that there's a pointer involved, and not 8k of data in an
array.

> AIUI. If we ever come up with a clever plan for this it should be
> no different if the VMID field is 16 vs 8 bits, though.

Yep.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

