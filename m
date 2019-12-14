Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96FBC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 07:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FAD214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 07:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WT7fBd4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FAD214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig1tt-0000t4-PO
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 02:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ig1tD-0000Ra-EC
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 02:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ig1tA-00026d-Cr
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 02:30:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46328
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ig1t9-0001yV-Ix
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 02:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576308653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3MQgw+uYLuMr8i7Blk2tPLyCuyl8YpKo5Va80slfTM=;
 b=WT7fBd4Hbt6zQxrj3DmyNDbOILZj0Wsin7Ko8SOTOmDda/Dr5+DHOh+eTmez+CSe1UlBhP
 +5BQ9hpS1Qp8pE8GhE112nWRG2wz9otKk2N1YUshY07d7vPmiQ7I7TKs7bOS1Q8acKfAjj
 ZCU4w6Iyaq7Iv7t6dDyfPeWzkcCmFjo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-QehFCOYSOsqe-ZlcAduOZQ-1; Sat, 14 Dec 2019 02:30:45 -0500
Received: by mail-wr1-f72.google.com with SMTP id f10so649308wro.14
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 23:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SWp2wj11HF/nfJ5vLXBuwKQKyS9KQKWPPoqzzy84jB0=;
 b=j1YNUKWdTrlt+rmXi1rPWglhXVL3WD7WwqXpkJg/zw94GeVweAnxYdhIEcbYMLnLM7
 w/h6fC9mWlnajg0WszH2gsR01AvHTKrAGIvDhJMqIhxK8nFikOW+4Wa5jsdAjCHRsZta
 gBsqmqGBrggdPyAUfOCkNJFn3nhVIUrGa/cYAqlBfnvth1jYPxfVGfUExZNQyt8nOmwD
 4dvrb8kn4YipthkDoXxSvxCoi0WukhmAr7ymGqu4DzSh2TMvScrO38i7aynacrd2Pfc6
 BG/PuELOIDuiqbVH98bCk2PX6sU87JBLSFhqNvvJGwkzrF+Lrfs4VAGOC+2DtKV08/dh
 SzSg==
X-Gm-Message-State: APjAAAUeQUYyeBttvQL4upasJKhQkwSfxUNzKogs4kQcFyWLBJyw4WE1
 jt58ZrGvWdFdRGoOGuLVqrQ/gSpJtRJiic8aMOO94LHkYOE5ZlwomCbkf2BFs6KDrkMycDnh3tT
 Vgv0EUW0db0Vwe9s=
X-Received: by 2002:adf:e591:: with SMTP id l17mr15939703wrm.139.1576308644107; 
 Fri, 13 Dec 2019 23:30:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKZ6quoIx0bWHdjv56ddMXEUYIxvXQSrgR3RB0NaVGZwRJZ/IOzMtD1HbIrqDjvWeB5eobzg==
X-Received: by 2002:adf:e591:: with SMTP id l17mr15939678wrm.139.1576308643817; 
 Fri, 13 Dec 2019 23:30:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:cde8:2463:95a9:1d81?
 ([2001:b07:6468:f312:cde8:2463:95a9:1d81])
 by smtp.gmail.com with ESMTPSA id d12sm12768732wrp.62.2019.12.13.23.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 23:30:43 -0800 (PST)
Subject: Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion
 `ret == cpu->kvm_msr_buf->nmsrs' failed.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Montes, Julio" <julio.montes@intel.com>, qemu-devel <qemu-devel@nongnu.org>
References: <DM6PR11MB4089A0B695CB84FB288068B89A540@DM6PR11MB4089.namprd11.prod.outlook.com>
 <2c28287e-1869-751d-f7c8-04605ef4b337@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d969066a-b10c-ebbc-b784-a19a66a5a831@redhat.com>
Date: Sat, 14 Dec 2019 08:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2c28287e-1869-751d-f7c8-04605ef4b337@redhat.com>
Content-Language: en-US
X-MC-Unique: QehFCOYSOsqe-ZlcAduOZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/12/19 02:31, Philippe Mathieu-Daud=E9 wrote:
>=20
> failed to launch qemu: exit status 1, error messages from qemu log:
> qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000
> qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2947: kvm_put_msrs:
> Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

It could be a KVM bug too.  The following features are being enabled:

#define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
#define VMX_SECONDARY_EXEC_SHADOW_VMCS              0x00004000
#define VMX_SECONDARY_EXEC_ENABLE_INVPCID           0x00001000
#define VMX_SECONDARY_EXEC_RDRAND_EXITING           0x00000800
#define VMX_SECONDARY_EXEC_ENABLE_VPID              0x00000020
#define VMX_SECONDARY_EXEC_ENABLE_EPT               0x00000002
#define VMX_SECONDARY_EXEC_DESC                     0x00000004
#define VMX_SECONDARY_EXEC_RDTSCP                   0x00000008

Can you try:

1) running "vmxcap" on the Azure VM

2) adding "-vmx-xsaves,-vmx-shadow-vmcs" to the "-cpu" option and, if it
works, add only one of the two.

3) if it doesn't work, adding "-vmx" to the "-cpu" option.  Either way,
run "x86info -a" in the resulting VM.

Thanks,

Paolo


