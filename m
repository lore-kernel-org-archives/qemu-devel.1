Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A717C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A03217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXcoas8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A03217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9XvM-0006Mc-7V
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 12:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j9Xug-0005pS-Bd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j9Xuf-0004XU-6d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:34:30 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j9Xue-0004WP-Ue
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:34:29 -0500
Received: by mail-pf1-x444.google.com with SMTP id f5so1294152pfk.9
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=za/Wo9N/jLaPQ/i3K7miQ5U2TNh+nuxKLY4yG49MZ0E=;
 b=FXcoas8acAdwejFixBWSQ4QuSL+za/yxYBmlx07SYUxQkqJhMFgWrEkmoIF9GoWDm8
 +AMVqhMIcUUPSWPJlIcv+RVfU3pW7T6+teoQEq9YXiQgyvcOJWuh7fAdakONGqKnKugK
 6c5+oKqvdVjd481u4weqFHjy/MXP5DxkOnx6QrUsdzFSeM8fD7/vyu+YJrzX0md9RXCS
 fmGngC6TaHQ6GCCVKVuDBFy1q16SUzpOujd014obGwAPRQ9y/mWWJZIY5detjUEt1LiY
 zClBEneMjFIpjkLwXQXxmwTbgczcVe1EOpy3iam+osKWnb5QovcBHE/DBmDLohLgX4Nj
 6TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=za/Wo9N/jLaPQ/i3K7miQ5U2TNh+nuxKLY4yG49MZ0E=;
 b=rHVkS4kfS7tbBhEjepTmx40ZEY9P2EGb6589+cVE0c0Uj6EJ4k1Id4jm/ajHaZ1OvN
 iVGp5/TejECQkR9Jgo4ER2K7w3dxoNauWpoLxbjIFwOsd9ZGRxA4kIN555I66JhXVBRg
 jp2vKaIe2lP3czt95aOW83o94c84GdOKBAZKEofKDOvALvR7Cp0mNjnJ7oAvpNfGMAY6
 rXIPHpAcfQEaxXz60WVf0ndqZVP04aXMsRS/tibn9A6IgAu0fb7dkQqHAGH8zAn0jK9J
 WHYHA9Tx5wNydu7OoKBx+LiHC7wFVPFUqRpuuUQWPikaNh8M3QqxvtD4Gx1QacCTrlIT
 ITBA==
X-Gm-Message-State: ANhLgQ0mpWoZuKNs8fcT5ommu++YSKsoP3lEzfJ4n5Vrq2awqrI5Q8w5
 UNXuHunGl6+82uUsyq65iySKAw==
X-Google-Smtp-Source: ADFU+vsbhSvt6IAi4dJv+ukreb87qZOfKYywvpzROKQeKONLkdI9z932NABuHUm8wNZKYMTZnsfj+w==
X-Received: by 2002:aa7:99c5:: with SMTP id v5mr4117236pfi.198.1583343267581; 
 Wed, 04 Mar 2020 09:34:27 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 19sm7101805pfn.30.2020.03.04.09.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 09:34:26 -0800 (PST)
Subject: Re: [PATCH v1 1/1] target/riscv: Don't set write permissions on dirty
 PTEs
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <c827880a47774cd3a6bcd59b79657f380da11d5d.1583284602.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8498727-03f8-7e04-efd3-c04763dcbfac@linaro.org>
Date: Wed, 4 Mar 2020 09:34:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c827880a47774cd3a6bcd59b79657f380da11d5d.1583284602.git.alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 5:16 PM, Alistair Francis wrote:
> The RISC-V spec specifies that when a write happens and the D bit is
> clear the implementation will set the bit in the PTE. It does not
> describe that the PTE being dirty means that we should provide write
> access. This patch removes the write access granted to pages when the
> dirty bit is set.

The W bit by itself says we should provide write access.

It is an implementation detail that we *withhold* write access when D is clear
(etc) so that we can trap, so that we can properly set D in the future.

The page table walk associated with a read is allowed to cache all of the
information it finds in the PTE during that walk.  Which includes the D bit.
If D is set, then we do not need to set it in future, so we do not need to
trap, so we can immediately honor the W bit.

If the guest changes R/W/X within a PTE (e.g. for mprotect), it is obvious that
a TLB flush for that page must be done.  It is no different if the guest
changes A/D (e.g. for swapping).

> Setting write permission on dirty PTEs results in userspace inside a
> Hypervisor guest (VU) becoming corrupted. This appears to be because it
> ends up with write permission in the second stage translation in cases
> where we aren't doing a store.

You've not really given any more information than last time this patch came around.

I still think this must be a guest (or nested guest) bug related to clearing
PTE bits and failing to flush the TLB properly.

I don't see how it could be a qemu tlb flushing bug.  The only primitive,
sfence.vma, is quite heavy-handed and explicitly local to the thread.

It may be a bug in qemu's implementation of second stage paging.  Which is not
yet upstream, and I haven't gone digging in the archives to find the patch.


r~

