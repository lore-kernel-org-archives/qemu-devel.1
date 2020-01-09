Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C26C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3033620661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoUBmqSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3033620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWXU-0003eD-MU
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ipWVU-0001Kl-LA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ipWVP-0008En-E7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:01:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ipWVP-0008CB-6q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578571298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Lt22O19QuHTJQu+nzkN/c1IZOGApIUddLF7Q+2xZGM=;
 b=IoUBmqSJ9nn5MLjM7e9gZeVEV1uTOT5E3E9m+XI2S3K6hUJl1+CNWRZMh5Ij2UJ05rAVlZ
 dOGIeeAg+sy8rK+HH/cQziY99I1DP7CCIN2I4rduZPg44TC0ctiOngBUI0wG4Mod61IH/y
 LdIo3EvZzhNWXDberDvrL+tJa+BV4/8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-8-NIkOnbOjuSuJKeTTpCVQ-1; Thu, 09 Jan 2020 07:01:35 -0500
Received: by mail-wm1-f72.google.com with SMTP id t16so833393wmt.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zSJJm3tQWyW9jXotqnOuI37W/l67rnKwDavcCwPaXqQ=;
 b=N6DQXWDiC77Vq5NQP3D0cXSBOlOuz5omrip73ndT2KMJkKH2+kp8oUARNDBhyHthyJ
 laMA8FL4/7ndNwtilCUXo71WW/RR8fVqfA9VpBuNKo9pZQxsgz+CT7P7SE5RNvCp5jLY
 As80WO5wrCMPpx2o1NEcg6+ihTHwAA0OqgUTb6/x7nl28x+t13L1BIa/2t7zn0wj6s23
 BSplfGmR9k+Tea3fHKVTKWHJuScaK7W8vMsyPScmwd2OApEL2POzMARNukWrwsE9YbtX
 I3vsrI2i8aEeMmZ6Nuc/YSu+g0WeqSf/EDM38UFaNDZQvPFuFbjet4DFRq2T5F0TcZzT
 NVVQ==
X-Gm-Message-State: APjAAAUujTdgAf9H3hEHop1/ppezrGG7jcwhra/7qsrFcIG5L7yDTZ9P
 K7hR6v/bZDVM+T9Uu1puBweSC8gLHoc6e8yGMGghiTm0qLS+CX4a8OJoMuAfW/umE4tHlkAH1rP
 mkSh2rptj4WyrTF8=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4618794wmk.68.1578571294055; 
 Thu, 09 Jan 2020 04:01:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxi2ptEfCZMo1cygJNxqtzs0wzqIqsgN7/whS4o7WtFM5LOsiLlWN1PVGqqZaw0lM8SGYA4sA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4618776wmk.68.1578571293829; 
 Thu, 09 Jan 2020 04:01:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id l18sm2620496wme.30.2020.01.09.04.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 04:01:33 -0800 (PST)
Subject: Re: Difference between 'current_machine' vs
 MACHINE(qdev_get_machine())
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Like Xu <like.xu@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <a88f7647-c061-bf3f-a272-72700078ef26@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6a7197d-1647-4667-dae8-10c8dba1737f@redhat.com>
Date: Thu, 9 Jan 2020 13:01:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a88f7647-c061-bf3f-a272-72700078ef26@redhat.com>
Content-Language: en-US
X-MC-Unique: 8-NIkOnbOjuSuJKeTTpCVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/01/20 12:23, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
>=20
> =C2=A0=C2=A0=C2=A0 current_machine =3D
> MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
> =C2=A0=C2=A0=C2=A0 object_property_add_child(object_get_root(), "machine"=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(current_machine), &error_abort);
>=20
> The bigger user of 'current_machine' is the accel/KVM code.
>=20
> Recently in a0628599f..cc7d44c2e0 "Replace global smp variables with
> machine smp properties" we started to use MACHINE(qdev_get_machine()).
>=20
> qdev_get_machine() resolves the machine in the QOM composition tree.
> I am confused by this comment:
>=20
> =C2=A0 /* qdev_get_machine() can return something that's not TYPE_MACHINE
> =C2=A0=C2=A0 * if this is one of the user-only emulators; in that case th=
ere's
> =C2=A0=C2=A0 * no need to check the ignore_memory_transaction_failures bo=
ard flag.
> =C2=A0=C2=A0 */
>=20
> Following a0628599f..cc7d44c2e0, a5e0b33119 use 'current_machine' again.
>=20
> What are the differences between both form, when should we use one or
> another (or can we use a single one?). Can this break user-only mode?

I would always use MACHINE(qdev_get_machine()), espeecially outside
vl.c.  Ideally, current_machine would be static within vl.c or even
unused outside the object_property_add_child() that you quote above.

Most of the times, I noticed from a quick grep, we actually want to
access the accelerator, not the machine, so we could add a
qemu_get_accelerator() wrapper that does
MACHINE(qdev_get_machine())->accelerator.

Paolo


