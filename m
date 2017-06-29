Received: from eggs.gnu.org ([2001:4830:134:3::10]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dQcnT-0004Ma-Ah
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dQcnQ-0008Qh-4q
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43316
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dQcnP-0008QZ-Tn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TGx6wp097638
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 12:59:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bd03b8gkq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 12:59:58 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 29 Jun 2017 12:59:58 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
	[9.57.199.109])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v5TGxuAp62718130
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 16:59:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D04AB112040
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 12:59:57 -0400 (EDT)
Received: from sbct-3.watson.ibm.com (unknown [9.2.141.158])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP id BF01A112034
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 12:59:57 -0400 (EDT)
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
	<20170628152214.3qhegqrjfpfh2sgs@redhat.com>
	<3b06e98c-33df-fa4d-e0ba-fcedf941619e@redhat.com>
	<f1e02018-7920-7c17-d5c9-91271d6f093c@linux.vnet.ibm.com>
	<a19eaa37-7bcd-be8b-8afb-092ef55b261f@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 12:59:55 -0400
MIME-Version: 1.0
In-Reply-To: <a19eaa37-7bcd-be8b-8afb-092ef55b261f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <ce17c16f-cf7d-71b8-347c-08266a5cd1df@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 06/29/2017 10:07 AM, Javier Martinez Canillas wrote:
> Hello Stefan,
>
> On 06/28/2017 10:57 PM, Stefan Berger wrote:
>> On 06/28/2017 12:44 PM, Laszlo Ersek wrote:
>>> On 06/28/17 17:22, Peter Jones wrote:
>>>> On Tue, Jun 27, 2017 at 12:12:50PM -0400, Stefan Berger wrote:
> [snip]
>
>>>>> To support measurements logs to be written by the firmware, e.g.
>>>>> SeaBIOS, a TCPA table is implemented. This table provides a 64kb
>>>>> buffer where the firmware can write its log into.
>>>> How does this work if we boot with edk2?
>>> My expectation is that it doesn't work at all, without doing some OVMF
>>> platform enablement first. (See
>>> <https://bugzilla.tianocore.org/show_bug.cgi?id=594>.) My plan is to use
>>> Stefan's document as a starting point for the edk2 / OVMF investigation
>>> -- one known and one unknown are better than two unknowns (to me).
>>>> Do we get what's described in
>>>> https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
>>>> instead of this interface?  As well as it?  It'd be good to have some
>>>> text about this here.
>>> I don't think that Stefan has spent any time on EFI enablement, so this
>>> part of the document will have to be written later, once there is any
>>> EFI-related functionality we can document. (I expect.)
>> Right, I did not spend any time on EFI. I suppose the ACPI tables going to a BIOS are also useful for EFI.
>>
>> For BIOS there is unfortunately only a spec for TPM 1.2, none anymore for
>> TPM2, at least back then when I last looked for it. So I ended up passing
>> that TCPA table that has the pointer for the logging area also in case of
>> a TPM 2. So SeaBIOS writes its log to it in both cases, following the TPM 2
> But this isn't correct from a TPM2 pov, right? Because the TPM2 spec says
> that the ACPI table that contains the TPM2.0 event logs is the TPM2 table.

The problem is the lack of specs for BIOS to support TPM. I don't see 
how the TPM2 could hold the log pointer. I am looking at section 7.3 in 
this document here:

https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_1-10_0-37-Published.pdf


>
> So instead the LASA field in the passed TPM2 ACPI table should point to the
> allocated buffer used by the firmware to store the event logs.

I only see LAML and LASA for TCPA ACPI table (sections 7.1.2 & 7.2.2),  
which seems to only be valid for TPM 1.2.


>> format form the EFI specs for the entries. The Linux driver in the meantime
>> has modified the code so  that it doesn't show the log anymore in case of
>> TPM 2 :-( . I think the above referenced specs would explain how the logging
> Do you mean that in the past Linux exposed the securityfs files with the event
> logs for TPM2 chips as well? My understanding is that Linux does the correct
> thing now, since as mentioned the TCPA table should only be used for TPM1.2.

There may have been a version or two of the driver that did that, yes.

This version has this check:

http://elixir.free-electrons.com/linux/v4.11.8/source/drivers/char/tpm/tpm_acpi.c#L57

This version does not have this check:

http://elixir.free-electrons.com/linux/v4.10.17/source/drivers/char/tpm/tpm_acpi.c



>
> There are patches posted to add Linux support to read the event logs for TPM2
> chips but from the TPM2 ACPI table. I see that hose haven't landed yet though:
>
> https://patchwork.kernel.org/project/tpmdd-devel/list/?submitter=7143

Aha, so I see this person is following some draft spec that isn't 
referenced via above page, yet.

"Latest draft of TPM 2 ACPI specification added TCG log start/length
to the TPM2 ACPI table.  So Linux kernel can now read it without
having to get involved with boot loader, same way TPM1/TCPA tables
work."

https://patchwork.kernel.org/patch/9651005/

> Best regards,
