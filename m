Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F279C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 06:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136B62070D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 06:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136B62070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgk93-0002R9-7M
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 02:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgk7b-0001tz-BO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 02:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgk7a-0006Gi-4A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 02:12:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgk7Z-0006Fa-UY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 02:12:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id z19so2098245pgl.12
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 23:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=19UBy/JSb09LAOfOQp8wf6xbaoZKZ3jSDn4GxSTUbTs=;
 b=IdarwScA6w7zfG/BnPdjngioSROQxs6aqA5WhJE413y9LmJ04zHWuqvx8Mlo8yw3nG
 lwATAhF/JqxZm87y7KDqrL+rkT9yNe5B2KNBbM6fb6ywXdOT+Hkj3t3OgiYEhnKk6AR9
 GWLDxtoTLByroAKFmZXh+4LxglE7JIbSfsfdROrTYtdwGjp2FBwBypaKqPE2lKM7jq/3
 w8MfMJEuUgNwTa5UwCAcDRukqPsDXkKaSTU5HBwI2g03HzF0pkux2tuawnlEBfMKc3dh
 bikVSIjFdrTHQoZPky6UEBZDj7IRzUUEhJ9c2VJJCb2DH6vBDRuqkUmon3frqieX5JK3
 dhGA==
X-Gm-Message-State: APjAAAXGAihX8UClU6y9PSwYLdkqpnKnlMUNOt6gjbezml8fJ1i0qAGT
 7w3MP0UKNG/j9pdcIYbJzLvSFw==
X-Google-Smtp-Source: APXvYqwKqswnoVUvbs2i+DYMAIFFSOFeFWiLi0HZ6GDexWiv/+I3SewaSCWApgS0kl3muTFG1aA6qw==
X-Received: by 2002:a17:90a:3590:: with SMTP id
 r16mr11072790pjb.44.1561702348388; 
 Thu, 27 Jun 2019 23:12:28 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id m101sm940730pjb.7.2019.06.27.23.12.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 23:12:27 -0700 (PDT)
Date: Thu, 27 Jun 2019 23:12:27 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 22:01:42 PDT (-0700)
In-Reply-To: <CAKmqyKMAGJFgJV1Y9W+ne_=jipqGMtZMKRHJmN5qpNVZrKUTeg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-89e59e27-71b5-4452-93af-a889983f711c@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3] target/riscv: Expose time CSRs
 when allowed by [m|s]counteren
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, fintelia@gmail.com,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Jun 2019 12:56:57 PDT (-0700), alistair23@gmail.com wrote:
> On Wed, Jun 26, 2019 at 1:25 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Tue, 25 Jun 2019 23:58:34 PDT (-0700), bmeng.cn@gmail.com wrote:
>> > On Wed, Jun 26, 2019 at 4:23 AM Jonathan Behrens <fintelia@gmail.com> wrote:
>> >>
>> >> I just did some testing on a HiFive Unleashed board and can confirm what
>> >> you are saying. The low 5 bits of both mcounteren and scounteren are
>> >> writable (if you try to write 0xFFFFFFFF to them, they'll take on the value
>> >> 0x1F) but even with the TM bit set in both mcounteren and scounteren the
>> >> rdtime instruction always generates an illegal instruction exception.
>> >>
>> >
>> > Then I would think the FU540 is not spec complaint :)
>>
>> Ya, it's an errata.  There's a handful of them :)
>>
>> >> Reading through the relevant chapter of the spec, I still think that having
>> >> mcounteren.TM be writable but making rdtime unconditionally trap is
>> >> non-conformant. If other people feel strongly that rdtime should always
>> >
>> > Agree. To test hardware (FU540) compatibility in QEMU, maybe we can
>> > add a cpu property to allow hard-wiring mcounteren.TM to zero?
>>
>> In theory we should have properties to control the behavior of all WARL fields,
>> but it's a lot of work.  I'd be happy to take a patch for any of them.
>
> Hmmm... We should avoid taking patches that don't adhere to the spec
> just to match some hardware. In the case that core/popular software
> doesn't work it probably makes sense, but in general it's probably not
> the best move.

WARL is Write Any Read Legal.  Essentially it means that the hardware gets to
decide what sort of behavior that field has, and is the mechanism for optional
features in the ISA.  In this case it'd be entirely within spec, specifically:

    Registers mcounteren and scounteren are WARL registers that must be
    implemented if U-mode and S-mode are implemented. Any of the bits may
    contain a hardwired value of zero, indicating reads to the corresponding
    counter will cause an illegal instruction exception when executing in a
    less-privileged mode.

Taking a patch that matches the out-of-spec FU540 behavior doesn't make any
sense, I don't want to implement errata in QEMU :)

>
> Alistair
>
>>
>> >> require trapping into firmware then the natural change would be to simply
>> >> hardwire mcounteren.TM to zero (the value in scounteren wouldn't matter in
>> >> that case so it could be left writable). My own (biased) personal feeling
>> >> is that this full implementation makes sense at least for the `virt`
>> >> machine type because it represents a clear case where deviating from
>> >> current hardware enables a performance boost, and would not break
>> >> compatibility with any current software: both OpenSBI and BBL try to enable
>> >> hardware handling of rdtime when the platform claims to support it.
>> >>
>> >
>> > Regards,
>> > Bin
>>

