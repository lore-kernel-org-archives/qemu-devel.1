Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BFFC47257
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EC52070B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0Y7JZlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EC52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWzNn-0004Ed-J9
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 05:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWzMW-0002yn-5O
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:32:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWzMV-0003Bn-9v
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588930326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Fizs/jTz7Evgj0jXTg1CAo/rJD+kXMrBLYhiLKYfrQ=;
 b=a0Y7JZlS8PIeEJ5Y/Bqo88ovA5LcqN8tQi1DME1E6pi8inPs6MaUEb3t8Okt5gKls0PrL7
 sCjqqwRo8nje26Gx4lAuXwActJ/wr2LWcNuJaB/Jz22EaIcEn51Mu/qMbb8isxXSWXdZsG
 t5Hfg0bkVScl6dw7hkR6jBYOVQBD0LA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-23SuHNl3NpeyCdk2FhCDJw-1; Fri, 08 May 2020 05:32:02 -0400
X-MC-Unique: 23SuHNl3NpeyCdk2FhCDJw-1
Received: by mail-wm1-f69.google.com with SMTP id a206so1347561wmh.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 02:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BFoDHna6XRL92Q6uyxjk4+3nW/j50BtcEQYU7yuSZ4c=;
 b=V8qfM7VxjfqfsNTm4aes78zEarQ1dsOW+FHvCFdPsiK0FQOSuYIrAHNlKbhkNOyv26
 8fy/4dE3Ba2/8gO7M5DK+/xVGio317fOKq1LCVO4wGdf2N964uyU95wJgjD6/XlD2zmi
 uF11pv/XPfXOU01WIdD7VRWM1S8WVW6GBCRF3KSf0/08BZmgJZ+TVCdCgRNTRW7KTps/
 6jbPU+mp1JTW0Pb8ASu7m0g46Dfqla80cYhpEWLVK0wcqGUFC88ity2fXT3mx9W4XaV6
 2DZswRhlmU8xKQ+Wt3R5p6hu1teTVFLzTUs44qBA31Awe13OMeAokB/H0/cZseyHV1mb
 kp9g==
X-Gm-Message-State: AGi0PuaCtMv2dALeEehegc4WqoqB3NoFt5wNtuYGf5bbC4rtyszvuVL5
 cxDO+WwszLDa7jaoDA33fEMrKUROh4mo50PvtU60j+/ykR6UmYUb/Xw095Kj2LKlrxO4nz7SzHd
 SjLN2Pw1Zjh/7VyQ=
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr16080728wml.55.1588930321644; 
 Fri, 08 May 2020 02:32:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypIn9j1oj4Str39MCCMkLIi/fuLFk9d58QkDTA/zKBxxIA1JCsgbH5eufVPx8yt9TWGYgHt8rQ==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr16080690wml.55.1588930321362; 
 Fri, 08 May 2020 02:32:01 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id i6sm1966693wrw.97.2020.05.08.02.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 02:32:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] exec: Check Xen is enabled before calling the Xen
 API
To: quintela@redhat.com
References: <20200508080738.2646-1-philmd@redhat.com>
 <20200508080738.2646-2-philmd@redhat.com> <87wo5mes6g.fsf@secure.mitica>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0731df30-b0c4-c7bf-6194-42cd6cc90ba5@redhat.com>
Date: Fri, 8 May 2020 11:31:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87wo5mes6g.fsf@secure.mitica>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Juan,

On 5/8/20 10:39 AM, Juan Quintela wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   include/exec/ram_addr.h | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 5e59a3d8d7..dd8713179e 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -330,7 +330,9 @@ static inline void cpu_physical_memory_set_dirty_ran=
ge(ram_addr_t start,
>>           }
>>       }
>>  =20
>> -    xen_hvm_modified_memory(start, length);
>> +    if (xen_enabled()) {
>> +        xen_hvm_modified_memory(start, length);
>> +    }
>>   }
>>  =20
>>   #if !defined(_WIN32)
>> @@ -388,7 +390,9 @@ static inline void cpu_physical_memory_set_dirty_leb=
itmap(unsigned long *bitmap,
>>               }
>>           }
>>  =20
>> -        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
>> +        if (xen_enabled()) {
>> +            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
>> +        }
>>       } else {
>>           uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_=
CLIENTS_NOCODE;
>=20
> I don't object moving the xen code to accell.  But I think that this
> change is bad.
>=20
> On the following patch:
> - You export xen_allowed
>    (ok, it was already exported, but I think it shouldn't)
>=20
> (master)$ find . -type f | xargs grep xen_allowed
> ./hw/xen/xen-common.c:    ac->allowed =3D &xen_allowed;
> ./include/hw/xen/xen.h:extern bool xen_allowed;
> ./include/hw/xen/xen.h:    return xen_allowed;
> ./softmmu/vl.c:bool xen_allowed;
>=20
> This are all the users that I can find.
>=20
> And xen_havm_modified_memory() is an empty function if xen is not
> compiled in.  And in the case that xen is compiled in, the 1st thing
> that it checks is:
>=20
>     if (unlikely(xen_in_migration)) {
>=20
> That is way more restrictive that xen_enabled().
>=20
> So, I think that it is better to drop this patch, maintain next one, but
> just un-exporting xen_allowed.
>=20
> What do you think?

I blindly trust your judgement on this :) I'd rather not touch this code=20
but as it happens to be in "exec/ram_addr.h" I had to modify it.

Thanks for your reviews!

>=20
> Later, Juan.
>=20
>=20


