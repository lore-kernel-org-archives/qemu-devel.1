Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D4C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558E520707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI/ZYDDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558E520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixSmD-0006K9-JB
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 04:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1ixSla-0005mF-NN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1ixSlZ-0004xX-CO
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:39:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1ixSlW-0004v3-FK; Fri, 31 Jan 2020 04:39:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3033B20707;
 Fri, 31 Jan 2020 09:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580463545;
 bh=Cp3p5SMGhrd94coYZ6hL8kIlAqY8MsSmw65mT3Rp2as=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BI/ZYDDpJJWbuc7Y85nN1Snwv7KzQb6uJTo9RL1KK+7CzlFV2i1muQuW/UCbFA7Mg
 oGEXkyNxNvs0QmwjEVJ+6cGolrWaCXg0vLPOVhiLeD4cwjly3V+Ht9YqvXzaKaBjki
 lb2DsYr42lb2PPc/ipzZRVgdy8EnpfaONJQAN86g=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1ixSlT-002Ki8-5g; Fri, 31 Jan 2020 09:39:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 31 Jan 2020 09:39:03 +0000
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
In-Reply-To: <ff584722-1b51-e538-7c45-c71cdc40105f@redhat.com>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
 <544f261e4b9c97f1d3a5fb64cef42ba5@kernel.org>
 <ff584722-1b51-e538-7c45-c71cdc40105f@redhat.com>
Message-ID: <c61c95c434dbcf97a0c946f0993d4843@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, aik@ozlabs.ru, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, drjones@redhat.com,
 eric.auger@redhat.com, jthierry@redhat.com, shan.gavin@gmail.com,
 qemu-devel@nongnu.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-01-31 06:59, Gavin Shan wrote:
> On 1/29/20 8:04 PM, Marc Zyngier wrote:
>> On 2020-01-29 02:44, Alexey Kardashevskiy wrote:
>>> On 28/01/2020 17:48, Gavin Shan wrote:
>>>> but a NMI is injected
>>>> through LAPIC on x86. So I'm not sure what architect (system reset=20
>>>> on
>>>> ppc or injecting NMI on x86) aarch64 should follow.
>>>=20
>>> I'd say whatever triggers in-kernel debugger or kdump but I am not
>>> familiar with ARM at all :)
>>=20
>> All that is completely OS specific, and has no relation to the=20
>> architecture.
>> As I mentioned in another part of the thread, the closest thing to=20
>> this
>> would be to implement SDEI together with an IMPDEF mechanism to enter=20
>> it
>> (or even generate a RAS error).
>>=20
>> On the other hand, SDEI is pretty horrible, and means either KVM or=20
>> QEMU
>> acting like a firmware for the guest. To say that I'm not keen is a=20
>> massive
>> understatement.
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.
>=20
> Marc, could you please explain a bit about "IMPDEF mechanism"? I'm not=20
> sure if
> it means a non-standard SDEI event should be used, corresponding to the=
=20
> HMP/QMP
> "nmi" command.

SDEI doesn't quite describe *why* and *how* you enter it. You just get=20
there by
some mean (SError, Group-0 interrupt, or IMPlementation DEFined=20
mechanism).
It is then for the SDEI implementation to sort it out and enter the OS=20
using the
registered entry point.

> Also, If I'm correct, you agree that a crash dump should be triggered=20
> on arm64
> guest once HMP/QMP "nmi" command is issued?

No, I don't agree. QEMU and KVM are OS agnostic, and there is nothing in=20
the ARMv8
architecture that talks about "crash dumps".  If your "nmi" command=20
generates
a SDEI event and that event gets dispatched to the guest, it is entirely=20
the guest's
responsibility to do whatever it wants. We should stay clear of assuming=20
behaviours.

> I also dig into SDEI a bit. It seems the SDEI support in QEMU isn't=20
> upstream yet:
>=20
> https://patchew.org/QEMU/20191105091056.9541-1-guoheyi@huawei.com/

And I'm glad. SDEI, as I said, is absolutely horrible. I'm also very=20
fortunate
to have been CC'd on this series on an email address I cannot read.
This would have huge impacts on both QEMU and KVM, and this needs more=20
than
a knee jerk reaction to support a QEMU command.

And to be honest, if what you require is the guest kernel to panic, why=20
don't
you just implement a QEMU-specific driver in Linux that does just that?
Some kind of watchdog driver, maybe?

Thanks,

         M.
--=20
Jazz is not dead. It just smells funny...

