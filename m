Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F87C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309E92084A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309E92084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he9eD-0003YR-GW
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1he9cd-0002qs-BY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1he9cc-0007P9-0g
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:49:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1he9ca-0007K7-VL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:49:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so2241910pla.7
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 19:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=aw5wQUD3VPHO+OMY2qMWNTo++9Jftg7mvus/qfGsyqE=;
 b=Kw/OXMVrV6z0PkIdX0p+GMp3zP+JiXIBRpC9B4W1lFvNRUQ0/K+NPoo8wyTKKZn4B/
 X37ghvqKZfm+w5Lnundq0Vhy/C32nyAKFjuPty94KLk/lcbeWqz7Ygm5eSWXZ64dEH8w
 Muui9MERf0/3td7vi+2LWVUC11Hzh5srPYSBfMyv/n0Cy2gsat8LKFYtbF2z1zLAVjcI
 RJWAXsJdqstsQKO2rp/OiQ0kdJJKJoUSDtdkM1WgIfCbgLbiERJSznYsckN5ZxpxSvHB
 YNRqBE7W+NVDIWzlWBUAn+TTtp0wAS0eX14X/0XLn21PNLJAd8mkzo7Y95YWCDPIlg0h
 O2Jg==
X-Gm-Message-State: APjAAAXVKSzm2itZwqK3gJMdu35njmPXI1HYdZRhvzPCtek0XKNtKQY7
 eKCGirVlJZMWzZinMkdqdH7fug==
X-Google-Smtp-Source: APXvYqyfTMyEBgN9jjzkVHj92pAld7l8OPxCMiJDL7IwcJepCj6g1F4eYyELMa6BA8U7TNxYwl0QEQ==
X-Received: by 2002:a17:902:8f87:: with SMTP id
 z7mr100620972plo.65.1561085385651; 
 Thu, 20 Jun 2019 19:49:45 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id h21sm863887pgg.75.2019.06.20.19.49.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 19:49:44 -0700 (PDT)
Date: Thu, 20 Jun 2019 19:49:44 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Jun 2019 19:41:46 PDT (-0700)
In-Reply-To: <CAKmqyKPRWASwUPQUROPWyrNC8gXTnizXTaXYdpbEAmkfjOZo1g@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-2816be05-3e0d-4cb6-a39e-082b071f8ba2@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
Subject: Re: [Qemu-devel] [PATCH v1 0/9] Update the RISC-V specification
 versions
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Jun 2019 07:19:38 PDT (-0700), alistair23@gmail.com wrote:
> On Wed, Jun 19, 2019 at 3:58 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Mon, 17 Jun 2019 18:31:00 PDT (-0700), Alistair Francis wrote:
>> > Based-on: <cover.1555726824.git.alistair.francis@wdc.com>
>> >
>> > Now that the RISC-V spec has started to be ratified let's update our
>> > QEMU implementation. There are a few things going on here:
>> >  - Add priv version 1.11.0 to QEMU
>> >     - This is the ratified version of the Privledge spec
>> >     - There are almost no changes to 1.10
>> >  - Mark the 1.09.1 privledge spec as depreated
>> >      - Let's aim to remove it in two releases
>> >  - Set priv version 1.11.0 as the default
>> >  - Remove the user_spec version
>> >      - This doesn't really mean anything so let's remove it
>> >  - Add support for the "Counters" extension
>> >  - Add command line options for Zifencei and Zicsr
>>
>> Thanks!  I'll look at the code, but I've currently got this queued up behind
>> your hypervisor patches so it might take a bit.  LMK if you want me to invert
>> the priority on these.  I'll probably be buried until the start of July.
>
> Let's move the Hypervisor patches to the back then. There is a new
> spec version now anyway so I'll have to update them for that.

OK.  Do you want me to just drop them and wait for a v2 / draft 0.4?

>
> Alistair
>
>>
>> > We can remove the spec version as it's unused and has never been exposed
>> > to users. The idea is to match the specs in specifying the version. To
>> > handle versions in the future we can extend the extension props to
>> > handle version information.
>> >
>> > For example something like this: -cpu rv64,i=2.2,c=2.0,h=0.4,priv_spec=1.11
>> >
>> > NOTE: This isn't supported today as we only have one of each version.
>> >
>> > This will be a future change if we decide to support multiple versions
>> > of extensions.
>> >
>> > The "priv_spec" string doesn't really match, but I don't have a better
>> > way to say "Machine ISA" and "Supervisor ISA" which is what is included
>> > in "priv_spec".
>> >
>> > For completeness I have also added the Counters, Zifencei and Zicsr
>> > extensions.
>> >
>> > Everything else seems to match the spec names/style.
>> >
>> > Please let me know if I'm missing something. QEMU 4.1 is the first
>> > release to support the extensions from the command line, so we can
>> > easily change it until then. After that it'll take more work to change
>> > the command line interface.
>> >
>> > Alistair Francis (9):
>> >   target/riscv: Restructure deprecatd CPUs
>> >   target/riscv: Add the privledge spec version 1.11.0
>> >   target/riscv: Comment in the mcountinhibit CSR
>> >   target/riscv: Set privledge spec 1.11.0 as default
>> >   qemu-deprecated.texi: Deprecate the RISC-V privledge spec 1.09.1
>> >   target/riscv: Require either I or E base extension
>> >   target/riscv: Remove user version information
>> >   target/riscv: Add support for disabling/enabling Counters
>> >   target/riscv: Add Zifencei and Zicsr as command line options
>> >
>> >  qemu-deprecated.texi                          |  8 +++
>> >  target/riscv/cpu.c                            | 72 ++++++++++---------
>> >  target/riscv/cpu.h                            | 19 ++---
>> >  target/riscv/cpu_bits.h                       |  1 +
>> >  target/riscv/csr.c                            | 13 +++-
>> >  .../riscv/insn_trans/trans_privileged.inc.c   |  2 +-
>> >  6 files changed, 71 insertions(+), 44 deletions(-)

