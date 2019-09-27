Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE0EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A60521841
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8Edi8jP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A60521841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqxV-0008LK-2o
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iDqG8-0007aY-Et
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iDqG7-00012a-Aq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:26:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iDqG7-00012W-58; Fri, 27 Sep 2019 09:26:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id y72so1581835pfb.12;
 Fri, 27 Sep 2019 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=TzPly1HOOP5ZxOVgZNGoYgvsj1Jnu09Ez2nIhgHlkY8=;
 b=L8Edi8jPOfq2NbZlINTGOHDgfJyjJIFAI0nrKtzA6iGx5qYKUMti0M25LvSOnNbN4l
 OM0naoRLzCuuz+zd0sp4/SzoW8ThYeAkfz/Qcifhbkg+zeAf5eLmkuK6MKwkPNPgY8uN
 QLPyZvLxTdjqCUU7QoVN1L+/HbWwX0jlzDRKQZSVEjCxy627dNVcsn2dIMev11PpNDsP
 uygFZN7Y9gGP5BpOSy1jfeb/tZxSN7HUKJzJkzpiqGUeM2Fzcr4DvpfsmBRagxFwwXLP
 GU+e1Eu8fzZnMofGeVof73xUnkzr/dbO5dK/uZZzIH0MC6CK3akiIoyRCdEB4J16P5Kj
 dT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=TzPly1HOOP5ZxOVgZNGoYgvsj1Jnu09Ez2nIhgHlkY8=;
 b=twWtxuFP0aG9Tdg0gm14nTRwZAxouQB99+QYCF/beTm2qj+tXdtgNDAxbXyH3MFIgZ
 IJKQDhOs3ULBLGlnJGZeNswjPw8y1Dbrvg0y4rwkiPqRVZxOOT7o3/rbXbnLbImAYnT3
 SKSEaRCVxUZL8rLLNDSgaM8zO4N+CT5cPlvDlssr0xkwGhFNKDy1hmTuM2KYjLn3oYqS
 ka3eKT8TQxcqIInok9LbtSFUhnN5ipkCU4AgSUG0sJRJ+PqVAwEhYZ2A021+0Tqwt3L+
 5/qzpgiuFo0Mb8CI2c4HdiJtFvuP7ETRU/Z9b+glEDvAsTBt0dyCxYt5ep+ScXc+C89A
 VLoQ==
X-Gm-Message-State: APjAAAX4Q/XKwU19VF708pumFaGwgtYDdiE9ijSR9/rbam48jJ1wQWs1
 cqlBsQPBEOcDfPOsr1zih4s=
X-Google-Smtp-Source: APXvYqwcBNT6wz0SymG2SWs8UsfrdYXH7KWpEqDSy2cs2h2hc5olPQw4Gno3/UQ1orULSMWr603PMA==
X-Received: by 2002:a63:5745:: with SMTP id h5mr9518090pgm.268.1569590765893; 
 Fri, 27 Sep 2019 06:26:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id f6sm4488541pga.50.2019.09.27.06.26.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 27 Sep 2019 06:26:04 -0700 (PDT)
Date: Fri, 27 Sep 2019 06:26:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: bzt <bztemail@gmail.com>
Subject: Re: [PATCH 14/19] python/qemu/machine: Allow to use other serial
 consoles than default
Message-ID: <20190927132602.GA19931@roeck-us.net>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-15-f4bug@amsat.org>
 <CADYoBw11iiK=+O-mGYS5Xp85zVhezOXXXr-wKV_xCg07ZYuzVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYoBw11iiK=+O-mGYS5Xp85zVhezOXXXr-wKV_xCg07ZYuzVw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cheng Xiang <ext-cheng.xiang@here.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 02:54:10PM +0200, bzt wrote:
> Hi,
> 
> On 9/26/19, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> > Currently we are limited to use the first serial console available.
> 
> I'm not so sure. Right now it works like this:
> 
> qemu -serial stdio
> Connects the VM's UART0 (PL011) serial console to the host terminal
> 
> qemu -serial null -serial stdio
> Connects the VM's UART1 (AUX) serial console to the host terminal
> 
> I think this is simple and good, please don't remove this option. If
> your commit does not influence these cli args, I'm not against it.
> 
Agreed. I am using that mechanism (raspi3 uses the second console,
not pl011) in my scripts. Please don't take it away.

Guenter

