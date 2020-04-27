Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCB2C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C28206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2GaKTpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C28206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT08b-0004uQ-OC
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT07M-0003D9-IT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT07K-0004Vb-Qm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:32:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54542
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jT07K-0004V8-D7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587979916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ORwgqUNxyWJx4g7rcsgXveOEL21jJCo2pNi3fBY+n2w=;
 b=M2GaKTpxnO+kT+WE6AtfDXldT03vYr9qiBOWFROsOpV68CAe1YzUq63VIIv413rxsD7zd2
 CCzgDVz/8q9uGLPsvydC1so3BpxmwDdZiKheNQ0sIU6o5qoJFH5vl7C5M4Nu422yd4rRdG
 4t6F4QqnjroUC652MrcwC4DPboTFWjU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-KME0tiPYNFuBunz3LQq4Tw-1; Mon, 27 Apr 2020 05:31:52 -0400
X-MC-Unique: KME0tiPYNFuBunz3LQq4Tw-1
Received: by mail-ej1-f70.google.com with SMTP id v3so10688777ejx.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EiU5WiM4xowKm7j0q3FEjpHE0HVtdXQ9VwcrLa3Q/QE=;
 b=uCW+B4eckMbUUFxfDPi9Y5bh05Se/p9W1wjTpx5oHbp150NFxFMNXOPg1xNKRGvZDY
 +50hHdfAFLI9qV522zrPap7rvq2+ssOrqfEovlRVGGXHbkAICqNwxwvp/mxCBA5E7inY
 N7aze9eutzLNB0BQOTY6S0LjTdvQmezCiUYsCJ65yJnY5hUxg4yNUZMcKIXFRl7QkoVs
 aOiDCeK/n98q/ggIwDeK4JhPIzpHE4D5gQunk2nRnqh5O5YXJFqgq1zCbWavbjhHqwCg
 NH7aEi96kHgYm/yH3d7j0/KB9Cn+khPweb4wqd/T1VaWy0mVGbjWYkZlu2HkZq8IwLWg
 Tjmw==
X-Gm-Message-State: AGi0PuY35YZH7g43pYfQQfJadP1sPmvw41+6b9Ht4ADqH//VbjwGBUzr
 YVhSgJ/dm1TsTn1FCXRixuc+n2yxqVybwG1g/5wA2JrmzI+urm5OCLK20oGYZ6JhYZ/X4J/Ztw2
 2VFC9940bzAi4miI=
X-Received: by 2002:a17:906:8282:: with SMTP id
 h2mr3423926ejx.250.1587979910418; 
 Mon, 27 Apr 2020 02:31:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypKPhfPOHgrsbAV+a2y/DeuHATp43qsHxQVLPyPzUUxKKoxG+lbeiwiu0KxQkI0One1+aAeDNg==
X-Received: by 2002:a17:906:8282:: with SMTP id
 h2mr3423903ejx.250.1587979910160; 
 Mon, 27 Apr 2020 02:31:50 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id z16sm2024759edq.23.2020.04.27.02.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:31:49 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200417074437.28526-1-yan.y.zhao@intel.com>
 <f96581ca-055e-ecc6-4a44-6bd26396bfc0@redhat.com>
 <20200426010430.GB12879@joy-OptiPlex-7040>
 <20200427091545.GH12879@joy-OptiPlex-7040>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <85cb56a3-882a-05af-5714-e51174aa995a@redhat.com>
Date: Mon, 27 Apr 2020 11:31:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427091545.GH12879@joy-OptiPlex-7040>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 11:15 AM, Yan Zhao wrote:
> On Sun, Apr 26, 2020 at 09:04:31AM +0800, Yan Zhao wrote:
>> On Sat, Apr 25, 2020 at 06:55:33PM +0800, Paolo Bonzini wrote:
>>> On 17/04/20 09:44, Yan Zhao wrote:
>>>> for ram device regions, drop guest writes if the regions is read-only.
>>>>
>>>> Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>>>> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>>>> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
>>>> ---
>>>>   memory.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/memory.c b/memory.c
>>>> index 601b749906..9576dd6807 100644
>>>> --- a/memory.c
>>>> +++ b/memory.c
>>>> @@ -34,6 +34,7 @@
>>>>   #include "sysemu/accel.h"
>>>>   #include "hw/boards.h"
>>>>   #include "migration/vmstate.h"
>>>> +#include "qemu/log.h"
>>>>  =20
>>>>   //#define DEBUG_UNASSIGNED
>>>>  =20
>>>> @@ -1313,6 +1314,12 @@ static void memory_region_ram_device_write(void=
 *opaque, hwaddr addr,
>>>>       MemoryRegion *mr =3D opaque;
>>>>  =20
>>>>       trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, =
data, size);
>>>> +    if (mr->readonly) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                      "Invalid write to read only ram device region 0=
x%"
>>>> +                       HWADDR_PRIx" size %u\n", addr, size);
>>>> +        return;
>>>> +    }
>>>
>>> As mentioned in the review of v1, memory_region_ram_device_write should
>>> be changed to a .write_with_attrs operation, so that it can return
>>> MEMTX_ERROR.
>>>
> hi Paolo and Alex,
> need I also change vfio_region_write() in patch 2 to a .write_with_attrs
> operation?
> vfio_region_read() is also possible to fail, so should I change it to a
> .read_with_attrs, too?

Yes.

Please submit your series as a thread, with a cover letter:
https://wiki.qemu.org/Contribute/SubmitAPatch#Include_a_meaningful_cover_le=
tter

>=20
> Thanks
> Yan
>=20
>>> Otherwise this looks good.
>>>
>> hi Paolo,
>> thanks for pointing it out again!
>> I didn't get your meaning in v1. will update the patch!
>>
>> Thanks
>> Yan
>>>
>>
>=20


