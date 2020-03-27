Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C40BC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01C320658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWAeK5Jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01C320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrh7-0004qs-V1
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jHrfk-0004FU-FJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jHrfi-0001O5-Tv
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:17:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22113)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jHrfi-0001MP-Ny
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585325845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dih+ydun9SdeT1WL+lC4Vb7S+BhIkEMHiGfzQCPeL5M=;
 b=OWAeK5JbbihO6XDp1Eg4HgeIsbj+/qC421jeoqvBzgs2ESq8/XrIfBtV/lZvY5n6Ywh4tT
 DLBHOws7wyzwQEcri5DzmKmQ3nlZecz+qfE/dBEbEx3kfUlFs0WTgSwQb0KTg+K7F6YhUm
 rOMkJwiytcYtxfcXzLbp3XBEHEFKhG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-LN32xtnLN_2jOz2wJk-RMw-1; Fri, 27 Mar 2020 12:17:24 -0400
X-MC-Unique: LN32xtnLN_2jOz2wJk-RMw-1
Received: by mail-wr1-f71.google.com with SMTP id v17so705714wro.21
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 09:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JXNMK3T6RLDfuwi0a805cudJtUUCqWi7IUPU0Uf/YdM=;
 b=DmBqOKVeKaRbQ4MzYX2goOQB2u+mEUUkbulgNQAMt/DSAMQXI6wzDYzA+EIses7yMs
 8LabA69CYUiu39LpsSZWo1ONUpx2fMxgCIRMyI0cFHY0eoZ37gChvsFmeE+xXGOmEC67
 99A8mpCcPQvx7lHPWox5TjraKEJ+Lrm5xJPIuOfNczE/iHaA2r3JN5oMbjU7bibluEYX
 IBimPCtYBnfGsozZovpFYu54ierunNc3nHD1kjhuJDz8hkQJhFeo58vXiq5PbQJyIIeW
 ii8E9dOfa+SaDHYocu0hKHVktFI7cAPUPYhlJ5OhMB3kWsAoWCh6/DLt8ZMksKf/qlVU
 37NA==
X-Gm-Message-State: ANhLgQ1wK5q2ocqeEtY/JAtdoRK4CpsKATxs1RM9V+7+48jfMojpYBwh
 iKrIjMSKyAK4Yprq/YX/UJnQ73xuHhYZYU4JUVeNtNmtCxQuRWoxrO0FEoZA5KMX8EoCvqtrRVZ
 /Wqf/1BNl0zfpfNg=
X-Received: by 2002:a5d:5687:: with SMTP id f7mr126724wrv.425.1585325842959;
 Fri, 27 Mar 2020 09:17:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu0WtgWKoIExHPFFlttMzK12XVy2ZFPDMKiYF8Qyoibvkj+GVrKhqf6FL5/voa5AOgDrIukLA==
X-Received: by 2002:a5d:5687:: with SMTP id f7mr126705wrv.425.1585325842716;
 Fri, 27 Mar 2020 09:17:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id d5sm9484277wrh.40.2020.03.27.09.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 09:17:22 -0700 (PDT)
Subject: Re: [PATCH] hw/vfio: let readonly flag take effect for mmaped regions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 yan.y.zhao@intel.com, qemu-devel@nongnu.org
References: <20200327111934.71066-1-yan.y.zhao@intel.com>
 <11c90e84-6c0c-9411-0d6c-7955136413c6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4eb2313-96b3-7e76-f48c-0059a40eabf7@redhat.com>
Date: Fri, 27 Mar 2020 17:17:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <11c90e84-6c0c-9411-0d6c-7955136413c6@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: alex.williamson@redhat.com, Xin Zeng <xin.zeng@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/03/20 11:51, Philippe Mathieu-Daud=C3=A9 wrote:
>>=C2=A0 diff --git a/memory.c b/memory.c
>> index 601b749906..4b1071dc74 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1313,6 +1313,9 @@ static void memory_region_ram_device_write(void
>> *opaque, hwaddr addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *mr =3D opaque;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_memory_region_ram_device_wri=
te(get_cpu_index(), mr,
>> addr, data, size);
>> +=C2=A0=C2=A0=C2=A0 if (mr->readonly) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Shouldn't this be in memory_region_dispatch_write()?

No, in general you want memory regions to get writes, so that they
become for example a machine-check exception of some sorts.  However,
memory_region_ram_device_write should probably be changed to a
.write_with_attrs operation, so that it can return MEMTX_ERROR.

> Please split this patch in 2, this (generic) hunk as first patch, then
> the VFIO more specific change.
>=20
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (size) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 1:
>>
>=20

No need, I can just add my Acked-by for Alex to pick up the patch.

Paolo


