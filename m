Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A66C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A005B206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A005B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44473 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYOJ-0004RI-O2
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:38:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRYN9-0003sC-5w
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRYN7-0006sz-Q7
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:37:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRYN7-0006qR-Jm
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:37:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so6071746wme.3
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 01:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hIBw9q+xfL/ZsGSYp0jZN0u802tM84VgRcXMKTKiP8o=;
	b=s0DudkEZWrhb8kZh88s5MGfF7H/UQu5T8ipZ8nw8XDyqD6EKnJJYX2zBnGhWmLLbCe
	04W8UEOdy+u1uwqghDXo9pq4UaiNIJAOIH6k0cUaGVWNDtzDe/1Vt1G3T3P1pf4oBuue
	ZQicq72PbthT/NGwO8rMcQ1IqZNtArhjnhWqbQ2Nz11mZfxsan+cpb+dveD8mhSpCpA1
	iMXbeek1NIUA5MD7nrYgVZ2PZ/SkoMXzT+SxkEZzipqSpILLRuxKQPriyEztNHPWTj/L
	eOJwzi0PoZrPDRSGdKX0kz4V3+9uHnpX/XCRAraIEzbbV2v77t2T9PYyrBjpBwa1lKKJ
	KanA==
X-Gm-Message-State: APjAAAXKSGvzKw8K+BfyqkkBoW1s4/GIojNBCvbGKuZ/C+zNjpBLr2B5
	N1F0xwF8YArpm6D2XB659khV8g==
X-Google-Smtp-Source: APXvYqzIO1VI8OFHxyg08g3AVSYSIKnzRNbOvQW0ayPCNCktaDxOEqrYWataGGqaleDciP98E20eeQ==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr31358657wmh.7.1558082264230; 
	Fri, 17 May 2019 01:37:44 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id d26sm5240016wmb.4.2019.05.17.01.37.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 01:37:43 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
	<CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
	<20190517014830.GA8322@richard>
	<70996852-8fae-adff-d302-a25a178ab384@redhat.com>
	<b31d13c1-b938-947e-a748-12c253cfff17@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a8511d01-5a23-fbc7-3d78-4fb44570c21e@redhat.com>
Date: Fri, 17 May 2019 10:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b31d13c1-b938-947e-a748-12c253cfff17@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 10:18 AM, Thomas Huth wrote:
> On 17/05/2019 10.12, Philippe Mathieu-Daudé wrote:
>> On 5/17/19 3:48 AM, Wei Yang wrote:
>>> On Thu, May 16, 2019 at 08:53:04PM +0200, Philippe Mathieu-Daudé wrote:
>>>> On Thu, May 16, 2019 at 8:33 PM Philippe Mathieu-Daudé
>>>> <philmd@redhat.com> wrote:
>>>>> On 5/16/19 6:04 PM, Peter Maydell wrote:
>>>>>> On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>>
>>>>>>> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>>>>>>>
>>>>>>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>>>>>>>
>>>>>>> are available in the Git repository at:
>>>>>>>
>>>>>>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>>>>>
>>>>>>> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
>>>>>>>
>>>>>>>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
>>>>>>>
>>>>>>> ----------------------------------------------------------------
>>>>>>> pci, pc, virtio: features, fixes
>>>>>>>
>>>>>>> reconnect for vhost blk
>>>>>>> tests for UEFI
>>>>>>> misc other stuff
>>>>>>>
>>>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>>
>>>>>>> ----------------------------------------------------------------
>>>>>>
>>>>>> Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
>>>>>> because the conversion of arm to Kconfig has landed in master.
>>>>>> Could you rebase and fix up to use whatever the Kconfig
>>>>>> equivalent of these changes is, please?
>>>>>
>>>>> Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"
>>>>>
>>>>> The conflict doesn't look trivial to resolve (to me) so I'd rather see
>>>>> it reviewed (by Thomas). I suggest to drop the patch(es) from your PR :(
>>>>
>>>> Thomas, FYI I did this to resolve the conflict:
>>>>
>>>> - keep default-configs/arm-softmmu.mak from master:
>>>>
>>>>  git checkout origin/master default-configs/arm-softmmu.mak
>>>>
>>>> - applied the following !fixup snippet:
>>>>
>>>> -- >8 --
>>>> --- a/hw/acpi/Kconfig
>>>> +++ b/hw/acpi/Kconfig
>>>> @@ -25,7 +25,7 @@ config ACPI_NVDIMM
>>>>
>>>> config ACPI_PCI
>>>>     bool
>>>> -    depends on ACPI
>>>> +    depends on ACPI && PCI
>>>
>>> Take a look into hw/arm/Kconfig. Only ARM_VIRT selects ACPI, but this one
>>> doesn't select PCI.
>>>
>>> Which option on arm select both?
>>
>> ARM_VIRT -> ACPI
>> ARM_VIRT -> PCI_EXPRESS -> PCI
>>
>> Maybe the correct Kconfig is:
>>
>> config ACPI_PCI
>>     bool
>>     default y if ACPI && PCI
>>
>> Paolo/Thomas?
> 
> Is it optional for the virt machine? If yes, "default y if ACPI && PCI"
> is fine. If not, the virt machine should "select ACPI_PCI" explicitly.

Yes, you are correct, we need 2 changes:

config ARM_VIRT
    ...
    select ACPI_PCI

config ACPI_PCI
    bool
    depends on ACPI && PCI

