Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9297C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99202206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTEKiEVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99202206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpHq-0003bK-PK
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iwpHG-00038Y-Tv
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iwpHF-0008Pg-SX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:29:14 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iwpHF-0008MI-Kb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:29:13 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so20663499wro.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:cc:from:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=/OepjiM66bZe8KwsOgHG8bTCJYzjbGSZ/EkEmj4RXsc=;
 b=OTEKiEVOBmM8V1L4U7WPSvkW0qbL9igEx4jyxr1Po7mAQQ4RH5E/4GdzH9ngaexTFc
 uBbf+wHCRH1re131HKG6JHGHpZMFyPRizOqdAqRW2GMn267WswLUJt37C48tv0X0cQeC
 cQqsQEzSCER/NGKz7SMf5nqIWDr4TbslA/VWo0maCrGucS9l1OWQa23C/a7MZFCQ00bb
 vJeb8DvIJCbsUmt7NxrOVuHiUFjd6DUALeipPivQ2/jN1f3dmM1mdfHuE0LWTrecGY6z
 Tue51n8g0MqlxmhrInjgPEDj2sKP+ih9DAesQUQO4EXqZqO4BuiaHUjgBRdekulH9f3t
 t7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:cc:from:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=/OepjiM66bZe8KwsOgHG8bTCJYzjbGSZ/EkEmj4RXsc=;
 b=YuJKTXyrk70EQGmCBxZtEI+iPwY4/kY5oJHg5mlMDs8rvSoIEfnZiIRGE1qxJYbX6H
 sz2NOTXC1ecfft21BZoI/Qtbtfh9b8dt+BKp1qLBPcSUx12/af9KD4ANY67OaOCARAw0
 36bmPZsysgG6/fPtRRBU/rhqnL7XDBptZu7i+J1s66GBbvuYY//8YDd4UnXW0EHKSc2f
 V/gwMdK+AsvVSAHipWhX6kNkX9PyFqshyYKannF8NlW44+yj3+NFwAtnmti5QER8DOf9
 37BneEOrcRpHK9ly2pH0Pgay3llDRW8rXoNLCtb+eO/iv9EEnLOkntbFm1D9Z4UyLCji
 p2xQ==
X-Gm-Message-State: APjAAAUG3L9wQ0ASllx/z9Wbi8rfuUAQgjovYc3ACfhj2vR1fDuPW50r
 MUF3LjXZpsFPEAXGvUPYLvuzqw==
X-Google-Smtp-Source: APXvYqxSdv2Bu4x6KY+14S+ce+NFPS1gCqWJTTT3ubj5CcfxJtt6kaAOSD5gmao6t9a2I9gCXL8qVQ==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr33695170wrv.291.1580311751448; 
 Wed, 29 Jan 2020 07:29:11 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
 by smtp.gmail.com with ESMTPSA id b17sm3264260wrx.15.2020.01.29.07.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 07:29:11 -0800 (PST)
Date: Wed, 29 Jan 2020 07:29:11 -0800 (PST)
X-Google-Original-Date: Wed, 29 Jan 2020 15:28:50 GMT (+0000)
Subject: Re: [PATCH] riscv: sifive_u: Add a "serial" property for board serial
 number
CC: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: bmeng.cn@gmail.com
In-Reply-To: <CAEUhbmXRaHqxNt2XCgsjUDfR+VoMOjb5f38V6Yu35HWV1nkKeQ@mail.gmail.com>
References: <CAEUhbmXRaHqxNt2XCgsjUDfR+VoMOjb5f38V6Yu35HWV1nkKeQ@mail.gmail.com>
 <CAEUhbmUuCOzd_Y6ip_oh13gt83rM8EffdXWRCa=KybOjAvEN-A@mail.gmail.com>
 <mhng-b2e05f4a-7c3d-4be1-a843-a19b4054760a@palmerdabbelt.mtv.corp.google.com>
Message-ID: <mhng-e3089574-e78c-4b6c-961e-cac55f0f23d4@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

On Fri, 10 Jan 2020 07:52:05 GMT (+0000), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Fri, Nov 22, 2019 at 10:38 AM Palmer Dabbelt
> <palmerdabbelt@google.com> wrote:
>>
>> On Thu, 21 Nov 2019 17:10:18 PST (-0800), bmeng.cn@gmail.com wrote:
>> > On Sat, Nov 16, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>> >>
>> >> At present the board serial number is hard-coded to 1, and passed
>> >> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
>> >> the serial number to generate a unique MAC address for the on-chip
>> >> ethernet controller. When multiple QEMU 'sifive_u' instances are
>> >> created and connected to the same subnet, they all have the same
>> >> MAC address hence it creates a unusable network.
>> >>
>> >> A new "serial" property is introduced to specify the board serial
>> >> number. When not given, the default serial number 1 is used.
>> >>
>> >> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> >> ---
>> >>
>> >>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
>> >>  include/hw/riscv/sifive_u.h |  1 +
>> >>  2 files changed, 21 insertions(+), 1 deletion(-)
>> >>
>> >
>> > ping?
>>
>> Sorry, it looks like I dropped this one.  I've put it in the queue for 5.0,
>> with a
>>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Has this been applied somewhere?

Weird, not sure how I managed to screw this up again.  It's actually on for-master as 

    * a828041ba6 - riscv: sifive_u: Add a "serial" property for board serial number (50 seconds ago) <Bin Meng>

with any luck I'll manage to avoid screwing it up a third time.

>
> Regards,
> Bin

