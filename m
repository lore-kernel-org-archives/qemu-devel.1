Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B38C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C308020578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vf5ItLFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C308020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKZ9-0008Ee-Tg
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBKXM-0005w0-Q9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBKXL-0000LB-57
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:41:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBKXL-0000Kh-1K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583768506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9CeH3IkcYVWI8EMq4UDI1RY7gGN/4pWBugXj67tYak=;
 b=Vf5ItLFNakJmgnciwbj+o3Xh5uOqRxk+B5ZVKl45p0UfzfIVcOr0EimxoCmcLJ1HZSj7R8
 aHtdAtzvWDAIWg/6F1d/fOHgfVraX82QTkwWt9dnt44+m9YSfMw4K/r0SPGr7m+oE61fFM
 Vca8Wke9w40cUZG/X5DRMJQa1rYoqYk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-aUKzQX0JPeOFpqJfe75Q-w-1; Mon, 09 Mar 2020 11:41:42 -0400
X-MC-Unique: aUKzQX0JPeOFpqJfe75Q-w-1
Received: by mail-ed1-f70.google.com with SMTP id x13so8300690eds.19
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8uVqvEC+I7iFp6JtqO4lH60g2L2zMJeC5RmESOlUfOo=;
 b=MdJEOIkYWSfw0RHX7QMi3OncBij7RWYFJ1kCWduFIx3D7paDD6kJG21hUmqbt/xD09
 UN75SiZOkBPSbEhPyxYFZ9cRYo8Sr2qKxh0RFuFSmtNDUTlabXEx+scgZtWAEaiHopjL
 QFmAeT1f55X/WGv6KXFu/JT5tXsvWldKgz1v+av9VSPS4J2cggBJkXr247ljYjMUUceX
 8VyED0+km5YpjVbWprxK6tpO3Mk7P6YuH4sxDtlfyqiMfh1Fi2GeS13dKGiv7ejg4rJF
 D+MSGB92MCb6q7IYAyWj1w6OZL0DARkUw18okXTOvSyOZHVglHv454SDSecys049UiUC
 9eGQ==
X-Gm-Message-State: ANhLgQ0db5SJTU0bLtzGPhrebsm07tqrQecw3PPfudzvnnKZQe4jtd0P
 7gMo+Zjm90LzdT7IXp+BKqxUEIQ9CF9YSiJHaaz1ZIP81QJaSHqg5QKfabuPllEfTJjL6ivC2ll
 KRX6uCbxiEcm2DXA=
X-Received: by 2002:aa7:d318:: with SMTP id p24mr10079166edq.386.1583768501081; 
 Mon, 09 Mar 2020 08:41:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtSENMX1eNkyZxN3I+UaJWd6I33plwpYDldrCrz5m5vknb0k4f7hIVmvb8+oRJ7WFU14jl7Fw==
X-Received: by 2002:aa7:d318:: with SMTP id p24mr10079141edq.386.1583768500766; 
 Mon, 09 Mar 2020 08:41:40 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id d1sm3328465ejy.3.2020.03.09.08.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 08:41:40 -0700 (PDT)
Subject: Re: [PATCH 2/5] hw/core/loader: Prohibit loading ROMs bigger than
 memory region
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200309144353.26457-1-philmd@redhat.com>
 <20200309144353.26457-3-philmd@redhat.com>
 <CAFEAcA-4BmEvo73a-1pvQx5r+T0gXRa2GcqAmAdYxZBsfAJqFw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <35729031-6c76-6f0e-a3f9-d88869aaef5f@redhat.com>
Date: Mon, 9 Mar 2020 16:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4BmEvo73a-1pvQx5r+T0gXRa2GcqAmAdYxZBsfAJqFw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 3:48 PM, Peter Maydell wrote:
> On Mon, 9 Mar 2020 at 14:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>
>> We must not write more data than the memory region size.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/core/loader.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index d1b78f60cd..c67c483936 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -1136,7 +1136,10 @@ static void rom_reset(void *unused)
>>               continue;
>>           }
>>           if (rom->mr) {
>> -            void *host =3D memory_region_get_ram_ptr(rom->mr);
>> +            void *host;
>> +
>> +            assert(memory_region_size(rom->mr) >=3D rom->datasize);
>> +            host =3D memory_region_get_ram_ptr(rom->mr);
>>               memcpy(host, rom->data, rom->datasize);
>=20
> Does this really only happen if there's a QEMU bug,
> or could a user trigger this assert by accidentally
> passing an oversize file on the command line?

This is definitively command-line triggered, but it occurred when I was=20
trying the RX port (not yet merged) so the bug might be an incorrect API=20
use there. I'll check tonight. Meanwhile I went consolidating the rest=20
of the code to feel safer.

>=20
> thanks
> -- PMM
>=20


