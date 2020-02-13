Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60C8C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD2E2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QROnraML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD2E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HGJ-0002Ye-JW
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2HFE-0001XJ-9s
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2HFD-00029S-5R
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:21:40 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2HFC-000279-VU; Thu, 13 Feb 2020 11:21:39 -0500
Received: by mail-pg1-x543.google.com with SMTP id j4so3369895pgi.1;
 Thu, 13 Feb 2020 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=VMvE+jjRrSJVchdl1Gsv64shRkckHcvzw0eAkdgO2dg=;
 b=QROnraMLjyi8Q/RHFb42t8EI4lWEobo5qBzWrOcM8/w2F89Ql1G7CwqCyNz1MEY0Sp
 z6SvKrd2oh4YWvnBIvFSJAb6qdx7ZYtQRDByATFLEJ7kVG2swMbt7r61XNZeQCgYCYkN
 9PGOSVuaCzVByUfLSyQqBcqtblkGNiGeDbjv/bobLv1Mbr0ttQ1yJRhyQRn/DTLDl8zD
 kWmyROEEvyiHVgXLPNNcwCi904jmfn/xhRahWmT79x++wA8XEBFTQAL47QO13sZEeJOo
 5zW6brpRH9HQOY+RsgHmNHxiGLAMZsyDD8+/fL/StNzpK3sj7gcG229FR4TmkOUX0ZrU
 zZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=VMvE+jjRrSJVchdl1Gsv64shRkckHcvzw0eAkdgO2dg=;
 b=W7AJR06bQUM82aoPouBp0hq/nZQsDsaW8+GffWS3Yiqpt9Yt+oxhry6MCFk0lWGfqp
 FxADIjoBaTT4TZYeIFL75/Sa1+LkQNQFh3myTIyaljglHKXNKWXsp4rmjomus/j0gbfa
 MhJXECLStFUI/XvcALpalmvwr/I0Fdf09oG9zKaWBa1N+GHwb6L9pRxC+Hsa+B6dsgi8
 xEhyQk7ksowb952mw8ADA3JOLRr8d2hT4KFNZLE7Ya3JRh4H1JpQldsRZtKgZv/Dk93Z
 CJX1Ezbs88RbB7LP+US40me+h8w86Gqm9rnvPwUoUb2llZPvNNIr1k4Dfq4AdV6quytf
 VEPQ==
X-Gm-Message-State: APjAAAXi3ARrXFKhWhW2hN+El/bBrprfB82F5D2IK1wpCYJ/OE+O8tFg
 pAvk/qgdXjWJMNBgQIYUXb8=
X-Google-Smtp-Source: APXvYqwsRefXxm7qjNP8edFbUGCBIRhzzKRCjQNpKKzH3u9lVj2ZCKKL9koMwok8UXw3EVHBMHfTaA==
X-Received: by 2002:a63:6d0b:: with SMTP id i11mr14645165pgc.266.1581610897939; 
 Thu, 13 Feb 2020 08:21:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id u2sm3628381pgj.7.2020.02.13.08.21.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Feb 2020 08:21:37 -0800 (PST)
Date: Thu, 13 Feb 2020 08:21:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Question about (and problem with) pflash data access
Message-ID: <20200213162135.GA16294@roeck-us.net>
References: <20200212184648.GA584@roeck-us.net>
 <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
 <20200212230918.GA27242@roeck-us.net>
 <560224fe-f0a3-c64a-6689-e824225cfbb9@redhat.com>
 <279d959f-f7e5-65e1-9c68-459f3fed56d3@ozlabs.ru>
 <52f0b829-151a-3dd0-0ec7-c3155185510c@redhat.com>
 <9f652340-1277-0eb2-bc2c-402b4209a220@roeck-us.net>
 <CAFEAcA8CyTqdqvT6xatkxb9EN49zD4OBaKrbaLpkyZg+eMoM6w@mail.gmail.com>
 <ff42c7de-ef78-a0e5-9abe-9343947ff6d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff42c7de-ef78-a0e5-9abe-9343947ff6d6@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 04:24:24PM +0100, Philippe Mathieu-Daudé wrote:
> On 2/13/20 3:39 PM, Peter Maydell wrote:
> > On Thu, 13 Feb 2020 at 14:26, Guenter Roeck <linux@roeck-us.net> wrote:
> > > What really puzzles me is that there is no trace output for
> > > flash data accesses (trace_pflash_data_read and trace_pflash_data_write),
> > > meaning the actual flash data access must be handled elsewhere.
> > > Can someone give me a hint where that might be ?
> 
> If you can share built kernel/dtb/rootfs for this machine I can have a look
> at it.
> 
> > > Clearly I am missing something about inner workings of qemu.
> 
> You can see all the pflash events using '-trace pflash*'.
> 
Yes, I got that much ;-).

> > 
> > Probably the device is in 'romd' mode. A QEMU MemoryRegion
> > can be:
> >   * RAM (includes ROM for these purposes) -- backed by host
> >     memory, reads and writes (if permitted) go straight to
> >     the host memory via fastpath accesses
> 
> No tracing here.
> 
> >   * MMIO -- backed by a read and write accessor function,
> >     all accesses go to these functions
> >   * "ROM device" -- a mix of the above where there is a
> >     backing bit of host memory but also accessor functions.
> >     When the device is in "romd" mode, reads go direct to
> >     host memory, and writes still go to the accessor function.
> >     When the device is not in "romd" mode, reads also go
> >     to the accessor function.
> > 
> > We use this in the pflash devices to make the common case
> > ("just read the flash") fast. When the guest makes a write
> > to flash that puts it into programming mode, we call
> > memory_region_rom_device_set_romd(..., false) so we can
> > intercept reads and make them do the right thing for
> > programming mode.
> > 

Disabling the calls to memory_region_rom_device_set_romd(..., true)
got me the trace output I was looking for. Turns out that reads
which supposedly are from the beginning of the flash start at offset
0x180000 instead of 0. This explains the "corruption", since that is
exactly the data in my test file at that offset. Adding debug output
to the Linux kernel confirms that this offset originates from the Linux
kernel.

Taking a closer look into the kernel source shows that the flash partitions
for SX1 indeed start at offset 0x180000 in the flash, not at 0. Bummer.

Sorry for all the noise. I should have paid closer attention to the
kernel source. Oh well, at least I learned a lot about qemu.

Thanks,
Guenter

