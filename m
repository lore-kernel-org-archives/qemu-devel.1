Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCDEC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8E720838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+DKdY4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8E720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1FBk-0003NV-9r
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 14:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j1FA0-0002Ei-HL
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j1F9z-0001IE-D7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:56:00 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:47062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j1F9z-0001GJ-5b
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:55:59 -0500
Received: by mail-pg1-x543.google.com with SMTP id b35so4434918pgm.13
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id;
 bh=6kF9UfsZ1jw1wbmZv09k+yzUSsgoqRNX+mimxCpXgYk=;
 b=k+DKdY4KWK6qnSn1YnOCiQssHprcn/USicBrd/6JrYhKH7sL0dGUwBUHKEavtgLkMN
 3CXgNUQMXO3EX81FLOB7HWB/2tsa8V9jX11lIbrDQ2osUPs1ZKzliK5FNudGuQnRmZDA
 y+meFqMtr9hnP4g3p9BmDDmhINsnB4IBZLnp3Kn//HT0x32v9IwjAhAl+T8/2rsS84mR
 5tqOL46L6sQ39zCARYMdpqRsvBIqC1FEx+KbB3YBNwsUgduWhb8w48e2tq4JbCQGEwlG
 /3ADvznznghqjVee4uhi8WUNj2RjDl2ApLG0rT6IbAnWkXGVD8NV9WmXjJGIZWpJ5i8V
 M05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
 bh=6kF9UfsZ1jw1wbmZv09k+yzUSsgoqRNX+mimxCpXgYk=;
 b=TYt9hVHT95xqqCef2iURTZ6MqOt3hqGvSenow9dHrYd1i8X/AlmQfXBbdxmLSNkdah
 V2TLV2QciSO1dslxGbOcuj3fzrUbkORlo0C6A7y/CSCpILzgK+8cZxd1AoI2behmiVBY
 dt43pifsJTiL17YCgj6hjwfLuJXaMf1FpVOF9gn5ZgY86ChkJtKWIvRlmh2o9v3OQB36
 f4rNEDsBMDoYo0IiN/LE9X5WjZOk4nDQxCSdMEP9I9G2UAO/CEblKOe+JYp7H0TO15sb
 w17oLxKyunLA+G4BPCnkU21R0YXZE78f7WP+ZTxl9yvK2PVPx7StpjkPddHMq1ZngrFA
 PIgg==
X-Gm-Message-State: APjAAAVFpGq9rHjaa4HqlUEDVOd/A8DQOSZDNGYsVhawfdOHBAXSAgey
 wgVXdMjgvYCaohKldH/C+D3QLQ==
X-Google-Smtp-Source: APXvYqwsJvz4M1fEusHUVJ97adnxPpEouJLd4aIa4zi1ocBlGUZ9kyK+WtvLpHQtS5N//KI1ECh1Vw==
X-Received: by 2002:a63:b047:: with SMTP id z7mr3272214pgo.431.1581364556758; 
 Mon, 10 Feb 2020 11:55:56 -0800 (PST)
Received: from localhost ([2600:1012:b161:af3e:21a9:6308:301b:ae65])
 by smtp.gmail.com with ESMTPSA id a17sm245795pjv.6.2020.02.10.11.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 11:55:56 -0800 (PST)
Date: Mon, 10 Feb 2020 11:55:56 -0800 (PST)
X-Google-Original-Date: Mon, 10 Feb 2020 11:55:53 PST (-0800)
Subject: Re: [PATCH] riscv: sifive_u: Add a "serial" property for board serial
 number
In-Reply-To: <mhng-e3089574-e78c-4b6c-961e-cac55f0f23d4@palmerdabbelt-glaptop1>
CC: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-3370fb0c-3076-4a05-8bcd-ac7fce08d408@palmerdabbelt-glaptop1>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

On Wed, 29 Jan 2020 07:29:11 PST (-0800), Palmer Dabbelt wrote:
> On Fri, 10 Jan 2020 07:52:05 GMT (+0000), bmeng.cn@gmail.com wrote:
>> Hi Palmer,
>>
>> On Fri, Nov 22, 2019 at 10:38 AM Palmer Dabbelt
>> <palmerdabbelt@google.com> wrote:
>>>
>>> On Thu, 21 Nov 2019 17:10:18 PST (-0800), bmeng.cn@gmail.com wrote:
>>> > On Sat, Nov 16, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>> >>
>>> >> At present the board serial number is hard-coded to 1, and passed
>>> >> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
>>> >> the serial number to generate a unique MAC address for the on-chip
>>> >> ethernet controller. When multiple QEMU 'sifive_u' instances are
>>> >> created and connected to the same subnet, they all have the same
>>> >> MAC address hence it creates a unusable network.
>>> >>
>>> >> A new "serial" property is introduced to specify the board serial
>>> >> number. When not given, the default serial number 1 is used.
>>> >>
>>> >> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>>> >> ---
>>> >>
>>> >>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
>>> >>  include/hw/riscv/sifive_u.h |  1 +
>>> >>  2 files changed, 21 insertions(+), 1 deletion(-)
>>> >>
>>> >
>>> > ping?
>>>
>>> Sorry, it looks like I dropped this one.  I've put it in the queue for 5.0,
>>> with a
>>>
>>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> Has this been applied somewhere?
>
> Weird, not sure how I managed to screw this up again.  It's actually on for-master as
>
>     * a828041ba6 - riscv: sifive_u: Add a "serial" property for board serial number (50 seconds ago) <Bin Meng>
>
> with any luck I'll manage to avoid screwing it up a third time.

Ah, OK -- the issue here is that this fails "make check", specifically

    $ make check-qtest-riscv64
    make[1]: Entering directory '/home/palmerdabbelt/life/riscv/qemu/slirp'
    make[1]: Nothing to be done for 'all'.
    make[1]: Leaving directory '/home/palmerdabbelt/life/riscv/qemu/slirp'
            CHK version_gen.h
      TEST    check-qtest-riscv64: tests/qtest/cdrom-test
      TEST    check-qtest-riscv64: tests/qtest/device-introspect-test
    /home/palmerdabbelt/life/riscv/qemu/hw/riscv/sifive_u.c:406:riscv_sifive_u_soc_init: Object 0x55baf3feea00 is not an instance of type sifive_u-machine
    Broken pipe
    tests/qtest/libqtest.c:149: kill_qemu() detected QEMU death from signal 6 (Aborted)
    ERROR - too few tests run (expected 6, got 5)
    make: *** [/home/palmerdabbelt/life/riscv/qemu/tests/Makefile.include:630: check-qtest-riscv64] Error 1

which is probably how it kept getting disappeared -- I just forgot to reply on
the list.  I'm going to hold it back from the PR I'm staging right now, LMK if
you have a fix.

>
>>
>> Regards,
>> Bin

