Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49C4C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D452087E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D452087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04ML-0003Rg-Mf
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i04LK-00031y-GE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i04LJ-0001Hn-9d
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:38:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i04LJ-0001HT-2M
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:38:33 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18BB3A4D5E
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 13:38:32 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t9so7096146wrx.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 06:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qb076JsVXdS5H+mO8IA0D+9RIrITh8FA82AqFXOSXc0=;
 b=mi4EKuFwsVD+3xbkynuG83buPYe5Q7Nmfg8y6dx8qiB92iI1PEeqxsO3fjdbsycFIX
 AxsIR6oj34NVZkWtJTbwCAqDeTaDjxBlnSlY6ODWfvlUaJKRQ+yKqTVg0NNM9OdXG2SX
 Unpi+juP8KK4O0fu5gUV/26cCu/8wlwfgpLtnq0qh/2tPV0gbuNIEkAWCodamyOkAh72
 joL35BO4/yNsGyBvoSKl7gyL5ufeBjXEJwepOT+Cz8dMIjg6t7AjbXZ9Xcr5xhmZ8mTh
 USebh8OY0Fe/SO7ZBut0EYmy2qc5DGgXGmGwIHYTkhXNCTUHm+FWtrZOXe4Q1OHMgwSe
 O5Zg==
X-Gm-Message-State: APjAAAX3CZACMAPgmAEFjmomAQnKo3Xo8moYycKsR9Dbg/wnkFltqCqV
 f1bktqINPuH6Vhwa4DYn2XVG97oI/jjsvebvK1Ir87rU2Y2gRlAIpG+rWixE6ileScJeIdUntfc
 WF/YYK1WMKB2tp9I=
X-Received: by 2002:a1c:9ec5:: with SMTP id h188mr51191wme.176.1566308310801; 
 Tue, 20 Aug 2019 06:38:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9q/loN9XF/D56wS6p8PlmHvQdTnaMji37oL5ohjB28WJkvZCgWyEtsTTF0mkSLtVaF6u13A==
X-Received: by 2002:a1c:9ec5:: with SMTP id h188mr51155wme.176.1566308310440; 
 Tue, 20 Aug 2019 06:38:30 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id m6sm13663212wrq.95.2019.08.20.06.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2019 06:38:29 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, seabios@seabios.org,
 Nikolay Nikolov <nickysn@users.sourceforge.net>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
Date: Tue, 20 Aug 2019 15:38:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Regression with floppy drive controller
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
Cc: Alex <coderain@sdf.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 3:12 PM, John Snow wrote:
> On 8/20/19 6:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> [cross posting QEMU & SeaBIOS]
>>
>> Hello,
>>
>> I'v been looking at a QEMU bug report [1] which bisection resulted in =
a
>> SeaBIOS commit:
>>
>> 4a6dbcea3e412fe12effa2f812f50dd7eae90955 is the first bad commit
>> commit 4a6dbcea3e412fe12effa2f812f50dd7eae90955
>> Author: Nikolay Nikolov <nickysn@users.sourceforge.net>
>> Date:   Sun Feb 4 17:27:01 2018 +0200
>>
>>     floppy: Use timer_check() in floppy_wait_irq()
>>
>>     Use timer_check() instead of using floppy_motor_counter in BDA for=
 the
>>     timeout check in floppy_wait_irq().
>>
>>     The problem with using floppy_motor_counter was that, after it rea=
ches
>>     0, it immediately stops the floppy motors, which is not what is
>>     supposed to happen on real hardware. Instead, after a timeout (lik=
e in
>>     the end of every floppy operation, regardless of the result - succ=
ess,
>>     timeout or error), the floppy motors must be kept spinning for
>>     additional 2 seconds (the FLOPPY_MOTOR_TICKS). So, now the
>>     floppy_motor_counter is initialized to 255 (the max value) in the
>>     beginning of the floppy operation. For IRQ timeouts, a different
>>     timeout is used, specified by the new FLOPPY_IRQ_TIMEOUT constant
>>     (currently set to 5 seconds - a fairly conservative value, but sho=
uld
>>     work reliably on most floppies).
>>
>>     After the floppy operation, floppy_drive_pio() resets the
>>     floppy_motor_counter to 2 seconds (FLOPPY_MOTOR_TICKS).
>>
>>     This is also consistent with what other PC BIOSes do.
>>
>>
>> This commit improve behavior with real hardware, so maybe QEMU is not
>> modelling something or modelling it incorrectly?
[...]
>=20
> Well, that's unfortunate.
>=20
> What version of QEMU shipped the SeaBIOS that caused the regression?

See https://bugs.launchpad.net/qemu/+bug/1840719/comments/3

QEMU commit 0b8f74488e, slighly before QEMU v3.1.0
(previous tag is v3.0.0).

But you can use v4.1.0 too, simply change the SeaBIOS bios.bin, i.e.:

  qemu$ git checkout v4.1.0

  qemu$ (cd roms/seabios && git checkout 4a6dbcea3e4~) && \
        make -C roms bios

Now pc-bios/bios.bin is built using the last commit working,

  qemu$ (cd roms/seabios && git checkout 4a6dbcea3e4) && \
        make -C roms bios

And you can reproduce the error.

Regards,

Phil.

