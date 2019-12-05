Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC1C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3C8206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdhHfMIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3C8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ics5B-0002q4-5w
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1icrxa-0003Db-0Z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1icrxV-0005za-Bf
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:18:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1icrxT-0005wn-V6
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575555497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+F4G0Z9RQ0x9S7RB1CVcM2M0dFKOSTvTeq5Z9+Kt4kc=;
 b=HdhHfMIKZck6m+XBv5NAxcG/PuBsmeUAgYKr3KL5hFE/zjH1RwbjGNzK0Y4pR0r9Acc3lN
 xPG+FqlcD8II9C46x8LRuYXAC10pA6znGrWGEdGPTQaOP/8OdZkVyOhou9fYjcbyxhHL5Y
 33q1oGRm6gjxJuwe1t8fZCl24TaVWsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-jsc8_4dJOAORysXJWuVdRQ-1; Thu, 05 Dec 2019 07:17:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34E77800D5F
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 12:17:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6267B600F0;
 Thu,  5 Dec 2019 12:17:22 +0000 (UTC)
Subject: Re: [PATCH for-5.0 4/8] acpi: cpuhp: spec: fix 'Command data'
 description
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-5-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <680b7776-044b-59e8-2ee9-f9e1751c5577@redhat.com>
Date: Thu, 5 Dec 2019 13:17:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575479147-6641-5-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jsc8_4dJOAORysXJWuVdRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/04/19 18:05, Igor Mammedov wrote:
> Correct returned value description in case 'Command field' == 0x0,
> it's in not PXM but CPU selector value with pending event

(1) s/in not/not/

> 
> In addition describe 0 blanket value in case of not supported
> 'Command field' value.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index 4e65286..19c508f 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -56,9 +56,8 @@ read access:
>             3-7: reserved and should be ignored by OSPM
>      [0x5-0x7] reserved
>      [0x8] Command data: (DWORD access)
> -          in case of error or unsupported command reads is 0xFFFFFFFF
> -          current 'Command field' value:
> -              0: returns PXM value corresponding to device
> +          contains 0 unless last stored in 'Command field' value is one of:
> +              0: contains 'CPU selector' value of a CPU with pending event[s]

(2) I think we can improve the word order:

  last stored in 'Command field' value
->
  value last stored in 'Command field'

>  
>  write access:
>      offset:
> @@ -81,9 +80,9 @@ write access:
>            value:
>              0: selects a CPU device with inserting/removing events and
>                 following reads from 'Command data' register return
> -               selected CPU (CPU selector value). If no CPU with events
> -               found, the current CPU selector doesn't change and
> -               corresponding insert/remove event flags are not set.
> +               selected CPU ('CPU selector' value).
> +               If no CPU with events found, the current 'CPU selector' doesn't
> +               change and corresponding insert/remove event flags are not set.

(3) AFAICT this is only a -- useful! -- re-wrapping. But, since we are
modifying this section anyway, can we replace "flags are not set" with
"flags are left unchanged" or "flags are not modified"?

"set" is ambiguous with bit fields: it can mean "rewritten", and it can
mean "set to 1".

>              1: following writes to 'Command data' register set OST event
>                 register in QEMU
>              2: following writes to 'Command data' register set OST status
> 

Anyway, these are all superficial comments. Pick up whatever you agree
with. Either way:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo


