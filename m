Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B9CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41C4206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41C4206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMU5U-0007n7-3M
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMU4j-0006yP-0P
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMU4h-0006Mj-4L
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:34:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMU4g-0006MK-SW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:34:03 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2F58C5117D
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:34:01 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j14so6649994wrm.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 02:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cDZe1+pi/7RJL1XV5KYr6L0zAgLFTBHD3z+IBh9RMyQ=;
 b=HvcjFaAMx9kdVBpN+cJ+z9YjdolKlchBpNrZGVaQydnBxutMJ5klU6Qtw9hqBThGN0
 qtXIV8e0/LFKzJ0i4dMG7Mac2j17ebepZsYzvBwiE/0MpNnJY1/oEkqlu65/UFR8b5yi
 B3K2KC2KBTUbqQ364DCBUPYUX6E15hmLaEV8ic2AovJ+vfofJ1Swr4U6fMsm6MlJJjxI
 bQ+O4NiqFOYK6O18fJhXyc1V7TWBWRNE3Vzo2NkxvNA0EiDxayXPLJYhz+LhShxVb9U+
 6PCXufX7p5MO4QKlCOtq4grxPygX5/IFSfj+dUKvQf3n6j2yvsSdbAuZFOPagJRUP4eR
 x63A==
X-Gm-Message-State: APjAAAVW7K/RExjVCZzxtr6uVYUZQb95mH5K1xh5uFht3o8MrY4SUxna
 mAvJ0oHNqWEuLC3XSQAh7taaK6tc2aaogbLBkNQoQzRlGScduUiL3LWIyLq+AV9keWZInY1vKt7
 7hAvdswKWvB9RVTg=
X-Received: by 2002:a05:6000:114e:: with SMTP id
 d14mr18169162wrx.47.1571650439900; 
 Mon, 21 Oct 2019 02:33:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5XIKRBB3TGKUw7i/sG2WUvAr6uTYWRTK6nAqVv3Pht+YwzEM60KU59Un1g7z0KCw88Nzhjw==
X-Received: by 2002:a05:6000:114e:: with SMTP id
 d14mr18169107wrx.47.1571650439670; 
 Mon, 21 Oct 2019 02:33:59 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id h17sm12430971wmb.33.2019.10.21.02.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 02:33:58 -0700 (PDT)
Subject: Re: [PATCH 12/21] hw/arm: Let the machine be the owner of the system
 memory
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-13-philmd@redhat.com>
 <CAFEAcA8bhP9X-2AaTus9=GtEAqmnNA9me6hv8U=vXYwjQp_CnA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <42944bea-4b15-7bdf-61a7-f1c73f5f7c2b@redhat.com>
Date: Mon, 21 Oct 2019 11:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8bhP9X-2AaTus9=GtEAqmnNA9me6hv8U=vXYwjQp_CnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 11:22 AM, Peter Maydell wrote:
> On Mon, 21 Oct 2019 at 00:01, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>=20
>>   hw/arm/virt.c             | 2 +-
>=20
> I think from a quick code scan that this is ok, but did
> you test that migration compat from old to new still works?
> I vaguely recall that there are some cases when adding an
> owner to a memory region changes the name string used for
> identifying the ramblock in migration.

It seems to still works:

$ make check-qtest-aarch64 V=3D1
QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64=20
QTEST_QEMU_IMG=3Dqemu-img tests/migration-test -m=3Dquick -k --tap <=20
/dev/null | ./scripts/tap-driver.pl --test-name=3D"migration-test"
PASS 1 migration-test /aarch64/migration/deprecated
PASS 2 migration-test /aarch64/migration/bad_dest
PASS 3 migration-test /aarch64/migration/fd_proto
PASS 4 migration-test /aarch64/migration/validate_uuid
PASS 5 migration-test /aarch64/migration/validate_uuid_error
PASS 6 migration-test /aarch64/migration/validate_uuid_src_not_set
PASS 7 migration-test /aarch64/migration/validate_uuid_dst_not_set
PASS 8 migration-test /aarch64/migration/auto_converge
PASS 9 migration-test /aarch64/migration/postcopy/unix
PASS 10 migration-test /aarch64/migration/postcopy/recovery
PASS 11 migration-test /aarch64/migration/precopy/unix
PASS 12 migration-test /aarch64/migration/precopy/tcp
PASS 13 migration-test /aarch64/migration/xbzrle/unix

This test migrate the virt machine.

Is this enough?

Regards,

Phil.

