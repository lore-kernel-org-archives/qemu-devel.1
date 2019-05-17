Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97043C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB6920848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB6920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44159 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXz3-0005CK-Hl
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:12:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRXyH-0004vb-75
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRXyG-0001BN-87
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:12:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRXyG-0001Ak-28
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:12:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so5931728wrv.2
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 01:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=u/e44JHdm2Rxi7Abi2o5Gp+pn7UDT7f4nXy4VxH3jMg=;
	b=VmVJRrs7RWtFpYopDqV++2V/SsfwV5ezV00QDugtmWXRgv51FRTqHVS81ZPkrq/LsE
	8BjCSVye2QSPChmFnEoSz2xwKJeKxULWDq20TKNguKH8Yakvs63An/3dyK1LEqJdz3tj
	12hEAd/wKHC8d/3TruxPA2b/wrYmZbIHSMPtCde5vI78YJvwZIsS75XBtnkQiE8yP+tv
	X8MuJssEFwrRm3ir16S4lMSEcz0BoUb32IHB/jXgmkG9dBXcPtULfb4+yT2fx+ADnptj
	33J1BYvLYjeSxkJWaYgdq4WRy73S2bxVLPdvuYwBVUWlMO/oGc3JpxJ8Ji3tjVKowT90
	amGg==
X-Gm-Message-State: APjAAAU9LK59MJcUutmBlfwy/q4rK+stFZkYwMJv8n853L2/dT5X+L+d
	TjXAiGal2tmnvRvkDAbbSK68VQ==
X-Google-Smtp-Source: APXvYqxmG7wXERjEWLbgW5pqvJFz9Y+SF0XoZPQcC6Dz+IojzulU1X7FR6bjPYRLLJQSCHeWZaGkFA==
X-Received: by 2002:adf:f349:: with SMTP id e9mr25427691wrp.133.1558080722889; 
	Fri, 17 May 2019 01:12:02 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	a10sm8591442wrm.94.2019.05.17.01.12.01
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 01:12:01 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
	<CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
	<20190517014830.GA8322@richard>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <70996852-8fae-adff-d302-a25a178ab384@redhat.com>
Date: Fri, 17 May 2019 10:12:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517014830.GA8322@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:48 AM, Wei Yang wrote:
> On Thu, May 16, 2019 at 08:53:04PM +0200, Philippe Mathieu-Daudé wrote:
>> On Thu, May 16, 2019 at 8:33 PM Philippe Mathieu-Daudé
>> <philmd@redhat.com> wrote:
>>> On 5/16/19 6:04 PM, Peter Maydell wrote:
>>>> On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>
>>>>> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>>>>>
>>>>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>>>
>>>>> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
>>>>>
>>>>>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> pci, pc, virtio: features, fixes
>>>>>
>>>>> reconnect for vhost blk
>>>>> tests for UEFI
>>>>> misc other stuff
>>>>>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>
>>>>> ----------------------------------------------------------------
>>>>
>>>> Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
>>>> because the conversion of arm to Kconfig has landed in master.
>>>> Could you rebase and fix up to use whatever the Kconfig
>>>> equivalent of these changes is, please?
>>>
>>> Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"
>>>
>>> The conflict doesn't look trivial to resolve (to me) so I'd rather see
>>> it reviewed (by Thomas). I suggest to drop the patch(es) from your PR :(
>>
>> Thomas, FYI I did this to resolve the conflict:
>>
>> - keep default-configs/arm-softmmu.mak from master:
>>
>>  git checkout origin/master default-configs/arm-softmmu.mak
>>
>> - applied the following !fixup snippet:
>>
>> -- >8 --
>> --- a/hw/acpi/Kconfig
>> +++ b/hw/acpi/Kconfig
>> @@ -25,7 +25,7 @@ config ACPI_NVDIMM
>>
>> config ACPI_PCI
>>     bool
>> -    depends on ACPI
>> +    depends on ACPI && PCI
> 
> Take a look into hw/arm/Kconfig. Only ARM_VIRT selects ACPI, but this one
> doesn't select PCI.
> 
> Which option on arm select both?

ARM_VIRT -> ACPI
ARM_VIRT -> PCI_EXPRESS -> PCI

Maybe the correct Kconfig is:

config ACPI_PCI
    bool
    default y if ACPI && PCI

Paolo/Thomas?

