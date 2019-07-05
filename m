Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D980C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 18:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C984720989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 18:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C984720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjSZp-00069C-Rt
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 14:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjSW3-0004Jc-Ux
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 14:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjSW1-00007x-JR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 14:00:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjSVz-0008Tc-Ij
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 14:00:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so10763350wrs.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 11:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mDuuTmkpG9H5bMTyr3THhrPPmDGahgOeZSNWwvB5IsU=;
 b=uhugUykJN9DSdnq92jMqVWPQKq4LW5l4TGEAZMNzuYo0acsi+3jmYAKqXXdA61eKyA
 YXCCtw86HGGvUijExxcAuqbC1kvooOmlLZFWffm9dfQzEYA2sfrTkw3HMgGM0iUTF/d7
 w7rERJtbr1CzX83uBCJMO7kS8T6znZk7kbTCY7oDcuAjwFaVUeNNywTSe0k1PQDLn+cQ
 RJryuJAxeM8xK4j0lpBdEZC0zXCvuMQbrdfT1gstlBSjCeolg6R3flaaE2Ls18/XlSo+
 4ORCaQQxMu/q3XdBULcn8UAmln+SR0hkGL8RHeyn8yR2TWg8KFaqpypTjhqRqjuxRMoc
 aa6w==
X-Gm-Message-State: APjAAAXxSg4MGXcEU6bHUPSlYGu8anZleCTWE9DxJLLOxkdnmv2jr9Mf
 dbyEwQQYXCnQDU7kKOIrU1YJwg==
X-Google-Smtp-Source: APXvYqwv0wG9g5Vptv2lsaZxHj9HR5/QPcgJmAIoUbzhVuzQg1ad0UrzorS+hgSPNNMdTXZv0lDI+g==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr4874995wrq.333.1562349648404; 
 Fri, 05 Jul 2019 11:00:48 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id r6sm6515344wmh.11.2019.07.05.11.00.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 11:00:47 -0700 (PDT)
To: Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
References: <20190627110201.1999-1-f4bug@amsat.org>
 <20190627110201.1999-2-f4bug@amsat.org>
 <62d7304c-0d3c-9c34-4934-d11393477ec5@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3a22cfdb-2968-83a5-5ffd-064e808d2f7d@redhat.com>
Date: Fri, 5 Jul 2019 20:00:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <62d7304c-0d3c-9c34-4934-d11393477ec5@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/acceptance: Add test that runs
 NetBSD installer on PRep/40p
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kamil,

On 6/27/19 11:47 PM, Kamil Rytarowski wrote:
> On 27.06.2019 13:01, Philippe Mathieu-Daudé wrote:
>> +        bios_url = ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
>> +                    '7020-40p/P12H0456.IMG')
>> +        bios_hash = '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
>> +        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
>> +        drive_url = ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
>> +                     'NetBSD-4.0/prep/installation/floppy/generic_com0.fs')
>> +        drive_hash = 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
>> +        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
>> +
>> +        self.vm.set_machine('40p')
>> +        self.vm.set_console()
>> +        self.vm.add_args('-bios', bios_path,
>> +                         '-fda', drive_path)
>> +        self.vm.launch()
>> +        os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
> 
> Is there a specific reason to use NetBSD 4.0? It's a very old release,
> the newest one is 8.1.

The goal of these integration tests is to verify a specific
configuration that worked in the past still works with today codebase.

It is particularly useful for machines that have not a big quantity of
users.

This test does not intent to test NetBSD, but that the PReP/40p machine
is still working, as it used to work in the post saved in the commit
description:

http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html

So this test is useful to avoid the PReP machine code to bitrot.

I'd like to know what other from the QEMU community think/expect about
these tests.

FWIW I tested newer versions and they don't boot.

Regards,

Phil.

