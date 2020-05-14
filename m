Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE95EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC46B205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Heq+IN4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC46B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6nJ-0003C5-QK
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZ6mc-0002fN-S0
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:51:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZ6mZ-0001C9-U1
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=f+1fgBg8t0GFK3u6tRmd8XDnrGJZ2cvKtu1R9XwEfu4=;
 b=Heq+IN4PBuc14f1QQ703PJXymeUh6n8d9sJSbFRXuFHReSWRH/V86gKvLFwlL5w2dp4u8o
 Hzvf3O32yFZAqBnr6gD8tw9FZgXncUYcZmT4KI8vuud/lwxbNHeJ4aZxPhAIX5MJBJ8utO
 ZNEcrn4AaOHRPMEdefwksAmB8PDc81w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-lcrhdvX4PJ2IfyfhDPUotA-1; Thu, 14 May 2020 01:51:44 -0400
X-MC-Unique: lcrhdvX4PJ2IfyfhDPUotA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52E0380183C;
 Thu, 14 May 2020 05:51:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74A7E1000320;
 Thu, 14 May 2020 05:51:29 +0000 (UTC)
Subject: Re: [PATCH v5 08/15] acpi: move aml builder code for floppy device
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-9-kraxel@redhat.com>
 <2f7a76fe-9c38-1441-70cf-919dce82e4fe@redhat.com>
 <77355745-5c13-6579-871d-4a2c02fb7049@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <466f2ed8-2379-0259-9b33-4e1d2c5ced4c@redhat.com>
Date: Thu, 14 May 2020 07:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <77355745-5c13-6579-871d-4a2c02fb7049@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/05/2020 22.43, John Snow wrote:
> 
> 
> On 5/7/20 10:05 AM, Philippe Mathieu-Daudé wrote:
>> +Hervé
>>
>> On 5/7/20 3:16 PM, Gerd Hoffmann wrote:
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>   hw/block/fdc.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++
> 
> oh no...
> 
>>>   hw/i386/acpi-build.c | 83 --------------------------------------------
>>>   stubs/cmos.c         |  7 ++++
>>>   stubs/Makefile.objs  |  1 +
>>>   4 files changed, 91 insertions(+), 83 deletions(-)
>>>   create mode 100644 stubs/cmos.c
>>>
>>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>>> index 9628cc171ef8..40faa088b5f7 100644
>>> --- a/hw/block/fdc.c
>>> +++ b/hw/block/fdc.c
>>> @@ -32,6 +32,8 @@
>>>   #include "qapi/error.h"
>>>   #include "qemu/error-report.h"
>>>   #include "qemu/timer.h"
>>> +#include "hw/i386/pc.h"
>>
>> I'd rather not see this target-specific header used in the generic
>> device model... The culprit seems cmos_get_fd_drive_type(). Is the value
>> really PC specific?
>>
>> Hervé, do you know if such info & RTC nvram layout is used in other arch?
>>
> 
> do we need pc-only floppy code somewhere to keep the makefile pure?

Yes, please put this into a separate file that only gets build if the
corresponding CONFIG switches are set. That way you should also get
along without that new stubs/cmos.c file.

 Thomas


