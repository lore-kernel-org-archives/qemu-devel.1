Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9599CC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D70721901
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D70721901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbT8-0002A7-JI
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39934)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpbSx-0001e4-QB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpbSs-0002EB-8V
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:47:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpbSm-0001e7-AD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:47:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so40154258wrr.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 09:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ntc9ImtHLpW3ApJuym0DELI99CgTGOti0SB1um2eOpM=;
 b=IBY54VHEr/fSmPIbs/+1UfdTeYndH+TZtTopb3EGfnzdNyP3XbKzTQRRKsMwbLVKHx
 +yB8WPkrXqOMN/VdHf8RQg0nIbdM+TLMJUbQb5E7c05NiP8SylLWWCs4c+pDCXR5oYfU
 G3u5Z1OZ73UxKQJmZ+yuVJdJng8jsKcE2ewHFxQH5T5q+k3ixgPKJG/bG14/iKvwFno2
 9xsk4RH7VGGjaleGEg6ZgDc4zxGMNp2cuKdkzopBcuSNAcJwirINHWNUnU3ZWyAa8RcB
 ujTWxi/3/aXvRthuGuozLrR5uusjf5F2QAweV/ZKnpeNmlsmyLsxROGV2nuILpK7yxB5
 mdYQ==
X-Gm-Message-State: APjAAAXDPCQRuzC9LiHJKvs/Hx0bnERj1mwHXBRFgFiHagWDCdVs005w
 QwHjIxEjceZmvpo3y0qOzhLbrw==
X-Google-Smtp-Source: APXvYqyWvFMRAGOuVumUhfiY6lSeJcni7DHiUwuW3VJj3Ff/83tB8a2JQbLNoaL59ndCKW5tXCezgA==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr43853796wrl.281.1563813990031; 
 Mon, 22 Jul 2019 09:46:30 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id x20sm30607062wmc.1.2019.07.22.09.46.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 09:46:29 -0700 (PDT)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru
References: <20190722150717.10564-1-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5d28678c-64c5-a3b9-0b2f-150dce1ad17e@redhat.com>
Date: Mon, 22 Jul 2019 18:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722150717.10564-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [for 4.2 PATCH 0/3] Remove time reset notifications
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/19 17:07, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Timers have a mechanism for detecting host clock jumps; this relied
> on noticing if the time had gone backwards or if it had gone forward
> more than 60s since we last read it.  This had assumed that we regularly
> read the time, which isn't true any more - we might not read the host
> timer until the guest explicitly reads the guest RTC (e.g. hwclock).
> This falsely triggers the reset mechanism.
> 
> The reset mechanism was only used by the mc146818 (i.e. PC) RTC
> anyway; so lets remove it.
> 
> Dr. David Alan Gilbert (3):
>   mc146818rtc: Remove reset notifiers
>   timer: Remove reset notifiers
>   timer: last, remove last bits of last
> 
>  hw/timer/mc146818rtc.c   | 19 -------------------
>  include/qemu/timer.h     | 35 ----------------------------------
>  replay/replay-snapshot.c |  3 +--
>  util/qemu-timer.c        | 41 +---------------------------------------
>  4 files changed, 2 insertions(+), 96 deletions(-)
> 

Queued, thanks.

Paolo

