Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E8BC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24982072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxY5si8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24982072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADEK-0006pE-35
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jADDC-0005Zh-Oi
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jADDA-0003dn-7F
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:40:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jADD9-0003LN-VH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583502018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTN85EDGHhLSRrRisKA51huPDatllgHXkn8nG5dIrk8=;
 b=fxY5si8/vhUyRWgppwzv6RNckRpc5BnTm8NXyjAZKnCNCUuLmRf2lc48ecP7Jkyfbp1mLD
 qfp73Y8DiP8ZdHl7SSzCdS7btNUFXYZRNUxcMhfPOpWAUSAYuL0LYbiZuAnk7cum+tcCNW
 Ng1nVutsJrqhSeTjhENxsIaPsuxaVHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-fdIQDuJVMWCtoADx9jmuyA-1; Fri, 06 Mar 2020 08:40:15 -0500
X-MC-Unique: fdIQDuJVMWCtoADx9jmuyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21CB4107ACC7;
 Fri,  6 Mar 2020 13:40:13 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D7635C545;
 Fri,  6 Mar 2020 13:40:08 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v3 11/14] arm/arm64: ITS: INT functional
 tests
To: Andrew Jones <drjones@redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-12-eric.auger@redhat.com>
 <20200207131547.rlj44nwu32xa4tyd@kamzik.brq.redhat.com>
 <5f5b7136-61e5-6464-f359-5925ceaa49a2@redhat.com>
 <20200306132957.ztjlr2g2ngqigfwq@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9ba9979c-3d0e-c416-f616-ab0a154ab236@redhat.com>
