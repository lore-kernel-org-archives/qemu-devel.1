Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B374F2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i476Xonh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B374F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHTx-0005Xt-U7
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihHTD-0004df-VW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihHTB-0006x4-Pm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:21:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42745
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihHT8-0006ts-BL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576606872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZJzMDxg9KwEGyTIrUvtcZ1X+MfVyHeal221n4XYJUk=;
 b=i476XonhLRdQV8L1wIOnLFBU/kmxIIQVkkeoxlHnX6I4ThFrsssMC8CF+yhrpryPTYZOmE
 cerNEMI2re8xNBssUwcXCL4xEgvNYu99rxy/jvkI2a3v+6OHq3wR6EHXz7j6OnyqDmWBVd
 UOc5Az4YfKIN/Ri9j0iLtGQBmgEGGkU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-knlUiBqPMB6z-OvRHnaWGA-1; Tue, 17 Dec 2019 13:21:08 -0500
Received: by mail-wr1-f69.google.com with SMTP id l20so5699417wrc.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fVEtmFjmA91rdpbP1BEtpcTTcvCvWfb2Cohkwh0jYsk=;
 b=sCmInbaY5CACI0DyyBtzXh5GMFSW75ZOG2tVqlerT89VKwiqlLQVsJDgDc6UxVxIYe
 DEHrd8kyxxCXK2ZYv1UKFGCYbMyrbw0qzI0PzC6o/3z9GubfafdaaRM+GuxIEisC4+JX
 NkRJBRNPg5/95rBro676XVUjEgb5Egn5GyupQqfNdPsjSBMjS5Gie9KSyhsJZEBgmp+K
 E08zZS97RYlVCJ4sxS9/R5sSma9fRrQo9BUtRfMtxQw+A6B4Y93xx6r1dzMpF6KSE7Ei
 iUgl9YkF8xc+xzDramw6AQz+9Ir/jJ++QdbDq0W5StCPHf/OblUNgXOfbazBO+PxRCEL
 BLtw==
X-Gm-Message-State: APjAAAVEU0VwPxZ08ghDqZCFkRpnHXLZl6WwrrtTa8BFZqP+c1v4XPu7
 4QleO7PFSCApdJy40C+YSNuYpTCLSFlrMftVyr1vVbjSJbFHMuhWUEKlVcIARiwNepXQn+hxVXq
 BK2TCWyahfO3opL8=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr36885856wrs.217.1576606867191; 
 Tue, 17 Dec 2019 10:21:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOwwJ1Iznqv5I+1IZ+mDwEiSCN0iMYLRLH30NK3R2mAbbV9LCJi0q1b3EWudxZgW4TlnKiWw==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr36885834wrs.217.1576606866879; 
 Tue, 17 Dec 2019 10:21:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id o15sm26904282wra.83.2019.12.17.10.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 10:21:05 -0800 (PST)
Subject: Re: [PULL v2 00/62] Misc patches for 2019-12-16
To: Peter Maydell <peter.maydell@linaro.org>
References: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA96uWaOD0wN5g6Q7+eMH-RbkiCYo-aE-d_KvkSFVmUP3Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd58ac3a-0430-a3ae-a438-2473ef5d80ea@redhat.com>
Date: Tue, 17 Dec 2019 19:21:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA96uWaOD0wN5g6Q7+eMH-RbkiCYo-aE-d_KvkSFVmUP3Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: knlUiBqPMB6z-OvRHnaWGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 19:13, Peter Maydell wrote:
> On Tue, 17 Dec 2019 at 17:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b3b=
72f:
>>
>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request=
' into staging (2019-12-13 18:14:07 +0000)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 74c14076700436f9d340652042c81f46eaf0cf9f:
>>
>>   colo: fix return without releasing RCU (2019-12-17 14:03:44 +0100)
>>
>> ----------------------------------------------------------------
>> * More uses of RCU_READ_LOCK_GUARD (Dave, myself)
>> * QOM doc improvments (Greg)
>> * Cleanups from the Meson conversion (Marc-Andr=C3=A9)
>> * Support for multiple -accel options (myself)
>> * Many x86 machine cleanup (Philippe, myself)
>> * tests/migration-test cleanup (Juan)
>>
>> ----------------------------------------------------------------
>=20
> Conflict:
>=20
> diff --cc hw/ppc/spapr_irq.c
> index 07e08d6544,15c3dd4812..0000000000
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@@ -70,17 -70,15 +70,22 @@@ void spapr_irq_msi_free(SpaprMachineSta
>       bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
>   }
>=20
>  -int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
>  +int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
>                          SpaprInterruptController *intc,
>  +                       uint32_t nr_servers,
>                          Error **errp)
>   {
> -     MachineState *machine =3D MACHINE(qdev_get_machine());
>       Error *local_err =3D NULL;
>=20
> ++<<<<<<< HEAD
>  +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
>  +        if (fn(intc, nr_servers, &local_err) < 0) {
>  +            if (machine_kernel_irqchip_required(machine)) {
> ++=3D=3D=3D=3D=3D=3D=3D
> +     if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
> +         if (fn(intc, &local_err) < 0) {
> +             if (kvm_kernel_irqchip_required()) {
> ++>>>>>>> remotes/bonzini/tags/for-upstream
>                   error_prepend(&local_err,
>                                 "kernel_irqchip requested but unavailable=
: ");
>                   error_propagate(errp, local_err);
>=20
>=20
> I could probably figure out the resolution but I'm about 5 minutes
> from having to leave the office; sorry.

I pushed a merge commit to the same place.

Paolo


