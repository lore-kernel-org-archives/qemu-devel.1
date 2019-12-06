Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31703C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0742206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pm+Mlw7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0742206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGuh-0002mM-0m
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1idFBm-0006wU-1t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1idFBk-0005go-LQ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:06:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45128
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1idFBi-0005es-NA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB7Dl0O/SdQi/C44lTRSAKFanxqyAJjtE6937CoG+lc=;
 b=Pm+Mlw7Q61xyTVoz5xBuIaf6iCNwTnXUTKIh/H+jAKpQ0YN/TUbOroiGqJpU7aO3GaE7+J
 9qlnJp9Li5LowNHwFoHmbA/b8UodSUYlztAjqZAjLmjWz0TKHFLlZijPEbBKNMJ7FzbCg0
 m1WbRucAe4P9pSCWSw35cmZrVcuM1oc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-FLCEaU9mPxGqzzK7hxfqQQ-1; Fri, 06 Dec 2019 10:06:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A3679126C
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 15:06:31 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-235.ams2.redhat.com
 [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C960C67E52;
 Fri,  6 Dec 2019 15:06:25 +0000 (UTC)
Subject: Re: [PATCH for-5.0 8/8] acpi: cpuhp: spec: document procedure for
 enabling modern CPU hotplug
To: Igor Mammedov <imammedo@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-9-git-send-email-imammedo@redhat.com>
 <bb601078-db09-1915-1d12-350093887183@redhat.com>
 <20191206144940.091bef52@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e432f16e-bf41-ae8f-aa04-d9fe18d39350@redhat.com>
Date: Fri, 6 Dec 2019 16:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191206144940.091bef52@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: FLCEaU9mPxGqzzK7hxfqQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/19 14:49, Igor Mammedov wrote:
> On Thu, 5 Dec 2019 15:07:53 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 12/04/19 18:05, Igor Mammedov wrote:
>>> Describe how to enable and detect modern CPU hotplug interface.
>>> Detection part is based on new CPHP_GET_CPU_ID_CMD command,
>>> introduced by "acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command" patch.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  docs/specs/acpi_cpu_hotplug.txt | 22 ++++++++++++++++++++--
>>>  1 file changed, 20 insertions(+), 2 deletions(-)  
>>
>> Could we make this usecase / workflow independent of the new
>> CPHP_GET_CPU_ID_CMD command please?
>>
>> I'd like to suggest the following:
>>
>>> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
>>> index bb33144..667b264 100644
>>> --- a/docs/specs/acpi_cpu_hotplug.txt
>>> +++ b/docs/specs/acpi_cpu_hotplug.txt
>>> @@ -15,14 +15,14 @@ CPU present bitmap for:
>>>    PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
>>>    One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-only.
>>>    The first DWORD in bitmap is used in write mode to switch from legacy
>>> -  to new CPU hotplug interface, write 0 into it to do switch.
>>> +  to modern CPU hotplug interface, write 0 into it to do switch.
>>>  ---------------------------------------------------------------
>>>  QEMU sets corresponding CPU bit on hot-add event and issues SCI
>>>  with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
>>>  to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
>>>
>>>  =====================================
>>> -ACPI CPU hotplug interface registers:
>>> +Modern ACPI CPU hotplug interface registers:
>>>  -------------------------------------
>>>  Register block base address:
>>>      ICH9-LPC IO port 0x0cd8
>>> @@ -105,6 +105,24 @@ write access:
>>>                other values: reserved
>>>
>>>      Typical usecases:
>>> +        - (x86) Detecting and enabling modern CPU hotplug interface.  
>>
>> (1) I think we can drop the (x86) restriction. (Because, we don't need
>> to depend on APIC ID specifics; see below.)
> I'd rather keep it x86 specific, as enabling interface and talking about
> legacy bitmap applies only to x86 impl.
> ARM one won't have any of it, it will just be enabled in a future QEMU
> (probably even without version-ed machine type).
> So could we just say usual "use firmware X.Y with QEMU Z to use CPU hotplug"
> in that case?
> Do we really need it to be arch agnostic?

No, I only suggested removing the x86 reference as a possible "extra"
improvement, from not depending on CPHP_GET_CPU_ID_CMD / APIC ID.

Thanks,
Laszlo


