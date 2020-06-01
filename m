Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FD2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 11:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FA320772
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 11:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W205YNhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FA320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfiRn-0000jV-5H
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 07:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfiPS-0007Vb-K0; Mon, 01 Jun 2020 07:15:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfiPQ-0001to-R4; Mon, 01 Jun 2020 07:15:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id j198so11842683wmj.0;
 Mon, 01 Jun 2020 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WQfJzqFfEaKfIfQ4a6l8KRYhHeFJRpYVrfeth7NbeaI=;
 b=W205YNhfbTjoAc+Sq9+SlEL7WiYKF5b9v5yHkY4DXyopHwJPg1SVVv2w9oIR4mdeiZ
 ST7h/2FQ9CrppRhn/J3bbwaLc+m7JhXGYYfwf5FoKVkAUCjHbK313p/oDAqp2+OiuQ4r
 motnab8vc2Rmd52V5L1Dr5cM5M/i7mdN+/Dt0ouAXWYIbm5zhpt61VXyfHGvHPrr0CoC
 wKuMWlY18eN+lp9S+laQKKZIlnLpzKuhpFWE7JvJMAv3TcbsEatQsReoROr3bwq1WeHg
 vCiXw550PsuSZzZCt6W4rjSmzJMMRbo4nTwPZfhJQQRMppYXbS56RbzP2oVOjhURm1dj
 /GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WQfJzqFfEaKfIfQ4a6l8KRYhHeFJRpYVrfeth7NbeaI=;
 b=cEKy5J9c0zQb5f61m+X6Hh0/XWkw4u9V1v3afsTNp4PjFTgLDi+qw3dGL1583yRyun
 yJjfEnOUI/ELNYkmTxTSaZCmEhC0Ihg8pX/DP4s1NcY/QCqhK/LjtDoQZoiEHC6htj9r
 cqM9qRAU7jOc6hbiXi6PKl8hu6L6CB7sOUTR9PCZgagK6r8Q/MCuZ1BlmGIPuQ84iFFl
 HRJim4Y2BDYI1fbOuewd8clbqAgKbPmEzbokQ0kFXQKI2eNbSJgS7vT8uzdydyJegqZM
 SGcmBi69z/E05Pf0hMETIQjFTJkh31PhMcUyvDe9Ssd+/TX9TGj+X/+0WeFMmOK7SFSp
 k8CA==
X-Gm-Message-State: AOAM530AcTiNbr3tjLqGUz4801mcS0IY69ljR1gRAtrlRldjndJtf+GD
 ITYqieSBVvmEL/gzbgBdWvo=
X-Google-Smtp-Source: ABdhPJyRaQ6tyLCXSzXBsr+8m+WKjmt1MKBaf3ZRhDkXsuFSkOG19192WzS4X+s7FDROQp6EsdbLZQ==
X-Received: by 2002:a1c:305:: with SMTP id 5mr20766893wmd.60.1591010110216;
 Mon, 01 Jun 2020 04:15:10 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id v27sm21731098wrv.81.2020.06.01.04.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 04:15:09 -0700 (PDT)
Subject: Re: [PATCH 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix
 definitions
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: paul@xen.org, qemu-devel@nongnu.org
References: <20200531173814.8734-1-f4bug@amsat.org>
 <20200531173814.8734-8-f4bug@amsat.org>
 <000001d637e5$f0c4b4f0$d24e1ed0$@xen.org>
 <63327be6-10c1-6a8c-b4ed-cbbd085a35a8@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <3b4fdc66-ea78-2270-a67a-6d9138fc12c4@amsat.org>
Date: Mon, 1 Jun 2020 13:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <63327be6-10c1-6a8c-b4ed-cbbd085a35a8@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Eduardo Habkost' <ehabkost@redhat.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>, 'Andrew Jeffery' <andrew@aj.id.au>,
 'Helge Deller' <deller@gmx.de>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?=27C=c3=a9dric_Le_Goater=27?= <clg@kaod.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?=27Herv=c3=a9_Poussineau=27?= <hpoussin@reactos.org>,
 'Joel Stanley' <joel@jms.id.au>, 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, 'Richard Henderson' <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 10:33 AM, Philippe Mathieu-Daudé wrote:
> On 6/1/20 9:26 AM, Paul Durrant wrote:
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com> On Behalf Of Philippe Mathieu-Daudé
>>> Sent: 31 May 2020 18:38
>>> To: qemu-devel@nongnu.org
>>> Cc: Andrew Jeffery <andrew@aj.id.au>; Helge Deller <deller@gmx.de>; Peter Maydell
>>> <peter.maydell@linaro.org>; Richard Henderson <rth@twiddle.net>; Eduardo Habkost
>>> <ehabkost@redhat.com>; Paul Durrant <paul@xen.org>; Hervé Poussineau <hpoussin@reactos.org>; Marcel
>>> Apfelbaum <marcel.apfelbaum@gmail.com>; xen-devel@lists.xenproject.org; Paolo Bonzini
>>> <pbonzini@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>; Cédric Le Goater <clg@kaod.org>;
>>> qemu-trivial@nongnu.org; Joel Stanley <joel@jms.id.au>; qemu-arm@nongnu.org; Michael S. Tsirkin
>>> <mst@redhat.com>; Anthony Perard <anthony.perard@citrix.com>; qemu-ppc@nongnu.org; Philippe Mathieu-
>>> Daudé <f4bug@amsat.org>
>>> Subject: [PATCH 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix definitions
>>>
>>> IEC binary prefixes ease code review: the unit is explicit.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  hw/i386/xen/xen-hvm.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>>> index 82ece6b9e7..679d74e6a3 100644
>>> --- a/hw/i386/xen/xen-hvm.c
>>> +++ b/hw/i386/xen/xen-hvm.c
>>> @@ -9,6 +9,7 @@
>>>   */
>>>
>>>  #include "qemu/osdep.h"
>>> +#include "qemu/units.h"
>>>
>>>  #include "cpu.h"
>>>  #include "hw/pci/pci.h"
>>> @@ -230,7 +231,7 @@ static void xen_ram_init(PCMachineState *pcms,
>>>           * Xen does not allocate the memory continuously, it keeps a
>>>           * hole of the size computed above or passed in.
>>>           */
>>> -        block_len = (1ULL << 32) + x86ms->above_4g_mem_size;
>>> +        block_len = 4 * GiB + x86ms->above_4g_mem_size;
>>
>> Not strictly necessary but could we retain the brackets please?
> 
> Sure.
> 
> Laurent, if this can go via your trivial@ tree, can you do the change or
> you rather I resend the whole series?

I understood reading another thread that contributor should not overload
maintainer, so I'll simply repost this as v2.
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00066.html

> 
>>
>>   Paul
>>
>>>      }
>>>      memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
>>>                             &error_fatal);
>>> --
>>> 2.21.3
>>
>>
>>
> 

