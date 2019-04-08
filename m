Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301C6C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA94120857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJd08ocG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA94120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59262 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbqD-0008DU-16
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:30:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hDbpO-0007tv-QP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hDbpN-00007s-Aq
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:29:18 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:34188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hDbpM-0008Ve-Mm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:29:17 -0400
Received: by mail-ed1-x544.google.com with SMTP id x14so13063178eds.1
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=5OujmZ1FZlnF7ecMrNyhSpVvC0WI69uVcZoEBGtISNA=;
	b=qJd08ocGRqkbZR9U1WUNQ6NK4Q2jZirrK0A85RLKl5W/vcH6CAz7kjhLsFNf3MaywT
	fodKsXorWRpJeduPMQHf7yMNudH09wv3mO4AxG0dt079ApznBLQAnY1UXKkGdF9jfWVy
	ozdksnPSrwQHqLowQ1U/2UqAASi6nX/9zXT8XeATyEJyBzDZAuiYYc6avIqKjLHdbW7f
	+FJy/UFbsYlfJmEvloX6rxSjs4gl9yd+YQk3w7gDLPcpl0OfH8ouEGfHm3ejB2ssaVw6
	9atEOpAX5FAgsun4MwfdI0I1zf/C1tXRIvEmJjw19nzG/rCHrLZMJJvlkoQkbUG3jC5k
	2G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=5OujmZ1FZlnF7ecMrNyhSpVvC0WI69uVcZoEBGtISNA=;
	b=ifYyZ4IUSoujOshQiM8ZwZ3kUXOiybvhVdNth7t5MXe/dbiZ/jDq7IC2pzH1DOEg0B
	WRpKbXq8ERoUrt6MTY1a2J9f6qA04M6Vnofa94/vPvpynQ+aW2mQT+pz1RwdDF2EJ10h
	zx8VDy1s5xPy0tzTw/L510n+egjLsAJhBvk2TvP4S/WY8UBH2QgBNC590MyQ+yuH2ONd
	GxHs+c0dt77W6P+2Swx5NdzN6AElwnnwsLcw1XtKed3zO1c5RGzelLkHGHVNPUwQVQjS
	vpJJEaxBlgECCNSApQhOrjTacfEng3cs7VFvKGWEdPIbAN08PH0Xa/7Hpj9zSz7QYdXx
	5RWA==
X-Gm-Message-State: APjAAAU+81eAttOukmfSGaSF7MJQ4vyQd/lGkagQv3VfG89iQDuSqSKg
	E8TY1hJup8Y6fAdyS8E3aps=
X-Google-Smtp-Source: APXvYqxvO4Uhl009wc+oOrYnqKCBtTuBQnwMZdkUhTScpJ3tWa7Fn8Pq7VWnLRGvy+Ai5aYdm8qy/A==
X-Received: by 2002:a50:84ac:: with SMTP id 41mr20788973edq.170.1554758953268; 
	Mon, 08 Apr 2019 14:29:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id k15sm1928325ejr.5.2019.04.08.14.29.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 08 Apr 2019 14:29:12 -0700 (PDT)
Date: Mon, 8 Apr 2019 21:29:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190408212911.jiqdva62ddebndut@master>
References: <20190407092314.11066-1-thuth@redhat.com>
	<20190408134517.GA9047@richard>
	<14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408212911.ePyLXE9TGQn5siL9_VV2zb_UhwYdxfRLILCVxdwUoUA@z>

On Mon, Apr 08, 2019 at 05:06:49PM +0200, Thomas Huth wrote:
>On 08/04/2019 15.45, Wei Yang wrote:
>> On Sun, Apr 07, 2019 at 11:23:14AM +0200, Thomas Huth wrote:
>>> QEMU currently crashes when you try to hot-plug an "nvdimm" device
>>> on older machine types:
>>>
>>> $ qemu-system-x86_64 -monitor stdio -M pc-1.1
>>> QEMU 3.1.92 monitor - type 'help' for more information
>>> (qemu) device_add nvdimm,id=nvdimmn1
>>> qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
>>> Assertion `*errp == ((void *)0)' failed.
>>> Aborted (core dumped)
>>>
>>> The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
>>> added recently before the check whether nvdimm is enabled. It should
>>> be done after the check. And while we're at it, also check the errp
>>> after the hotplug_handler_pre_plug(), otherwise errors are silently
>>> ignored here.
>> 
>> Thomas,
>> 
>> Thanks for pointing this out, while I have some different idea on how to fix
>> this.
>> 
>> The reason of the core dump is errp already been set in
>> hotplug_handler_pre_plug(), and this function check acpi hotplug capability.
>> The order of this check is correct, while we should  return when errp is set
>> in hotplug_handler_pre_plug().
>> 
>> I got a fix like this, which I have tested and looks good to me.
>> 
>> 
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 6077d27361..b11f3b15c1 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>      }
>>  
>>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>> +    if (*errp) {
>> +        return;
>> +    }
>
>Not sure, but I think you can not rely on the fact that the caller set
>*errp = NULL already... that's why it is more common to use a local_err
>variable and error_propagate() for such cases (which is what I did in my
>patch).
>

Ok, that's fine for me.

>Also, why don't you want the "nvdimm is not enabled: missing 'nvdimm' in
>'-M'" check to be done first?
>

Because this function pc_memory_pre_plug() will be called not only when
nvdimm is hot-plugged but also dimm is hot-plugged. And
hotplug_handler_pre_plug() here is to check the acpi(if it has) hot-plug
capability.

So the check in pc_memory_pre_plug() is from generic to specific: 
    1. Do we have capability to hot-plug?
    2. If the device is nvdimm, do we enabled nvdimm?

> Thomas
>
>
>
>>      if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>> 
>>>
>>> Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> hw/i386/pc.c | 9 +++++++--
>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 6077d27361..f2c15bf1f2 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>     const MachineState *ms = MACHINE(hotplug_dev);
>>>     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>>>     const uint64_t legacy_align = TARGET_PAGE_SIZE;
>>> +    Error *local_err = NULL;
>>>
>>>     /*
>>>      * When -no-acpi is used with Q35 machine type, no ACPI is built,
>>> @@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>         return;
>>>     }
>>>
>>> -    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>>> -
>>>     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>>>         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>>>         return;
>>>     }
>>>
>>> +    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +
>>>     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>>>                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
>>> }
>>> -- 
>>> 2.21.0
>> 
>

-- 
Wei Yang
Help you, Help me

