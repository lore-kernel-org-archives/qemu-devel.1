Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41AC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71E52077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="RRh5qfR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71E52077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTzz-0005sk-Ng
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icTVd-0004W4-AP
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icTVY-0002b2-VJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:11:54 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:46166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icTVU-0001kY-LP; Wed, 04 Dec 2019 07:11:49 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 05BAF96EF0;
 Wed,  4 Dec 2019 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575461504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaurbfOKuOcfUaP1AMMQnTq3LAvy/GF5omcI4wFBMHA=;
 b=RRh5qfR9TkykdbQBNF5BrwkB5Zn6pbAjlGt0vQEkdZJSt1YX7YFxUHAn+xSTY4tvzqwwS+
 aPVyaeiXCvE4/55lhA6J8RBb4wnqnuhNsU7fFnWvOafuhrGCWtXmmFSRBuYeZf7VZ762ot
 ysbL7+sVv6wjHSN4j1UJK2tDVZsTOs0=
Subject: Re: [PATCH v6 6/9] docs/clocks: add device's clock documentation
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-7-damien.hedde@greensocs.com>
 <CAFEAcA-N=pBSMrALSYTHFFk4K=G+Zv_BO0ytF1FBS_PG6WMr2w@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <9a460a48-250f-eb70-f2cd-bbc9624963b1@greensocs.com>
Date: Wed, 4 Dec 2019 13:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-N=pBSMrALSYTHFFk4K=G+Zv_BO0ytF1FBS_PG6WMr2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575461504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaurbfOKuOcfUaP1AMMQnTq3LAvy/GF5omcI4wFBMHA=;
 b=yOiKSflFcV8ysr1i64O5apL2lQ7AfpgP6u6IJehGC+wbvPMnuPdXr8i5k8wFJChxb7yZwv
 9Da4UxHDpU58v73F2rhW4uAR0EPcGo/DzdcsUG4oSoxMI4Z5MH0OLbFNmQGqHt7Jy3x4+/
 JmGV34Z42jrRLtyFk1kn/7bV/cdOtrY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575461504; a=rsa-sha256; cv=none;
 b=jxaYQJd2zVG4nWG7KgI5GAO9a3ly5rTRUjxj/naUxXX87iPkXYAwnH1zxrFyW3tfjR84ll
 NOXHImHWT6h80cyco6ePcTjfa3j1c57snuSolbdJoywxmhK57jlPfbQHOvYZwkSplX4Dj4
 5FUH4zgvSDCcbbSvPCG1JmBA8eemLyk=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/2/19 4:17 PM, Peter Maydell wrote:
> On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Add the documentation about the clock inputs and outputs in devices.
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  docs/devel/clock.txt | 246 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 246 insertions(+)
>>  create mode 100644 docs/devel/clock.txt
> 
> Could you convert this to rst format, please?Yes.
> 
> 
> 
>> +Changing a clock output
>> +=======================
>> +
>> +A device can change its outputs using the clock_set_frequency function. It
>> +will trigger updates on every connected inputs.
> 
> "input"
> 
>> +
>> +For example, let's say that we have an output clock "clkout" and we have a
>> +pointer to it in the device state because we did the following in init phase:
>> +dev->clkout = qdev_init_clock_out(DEVICE(dev), "clkout");
>> +
>> +Then at any time (apart from the cases listed below), it is possible to
>> +change the clock value by doing:
>> +clock_set_frequency(dev->clkout, 1000 * 1000 * 1000); /* 1Ghz */
>> +This operation must be done while holding the qemu io lock.
>> +
>> +One can change clocks only when it is allowed to have side effects on other
>> +objects. In consequence, it is forbidden:
>> ++ during migration,
>> ++ and in the init phase of reset.
>> +
>> +Forwarding clocks
>> +=================
>> +
>> +Sometimes, one needs to forward, or inherit, a clock from another device.
>> +Typically, when doing device composition, a device might expose a sub-device's
>> +clock without interfering with it.
>> +The function qdev_pass_clock() can be used to achieve this behaviour. Note, that
> 
> "Note that"
> 
>> +it is possible to expose the clock under a different name. This works for both
>> +inputs or outputs.
> 
> "inputs and outputs"
> 
> 
>> +Migration
>> +=========
>> +
>> +Only the ClockIn object has a state. ClockOut is not concerned by migration.
> 
> "has any state".
> 
> "ClockOut has no state and does not need special handling for migration."
> 
>> +
>> +In case the frequency of in input clock is needed for a device's migration,
>> +this state must be migrated.
> 
> Are you trying to say that if an input clock is known to be a
> fixed frequency we don't need to migrate anything? I wonder
> if we need to worry about that or if we could/should just say that
> input clocks should always be migrated.

What I wanted to say is that there are indeed probably cases where
migrating the frequency is unnecessary. For example if we only use the
callback and never fetch the frequency outside it: if the frequency is
only used to compute something which is already saved/loaded during
migration.

But yes we could just do as you say. It's probably less confusing.

> 
>> The VMSTATE_CLOCKIN macro defines an entry to
>> +be added in a vmstate description.
>> +
>> +For example, if a device has a clock input and the device state looks like:
>> +MyDeviceState {
>> +    DeviceState parent_obj;
>> +    ClockIn *clk;
>> +};
>> +
>> +Then, to add the clock frequency to the device's migrated state, the vmstate
>> +description is:
>> +VMStateDescription my_device_vmstate = {
>> +    .name = "my_device",
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_CLOCKIN(clk, MyDeviceState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +When adding a input clock support to an existing device, you must care about
>> +migration compatibility. To this end, you can use the clock_init_frequency in
>> +a pre_load function to setup a default value in case the source vm does not
>> +migrate the frequency.
> 
> thanks
> -- PMM
> 

