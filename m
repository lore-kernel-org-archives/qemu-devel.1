Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54354C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286AE214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286AE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hficT-00059D-Dg
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34253)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfiVn-0006UG-Il
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfiVm-000053-68
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:17:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfiVl-0008VK-Ic
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:17:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so15992966wrs.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=exu3EIjlfXGbFdMZZlp7ut6canlw3gjprq3dSY3plIE=;
 b=Pfr8A6+oZN7vSiwDX3Mkj0Z9IzXBsMCJbgTBGVQXa2ynPel/O7d1A0AvIzEyTmHMXs
 1hdhMAhQD1jxa1jA6Vc9oZiZtSzmlnbcvtf71/iQs3SgbmldYaTN/T6Yu312BpQUxmHZ
 w6Og80A2cY9qzsop6nFI42LoDtpEKtFh8u6Jampf5GCC+JITo6teo5UzLwIKUk+LYy3T
 3BBLWc4p6gkvoW6Pu80Ht31kx8k7uYhgVrP4zbrDRwIHln+UPVX0JdKtGAkfzpvPxm18
 NglDUxV8dO3Ik2Y4iuOI3zYRjKBwfQ+VI7gD9uj2cqIpEVDsMI5bkotenarVapbcUZBv
 PbuA==
X-Gm-Message-State: APjAAAXcxjZVjKnFZ+1jjkYaMQQKv3a/VcKay3MCoxG5wDzpnAWvlWLH
 Oz0l7mYcJiDzltSLXkkvxnbHWg==
X-Google-Smtp-Source: APXvYqzL20pxh3RC0TNTU+WFTr9sX+wGS/FksUsJfk5nSZ7J4XihkautpghEuzEuivDKheaHoH4FCw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr56079143wrn.120.1561457832358; 
 Tue, 25 Jun 2019 03:17:12 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id s10sm2513687wmf.8.2019.06.25.03.17.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 03:17:11 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190624090200.5383-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9826130c-0711-6d82-72ed-8e726dea8267@redhat.com>
Date: Tue, 25 Jun 2019 12:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624090200.5383-1-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2] pc: fix possible NULL pointer
 dereference in pc_machine_get_device_memory_region_size()
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
Cc: pbonzini@redhat.com, mst@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/19 11:02 AM, Igor Mammedov wrote:
> QEMU will crash when device-memory-region-size property is read if ms->device_memory
> wasn't initialized yet.
> 
> Crash can be reproduced with:
>  $QEMU -preconfig -qmp unix:qmp_socket,server,nowait &
>  ./scripts/qmp/qom-get -s qmp_socket /machine.device-memory-region-size
> 
> Instead of crashing return 0 if ms->device_memory hasn't been initialized.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> v2:
>   * fix missing return value assignment
>       (Eduardo Habkost <ehabkost@redhat.com>)
> ---
>  hw/i386/pc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e96360b47a..552f3401e2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2458,7 +2458,11 @@ pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
>                                           Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> -    int64_t value = memory_region_size(&ms->device_memory->mr);
> +    int64_t value = 0;
> +
> +    if (ms->device_memory) {
> +        value = memory_region_size(&ms->device_memory->mr);
> +    }
>  
>      visit_type_int(v, name, &value, errp);
>  }
> 