Date: Fri, 6 Mar 2020 14:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200306132957.ztjlr2g2ngqigfwq@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, yuzenghui@huawei.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 3/6/20 2:29 PM, Andrew Jones wrote:
> On Fri, Mar 06, 2020 at 01:55:09PM +0100, Auger Eric wrote:
>> Hi Drew,
>>
>> On 2/7/20 2:15 PM, Andrew Jones wrote:
>>> On Tue, Jan 28, 2020 at 11:34:56AM +0100, Eric Auger wrote:
>>>> Triggers LPIs through the INT command.
>>>>
>>>> the test checks the LPI hits the right CPU and triggers
>>>> the right LPI intid, ie. the translation is correct.
>>>>
>>>> Updates to the config table also are tested, along with inv
>>>> and invall commands.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> v2 -> v3:
>>>> - add comments
>>>> - keep the report_skip in case there aren't 4 vcpus to be able to
>>>>   run other tests in the its category.
>>>> - fix the prefix pop
>>>> - move its_event and its_stats to arm/gic.c
>>>> ---
>>>>  arm/gic.c         | 228 +++++++++++++++++++++++++++++++++++++++++++---
>>>>  arm/unittests.cfg |   7 ++
>>>>  2 files changed, 224 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arm/gic.c b/arm/gic.c
>>>> index 4d7dd03..50104b1 100644
>>>> --- a/arm/gic.c
>>>> +++ b/arm/gic.c
>>>> @@ -160,6 +160,87 @@ static void ipi_handler(struct pt_regs *regs __unused)
>>>>  	}
>>>>  }
>>>>  
>>>> +static void setup_irq(handler_t handler)
>>>> +{
>>>> +	gic_enable_defaults();
>>>> +#ifdef __arm__
>>>> +	install_exception_handler(EXCPTN_IRQ, handler);
>>>> +#else
>>>> +	install_irq_handler(EL1H_IRQ, handler);
>>>> +#endif
>>>> +	local_irq_enable();
>>>> +}
>>>> +
>>>> +#if defined(__aarch64__)
>>>> +struct its_event {
>>>> +	int cpu_id;
>>>> +	int lpi_id;
>>>> +};
>>>> +
>>>> +struct its_stats {
>>>> +	struct its_event expected;
>>>> +	struct its_event observed;
>>>> +};
>>>> +
>>>> +static struct its_stats lpi_stats;
>>>> +
>>>> +static void lpi_handler(struct pt_regs *regs __unused)
>>>> +{
>>>> +	u32 irqstat = gic_read_iar();
>>>> +	int irqnr = gic_iar_irqnr(irqstat);
>>>> +
>>>> +	gic_write_eoir(irqstat);
>>>> +	if (irqnr < 8192)
>>>> +		report(false, "Unexpected non LPI interrupt received");
>>>
>>> report_info
>> why? This is an error case. We do not expect other interrupts than LPIs
> 
> If there's almost no chance this will happen and it means something quite
> unexpected has occurred, then it should probably be an assert. If this is
> a real test case, then it should be
> 
>  report(irqnr >= 8192, "Got LPI");
> 
> or something like that. If it's something that shouldn't ever happen, so
> it doesn't really deserve its own PASS/FAIL test output each execution
> of the unit test, but you don't want to assert for some reason, then it
> should be a report_info, but it should probably also contain a "WARNING"
> prefix in that case.
OK so the assert should be OK.
> 
>>>
>>>> +	smp_rmb(); /* pairs with wmb in lpi_stats_expect */
>>>> +	lpi_stats.observed.cpu_id = smp_processor_id();
>>>> +	lpi_stats.observed.lpi_id = irqnr;
>>>> +	smp_wmb(); /* pairs with rmb in check_lpi_stats */
>>>> +}
>>>> +
>>>> +static void lpi_stats_expect(int exp_cpu_id, int exp_lpi_id)
>>>> +{
>>>> +	lpi_stats.expected.cpu_id = exp_cpu_id;
>>>> +	lpi_stats.expected.lpi_id = exp_lpi_id;
>>>> +	lpi_stats.observed.cpu_id = -1;
>>>> +	lpi_stats.observed.lpi_id = -1;
>>>> +	smp_wmb(); /* pairs with rmb in handler */
>>>> +}
>>>> +
>>>> +static void check_lpi_stats(void)
>>>
>>> static void check_lpi_stats(const char *testname)
>>> {
>>>    bool pass = false;
>>>
>>>> +{
>>>> +	mdelay(100);
>>>> +	smp_rmb(); /* pairs with wmb in lpi_handler */
>>>> +	if ((lpi_stats.observed.cpu_id != lpi_stats.expected.cpu_id) ||
>>>> +	    (lpi_stats.observed.lpi_id != lpi_stats.expected.lpi_id)) {
>>>
>>> nit: extra ()
>>>
>>>> +		if (lpi_stats.observed.cpu_id == -1 &&
>>>> +		    lpi_stats.observed.lpi_id == -1) {
>>>> +			report(false,
>>>> +			       "No LPI received whereas (cpuid=%d, intid=%d) "
>>>> +			       "was expected", lpi_stats.expected.cpu_id,
>>>> +			       lpi_stats.expected.lpi_id);
>>>
>>> report_info
>> What's the problem keeping those. Those are error reports. The message
>> is something like that:
>> FAIL: gicv3: its-trigger: mapc valid=false: No LPI received whereas
>> (cpuid=1, intid=8192) was expected.
>>
>> So the testname is already part of the message.
> 
> This one has two problems with being report() vs. report_info. The same
> comment as above, where the condition for a report() should be the test,
> rather than if (cond) report(false, ...), which implies it's not expected
> to report at all. A pattern like that needs to be extended at least to
> something like this
> 
> if (cond)
>   report(true, ...)
> else
>   report(false, ...)
OK understood. I should have use the test as the 1st param.
> 
> so we get the PASS/FAIL each execution. The other problem with this
> particular report() is the dynamic info in it (cpuid and maybe intid).
> A report() should only have consistent info so test output parsers
> can count on finding the PASS/FAIL for a given report line. If you
> need a test like this, then it can be structured like
> 
> report_info(...); // dynamic info
> if (cond) {
>    report(true, MSG1); // no dynamic info
>    report(true, MSG2); // no dynamic info
> } else {
>    report(false, MSG1); // no dynamic info
>    report(false, MSG2); // no dynamic info
> }
> 
> Notice how the MSG's match on both paths of the condition.
> 
> Or just 
> 
> report_info(...);
> report(cond, ...);
OK I see what you mean now. I will rewrite it accordingly.

Thank you for the extra explanation

Eric
> 
>>>
>>>> +		} else {
>>>> +			report(false, "Unexpected LPI (cpuid=%d, intid=%d)",
>>>> +			       lpi_stats.observed.cpu_id,
>>>> +			       lpi_stats.observed.lpi_id);
>>>
>>> report_info
>>>
>>>> +		}
>>>
>>> pass = false;
>>>
>>>> +	} else if (lpi_stats.expected.lpi_id != -1) {
>>>> +		report(true, "LPI %d on CPU %d", lpi_stats.observed.lpi_id,
>>>> +		       lpi_stats.observed.cpu_id);
>>>
>>> report_info
>>>
>>>> +	} else {
>>>> +		report(true, "no LPI received, as expected");
>>>
>>> report_info
> 
> This if, else if, ..., else with report() would be fine if the messages
> would all match, resulting in a single 'PASS: MSG' line. report_info can
> be used to get the dynamic info output too.
> 
>>>
>>>
>>>> +	}
>>>
>>> report(pass, "%s", testname);
>>>
>>>> +}
>>>> +
>>>> +static void secondary_lpi_test(void)
>>>> +{
>>>> +	setup_irq(lpi_handler);
>>>> +	cpumask_set_cpu(smp_processor_id(), &ready);
>>>> +	while (1)
>>>> +		wfi();
>>>> +}
>>>> +#endif
>>>> +
>>>>  static void gicv2_ipi_send_self(void)
>>>>  {
>>>>  	writel(2 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
>>>> @@ -217,17 +298,6 @@ static void ipi_test_smp(void)
>>>>  	report_prefix_pop();
>>>>  }
>>>>  
>>>> -static void setup_irq(handler_t handler)
>>>> -{
>>>> -	gic_enable_defaults();
>>>> -#ifdef __arm__
>>>> -	install_exception_handler(EXCPTN_IRQ, handler);
>>>> -#else
>>>> -	install_irq_handler(EL1H_IRQ, handler);
>>>> -#endif
>>>> -	local_irq_enable();
>>>> -}
>>>> -
>>>>  static void ipi_send(void)
>>>>  {
>>>>  	setup_irq(ipi_handler);
>>>> @@ -522,6 +592,7 @@ static void gic_test_mmio(void)
>>>>  #if defined(__arm__)
>>>>  
>>>>  static void test_its_introspection(void) {}
>>>> +static void test_its_trigger(void) {}
>>>>  
>>>>  #else /* __arch64__ */
>>>>  
>>>> @@ -561,6 +632,137 @@ static void test_its_introspection(void)
>>>>  	report_info("collection baser entry_size = 0x%x", coll_baser->esz);
>>>>  }
>>>>  
>>>> +static bool its_prerequisites(int nb_cpus)
>>>> +{
>>>> +	int cpu;
>>>> +
>>>> +	if (!gicv3_its_base()) {
>>>> +		report_skip("No ITS, skip ...");
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	if (nr_cpus < 4) {
>>>
>>> nr_cpus < nb_cpus, or just drop the nb_cpus parameter and hard code 4
>>> here.
>> sure
>>>
>>>> +		report_skip("Test requires at least %d vcpus", nb_cpus);
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	stats_reset();
>>>> +
>>>> +	setup_irq(lpi_handler);
>>>> +
>>>> +	for_each_present_cpu(cpu) {
>>>> +		if (cpu == 0)
>>>> +			continue;
>>>> +		smp_boot_secondary(cpu, secondary_lpi_test);
>>>> +	}
>>>> +	wait_on_ready();
>>>> +
>>>> +	its_enable_defaults();
>>>> +
>>>> +	lpi_stats_expect(-1, -1);
>>>> +	check_lpi_stats();
>>>> +
>>>> +	return false;
>>>
>>> Reverse logic. I'd expect 'return true' for success.
>> I am going to return an int. In case of error a std negative error will
>> be returned.
>>>
>>>> +}
>>>> +
>>>> +static void test_its_trigger(void)
>>>> +{
>>>> +	struct its_collection *col3, *col2;
>>>> +	struct its_device *dev2, *dev7;
>>>> +
>>>> +	if (its_prerequisites(4))
>>>
>>> if (!its_prerequisites(...))
>>>
>>>> +		return;
>>>> +
>>>> +	dev2 = its_create_device(2 /* dev id */, 8 /* nb_ites */);
>>>> +	dev7 = its_create_device(7 /* dev id */, 8 /* nb_ites */);
>>>> +
>>>> +	col3 = its_create_collection(3 /* col id */, 3/* target PE */);
>>>> +	col2 = its_create_collection(2 /* col id */, 2/* target PE */);
>>>> +
>>>> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
>>>> +	gicv3_lpi_set_config(8196, LPI_PROP_DEFAULT);
>>>> +
>>>> +	its_send_invall(col2);
>>>> +	its_send_invall(col3);
>>>> +
>>>> +	report_prefix_push("int");
>>>> +	/*
>>>> +	 * dev=2, eventid=20  -> lpi= 8195, col=3
>>>> +	 * dev=7, eventid=255 -> lpi= 8196, col=2
>>>> +	 * Trigger dev2, eventid=20 and dev7, eventid=255
>>>> +	 * Check both LPIs hit
>>>> +	 */
>>>> +
>>>> +	its_send_mapd(dev2, true);
>>>> +	its_send_mapd(dev7, true);
>>>> +
>>>> +	its_send_mapc(col3, true);
>>>> +	its_send_mapc(col2, true);
>>>> +
>>>> +	its_send_mapti(dev2, 8195 /* lpi id */,
>>>> +		       20 /* event id */, col3);
>>>> +	its_send_mapti(dev7, 8196 /* lpi id */,
>>>> +		       255 /* event id */, col2);
>>>
>>> No need for line breaks, with the embedded comments it's hard to read
>> OK
>>>
>>>> +
>>>> +	lpi_stats_expect(3, 8195);
>>>> +	its_send_int(dev2, 20);
>>>> +	check_lpi_stats();
>>>> +
>>>> +	lpi_stats_expect(2, 8196);
>>>> +	its_send_int(dev7, 255);
>>>> +	check_lpi_stats();
>>>> +
>>>> +	report_prefix_pop();
>>>
>>> I think a table of parameters and loop would be nicer than all the
>>> repeated function calls.
>> Frankly speaking I am not sure this would really help. We are just
>> enabling 2 translation paths. I think I prefer to manipulate the low
>> level objects and helpers rather than playing with a loop and potential
>> new structs of params.
> 
> OK, but you could probably at least wrap the common sequence into one
> function
> 
> void master_function(a1, a2, a3, a4)
> {
>   lpi_stats_expect(a1, a2);
>   its_send_int(a3, a4);
>   check_lpi_stats();
> }
> 
> but whatever, it's not so important.
> 
>>>
>>>> +
>>>> +	report_prefix_push("inv/invall");
>>>> +
>>>> +	/*
>>>> +	 * disable 8195, check dev2/eventid=20 does not trigger the
>>>> +	 * corresponding LPI
>>>> +	 */
>>>> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT & ~0x1);
>>>
>>> LPI_PROP_DEFAULT & ~LPI_PROP_ENABLED
>> ok
>>>
>>>> +	its_send_inv(dev2, 20);
>>>> +
>>>> +	lpi_stats_expect(-1, -1);
>>>> +	its_send_int(dev2, 20);
>>>> +	check_lpi_stats();
>>>> +
>>>> +	/*
>>>> +	 * re-enable the LPI but willingly do not call invall
>>>> +	 * so the change in config is not taken into account.
>>>> +	 * The LPI should not hit
>>>> +	 */
>>>> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
>>>> +	lpi_stats_expect(-1, -1);
>>>> +	its_send_int(dev2, 20);
>>>> +	check_lpi_stats();
>>>> +
>>>> +	/* Now call the invall and check the LPI hits */
>>>> +	its_send_invall(col3);
>>>> +	lpi_stats_expect(3, 8195);
>>>> +	its_send_int(dev2, 20);
>>>> +	check_lpi_stats();
>>>> +
>>>> +	report_prefix_pop();
>>>
>>> Need blank line here.
>> OK
>>>
>>>> +	/*
>>>> +	 * Unmap device 2 and check the eventid 20 formerly
>>>> +	 * attached to it does not hit anymore
>>>> +	 */
>>>> +	report_prefix_push("mapd valid=false");
>>>
>>> Above you have the prefix-push before the comment explaining the test.
>>> After is probably better, but whatever, as long as it's consistent.
>> moved after
>>>
>>>> +	its_send_mapd(dev2, false);
>>>> +	lpi_stats_expect(-1, -1);
>>>> +	its_send_int(dev2, 20);
>>>> +	check_lpi_stats();
>>>> +	report_prefix_pop();
>>>> +
>>>> +	/* Unmap the collection this time and check no LPI does hit */
>>>> +	report_prefix_push("mapc valid=false");
>>>> +	its_send_mapc(col2, false);
>>>> +	lpi_stats_expect(-1, -1);
>>>> +	its_send_int(dev7, 255);
>>>> +	check_lpi_stats();
>>>> +	report_prefix_pop();
>>>> +}
>>>>  #endif
>>>>  
>>>>  int main(int argc, char **argv)
>>>> @@ -594,6 +796,10 @@ int main(int argc, char **argv)
>>>>  		report_prefix_push(argv[1]);
>>>>  		gic_test_mmio();
>>>>  		report_prefix_pop();
>>>> +	} else if (!strcmp(argv[1], "its-trigger")) {
>>>> +		report_prefix_push(argv[1]);
>>>> +		test_its_trigger();
>>>> +		report_prefix_pop();
>>>>  	} else if (strcmp(argv[1], "its-introspection") == 0) {
>>>>  		report_prefix_push(argv[1]);
>>>>  		test_its_introspection();
>>>> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
>>>> index ba2b31b..bfafec5 100644
>>>> --- a/arm/unittests.cfg
>>>> +++ b/arm/unittests.cfg
>>>> @@ -129,6 +129,13 @@ extra_params = -machine gic-version=3 -append 'its-introspection'
>>>>  groups = its
>>>>  arch = arm64
>>>>  
>>>> +[its-trigger]
>>>> +file = gic.flat
>>>> +smp = $MAX_SMP
>>>> +extra_params = -machine gic-version=3 -append 'its-trigger'
>>>> +groups = its
>>>> +arch = arm64
>>>> +
>>>>  # Test PSCI emulation
>>>>  [psci]
>>>>  file = psci.flat
>>>> -- 
>>>> 2.20.1
>>>>
>>>
>>> Thanks,
>>> drew 
>>>
>> Thanks
>>
>> Eric
>>
>>
> 


