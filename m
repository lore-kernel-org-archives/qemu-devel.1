Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C747C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 10:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF502076D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 10:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5W6nqzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF502076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD4Mr-0003HT-2M
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 06:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jD4MG-0002rn-T3
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jD4MF-00020H-0K
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:49:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jD4ME-0001ub-Rc
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584182969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfO/M4brf4+7T7glQwVoHtNUfxwN6OeN9W90pyrCnzk=;
 b=M5W6nqzpJGco9bgxRZnF/qSrY8Gflk0HeSKDrNKIK0cg+iCc8J+S2a2eqwgHR7XC0oj1qS
 6++RDlC5hT7PdFwFBUOS6+g3ZLje3FpJifKRdoE5oqD0ypjZtBZkcrnEGZVKgGAm7ZtKr2
 ucqJK7eFnvoqsrk9AmgrHKuQbJQ9OFA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-RDWURmVLMIWfXvZekt5e3Q-1; Sat, 14 Mar 2020 06:49:27 -0400
X-MC-Unique: RDWURmVLMIWfXvZekt5e3Q-1
Received: by mail-ed1-f71.google.com with SMTP id l8so10475550edq.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 03:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8FAM4Zu4yvg/94X1ywcwgdfMhh+dMstbs52PzkgQVCQ=;
 b=SVzlPwR7uuIhltmUtMShqeSMSS4YHbWIZ01XI3q3LLjadozctwggNIhjIsvDVuoi/B
 OsvX9JdkUHW6aeFjoJ3wy5wbJopZOO4aZZs3fJbDvufw7pWsK4kuy9cgxrlt6IHL89HC
 Mrk1tZ000R9K1ouzrsAUrP7MkhjuSVf8IJIqO/+emvS8hj1hKf3invk16oZGzV/Jbb6u
 r3KBvquHYHT/a4zJlhJq9uudsd4DRLx3J+a8IWcUQn0V+Lic/YsG09o1aaO5tEv5b9Rf
 7IAK6xM1uPuTXix+IpX975TdNeckOKelL0bTBGES9wOMt4T9wdHH/9ZSS1mBtH3wnAFP
 CqHg==
X-Gm-Message-State: ANhLgQ2QV6QAHxKFHYquyQxLzDjXdeKuLWO+EtFg/5YMUcJhJ+XRfQCI
 EvVOq51hC3qPqt4gzuMxl8kNZJZGNjRjHQC32eE5mHyms/2H6Ce2S7Virn4CI7mywAroDMOT/LQ
 Mo1xlr5tv4hrUtDs=
X-Received: by 2002:a50:f787:: with SMTP id h7mr17956772edn.301.1584182966412; 
 Sat, 14 Mar 2020 03:49:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vurrR/8ogmKuTsI79Df7XQ//heSze1XuBFK+OgeArWl8FHOhKikz6f4vaRdIEHVhtign17lAQ==
X-Received: by 2002:a50:f787:: with SMTP id h7mr17956755edn.301.1584182966135; 
 Sat, 14 Mar 2020 03:49:26 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s22sm1519206eja.84.2020.03.14.03.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 03:49:25 -0700 (PDT)
Subject: Re: [PATCH 8/9] hw/core: Add qdev stub for user-mode
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-9-philmd@redhat.com>
 <7775dd60-7c5d-e973-162d-5eb742b41c07@redhat.com>
Message-ID: <9118c5b3-196b-9002-dcb8-1d3b91b59fc3@redhat.com>
Date: Sat, 14 Mar 2020 11:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7775dd60-7c5d-e973-162d-5eb742b41c07@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 10:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/13/20 7:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> While user-mode does not use peripherals (devices), it uses a
>> CPU which is a device.
>> In the next commit we will reduce the QAPI generated code for
>> user-mode. Since qdev.c calls qapi_event_send_device_deleted(),
>> let's add a stub for it.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> =C2=A0 hw/core/qdev-stubs.c=C2=A0 | 20 ++++++++++++++++++++
>> =C2=A0 hw/core/Makefile.objs |=C2=A0 1 +
>> =C2=A0 2 files changed, 21 insertions(+)
>> =C2=A0 create mode 100644 hw/core/qdev-stubs.c
>>
>> diff --git a/hw/core/qdev-stubs.c b/hw/core/qdev-stubs.c
>> new file mode 100644
>> index 0000000000..0819dcba12
>> --- /dev/null
>> +++ b/hw/core/qdev-stubs.c
>> @@ -0,0 +1,20 @@
>> +/*
>> + * QAPI qdev stubs
>> + *
>> + * Copyright (c) 2020 Red Hat, Inc.
>> + *
>> + * Author:
>> + *=C2=A0=C2=A0 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
=20
>> later.
>> + * See the COPYING file in the top-level directory.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/qapi-events-qdev.h"
>> +
>> +void qapi_event_send_device_deleted(bool has_device,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const ch=
ar *device, const char=20
>> *path)
>> +{
>> +}
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index 6215e7c208..89bf247173 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -8,6 +8,7 @@ common-obj-y +=3D vmstate-if.o
>> =C2=A0 # irq.o needed for qdev GPIO handling:
>> =C2=A0 common-obj-y +=3D irq.o
>> +common-obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o
>=20
> This should be:
>=20
>  =C2=A0=C2=A0 obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o

Actually I moved it to stub-obj-y which makes things easier.

>=20
> (not common).
>=20
>> =C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D reset.o
>> =C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>> =C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>>


