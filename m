Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C7C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 13:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A536E206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 13:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeHPIdmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A536E206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijNwH-0003tE-QD
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 08:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ijNvN-0002vX-O5
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 08:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ijNvL-0002Ny-4S
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 08:39:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50590
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ijNvK-0002Mk-Ha
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 08:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577108341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6F9JTWWJHHxiwl3ygP3ZcbSTO8lvcvAMkBXQLhlIL8U=;
 b=SeHPIdmVZzhlJ2gnpTrytk4pjI0ohpfaM+Zh3MkRgDGpfvXH9d6/pDTF7maPZ1YQQf4S0w
 BSdPjutiw7kuU2AiX+Ry+w5ptT0w0yKO9kYyg15pppOUlJyYklu3T4c72OF97FisiYdUOr
 YS9UCwjr+Yo5g4c81mKPbQOuDxoOOQA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-6gW0ztwhMeWm3MTWOu75Fw-1; Mon, 23 Dec 2019 08:38:44 -0500
Received: by mail-wr1-f70.google.com with SMTP id h30so4277242wrh.5
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 05:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1XHwEBh1csSfx1CxmufQpAprZIhOsrCJ3EG4V5ubYAw=;
 b=oOyH3KuDQQaTKtBulAeXE/3muQU7VMra0XoXd9Z/fA3YA5y4v1U5aIxCj0eibXlcZU
 c9TGRUCfbPud/rKBWAtW/UGiMp3JcyG/iG/Q6Ua8SIBKrFsYwezw7kVNg1LUqjHOsNI9
 tX0K9OmEUl3nuHRZcR9+jHOGh+o/iC0HlsiNhX/Vce7BURM7tofYoJH69kSsnayxGGhR
 l2IXWXnZk3Pzny4Gd97SYUkj6yRPoYod3N0ASrU3R6yI0EWwdmHMmexrRLQlHAAjSizZ
 v2rE+S8kD3opigDZcGQaxhhPy4zN5U/CdVUfOX1lJGR8JE/BYrkri+nVsTD+1PcTpvhd
 RNDA==
X-Gm-Message-State: APjAAAUH5MdhcyRfsmIar9qiYbYoTkZH8M0O/I7I+SAd8KDVgEfDegId
 8ZhYAQRe1Nn+UA9aOIXUb9JnwvPrz3bGs5VwGZOiVCw1XwMqPp9FJ1SGsaXVLtJYxlitMHbIOV7
 TCWalJ1tAMaj/mH0=
X-Received: by 2002:a1c:9d81:: with SMTP id g123mr31275078wme.29.1577108323095; 
 Mon, 23 Dec 2019 05:38:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZs9N10NOGObH/BdCxFMMzNypvVgRpcAWaOdUoQuXPpl9/KW8czxw3Aspzzr04pMOF+aDbfw==
X-Received: by 2002:a1c:9d81:: with SMTP id g123mr31275055wme.29.1577108322856; 
 Mon, 23 Dec 2019 05:38:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:7009:9cf0:6204:f570?
 ([2001:b07:6468:f312:7009:9cf0:6204:f570])
 by smtp.gmail.com with ESMTPSA id e6sm20267855wru.44.2019.12.23.05.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2019 05:38:42 -0800 (PST)
Subject: Re: [PULL 48/87] x86: move SMM property to X86MachineState
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
 <1576670573-48048-49-git-send-email-pbonzini@redhat.com>
 <8e6af403-173f-ff15-11c7-5dad511795a1@redhat.com>
 <20191223113315.GI2529561@redhat.com>
 <07a106e4-ffa1-57d6-6909-6814d9c4de25@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4cccaf45-443d-56c9-e2e1-9c72b6638562@redhat.com>
Date: Mon, 23 Dec 2019 14:38:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <07a106e4-ffa1-57d6-6909-6814d9c4de25@redhat.com>
Content-Language: en-US
X-MC-Unique: 6gW0ztwhMeWm3MTWOu75Fw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/12/19 12:40, Michal Pr=C3=ADvozn=C3=ADk wrote:
>=20
> diff --git i/target/i386/kvm.c w/target/i386/kvm.c
> index 0b511906e3..7ee3202634 100644
> --- i/target/i386/kvm.c
> +++ w/target/i386/kvm.c
> @@ -2173,6 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      }
>=20
>      if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
> +        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
>          x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
>          smram_machine_done.notify =3D register_smram_listener;
>          qemu_add_machine_init_done_notifier(&smram_machine_done);

Yes, it's correct.  Is it okay if I just send a patch with your
Signed-off-by?

Paolo


