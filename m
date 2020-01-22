Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288D4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB002071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB002071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuHym-00011Z-43
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1iuHxx-0000Qs-36
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1iuHxv-00058L-K1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:30:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59934 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1iuHxr-00053I-Qz; Wed, 22 Jan 2020 10:30:44 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 59C2A38D4F1D3B71379D;
 Wed, 22 Jan 2020 23:30:33 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 23:30:22 +0800
Subject: Re: [PATCH v22 8/9] target-arm: kvm64: handle SIGBUS signal from
 kernel or KVM
To: Peter Maydell <peter.maydell@linaro.org>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-9-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA_=PgkrWjwPxD89fCi85XPpcTHssXkSmE04Ctoj7AX0kA@mail.gmail.com>
 <c89db331-cb94-8e0b-edf8-25bfb64f826d@huawei.com>
 <CAFEAcA_Qs3p=iEU+D5iqjyZYpPQO0D16AWvjp0wcvbvRNdGAGg@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <a6030ba3-c82b-af4c-950c-4e15c315ad41@huawei.com>
Date: Wed, 22 Jan 2020 23:30:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Qs3p=iEU+D5iqjyZYpPQO0D16AWvjp0wcvbvRNdGAGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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

On 2020/1/20 20:15, Peter Maydell wrote:
> On Fri, 17 Jan 2020 at 10:05, gengdongjiu <gengdongjiu@huawei.com> wrot=
e:
>>
>> On 2020/1/17 0:28, Peter Maydell wrote:
>>> On Wed, 8 Jan 2020 at 11:33, Dongjiu Geng <gengdongjiu@huawei.com> wr=
ote:
>>>
>>>> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>> +{
>>>> +    ram_addr_t ram_addr;
>>>> +    hwaddr paddr;
>>>> +
>>>> +    assert(code =3D=3D BUS_MCEERR_AR || code =3D=3D BUS_MCEERR_AO);
>>>> +
>>>> +    if (acpi_enabled && addr &&
>>>> +            object_property_get_bool(qdev_get_machine(), "ras", NUL=
L)) {
>>>> +        ram_addr =3D qemu_ram_addr_from_host(addr);
>>>> +        if (ram_addr !=3D RAM_ADDR_INVALID &&
>>>> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, =
&paddr)) {
>>>> +            kvm_hwpoison_page_add(ram_addr);
>>>> +            /*
>>>> +             * Asynchronous signal will be masked by main thread, s=
o
>>>> +             * only handle synchronous signal.
>>>> +             */
>>>
>>> I don't understand this comment. (I think we've had discussions
>>> about it before, but it's still not clear to me.)
>>>
>>> This function (kvm_arch_on_sigbus_vcpu()) will be called in two conte=
xts:
>>>
>>> (1) in the vcpu thread:
>>>   * the real SIGBUS handler sigbus_handler() sets a flag and arranges
>>>     for an immediate vcpu exit
>>>   * the vcpu thread reads the flag on exit from KVM_RUN and
>>>     calls kvm_arch_on_sigbus_vcpu() directly
>>>   * the error could be MCEERR_AR or MCEERR_AOFor the vcpu thread, the=
 error can be MCEERR_AR or MCEERR_AO,
>> but kernel/KVM usually uses MCEERR_AR(action required) instead of MCEE=
RR_AO, because it needs do action immediately. For MCEERR_AO error, the a=
ction is optional and the error can be ignored.
>> At least I do not find Linux kernel/KVM deliver MCEERR_AO in the vcpu =
threads.
>>
>>> (2) MCE errors on other threads:
>>>   * here SIGBUS is blocked, so MCEERR_AR (action-required)
>>>     errors will cause the kernel to just kill the QEMU process
>>>   * MCEERR_AO errors will be handled via the iothread's use
>>>     of signalfd(), so kvm_on_sigbus() will get called from
>>>     the main thread, and it will call kvm_arch_on_sigbus_vcpu()
>>>   * in this case the passed in CPUState will (arbitrarily) be that
>>>     for the first vCPU
>>
>> For the MCE errors on other threads, it can only handle MCEERR_AO. If =
it is MCEERR_AR, the QEMU will assert and exit[2].
>>
>> Case1: Other APP indeed can send MCEERR_AO to QEMU=EF=BC=8C QEMU handl=
e it via the iothread's use of signalfd() through above path.
>> Case2: But if the MCEERR_AO is delivered by kernel, I see QEMU ignore =
it because SIGBUS is masked in main thread[3], for this case, I do not se=
e QEMU handle it via signalfd() for MCEERR_AO errors from my test.
>=20
> SIGBUS is blocked in the main thread because we use signalfd().
> The function sigfd_handler() should be called and it will then
> manually invoke the correct function for the signal.
>=20
>> For Case1=EF=BC=8CI think we should not let guest know it, because it =
is not triggered by guest. only other APP send SIGBUS to tell QEMU do som=
ethings.
>=20
> I don't understand what you mean here by "other app" or
> "guest" triggering of MCEERR. I thought that an MCEERR meant
> "the hardware has detected that there is a problem with the
> RAM". If there's a problem with the RAM and it's the RAM that's
> being used as guest RAM, we need to tell the guest, surely ?

  sure, If the error is guest RAM, we need to test the guest.
  I mean if the RAM that is being used as QEMU RAM(not guest RAM), we sho=
uld not tell the guest.
  OR if another user space manually send SIGBUS to qemu, such as using "k=
ill -s SIGBUS xxx" commands, we should not tell the guest.

>=20
>> For Case2=EF=BC=8Cit does not call call kvm_arch_on_sigbus_vcpu().
>=20
> It should do. The code you quote calls that function
> for that case:
  According to our analysis, I also think it should call the function for=
 that case.
  But from my test, I see  kvm_arch_on_sigbus_vcpu() is not called when K=
VM/Kernel delivers SIGBUS to QEMU main thread.
  So I am also confused. I haven't even dig into the reason yet.

 If anyone has done the test or knows the reason, welcome comments.


>=20
>> [1]:
>> /* Called synchronously (via signalfd) in main thread.  */
>> int kvm_on_sigbus(int code, void *addr)
>> {
>> #ifdef KVM_HAVE_MCE_INJECTION
>>     /* Action required MCE kills the process if SIGBUS is blocked.  Be=
cause
>>      * that's what happens in the I/O thread, where we handle MCE via =
signalfd,
>>      * we can only get action optional here.
>>      */
>> [2]: assert(code !=3D BUS_MCEERR_AR);
>>     kvm_arch_on_sigbus_vcpu(first_cpu, code, addr);
>>     return 0;
>> #else
>>     return 1;
>> #endif
>> }
>=20
>=20
>> Above all, from my test, for MCEERR_AO error which is triggered by gue=
st, it not call
> kvm_arch_on_sigbus_vcpu().
>=20
> I'm not sure what you mean by "triggered by guest". I assume that
> exactly what kind of errors the kernel can report and when will
> depend to some extent on the underlying hardware/firmware
> implementation of reporting of memory errors, but in principle
> the ABI allows the kernel to send SIGBUS_(BUS_MCEERR_AO) to the
> main thread, the signal should be handled by signalfd, our code
> for working with multiple fds should mean that the main thread
> calls sigfd_handler() to deal with reading bytes from the signalfd
> fd, and that function should then call sigbus_handler(), which
> calls kvm_on_sigbus(), which calls kvm_arch_on_sigbus_vcpu().
> If something in that code path is not working then we need to
> find out what it is.

  I agree with you, we need to check why it does not call sigbus_handler(=
) for the SIGBUS delivered by kernel/KVM.
  But I think it can  put it in another series, this series we only handl=
e the SIGBUS_(BUS_MCEERR_AR), whether do you think it is OK?
  Of course I will update the comments that you ever mentioned.

  By the way, If using "kill -s SIGBUS xxx" command to send SIGBUS to QEM=
U main thread, it indeed will be handled by signalfd.

>=20
> thanks
> -- PMM
> .
>=20


