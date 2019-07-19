Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62250C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 14:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA9220873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 14:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA9220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTe9-00024h-DR
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 10:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoTdz-0001eN-HO
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 10:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoTdy-00078L-Fh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 10:13:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoTdy-00077i-A1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 10:13:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so29164967wme.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 07:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z06Wf8rWNbmO4XD6AGCiuWwoNzP3/B0ox4r/Xl+UC5U=;
 b=krd/zaKeQJAdpEazlsLQSAFGZEAJF0WbH0py86coD7t670YA21APSnrUsvvQ+5gJRX
 sDCoc3KWp8aw+ZHBxWfcnFFYZzsjJg5H2vhWhflySgqk17+JnHtgqyzMfmpEFmQwb9D3
 JPun499ZLCrqDirSOFfv4MvC6Cbg8/fIlTXdQAAzUkDtPNcJwjJGEYaZSyONUA1cklUK
 FP4QAiNyD8fQyuIXaIbpQAjjAs2qKeMvNdughzpLd7sPQ+cnmkR5zNi9mkxhPeNa3u16
 BgXIl0WEPTpcGMvssy4btV7YE7VhnU6mE+WM9yMP2760yaZwfBUCupFCT64RGc6csEQj
 EpyA==
X-Gm-Message-State: APjAAAXTVeKUVsAbEI1sO7wVan4dSmOdtNcMV566nw9ZW44K5JO9J4cj
 pp0D001b9TaPtYCUFiKvMgfXIg==
X-Google-Smtp-Source: APXvYqypR6ZaG7YMjAEBOSizOOvGPdz/MWo05LTTv2iSWxJjzn3SWspqLK24WdlP89bJlfQS6ZRbJw==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr45088624wmk.136.1563545633126; 
 Fri, 19 Jul 2019 07:13:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id c11sm52451147wrq.45.2019.07.19.07.13.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 07:13:52 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
References: <20190719123652.GA3000@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5ee83209-cd46-dded-4d04-0dce1a01fccb@redhat.com>
Date: Fri, 19 Jul 2019 16:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719123652.GA3000@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] -rtc base=, migration and time jumps
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
Cc: jan.kiszka@siemens.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So here's my understanding:  "-rtc base=" says what is the RTC value
when the guest starts.  This value is only used by qemu_get_timedate,
and most RTCs only use it on startup or reset.  However, there are
exceptions (the PC RTC's host clock notifier, the ds1338's set time
functionality, and all reads of m41t80/m48t59/twl92230) and this causes
the bug.

On 19/07/19 14:36, Dr. David Alan Gilbert wrote:
> d) The host clock jump detection (b) is broken - it correctly detects
> backwards jumps; but it's detection of a forward jump is based
> on two readings of the host clock being more than 60s apart - but
> often ona q emu running a Linux guest the host clock isn't read at all;
> so reading hwclock, waiting a minute and reading it again will trigger
> the jump code.

Oops.  Back when the detection was added, there were two QEMU_CLOCK_HOST
timers firing every second so the clock jump detection happened promptly.

These timers were then removed as a power-saving optimization, and that
broke the jump detection.

> 1) Tell people to do what libvirt does and specify base= differently
> on the dest.

This is racy; the user does not have a good way to know the exact base
on the destination.

> 2) Migrate the offset value such that the base= on the destination
> is ignored

At least on some RTCs the offset is already being migrated indirectly.
For example on x86 the (base_rtc, last_update) pair might be usable to
reconstruct the offset?

> 3) Fix the host clock jump detection
> 
> (3) is probably independent - the easiest fix would seem to be just
> to set a timer to read the host clock at say 20 second intervals
> which is wasteful but would avoid the false trigger.
> 
> Is (2) worth it or do we just go with (1) - I'm tempted to just
> specify the behaviour.
> 
> Mind you, we could kill the host clock jump detection code - only
> the mc148618 registers on the notifier for it - so presumably
> aarch/ppc/s390 etc dont see it.

I would just remove the host clock jump detection code.  IIUC that
should fix your bug so you don't even need to do the above-mentioned
reconstruction of the offset (let's call it 2b) in the PC RTC.

That still leaves the problem that the base goes out of sync on
migration on m41t80/m48t59/twl92230.  For that, I think that the
simplest thing to do would be to fix those to store and migrate the
offset themselves just like all other RTC implementations.

Paolo

