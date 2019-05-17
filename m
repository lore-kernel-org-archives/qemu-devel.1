Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D66C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E1820848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E1820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRY1B-0005q2-GK
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:15:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRY0O-0005ZE-3I
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRY0M-0003Jp-Tb
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:14:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRY0M-0003Id-N8
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:14:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so6032295wme.0
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 01:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=g4QgEonpVjfkwB0bmc92o1WH1eZV6JlNl2ujCMLzC18=;
	b=qn/HLhgwHIY3WyP4eI6XiSPlNVlFnJJU1WpvbusXUf7K9/mR7mPAPqpRxqVxvBDN8h
	ire3jK9BHPC9eTMsPKCq9UARzQAwG7vrLmo5UpbOWDcWQQr3QLga05zO10xANiorh4CG
	/notryhK4RYAZgqiASQCVIo/e/GytpjpLfrnKCCqdaI8p81iwz/mGiPvaDxg52898AsH
	V9VRrHMOZTWHvz3y0UwArWfbFTn4d5RkYf1m8OFws7OSWm2uwzt365Gw5IRavY8QaPUM
	7sPN20QTbnd/AShDLnXJbU1JSP4BkrvWaK5DlRoFMAJA+Il1MNlCTZ7myW7sbVW9gsgX
	iUSA==
X-Gm-Message-State: APjAAAXC6icIarb/iaXYF61epYq5lsla3UL1le0EIHg3D723nNGpapaY
	+8KfAH/4wdTOXBLN3CF+jz84PQ==
X-Google-Smtp-Source: APXvYqzg7smA3rcnp8grtL6PsCx40xcG/DYVvFiAeZ6Lvf0CF0KguLc3bH3AlVE2ptnQCFgcTY4uTg==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr1186407wmd.30.1558080853666; 
	Fri, 17 May 2019 01:14:13 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	g11sm2797510wrx.62.2019.05.17.01.14.12
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 01:14:12 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
	<CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
	<20190517025903.GA17182@richard> <20190517031203.GA17339@richard>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bea6f63b-a877-54f8-728e-4f1f2d2b0081@redhat.com>
Date: Fri, 17 May 2019 10:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517031203.GA17339@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PULL 00/37] pci, pc, virtio: features, fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, imammedo@redhat.com,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 5:12 AM, Wei Yang wrote:
> On Fri, May 17, 2019 at 10:59:03AM +0800, Wei Yang wrote:
>> On Thu, May 16, 2019 at 08:53:04PM +0200, Philippe Mathieu-Daudé wrote:
>>> On Thu, May 16, 2019 at 8:33 PM Philippe Mathieu-Daudé
>>> <philmd@redhat.com> wrote:
>>>> On 5/16/19 6:04 PM, Peter Maydell wrote:
>>>>> On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>
>>>>>> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>>>>>>
>>>>>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>>>>
>>>>>> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
>>>>>>
>>>>>>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> pci, pc, virtio: features, fixes
>>>>>>
>>>>>> reconnect for vhost blk
>>>>>> tests for UEFI
>>>>>> misc other stuff
>>>>>>
>>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>
>>>>> Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
>>>>> because the conversion of arm to Kconfig has landed in master.
>>>>> Could you rebase and fix up to use whatever the Kconfig
>>>>> equivalent of these changes is, please?
>>>>
>>>> Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"
>>>>
>>>> The conflict doesn't look trivial to resolve (to me) so I'd rather see
>>>> it reviewed (by Thomas). I suggest to drop the patch(es) from your PR :(
>>>
>>> Thomas, FYI I did this to resolve the conflict:
>>>
>>> - keep default-configs/arm-softmmu.mak from master:
>>>
>>>  git checkout origin/master default-configs/arm-softmmu.mak
>>>
>>> - applied the following !fixup snippet:
>>>
>>> -- >8 --
>>> --- a/hw/acpi/Kconfig
>>> +++ b/hw/acpi/Kconfig
>>> @@ -25,7 +25,7 @@ config ACPI_NVDIMM
>>>
>>> config ACPI_PCI
>>>     bool
>>> -    depends on ACPI
>>> +    depends on ACPI && PCI
>>>
>>> ---
>>>
>>> I felt it easier to review on top of "hw/acpi: Improve build modularity"
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04718.html
>>>
>>
>> Well, I hope this will not block the merge.
>>
>> I took a look in the change of default-configs/arm-softmmu.mak. The general
>> idea from Thomas is put those hard-coded config to Kconfig.
>>
>> This is fine and what I need to change in my patch is to select ACPI_PCI in
>> the proper place, if my understanding is correct.
>>
>> Two things I need to fix:
>>
>>  * add select ACPI_PCI in proper place of hw/arm/Kconfig
>>  * add a dummy build_mcfg() for link when ACPI_PCI is not configured.
>>
>> Then I have two questions:
>>
>>  * In hw/arm/Kconfig, I don't see one option contains both PCI and ACPI. I am
>>    confused where to put the select.
>>  * put dummy build_mcfg() in aml-build.c works. Igor, do you like this? Or
>>    you haver other preference?
> 
> Hmm... put build_mcfg() in aml-build.c seems not work when we config both x86
> and arm. e.g. --target-list=x86_64-softmmu,arm-softmmu. Because we only have
> one aml-build.o object file.

I think this is what I tried to fix in "hw/acpi: Improve build modularity"
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04718.html

> 
> What comes into my mind is wrap build_mcfg() with #ifdef CONFIG_ACPI_PCI.
> 
> Any better idea?
> 
>>
>>> Sadly both series clash :(
>>>
>>> Regards,
>>>
>>> Phil.
>>
>> -- 
>> Wei Yang
>> Help you, Help me
> 

