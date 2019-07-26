Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E21C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4A822ADA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgZ2FjrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4A822ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr6pS-0006ma-JY
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 16:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42306)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hr6pH-0006Mu-Rg
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hr6pG-0001Ho-Ns
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:28:27 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hr6pG-0001FF-BO; Fri, 26 Jul 2019 16:28:26 -0400
Received: by mail-lf1-x144.google.com with SMTP id q26so37952926lfc.3;
 Fri, 26 Jul 2019 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pGy1g6EbkGS9Q9IepH/gSTvQmqyMRD/7i4dSk3cQ3e4=;
 b=GgZ2FjrG+h3NIlSKZ5lIu4vxhA7IeCI2fq68qjfDZtHWzw/L9RbnE1JdsnNqkTfX3x
 GQexWO901PqFwA7oPubrI4t3B/YrYjSvoNpW3m2Y2BKP9Wt71wr16mf9KRimmvhS6gTS
 UahgVsy9gS/DCR878koMwHT1Z1eV/+3WNHlWauP+qHFFhOjkbY5VTRFntRA/b210DY5G
 MksVto3JYXg8jQ0gE4R46b1Ik4zBEPj9lQI9W9CzCyc+n1HPoNJFkdolELkXtvssVj4r
 wRQCwruEu6QjdG3iZIngVEyR7x5wnc8seiuWhF/CeQ5mUKOLlFmuD+tN1U/mg96P0IDY
 kG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pGy1g6EbkGS9Q9IepH/gSTvQmqyMRD/7i4dSk3cQ3e4=;
 b=KdR03mX+ddUFhw+qq9fD/cJ14VODhg19jn0QrzV0M90L2sFD5e1xyOqdqy0R2oAx6e
 BZlS2+3CrXiejb8S3FvhWUZ+ABWAlvA+O7gtKOEponNjyBXuEpyAFT29RKwEAgk1wkSC
 3ZThVvPHUDN7UFKg042jASMUC4cmbATGKUWpZkIinCA3QQtJ+Qoc8pwlb06/YNZJwYer
 5INeG1luBu3owk3iMlXX69QS3J9DS3NRsspoC4lSnm0aZvHaHAHs9XgNL6ijSm427Wj+
 VpRGwm+2L9hA2FfNMlX/Z37HfPTgw22ZjrsbjyPqafuHgYwNgDi5/P49Otkf3L6JqQTX
 ko7w==
X-Gm-Message-State: APjAAAWJkic0mEDpqQ11LEDLntQWjV1QJ3G7sVrxLisjqQb3VNem5E7p
 ajfiHtWhGE8Z0iN5ba3JG+JUuQ+/ziZWHMMffMA=
X-Google-Smtp-Source: APXvYqxJlud96LPVCRCla5yshkaU/r1FCnWPbkb15WNXSTqAyUPAXSZnGgGcGqys8ULEcf7imrRnqMmZkN50uQ+yqCU=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr45203396lfu.141.1564172904656; 
 Fri, 26 Jul 2019 13:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <b415f5b51e09418760b95e5c73fad5e68b97f173.1564080680.git.alistair.francis@wdc.com>
 <CANnJOVEyy7wb74eEucj5t=xonOvUFTPWuty9R+-KP0DLc+L7zQ@mail.gmail.com>
In-Reply-To: <CANnJOVEyy7wb74eEucj5t=xonOvUFTPWuty9R+-KP0DLc+L7zQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2019 13:24:51 -0700
Message-ID: <CAKmqyKOh-7LE5ry_RG56-TM0bqj_kckcK74W8kFLiPHrjjx7hw@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH-4.2 v1 2/6] target/riscv:
 Remove strict perm checking for CSR R/W
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 2:48 PM Jonathan Behrens <fintelia@gmail.com> wrote=
:
>
> Unless I'm missing something, this is the only place that QEMU checks the=
 privilege level for read and writes to CSRs. The exact computation used he=
re won't work with the hypervisor extension, but we also can't just get rid=
 of privilege checking entirely...

The csr_ops struct contains a checker function, so there are still
some checks occurring. I haven't done negative testing on this patch,
but the current check doesn't seem to make any sense so it should be
removed. We can separately discuss adding more checks but this current
way base don CSR address just seems strange.

Alistair

>
> Jonathan
>
> On Thu, Jul 25, 2019 at 2:56 PM Alistair Francis <alistair.francis@wdc.co=
m> wrote:
>>
>> The privledge check based on the CSR address mask 0x300 doesn't work
>> when using Hypervisor extensions so remove the check
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  target/riscv/csr.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index e0d4586760..af3b762c8b 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -797,9 +797,8 @@ int riscv_csrrw(CPURISCVState *env, int csrno, targe=
t_ulong *ret_value,
>>
>>      /* check privileges and return -1 if check fails */
>>  #if !defined(CONFIG_USER_ONLY)
>> -    int csr_priv =3D get_field(csrno, 0x300);
>>      int read_only =3D get_field(csrno, 0xC00) =3D=3D 3;
>> -    if ((write_mask && read_only) || (env->priv < csr_priv)) {
>> +    if (write_mask && read_only) {
>>          return -1;
>>      }
>>  #endif
>> --
>> 2.22.0
>>
>>

