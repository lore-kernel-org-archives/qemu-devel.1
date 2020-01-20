Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68E0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D2C207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcURgP6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D2C207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVzc-0002Zi-8T
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itVxu-0001GN-U4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itVxt-0003Aa-Aw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:15:34 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itVxt-00038q-46
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:15:33 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so13490484oig.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 04:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BIh9YR7ribtNKqpS6WraqY8c5jxqIOOYDe80jRm6D5Y=;
 b=FcURgP6eMlNurFWWH0M/cmGAdX7g4MN5esyjZ2BW6LmDfqoZ7ssWNnjUE97HpCwB3c
 RSTxpl3HEmglPoC+OxTBnRWGuVgVBsV4FTEvxmotsEWN378omvwyG5E1o08x1Dv5x4i/
 2un7yJA1KOgptV5UKJ+CfnXUD2L8uFnoBOUazZz27bL+fUprysSWGJwLv9vXTbOBnPnb
 Kc02QeVOHnOhxZ768hFVopM7gcISKRr4H0aWrwclnfogteqGLJWdVOWBjUzWYXIMhkCR
 zG5Y9USo6weLRoi2DySC2egUK3AJqrD2KSA4Msf7jUDL+79ign5yW0q1sEmqk/Y5y13q
 1waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BIh9YR7ribtNKqpS6WraqY8c5jxqIOOYDe80jRm6D5Y=;
 b=XD6DZFprUDl46fSx4BFNdbJ+i+o+e7jYQ3NAt1Z78h+pSHLc5zvNS/hZa4+yTpt1lZ
 6nDBNVY4I0flfQOyMG0SIx7XeYWd22B+SPz5kCktrmDBizLc7PrjBnpEAarNHMKfbLpP
 Nm0/cKv/tI3dxH3jSj96ehfNgYd+GYUHviFSMOzMYwEETLW8As8TAccJ/wg7KYyBH+Bo
 QFV5cHw9lzwypYVDlZuQbjxrVI8wGMaALsCSIb5cb5S3mjvcdgivOBpOwIcwmnX7/xF6
 aNwarsxFd3rQsUPe4O7bP9nhpxMToAwANMWo8VgglqjJyORziiXYhXPEWOfun4CWpaSz
 WhEQ==
X-Gm-Message-State: APjAAAUGGfJr/Q76NT5Va0W9oibjwMEX5pu7vRLnQhWaNJU10iOsER9y
 Atkta622bgWnYWfV0W5WQ5ZshYqZU9CzCgpI1znoLA==
X-Google-Smtp-Source: APXvYqyBKgwLpMs7bERGUIwh2DFIPid0XT0le4cFbQV9y9pbq7lnssLrYEOl9FwUv8peTTYFE/m+KzgjFil7u+Gwle0=
X-Received: by 2002:aca:3182:: with SMTP id
 x124mr12795563oix.170.1579522532051; 
 Mon, 20 Jan 2020 04:15:32 -0800 (PST)
MIME-Version: 1.0
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-9-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA_=PgkrWjwPxD89fCi85XPpcTHssXkSmE04Ctoj7AX0kA@mail.gmail.com>
 <c89db331-cb94-8e0b-edf8-25bfb64f826d@huawei.com>
In-Reply-To: <c89db331-cb94-8e0b-edf8-25bfb64f826d@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 12:15:21 +0000
Message-ID: <CAFEAcA_Qs3p=iEU+D5iqjyZYpPQO0D16AWvjp0wcvbvRNdGAGg@mail.gmail.com>
Subject: Re: [PATCH v22 8/9] target-arm: kvm64: handle SIGBUS signal from
 kernel or KVM
