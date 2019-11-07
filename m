Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4480C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04F520869
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlzYEKp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04F520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmBu-0001Fy-Cx
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSm8k-0005zl-Dn
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSm8j-0007hp-4E
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:04:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36750
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSm8h-0007gC-Sk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573149851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cA5Nj2lSy6a+kfwgiAcW5Spxg2tRNKg1j960jZLS/c=;
 b=DlzYEKp3NRtpTqx7wsOBYvlZLmSVY2w1EOWb6ec9mBwJOxZj2VQbkyFTR46JqaRqrxQeyh
 YhUED4slPesZUa2do4LrlYqZ6HOTocrBPJhTCm2W+GJYrx8D35r2c0UI7Yuf0Fz1LhPtIv
 cLJgAOyoFRYx78ibXcXjVt+UE9NyR14=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-mleqxHSAOgKi4-VJRB01Nw-1; Thu, 07 Nov 2019 13:04:09 -0500
Received: by mail-wr1-f69.google.com with SMTP id m17so1493390wrb.20
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 10:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9EKh4v8U/tcnBfisjslFQQy7nTkPVB+gqAlqojhWRuA=;
 b=SoNfxjKDbeVGMGwA7UJf8t0nLsH+SplZ0ghjvqzJvjg/u2e5RkVc5scKExm2DNTyDd
 n+tmYkH7mU2TSPZ/jLNHAQoyk5XszGlgx5eY6+KgBytEsqo9+fjEg7b1FRfxnAxRqOZr
 2zreUiNVl6V4OOwEbPrH27vsor64W8NAhVkaM51VPHu/c49eSeus0lcRQcuJdWdonq4v
 AEj9c1O+8hGGtvRxPkUEm1OzDyyWSs9nG53yua82lkXtqvJuwh8g+AC3cLJQ71XSyQno
 fWDW85oJLi59kSpfh3I84u60S4FMs3/+AO8XrE+EEnJOn3E6ViOfPxXEsJvbWE0wHvBt
 hvpw==
X-Gm-Message-State: APjAAAWaf5fHX8ErPiahGjXKPGzmrH2AOP74x13mpi/7m9iM+CKQlJBo
 u9HoKFgbARzwixxZ6XFGBPiBoWhYVe+pyuc8ABj/6j9jSErtRk6MWrnKHg0Ng7KJ+pcgPiNfht9
 4CKq21dXftpvQ6fk=
X-Received: by 2002:a1c:200f:: with SMTP id g15mr4302274wmg.96.1573149847911; 
 Thu, 07 Nov 2019 10:04:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZasOske5uA1TgXXaJKnYor89xB+6otSL4aKv4o7wbQt5FBwVdWfGIL6wQ4ZuNwPBWyrS10A==
X-Received: by 2002:a1c:200f:: with SMTP id g15mr4302247wmg.96.1573149847669; 
 Thu, 07 Nov 2019 10:04:07 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id f188sm2627625wmf.3.2019.11.07.10.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2019 10:04:07 -0800 (PST)
Subject: Re: [PATCH v8 0/3] RTC support for QEMU RISC-V virt machine
To: Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <Anup.Patel@wdc.com>
References: <mhng-fceb5aa2-7610-421a-b350-d939ace5fee2@palmer-si-x1c4>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ac999ff0-3c47-7e79-a339-5b0cd1c2dc5c@redhat.com>
Date: Thu, 7 Nov 2019 19:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <mhng-fceb5aa2-7610-421a-b350-d939ace5fee2@palmer-si-x1c4>
Content-Language: en-US
X-MC-Unique: mleqxHSAOgKi4-VJRB01Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 palmer@sifive.com, qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, anup@brainfault.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/19 5:52 PM, Palmer Dabbelt wrote:
> On Wed, 06 Nov 2019 03:56:29 PST (-0800), Anup Patel wrote:
>> This series adds RTC device to QEMU RISC-V virt machine. We have
>> selected Goldfish RTC device model for this. It's a pretty simple
>> synthetic device with few MMIO registers and no dependency external
>> clock. The driver for Goldfish RTC is already available in Linux so
>> we just need to enable it in Kconfig for RISCV and also update Linux
>> defconfigs.
>>
>> We have tested this series with Linux-5.4-rc4 plus defconfig changes
>> available in 'goldfish_rtc_v2' branch of:
>> https://github.com/avpatel/linux.git
>>
>> Changes since v7:
>> =C2=A0- Fix broken "stdout-path" in "/chosen" DT node of virt machine
>>
>> Changes since v6:
>> =C2=A0- Rebased on latest QEMU master
>> =C2=A0- Addressed all nit comments from Philippe Mathieu-Daude
>>
>> Changes since v5:
>> =C2=A0- Rebased on latest QEMU master
>> =C2=A0- Added maintainer entry for Goldfish RTC
>>
>> Changes since v4:
>> =C2=A0- Fixed typo in trace event usage
>> =C2=A0- Moved goldfish_rtc.h to correct location
>>
>> Changes since v3:
>> =C2=A0- Address all nit comments from Alistair
>>
>> Changes since v2:
>> =C2=A0- Rebased on RTC code refactoring
>>
>> Changes since v1:
>> =C2=A0- Implemented VMState save/restore callbacks
>>
>> Anup Patel (3):
>> =C2=A0 hw: rtc: Add Goldfish RTC device
>> =C2=A0 riscv: virt: Use Goldfish RTC device
>> =C2=A0 MAINTAINERS: Add maintainer entry for Goldfish RTC
>>
>> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
>> =C2=A0hw/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0hw/riscv/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++
>> =C2=A0hw/rtc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>> =C2=A0hw/rtc/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0hw/rtc/goldfish_rtc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 285 ++++++++++++++++++++++++++++++++++
>> =C2=A0hw/rtc/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>> =C2=A0include/hw/riscv/virt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +
>> =C2=A0include/hw/rtc/goldfish_rtc.h |=C2=A0 46 ++++++
>> =C2=A09 files changed, 366 insertions(+)
>> =C2=A0create mode 100644 hw/rtc/goldfish_rtc.c
>> =C2=A0create mode 100644 include/hw/rtc/goldfish_rtc.h
>=20
> Thanks.=C2=A0 I've updated the patches on my queue, LMK if there are any =
more=20
> changes!

I'm happy with the series, thanks Anup for addressing all the comments.

Regards,

Phil.


