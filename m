Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE7C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B032073F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bphdi5TU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B032073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6Mu-0005pP-SZ
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY6MF-0005EC-Rg
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY6ME-0000NC-ST
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:40:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY6ME-0000Mu-Oi
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574419210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtSc+e/0CNwYs3aEXFLcsT4W8amz9gxGO+QS7CWDUww=;
 b=Bphdi5TUfqyMDTm1ngoinfB3mgS4X9XcKFWyujmV5yxLBfO4JhdEHEXfgHHfz2yOioz9gi
 tW+rWU76nkg/DGqw3dxQrFgXWjEq0bsDbFmOHtpW7BfkoEi+84a9EdXuDPE25ZPxAFszZ1
 t1peVMCtK0nvS+RInOGGBzQz/BsIwIQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-hLSXVgz8O867-mICfc7KLg-1; Fri, 22 Nov 2019 05:40:08 -0500
Received: by mail-wr1-f71.google.com with SMTP id l3so3625889wrx.21
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9JPoK8wJk/ehYOwxPjR7b6d1G1rJObnAaz+6f2DjrgU=;
 b=b2TbIZS0LnPQ4LaABqCCSSDagAVdN8CK2MDQwfUsU3wsH9f8IP+OC7LktZJ6Yzv+uL
 5mhIQPgTiDItVF1aqTzUwCKP7+jclGs1+MCzBu4qPDHzGkEOgZgUS5Dd8lVmF3Jc+Fle
 Mvu61gE/DD2nISXDpdQhoDw+/MSTjn/wkOkCPljQex7XXy9Tg7SfdOTfzUrhfb2OUs8d
 B1cMM3dlwSaszFCFadnOW6tJV5Jiv+n2CUmxs1u6V95t5NpbW38s+3zB7dENRoq9+Kit
 FmI+18aB50hNgLo58SzNG9HN62uTkyObKWxcXyw5GW7DCC05Ig9W5Sdej8rWpo8wPekZ
 5ZoQ==
X-Gm-Message-State: APjAAAVbfBwRsYLUToeOfm4xB2a9sSCzpvOuN2ZABcbBZwVRdHtEfJPD
 EhHvncxfJG/NfkiIYRx34A/mM8IXThJw2bipc2pbOt6pF/aOdUwVDUpGUW/e4BeH9kbDEx3XeCI
 M1dEnMruL2XeYazk=
X-Received: by 2002:adf:9d88:: with SMTP id p8mr17250855wre.286.1574419207013; 
 Fri, 22 Nov 2019 02:40:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxH2ytIhqF0SkwaPMEEjZuCTjPvmLJDSpMwwDy/3rx9NtwNf108SYtBZqyZCeMy4Ko6S7tBZQ==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr17250823wre.286.1574419206715; 
 Fri, 22 Nov 2019 02:40:06 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id y78sm3044530wmd.32.2019.11.22.02.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 02:40:06 -0800 (PST)
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAL1e-=gHukqViBf8hXMnCJDPB36yzanrWPF6cz26W3ebwXGkLA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56528dfc-3305-da24-1df3-700f63779cac@redhat.com>
Date: Fri, 22 Nov 2019 11:40:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gHukqViBf8hXMnCJDPB36yzanrWPF6cz26W3ebwXGkLA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: hLSXVgz8O867-mICfc7KLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 9:55 PM, Aleksandar Markovic wrote:
>> Why not implement the dump_ASM code? This is very useful...
>>
>=20
> ... and time-consuming to implement, unless Michael have some
> ready off-shelf code.
>=20
> It is great that you have lots of ideas, Philippe, however I think
> that it is counterproductive to suggest Michael to work on this
> at this moment.

I am just asking why. I later realized Michael and Sarah should be using=20
their port via gdbstub, this having the gdb internal disassembler available=
.

> Disassembler is just a debugging tool,
> non-essential to core functionality, and Michael should remain
> focused on completing core bits and pieces of AVR emulation.
>=20
> My 2 cents,
> Aleksandar


