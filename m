Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C949BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916152054F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUxsFc3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916152054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmUj-0005vE-Lz
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDmLT-000558-Nh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDmLR-0002vB-Gz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:15:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDmLR-0002td-Dp
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569575720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=7wZxLIs8Ts4HJSL9qGkv1O0CMPFLEaAmLOKNPImx/80=;
 b=DUxsFc3x47tzy2WuJbq7jFLPNyjl0q6M3NsnjjsDX1/9mcHOldlip8qEBX8TfEOIln8oD7
 VAM4C5nl2ozoIQIoHtGU5ymI+MuGeebhnC0KGbRTR8JblYYDfb8GjgDafiH9VwfdSnu4n5
 RQSMIIrhVMiYAJCdse3fU+OA+tnwOjk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-i9G7anYvNiWd3uXZZJKMlg-1; Fri, 27 Sep 2019 05:15:15 -0400
Received: by mail-wm1-f70.google.com with SMTP id f63so1967399wma.7
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 02:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZM17ymn2lck6Yard47o1e27kHTzBjtHrS85U5JQL02A=;
 b=gH7Ps0o0CA6hO9cVyaNnKLWv/a7l8PiYYtXY0XKuiNSL3w6/xs1zB4o0F5/RY/tj0l
 mnb+NeF1CQJz0HvXhCzmLRzOhBIR7Nn+Wodd6snIuwF+eyncIWYblqgMb8puh0gslh8W
 dD3QnMLlftkvGq7++kMJrDTnL41zMIuAYhVrp2QP+VwFK0TA/LFyUFeTc4Ko2dmmOVZ4
 Y9qbZjxP7tdqYQjq3ldrzuaF6XtMa6iB5wtU1V3ja9HePGe7pQdyzbA5xvyOeUnRowPB
 9tPHd/NCBRYEH2seN6fo1zJ3XtTUqvhoKR9RoucQOFKHnqycMYUvVaRb9Q5y4bRi/UdY
 OwYw==
X-Gm-Message-State: APjAAAUG3JT6BNyQ7FhemxJKY5QTmu2SHbdoNYf746W5gwAOuPBT8xBY
 v9zeyCYXU4NQk2wZJk5Qg08XEmf7wX4/aN8ST9hTg/Vv2LdrBa6SL9qr5WBdaiCZ6p0fSvoc2Oq
 mM6WHbmV2DQeYdUc=
X-Received: by 2002:a05:6000:162e:: with SMTP id
 v14mr2245369wrb.112.1569575714464; 
 Fri, 27 Sep 2019 02:15:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7C4+jb3J4rpJFChn2ORx5qdt+CSdOp8rw5nKNubm1AMX48k/ucS4cLVld7J/tMsxjJQvWWA==
X-Received: by 2002:a05:6000:162e:: with SMTP id
 v14mr2245344wrb.112.1569575714159; 
 Fri, 27 Sep 2019 02:15:14 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q3sm1938155wrm.86.2019.09.27.02.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 02:15:13 -0700 (PDT)
Subject: Re: Is kexec supported in QEMU for ARM64 (qemu-system-aarch64) with
 arm-trusted-firmware, optee, and u-boot.
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 qemu-devel@nongnu.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <21633062-b021-a8e7-0cc8-062f4c29dde5@linux.microsoft.com>
 <ca5c74db-cf5d-0c3f-eb6f-27d1092420ae@linux.microsoft.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <65b49cb0-c9fb-d966-8dec-1e39d09ab8c7@redhat.com>
Date: Fri, 27 Sep 2019 11:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ca5c74db-cf5d-0c3f-eb6f-27d1092420ae@linux.microsoft.com>
Content-Language: en-US
X-MC-Unique: i9G7anYvNiWd3uXZZJKMlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Ard too

On 9/27/19 12:35 AM, Lakshmi Ramasubramanian wrote:
> On 9/26/19 8:17 AM, Lakshmi Ramasubramanian wrote:
>=20
> The following commit for ARM Trusted Firmware for QEMU virt ARMv8-A
> is almost 3 years old
>=20
> https://salsa.debian.org/debian/atf-allwinner/commit/b6b671c4ac4bd5595306=
863225bb3bece1e6135c
>=20
>=20
> Current limitations:
> * Only cold boot is supported
> * No build instructions for QEMU_EFI.fd and rootfs-arm64.cpio.gz
> * No instructions for how to load a BL32 (Secure Payload)
>=20
> So looks like only cold boot is supported (no kexec support)
> Is this correct?
>=20
>> When I execute kexec ("kexec -l <kernel>", followed by "kexec -e") I
>> hit the following assert (in arm-trusted-firmware/plat/qemu/qemu_pm.c)
>>
>> /***********************************************************************=
********
>>
>> =C2=A0=C2=A0* Platform handler called when a power domain is about to be=
 turned
>> =C2=A0=C2=A0* off. The target_state encodes the power state that each le=
vel should
>> =C2=A0=C2=A0* transition to.
>> ************************************************************************=
******/
>>
>> void qemu_pwr_domain_off(const psci_power_state_t *target_state)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assert(0);
>> }
>>
>> Is kexec supported in ARM64 QEMU (qemu-system-aarch64) -
>> using arm-trusted-firmware, optee, and u-boot?
>>
>> Thanks,
>> =C2=A0=C2=A0-lakshmi
>=20
>=20


