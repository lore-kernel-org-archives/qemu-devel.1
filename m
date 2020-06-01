Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5F7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7962074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpAUJ/Xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7962074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfftg-0003Ez-07
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 04:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffsy-0002MT-Ak; Mon, 01 Jun 2020 04:33:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffsw-0003W2-HZ; Mon, 01 Jun 2020 04:33:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id q25so1546302wmj.0;
 Mon, 01 Jun 2020 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Wb302sgiYxfPaOUVMNPVZTgMDWXAbDEM/6w0YEYyXVI=;
 b=qpAUJ/XnT4mWsnqFMatowAbLLFJq43367/cBpfL/d3ZzTAp/DFEljArpThGY9+x18V
 mEWL8q9LN1y/Kzo+yPVP9NuX/kfEdhcwtUoUfgf7soF39oOD56i779EDikiWNdymrWiX
 iGGtrBcC2jcRqrRl9ppZVn/1WCbmq4vVN9DSxtAyiWa1+q4pxj6qRzoay8n+SQrsR0yw
 xppjqFmvZcRSAqBhzHi3l+z0IJbui5cI7X5kxEJ1zcyLOImgzgUXu2H10/7ZMwXcJ4zi
 f2UOMruKHQPpVSt0R+Z8WeJyW7oZywqw1PT6JFEm2PiEbYoqydIw6Ah5rnt5mxbRKRnd
 TU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wb302sgiYxfPaOUVMNPVZTgMDWXAbDEM/6w0YEYyXVI=;
 b=mKWTxht0naIZmYrTy6iWKMksJcqbkbUX6/urX9cRaGvWRUM1BItDVSN5pW0lo7dnEp
 7EIC0Y2hQkdBKv9fwoZftis7kCuFydjGzZPYqy/rceng1Z1SItD/dkQCQpXC9nzttrr9
 2GgEF+1gHD0A89Hn7fe7m3DwoqC2OVSkHVXZHbtV5UUGkRVpHgvYbstHxEO9b8rGdMUG
 HQm+Q5wWEpUm8RDo3OuiVLH2uI9CbTwOXizt2dUiNt4OWKWKxlXdD5ldp+X/f61zyPHq
 My2OtHxtMDnHb4HIF2cDpW+QHB1bt79ebDiG7ofDkmaHwqHlmgeihBvHqpD/Za+nEVfm
 /rUQ==
X-Gm-Message-State: AOAM531NVTHFSYAgQ59pTPBk3xTzt9TNH0K37JPNw3bd2NVvCYQuJLGM
 fGGqnWEzlqtOCnGKW7G2+qM=
X-Google-Smtp-Source: ABdhPJxCUGyTLCx6nC4rkNK06m7YbI0ofoKV10ACf5rgyiIrixi/EROQbo/YLaDXpnfOfoBnf+b5TA==
X-Received: by 2002:a1c:62d6:: with SMTP id w205mr19510946wmb.97.1591000407855; 
 Mon, 01 Jun 2020 01:33:27 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id l17sm11837037wmi.16.2020.06.01.01.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 01:33:27 -0700 (PDT)
Subject: Re: [PATCH 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix
 definitions
To: paul@xen.org, qemu-devel@nongnu.org
References: <20200531173814.8734-1-f4bug@amsat.org>
 <20200531173814.8734-8-f4bug@amsat.org>
 <000001d637e5$f0c4b4f0$d24e1ed0$@xen.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63327be6-10c1-6a8c-b4ed-cbbd085a35a8@amsat.org>
Date: Mon, 1 Jun 2020 10:33:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <000001d637e5$f0c4b4f0$d24e1ed0$@xen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 'Helge Deller' <deller@gmx.de>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?=27Herv=c3=a9_Poussineau=27?= <hpoussin@reactos.org>,
 'Joel Stanley' <joel@jms.id.au>, xen-devel@lists.xenproject.org,
 'Anthony Perard' <anthony.perard@citrix.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>, 'Richard Henderson' <rth@twiddle.net>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?=27C=c3=a9dric_Le_Goater=27?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 9:26 AM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com> On Behalf Of Philippe Mathieu-Daudé
>> Sent: 31 May 2020 18:38
>> To: qemu-devel@nongnu.org
>> Cc: Andrew Jeffery <andrew@aj.id.au>; Helge Deller <deller@gmx.de>; Peter Maydell
>> <peter.maydell@linaro.org>; Richard Henderson <rth@twiddle.net>; Eduardo Habkost
>> <ehabkost@redhat.com>; Paul Durrant <paul@xen.org>; Hervé Poussineau <hpoussin@reactos.org>; Marcel
>> Apfelbaum <marcel.apfelbaum@gmail.com>; xen-devel@lists.xenproject.org; Paolo Bonzini
>> <pbonzini@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>; Cédric Le Goater <clg@kaod.org>;
>> qemu-trivial@nongnu.org; Joel Stanley <joel@jms.id.au>; qemu-arm@nongnu.org; Michael S. Tsirkin
>> <mst@redhat.com>; Anthony Perard <anthony.perard@citrix.com>; qemu-ppc@nongnu.org; Philippe Mathieu-
>> Daudé <f4bug@amsat.org>
>> Subject: [PATCH 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix definitions
>>
>> IEC binary prefixes ease code review: the unit is explicit.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/i386/xen/xen-hvm.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>> index 82ece6b9e7..679d74e6a3 100644
>> --- a/hw/i386/xen/xen-hvm.c
>> +++ b/hw/i386/xen/xen-hvm.c
>> @@ -9,6 +9,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>
>>  #include "cpu.h"
>>  #include "hw/pci/pci.h"
>> @@ -230,7 +231,7 @@ static void xen_ram_init(PCMachineState *pcms,
>>           * Xen does not allocate the memory continuously, it keeps a
>>           * hole of the size computed above or passed in.
>>           */
>> -        block_len = (1ULL << 32) + x86ms->above_4g_mem_size;
>> +        block_len = 4 * GiB + x86ms->above_4g_mem_size;
> 
> Not strictly necessary but could we retain the brackets please?

Sure.

Laurent, if this can go via your trivial@ tree, can you do the change or
you rather I resend the whole series?

> 
>   Paul
> 
>>      }
>>      memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
>>                             &error_fatal);
>> --
>> 2.21.3
> 
> 
> 

