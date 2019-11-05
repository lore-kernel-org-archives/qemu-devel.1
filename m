Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B34C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7C921929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="RzLZXAWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7C921929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6xP-0002Wf-7W
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 17:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iS6B5-0004UM-1L
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iS6B3-0005sR-L3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:15:50 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iS6B3-0005sC-8H
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:15:49 -0500
Received: by mail-pg1-x541.google.com with SMTP id q22so7767728pgk.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 13:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=vX+PxPYjlpWPJsGckaHiwLQHpKcAySoc7QzwjClXI2o=;
 b=RzLZXAWfbduhN2CU7CS61Qk5TnDUVDqQQdmzpkZ1dPin1xLT6PFbCGoaF4dDHbPfe1
 gVskqKqG6jpRdZovG6aCXGYi0xLIgWoiVVkjY8xd65P6mk0XHyHKxf+bD1lfPF7C68GB
 OepJ/RTnKz8SwOjc2GR+6ylKH9OG8eqe446tp1qiZlohFUCrniGYnUzRaLvLPmgstvek
 Dz8ZLvqjoUhbbQa67XjJ2wLB7+ZMfG1mCV5dyQ7kl9Fwv9Spoi5LdP03IRK8yKD0anPb
 WkShemB4oW8a4nHy0iAfJV3QeEfd1jXHGVJvciyJCUiMRnuQwnuzedwjPvoOrYdzWyvz
 TZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=vX+PxPYjlpWPJsGckaHiwLQHpKcAySoc7QzwjClXI2o=;
 b=GApHOqWGCM95p/dBCSjq8WTpZbOtlcyi2buYQ7ViIo6LH+qU9qh/NXPf++dBOrCZPK
 wrVh2oav5EkmJ7aDJoVjIgbrWtnJue/KStza83WQyuhQI5JOs8woiN3XA5zNKJGOu6OR
 4SQFvmLEJW7SjDOBccAjDGGOHrRZvr+O4bJ8FWam4eK2qxl/aUaVfgxdm+OBOLueNGSW
 S+pM/UYAJot52UF5odzuR4G2ShRgKMFr3QzsIAPCH7SLOq+gDXoc0MhcPM9nMsFnSpTt
 6QkC+tMiXGah6JaU7a7fIu4kcr9tq0FkULDvWXu+WegUmDNbz5ag922O9CpxfPLssUgk
 NGWQ==
X-Gm-Message-State: APjAAAUdMpIcA8c1tpUwSHIXsMXgMzHcmdR0mTvOISlAFpOwf++ONTq/
 ZWKfuMINsRZd70SsMLl+95g1Gg==
X-Google-Smtp-Source: APXvYqzdZu4YrMBEIzJ20lha8D/jtiAJfJ7S6Qe2ZN9qm2LqAcp89JqcPkpHmitBHGtX5gHsxUnBww==
X-Received: by 2002:a17:90a:de4:: with SMTP id
 91mr1406497pjv.113.1572988547259; 
 Tue, 05 Nov 2019 13:15:47 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id m65sm791237pje.3.2019.11.05.13.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 13:15:46 -0800 (PST)
Date: Tue, 05 Nov 2019 13:15:46 -0800 (PST)
X-Google-Original-Date: Tue, 05 Nov 2019 13:04:01 PST (-0800)
Subject: Re: Adding New, Unsupported ISA to Qemu
In-Reply-To: <20191105164253.GJ166646@stefanha-x1.localdomain>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: stefanha@gmail.com
Message-ID: <mhng-fd2d5adf-ada4-41ab-94cc-f56e0481bcdc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: shanson@sandia.gov, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 05 Nov 2019 08:42:53 PST (-0800), stefanha@gmail.com wrote:
> On Mon, Nov 04, 2019 at 11:50:11PM +0000, Hanson, Seth via wrote:
>> I'm looking for in-depth documentation pertaining to how an unsupported 16 bit RISC ISA can be emulated in Qemu.
>> 
>> I've referenced this:
>> 
>> https://wiki.qemu.org/Documentation/TCG
>> 
>> and have been hoping there's additional, related documentation that I've overlooked.
>
> The general advice I've seen is:
>
> 1. Look at existing TCG targets to learn how to implement aspects of
>    your ISA.

Michael wrote a pair of blogs describing our port.  They're part of the "All 
Aboard" series, which details the RISC-V ports of the various core software 
components (binutils, GCC, glibc, Linux, and QEMU):

     https://www.sifive.com/blog/risc-v-qemu-part-1-privileged-isa-hifive1-virtio
     https://www.sifive.com/blog/risc-v-qemu-part-2-the-risc-v-qemu-port-is-upstream

It's a whole different thing than the documentation and is two years out of 
date, but it at least provides some perspective on why certain things in our 
port were done the way they were in caesy ou end up looking at the code.>

> 2. If you are unfamiliar with emulation, CPU ISA, or just-in-time
>    compiler concepts, try to read up on them and then look back at the
>    QEMU code.  Things will be clearer.
>
> You're welcome to join #qemu IRC on irc.oftc.net to ask questions.
>
> Good luck!
>
> Stefan

