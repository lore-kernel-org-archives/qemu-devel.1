Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90415ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6153620679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6153620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpdL-0004Dy-FD
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 03:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIpYR-0000rW-UT
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIpYQ-0003mb-0U
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:41:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12707)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIpYP-0003lv-Ni
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:41:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67DB1307D88C;
 Fri, 11 Oct 2019 07:41:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-177.rdu2.redhat.com
 [10.10.120.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2E0360600;
 Fri, 11 Oct 2019 07:41:25 +0000 (UTC)
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191010055356-mutt-send-email-mst@kernel.org>
 <20191010153815.4f7a3fc9@redhat.com>
 <20191010095459-mutt-send-email-mst@kernel.org>
 <20191010175754.7c62cf8f@Igors-MacBook-Pro>
 <20191010140934-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <361f8d36-5dc7-6428-2954-fd20707f351a@redhat.com>
Date: Fri, 11 Oct 2019 09:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191010140934-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 11 Oct 2019 07:41:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 20:15, Michael S. Tsirkin wrote:
> On Thu, Oct 10, 2019 at 05:57:54PM +0200, Igor Mammedov wrote:
>>> Then we should consider switching acpi to use fw cfg.
>>> Or build another interface that can scale.
>>
>> Could be an option, it would be a pain to write a driver in AML for fwcfg access though
>> (I've looked at possibility to access fwcfg from AML about a year ago and gave up.
>> I'm definitely not volunteering for the second attempt and can't even give an estimate
>> it it's viable approach).
>>
>> But what scaling issue you are talking about, exactly?
> 
> Just this: each new thing we add is an ad-hoc data structure with
> manually maintained backwards compatibility and no built-in discovery.
> 
> fw cfg has built-in discovery and we've finally managed to
> handle compatibility reasonably well.
> 
> PV is already very problematic.  Spreading PV code all over the place
> like this is a very bad idea.  For you CPU hotplug is something that you
> keep in mind first of all, but someone bringing up a new platform
> already has a steep hill to climb.  Adding tons of custom firmware is
> not helping things.
> 

- Custom firmware is unfortunately unavoidable in this case. SMM is a
privilege barrier between the firmware and the OS. The firmware needs to
care because to OS could use a hotplugged CPU to attack SMM, unless
hardware and firmware co-operate to prevent that. This whole ordeal aims
to prevent such an attack.

If you remove SMM from the picture (build OVMF without it), there is no
such privilege barrier between fw and OS, the firmware doesn't need to
know anything about VCPU hotplug events, and hotplug already works.


- Custom hardware is also expected. On physical platforms, there is a
dedicated BMC / RAS thingy that e.g. provides the APIC-ID to firmware,
when a CPU is hotplugged. One factor that makes this feature difficult
is that edk2 does not contain any code driving such hardware; it only
contains firmware code for *consuming* what the BMC / RAS thingy
produces. We're trying to work backwards from that. We could implement a
brand new hotplug controller device model, but it would be entirely PV
(= it would be our own design). Reusing the CPU hotplug register block
isn't worse, in that regard. This is my understanding anyway.


- Using fw_cfg *DMA* in an SMI handler (at OS runtime) could be
problematic. Especially if you consider SEV guests. For DMA transfers,
memory has to be decrypted and encrypted, which involves page table
manipulation.

In the firmware, this is handled with a SEV-specific
EDKII_IOMMU_PROTOCOL implementation. The fw_cfg library (transparently
to the caller) utilizes the IOMMU protocol, for dealing with DMA in SEV
guests.

Such protocols are boot-time only; they are not runtime protocols, let
alone SMM protocols. They are not available to SMI handlers.

Raw IO ports are extremely attractive in this regard: they don't depend
on page tables (SMM has its own set of page tables), they just work
under SEV out of the box. (The only exception is [REP] INS*/OUTS*, as
those depend on memory, not just registers, but no such instructions are
expected for the hotplug register block.)

- IO-port based fw_cfg might be suitable for the hotplug SMI handler,
yes. Assuming it's really only the firmware that needs information from
QEMU in the hotplug SMI handler, and not the other way around. (IO-port
based fw_cfg doesn't support writes.)

Now, when considering IO-port based fw_cfg in the SMI handler, we should
at least mention the risk of interfering with the Linux guest's own
fw_cfg driver. I've *never* been happy with anything non-firmware
accessing fw_cfg (it says "*firmware* config" in the name!), so I
wouldn't care much in practice. It's just that we should be aware that
there is a chance for entanglement. (The SMI handler cannot restore the
previous fw_cfg state, when it finishes up.)

At least on a theoretical level, the ACPI CPU hotplug register block is
nicer in this regard: the OS doesn't know about it at all (it is
accessed only through QEMU-generated AML code), and the plan is for the
same AML code to closely coordinate with the firmware. Namely, the AML
would raise the hotplug SMI.

Thanks
Laszlo