To: gengdongjiu <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 10:05, gengdongjiu <gengdongjiu@huawei.com> wrote:
>
> On 2020/1/17 0:28, Peter Maydell wrote:
> > On Wed, 8 Jan 2020 at 11:33, Dongjiu Geng <gengdongjiu@huawei.com> wrot=
e:
> >
> >> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> >> +{
> >> +    ram_addr_t ram_addr;
> >> +    hwaddr paddr;
> >> +
> >> +    assert(code =3D=3D BUS_MCEERR_AR || code =3D=3D BUS_MCEERR_AO);
> >> +
> >> +    if (acpi_enabled && addr &&
> >> +            object_property_get_bool(qdev_get_machine(), "ras", NULL)=
) {
> >> +        ram_addr =3D qemu_ram_addr_from_host(addr);
> >> +        if (ram_addr !=3D RAM_ADDR_INVALID &&
> >> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &p=
addr)) {
> >> +            kvm_hwpoison_page_add(ram_addr);
> >> +            /*
> >> +             * Asynchronous signal will be masked by main thread, so
> >> +             * only handle synchronous signal.
> >> +             */
> >
> > I don't understand this comment. (I think we've had discussions
> > about it before, but it's still not clear to me.)
> >
> > This function (kvm_arch_on_sigbus_vcpu()) will be called in two context=
s:
> >
> > (1) in the vcpu thread:
> >   * the real SIGBUS handler sigbus_handler() sets a flag and arranges
> >     for an immediate vcpu exit
> >   * the vcpu thread reads the flag on exit from KVM_RUN and
> >     calls kvm_arch_on_sigbus_vcpu() directly
> >   * the error could be MCEERR_AR or MCEERR_AOFor the vcpu thread, the e=
rror can be MCEERR_AR or MCEERR_AO,
> but kernel/KVM usually uses MCEERR_AR(action required) instead of MCEERR_=
AO, because it needs do action immediately. For MCEERR_AO error, the action=
 is optional and the error can be ignored.
> At least I do not find Linux kernel/KVM deliver MCEERR_AO in the vcpu thr=
eads.
>
> > (2) MCE errors on other threads:
> >   * here SIGBUS is blocked, so MCEERR_AR (action-required)
> >     errors will cause the kernel to just kill the QEMU process
> >   * MCEERR_AO errors will be handled via the iothread's use
> >     of signalfd(), so kvm_on_sigbus() will get called from
> >     the main thread, and it will call kvm_arch_on_sigbus_vcpu()
> >   * in this case the passed in CPUState will (arbitrarily) be that
> >     for the first vCPU
>
> For the MCE errors on other threads, it can only handle MCEERR_AO. If it =
is MCEERR_AR, the QEMU will assert and exit[2].
>
> Case1: Other APP indeed can send MCEERR_AO to QEMU=EF=BC=8C QEMU handle i=
t via the iothread's use of signalfd() through above path.
> Case2: But if the MCEERR_AO is delivered by kernel, I see QEMU ignore it =
because SIGBUS is masked in main thread[3], for this case, I do not see QEM=
U handle it via signalfd() for MCEERR_AO errors from my test.

SIGBUS is blocked in the main thread because we use signalfd().
The function sigfd_handler() should be called and it will then
manually invoke the correct function for the signal.

> For Case1=EF=BC=8CI think we should not let guest know it, because it is =
not triggered by guest. only other APP send SIGBUS to tell QEMU do somethin=
gs.

I don't understand what you mean here by "other app" or
"guest" triggering of MCEERR. I thought that an MCEERR meant
"the hardware has detected that there is a problem with the
RAM". If there's a problem with the RAM and it's the RAM that's
being used as guest RAM, we need to tell the guest, surely ?

> For Case2=EF=BC=8Cit does not call call kvm_arch_on_sigbus_vcpu().

It should do. The code you quote calls that function
for that case:

> [1]:
> /* Called synchronously (via signalfd) in main thread.  */
> int kvm_on_sigbus(int code, void *addr)
> {
> #ifdef KVM_HAVE_MCE_INJECTION
>     /* Action required MCE kills the process if SIGBUS is blocked.  Becau=
se
>      * that's what happens in the I/O thread, where we handle MCE via sig=
nalfd,
>      * we can only get action optional here.
>      */
> [2]: assert(code !=3D BUS_MCEERR_AR);
>     kvm_arch_on_sigbus_vcpu(first_cpu, code, addr);
>     return 0;
> #else
>     return 1;
> #endif
> }


> Above all, from my test, for MCEERR_AO error which is triggered by guest,=
 it not call
kvm_arch_on_sigbus_vcpu().

I'm not sure what you mean by "triggered by guest". I assume that
exactly what kind of errors the kernel can report and when will
depend to some extent on the underlying hardware/firmware
implementation of reporting of memory errors, but in principle
the ABI allows the kernel to send SIGBUS_(BUS_MCEERR_AO) to the
main thread, the signal should be handled by signalfd, our code
for working with multiple fds should mean that the main thread
calls sigfd_handler() to deal with reading bytes from the signalfd
fd, and that function should then call sigbus_handler(), which
calls kvm_on_sigbus(), which calls kvm_arch_on_sigbus_vcpu().
If something in that code path is not working then we need to
find out what it is.

thanks
-- PMM

