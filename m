Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7753CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FD720730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAmCvJT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FD720730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfyP-0000aK-F2
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfxk-0008Oa-2l
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfxi-0000pK-V3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:08:51 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfxi-0000jM-LH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:08:50 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so6875501wru.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 04:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TNt8UPNyeJHsnrRpeku2sFJA2l5UkkettWd5ETMkPuU=;
 b=oAmCvJT1VJgF3MHjP0PWU1HLScqJr4K0vcKGkI3SVqFpa3gMF25QwW1pZMAAyWNAVw
 FEbNQuADlBjU2U/3V8ilsBHOBgiWFa3pDfV10SQvz49fSVdFK+XABHppbX7YWoHCY6cx
 RFnGB5nZibdnbPYclMizR2zI+8zGxr5dT84VIMOu584dvJJTX3JZe4Hj00ccnOFptnHn
 fBmH4vKk5JIWrks5G9n1ebSBxY7jLygrmHKX20g9GDdzIbwJzuMb9y17aJ6/D5E37M/y
 lsnwEzNUeI/Y5FS4+9F4b9vlvRZAR4Cb+caEyly4TzdsOvkSEaOeuYBrqGI0eVVzm1hQ
 wN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TNt8UPNyeJHsnrRpeku2sFJA2l5UkkettWd5ETMkPuU=;
 b=kRjwCQGdUTxUtLAqV8hW8/YLs+38xcvwkOWHppGj3linIBCvdVdaDYmoUS3ZjGf1Nu
 XukHuP8+XNyQ8J+jre5FUmNx4URCWKgr94JnpznxV5R+t9sVgkQz/v5k3wcKAmQSiJnt
 93L8jgH4k4cMXvZ1Fgdzi/Jwg53riyRybDEMtyGtmJSkD4euKf1B0ZmwH9zCseQjnAUt
 wQJ0WzvQmscpz0vkofbCgmLRExlVZJpNW5SVsFgOI3xomrGIuWX4/A4YJSCkHEjqgjwW
 g13DAws2NLQOQrpOljDoLCeq41nNocwuRYyWZGreLfh2TsSf/w5LCcGzkHr4DcKdIVK4
 sRVQ==
X-Gm-Message-State: APjAAAUQecrEwdDte9wCOGW4okmsVxbTHs1GYf2WHY7H4hgpyB47PlWb
 r53oK6ENDJDKBftHHSTKNWOTNQ==
X-Google-Smtp-Source: APXvYqx/qclHb1lYk4WtKNL9Hy9Kd/dDt9vRdCbePfpHm5ElFo7B99LDapTT0YaVEEwFv9ApE0hsBQ==
X-Received: by 2002:adf:ab49:: with SMTP id r9mr3624777wrc.351.1580990929308; 
 Thu, 06 Feb 2020 04:08:49 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id v8sm4089763wrw.2.2020.02.06.04.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 04:08:48 -0800 (PST)
Subject: Re: [PATCH v1 09/13] util/mmap-alloc: Implement resizable mmaps
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9adb5b25-d53b-9304-77ba-82c5b59c5cc1@linaro.org>
Date: Thu, 6 Feb 2020 12:08:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 6:31 PM, David Hildenbrand wrote:
> +void *qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t new_size,
> +                           bool shared, bool is_pmem)
>  {
>      const size_t pagesize = mmap_pagesize(fd);
>  
>      /* we can only map whole pages */
> -    size = QEMU_ALIGN_UP(size, pagesize);
> +    old_size = QEMU_ALIGN_UP(old_size, pagesize);
> +    new_size = QEMU_ALIGN_UP(new_size, pagesize);
> +
> +    /* we support actually resizable memory regions only on Linux */
> +    if (old_size < new_size) {
> +        /* populate the missing piece into the reserved area */
> +        ptr = mmap_populate(ptr + old_size, new_size - old_size, fd, old_size,
> +                            shared, is_pmem);
> +    } else if (old_size > new_size) {
> +        /* discard this piece, keeping the area reserved (should never fail) */
> +        ptr = mmap_reserve(ptr + new_size, old_size - new_size, fd);
> +    }
> +    return ptr;
> +}

What does the return value indicate?
Is it just for != MAP_FAILED?

Would we be better off with an assert?  There's the comment re mmap_reserve,
but I can't see why mmap_populate should fail either.

Assuming an assert isn't viable, are we better off with a boolean return?  With
an Error **ptr?


r~

