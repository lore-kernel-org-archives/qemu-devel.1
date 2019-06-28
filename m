Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D738C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBA6208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBA6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrhr-0003n0-Mt
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52469)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgqny-0006A5-Ar
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgqnw-0007wA-Rs
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:20:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgqnw-0007sl-Lf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:20:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so9113003wmf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 06:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rz1wEKAqnaxpJPc5M7DlISFUk671y+XHVbTHo1RhsJo=;
 b=YpPOW5YLHh27BKh1sP2T9+PvDTsvgN8fCCa6KyPakgbFvOEOqSLvBCe6lcF6J/HJTb
 OTt4vK6a830vuFPfYSQgwnipwu+juA2shXFmr3zpRcgWDMwdYsq1/sCs5Y49ZxEfOsJa
 Enb/s1inx+Mld/wSs52sJf+itW4lVvgGc5+k7mH0JOidhrimGX7GTJhOIedaJiJERYhb
 gyS3yVZ+xJSZyI+H7qH+ZMs5/78rb+HUWcrUEge7EZ0gKOSqVSxbNIHAhPacPwnqIqnZ
 NoaexzyOduDlyB4cuom6BciFkIrxlaGlBhQNAbe/6PrXPuSr0mkEKXgPpCQ0WRiB/Ye7
 RSjg==
X-Gm-Message-State: APjAAAXZzabDul4J1vg31k9GG9Bq3A3A2oAE078B23iScKZRdLEMO7jn
 QwhSWnSTRkTiV8s6Zgtqda/2Pw==
X-Google-Smtp-Source: APXvYqxcEN0rXfXMJ/5ictSQ/7Xv8463CzVKDug12talOf+fjUBkBPdZfjVSyiQMpZ7EuuRIH/hOAg==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr7458896wmj.89.1561728039072;
 Fri, 28 Jun 2019 06:20:39 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id v27sm4368549wrv.45.2019.06.28.06.20.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 06:20:38 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>, lvivier@redhat.com
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
 <20190310082703.1245-58-david@gibson.dropbear.id.au>
 <20190312150115.6zuaid43gr7hklt5@unused>
 <58de43c6-31d5-a0a3-b443-54a33f11d75a@kaod.org>
 <20190312191409.vxnpscrephtk6otv@dhcp-17-165.bos.redhat.com>
 <1746025955.7399905.1552419034356.JavaMail.zimbra@redhat.com>
 <154364d7-fe5b-4f40-b976-b85ff9060ee0@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dc6578eb-569b-477e-9a74-2925de8ac204@redhat.com>
Date: Fri, 28 Jun 2019 15:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <154364d7-fe5b-4f40-b976-b85ff9060ee0@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PULL 57/60] target/ppc: add HV support for POWER9
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
Cc: peter maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 3/12/19 8:58 PM, Cédric Le Goater wrote:
> On 3/12/19 8:30 PM, Cleber Rosa wrote:
>>> From: "Cleber Rosa" <crosa@redhat.com>
>>> Sent: Tuesday, March 12, 2019 3:14:09 PM
>>> Subject: Re: [Qemu-devel] [PULL 57/60] target/ppc: add HV support for POWER9
>>>
>>> On Tue, Mar 12, 2019 at 07:34:04PM +0100, Cédric Le Goater wrote:
>>>> On 3/12/19 4:01 PM, Cleber Rosa wrote:
>>>>> On Sun, Mar 10, 2019 at 07:27:00PM +1100, David Gibson wrote:
>>>>>> From: Cédric Le Goater <clg@kaod.org>
>>>>>>
>>>>>> We now have enough support to boot a PowerNV machine with a POWER9
>>>>>> processor. Allow HV mode on POWER9.
>>>>>>
>>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>>> Message-Id: <20190307223548.20516-16-clg@kaod.org>
>>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>>>> ---
>>>>>>  target/ppc/translate_init.inc.c | 3 ++-
>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/target/ppc/translate_init.inc.c
>>>>>> b/target/ppc/translate_init.inc.c
>>>>>> index af70a3b78c..0bd555eb19 100644
>>>>>> --- a/target/ppc/translate_init.inc.c
>>>>>> +++ b/target/ppc/translate_init.inc.c
>>>>>> @@ -8895,7 +8895,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void
>>>>>> *data)
>>>>>>                         PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
>>>>>>                         PPC_MEM_SYNC | PPC_MEM_EIEIO |
>>>>>>                         PPC_MEM_TLBSYNC |
>>>>>> -                       PPC_64B | PPC_64BX | PPC_ALTIVEC |
>>>>>> +                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
>>>>>>                         PPC_SEGMENT_64B | PPC_SLBI |
>>>>>>                         PPC_POPCNTB | PPC_POPCNTWD |
>>>>>>                         PPC_CILDST;
>>>>>> @@ -8907,6 +8907,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void
>>>>>> *data)
>>>>>>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>>>>>>                          PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
>>>>>>      pcc->msr_mask = (1ull << MSR_SF) |
>>>>>> +                    (1ull << MSR_SHV) |
>>>>>>                      (1ull << MSR_TM) |
>>>>>>                      (1ull << MSR_VR) |
>>>>>>                      (1ull << MSR_VSX) |
>>>>>> --
>>>>>> 2.20.1
>>>>>>
>>>>>>
>>>>>
>>>>> This change prevents a Fedora 29 kernel[1] from booting... is this
>>>>> intended or a known limitation of the Fedora 29 kernel?
>>>>
>>>> The default CPU is still power8_v2.0. This is curious.
>>>>
>>>
>>> Are you sure?  I'm getting:
>>>
>>>  $ git rev-parse HEAD
>>>  cfc3fef6b4e493bf1a7ee16790ad584e20dfbbd1
>>>  $ ./ppc64-softmmu/qemu-system-ppc64 -qmp unix:/tmp/qmp-sock,server
>>>  $ ./scripts/qmp/qom-get -s /tmp/qmp-sock /machine/unattached/device[0].type
>>>  power9_v2.0-spapr-cpu-core
> 
> That's a pseries machine, not a powernv machine. pseries should use P9
> processor by default but the patch above should not impact f29 on pseries. 
> If it does, then we have a bug. 
>  
>> Looks like the overall default is "power9_v2.0", and then on pseries-3.1 and
>> lower, it's "power8_v2.0", as per 34a6b015a98.
> 
> I was looking at pnv_machine_class_init() which sets the default CPU :
> 
>     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");

I found this thread while trying auto-bisection for LP#1834613:
https://bugs.launchpad.net/bugs/1834613

When trying the options suggested by Laurent here:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06209.html

this one hangs:

$ qemu-system-ppc64 \
 -kernel vmlinuz-vanilla \
 -nographic -append "console=hvc0" \
 -M cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken

but this one works:

$ qemu-system-ppc64 \
 -kernel vmlinuz-vanilla \
 -nographic -append "console=hvc0" \
 -M pseries-3.1

> 
> C.
> 
>>
>> - Cleber.
>>
>>> Thanks,
>>> - Cleber.
>>>
>>>>> FIY, by using a "power8" CPU the Fedora 29 kernel boots successfully.
>>>>> For a reproducer, please refer to [2].
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>>> Thanks,
>>>>> - Cleber.
>>>>>
>>>>> [1] -
>>>>> https://download.fedoraproject.org/pub/fedora-secondary/releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz
>>>>>
>>>>> [2] -
>>>>> https://github.com/clebergnu/qemu/blob/sent/target_arch_v4/tests/acceptance/boot_linux_console.py#L138
>>>>>
>>>>
>>>

