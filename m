Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AA9C606A7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B631D20656
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B631D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQyZ-00084V-VH
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 06:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkQvL-0007KY-9t
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkQvK-0005lr-53
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:31:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkQvJ-0005lU-Rd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:31:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so11811568wru.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 03:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hF7UVqwijPHZ9t69gGwYDNbu+YA+hZic/Nq2VgyNwJ4=;
 b=OBezDiqL+RFyBkLwCRiRpyDWy7kAoQ8kG0zzI0p9uX7oLvSemhuuQZhf8wFJNQ+qp5
 xPf4X1Wqtusx6PTLxqrjjEclbpgMF1ARuYhWv/N7PmFscpJ86hF4+i6PkL5LpMyjlg9F
 C3IH+syZ5Ut9zT2sqNGo9bYkcFuCBqUUmN8FZgsLgFysTFUVwKc859qU3uHv45UkAYO6
 2QTyeeEqwOL4UsT+/+qz3yA67UxhMkQapJAxPVHuCy6lqM25JKKLoyoCuohMA3iMNg3V
 8ice7W3QZajG18eAzynys8MAHwwTPOUexufQKt8gVcYu+xhZ1ybRCqajIdI0Nx4YjJ5q
 Tofg==
X-Gm-Message-State: APjAAAVTYW6w+DhThjoBhw/TBmtg4GSZE2I9Qdq6uAkuiyLEMB2IdyZf
 Vf5FKJ0S6pkkwanqSLFCYTP5aA==
X-Google-Smtp-Source: APXvYqxpiXJ0zU5+9vs/stvk+BZZf3glwtKTYz09yA7S45gyGAET6Sp+2d2rRQU+Cu9PWJLD8B1hxg==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr17520034wrn.11.1562581864769; 
 Mon, 08 Jul 2019 03:31:04 -0700 (PDT)
Received: from [192.168.1.103] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id u18sm15832471wmd.19.2019.07.08.03.31.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jul 2019 03:31:04 -0700 (PDT)
To: Francisco Iglesias <frasse.iglesias@gmail.com>
References: <20190705202500.18853-1-philmd@redhat.com>
 <20190705202500.18853-4-philmd@redhat.com>
 <20190705222429.ox6z6wckkupjpug2@fralle-msi>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cc2c2c78-70ad-f7e2-99a9-a428303c7f5e@redhat.com>
Date: Mon, 8 Jul 2019 12:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705222429.ox6z6wckkupjpug2@fralle-msi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.1 v4 3/3] hw/ssi/xilinx_spips:
 Avoid out-of-bound access to lqspi_buf[]
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
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/19 12:24 AM, Francisco Iglesias wrote:
> Hi Philippe,
> 
> On [2019 Jul 05] Fri 22:25:00, Philippe Mathieu-Daudé wrote:
>> Both lqspi_read() and lqspi_load_cache() expect a 32-bit
>> aligned address.
>>
>> Set MemoryRegionOps.impl values to force 32-bit accesses,
>> this way we are sure we do not access the lqspi_buf[] array
>> out of bound.
> 
> The patch and correction follows chapter 24 aswell (UG1085) so I suggest
> dropping 'RFC' in the subject.

OK.

>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Late friday patch...
>>
>>  hw/ssi/xilinx_spips.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>> index 3c4e8365ee..8f705132a3 100644
>> --- a/hw/ssi/xilinx_spips.c
>> +++ b/hw/ssi/xilinx_spips.c
>> @@ -1243,6 +1243,10 @@ static const MemoryRegionOps lqspi_ops = {
>>          .min_access_size = 1,
>>          .max_access_size = 4
>>      }
> 
> A comma is missing on the line above (else the patch doesn't compile).

Sorry, I first added this block before '.valid' and tested it, then
moved it and thought the trailing comma was not useful and forgot to
test for the previous '.valid' field :/

> 
> Best regards,
> Francisco
> 
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    }
>>  };
>>  
>>  static void xilinx_spips_realize(DeviceState *dev, Error **errp)
>> -- 
>> 2.20.1
>>

