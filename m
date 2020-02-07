Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE88C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025ED21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dt9pgrMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025ED21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03VI-000240-5y
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j03UI-00011G-So
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j03UG-0000Ep-Aj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:16:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j03UG-0000ET-5Q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581081359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oClRtBhodqGVYqoJbtW8DMEVH3CdF5teJSKNOv0GzTM=;
 b=Dt9pgrMyKFQI6/oPUSGNH9PQ5MiE/qnf81vbcvKajlHvkOr70Kl0P3D1zEraY5+mLL+qox
 EGnbm9Ump2Nas/DfAWAppMvyVWozA8R5zJQT2qLxKl9gMWz3faFGz7c3RIO0HPrbv/2IZW
 XsIXrIJZW+5/0cI+34bzAbfSAirDG3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-cudI3_b8PxemvxAJoIbtxw-1; Fri, 07 Feb 2020 08:15:57 -0500
X-MC-Unique: cudI3_b8PxemvxAJoIbtxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32D0100726C;
 Fri,  7 Feb 2020 13:15:55 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C530F1001B28;
 Fri,  7 Feb 2020 13:15:50 +0000 (UTC)
Date: Fri, 7 Feb 2020 14:15:47 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 11/14] arm/arm64: ITS: INT functional
 tests
Message-ID: <20200207131547.rlj44nwu32xa4tyd@kamzik.brq.redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-12-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128103459.19413-12-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Tue, Jan 28, 2020 at 11:34:56AM +0100, Eric Auger wrote:
> Triggers LPIs through the INT command.
> 
> the test checks the LPI hits the right CPU and triggers
> the right LPI intid, ie. the translation is correct.
> 
> Updates to the config table also are tested, along with inv
> and invall commands.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - add comments
> - keep the report_skip in case there aren't 4 vcpus to be able to
>   run other tests in the its category.
> - fix the prefix pop
> - move its_event and its_stats to arm/gic.c
> ---
>  arm/gic.c         | 228 +++++++++++++++++++++++++++++++++++++++++++---
>  arm/unittests.cfg |   7 ++
>  2 files changed, 224 insertions(+), 11 deletions(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index 4d7dd03..50104b1 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -160,6 +160,87 @@ static void ipi_handler(struct pt_regs *regs __unused)
>  	}
>  }
>  
> +static void setup_irq(handler_t handler)
> +{
> +	gic_enable_defaults();
> +#ifdef __arm__
> +	install_exception_handler(EXCPTN_IRQ, handler);
> +#else
> +	install_irq_handler(EL1H_IRQ, handler);
> +#endif
> +	local_irq_enable();
> +}
> +
> +#if defined(__aarch64__)
> +struct its_event {
> +	int cpu_id;
> +	int lpi_id;
> +};
> +
> +struct its_stats {
> +	struct its_event expected;
> +	struct its_event observed;
> +};
> +
> +static struct its_stats lpi_stats;
> +
> +static void lpi_handler(struct pt_regs *regs __unused)
> +{
> +	u32 irqstat = gic_read_iar();
> +	int irqnr = gic_iar_irqnr(irqstat);
> +
> +	gic_write_eoir(irqstat);
> +	if (irqnr < 8192)
> +		report(false, "Unexpected non LPI interrupt received");

report_info

> +	smp_rmb(); /* pairs with wmb in lpi_stats_expect */
> +	lpi_stats.observed.cpu_id = smp_processor_id();
> +	lpi_stats.observed.lpi_id = irqnr;
> +	smp_wmb(); /* pairs with rmb in check_lpi_stats */
> +}
> +
> +static void lpi_stats_expect(int exp_cpu_id, int exp_lpi_id)
> +{
> +	lpi_stats.expected.cpu_id = exp_cpu_id;
> +	lpi_stats.expected.lpi_id = exp_lpi_id;
> +	lpi_stats.observed.cpu_id = -1;
> +	lpi_stats.observed.lpi_id = -1;
> +	smp_wmb(); /* pairs with rmb in handler */
> +}
> +
> +static void check_lpi_stats(void)

static void check_lpi_stats(const char *testname)
{
   bool pass = false;

> +{
> +	mdelay(100);
> +	smp_rmb(); /* pairs with wmb in lpi_handler */
> +	if ((lpi_stats.observed.cpu_id != lpi_stats.expected.cpu_id) ||
> +	    (lpi_stats.observed.lpi_id != lpi_stats.expected.lpi_id)) {

nit: extra ()

> +		if (lpi_stats.observed.cpu_id == -1 &&
> +		    lpi_stats.observed.lpi_id == -1) {
> +			report(false,
> +			       "No LPI received whereas (cpuid=%d, intid=%d) "
> +			       "was expected", lpi_stats.expected.cpu_id,
> +			       lpi_stats.expected.lpi_id);

report_info

> +		} else {
> +			report(false, "Unexpected LPI (cpuid=%d, intid=%d)",
> +			       lpi_stats.observed.cpu_id,
> +			       lpi_stats.observed.lpi_id);

report_info

> +		}

pass = false;

> +	} else if (lpi_stats.expected.lpi_id != -1) {
> +		report(true, "LPI %d on CPU %d", lpi_stats.observed.lpi_id,
> +		       lpi_stats.observed.cpu_id);

report_info

> +	} else {
> +		report(true, "no LPI received, as expected");

report_info


> +	}

report(pass, "%s", testname);

> +}
> +
> +static void secondary_lpi_test(void)
> +{
> +	setup_irq(lpi_handler);
> +	cpumask_set_cpu(smp_processor_id(), &ready);
> +	while (1)
> +		wfi();
> +}
> +#endif
> +
>  static void gicv2_ipi_send_self(void)
>  {
>  	writel(2 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
> @@ -217,17 +298,6 @@ static void ipi_test_smp(void)
>  	report_prefix_pop();
>  }
>  
> -static void setup_irq(handler_t handler)
> -{
> -	gic_enable_defaults();
> -#ifdef __arm__
> -	install_exception_handler(EXCPTN_IRQ, handler);
> -#else
> -	install_irq_handler(EL1H_IRQ, handler);
> -#endif
> -	local_irq_enable();
> -}
> -
>  static void ipi_send(void)
>  {
>  	setup_irq(ipi_handler);
> @@ -522,6 +592,7 @@ static void gic_test_mmio(void)
>  #if defined(__arm__)
>  
>  static void test_its_introspection(void) {}
> +static void test_its_trigger(void) {}
>  
>  #else /* __arch64__ */
>  
> @@ -561,6 +632,137 @@ static void test_its_introspection(void)
>  	report_info("collection baser entry_size = 0x%x", coll_baser->esz);
>  }
>  
> +static bool its_prerequisites(int nb_cpus)
> +{
> +	int cpu;
> +
> +	if (!gicv3_its_base()) {
> +		report_skip("No ITS, skip ...");
> +		return true;
> +	}
> +
> +	if (nr_cpus < 4) {

nr_cpus < nb_cpus, or just drop the nb_cpus parameter and hard code 4
here.

> +		report_skip("Test requires at least %d vcpus", nb_cpus);
> +		return true;
> +	}
> +
> +	stats_reset();
> +
> +	setup_irq(lpi_handler);
> +
> +	for_each_present_cpu(cpu) {
> +		if (cpu == 0)
> +			continue;
> +		smp_boot_secondary(cpu, secondary_lpi_test);
> +	}
> +	wait_on_ready();
> +
> +	its_enable_defaults();
> +
> +	lpi_stats_expect(-1, -1);
> +	check_lpi_stats();
> +
> +	return false;

Reverse logic. I'd expect 'return true' for success.

> +}
> +
> +static void test_its_trigger(void)
> +{
> +	struct its_collection *col3, *col2;
> +	struct its_device *dev2, *dev7;
> +
> +	if (its_prerequisites(4))

if (!its_prerequisites(...))

> +		return;
> +
> +	dev2 = its_create_device(2 /* dev id */, 8 /* nb_ites */);
> +	dev7 = its_create_device(7 /* dev id */, 8 /* nb_ites */);
> +
> +	col3 = its_create_collection(3 /* col id */, 3/* target PE */);
> +	col2 = its_create_collection(2 /* col id */, 2/* target PE */);
> +
> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
> +	gicv3_lpi_set_config(8196, LPI_PROP_DEFAULT);
> +
> +	its_send_invall(col2);
> +	its_send_invall(col3);
> +
> +	report_prefix_push("int");
> +	/*
> +	 * dev=2, eventid=20  -> lpi= 8195, col=3
> +	 * dev=7, eventid=255 -> lpi= 8196, col=2
> +	 * Trigger dev2, eventid=20 and dev7, eventid=255
> +	 * Check both LPIs hit
> +	 */
> +
> +	its_send_mapd(dev2, true);
> +	its_send_mapd(dev7, true);
> +
> +	its_send_mapc(col3, true);
> +	its_send_mapc(col2, true);
> +
> +	its_send_mapti(dev2, 8195 /* lpi id */,
> +		       20 /* event id */, col3);
> +	its_send_mapti(dev7, 8196 /* lpi id */,
> +		       255 /* event id */, col2);

No need for line breaks, with the embedded comments it's hard to read

> +
> +	lpi_stats_expect(3, 8195);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats();
> +
> +	lpi_stats_expect(2, 8196);
> +	its_send_int(dev7, 255);
> +	check_lpi_stats();
> +
> +	report_prefix_pop();

I think a table of parameters and loop would be nicer than all the
repeated function calls.

> +
> +	report_prefix_push("inv/invall");
> +
> +	/*
> +	 * disable 8195, check dev2/eventid=20 does not trigger the
> +	 * corresponding LPI
> +	 */
> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT & ~0x1);

LPI_PROP_DEFAULT & ~LPI_PROP_ENABLED

> +	its_send_inv(dev2, 20);
> +
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats();
> +
> +	/*
> +	 * re-enable the LPI but willingly do not call invall
> +	 * so the change in config is not taken into account.
> +	 * The LPI should not hit
> +	 */
> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats();
> +
> +	/* Now call the invall and check the LPI hits */
> +	its_send_invall(col3);
> +	lpi_stats_expect(3, 8195);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats();
> +
> +	report_prefix_pop();

Need blank line here.

> +	/*
> +	 * Unmap device 2 and check the eventid 20 formerly
> +	 * attached to it does not hit anymore
> +	 */
> +	report_prefix_push("mapd valid=false");

Above you have the prefix-push before the comment explaining the test.
After is probably better, but whatever, as long as it's consistent.

> +	its_send_mapd(dev2, false);
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats();
> +	report_prefix_pop();
> +
> +	/* Unmap the collection this time and check no LPI does hit */
> +	report_prefix_push("mapc valid=false");
> +	its_send_mapc(col2, false);
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev7, 255);
> +	check_lpi_stats();
> +	report_prefix_pop();
> +}
>  #endif
>  
>  int main(int argc, char **argv)
> @@ -594,6 +796,10 @@ int main(int argc, char **argv)
>  		report_prefix_push(argv[1]);
>  		gic_test_mmio();
>  		report_prefix_pop();
> +	} else if (!strcmp(argv[1], "its-trigger")) {
> +		report_prefix_push(argv[1]);
> +		test_its_trigger();
> +		report_prefix_pop();
>  	} else if (strcmp(argv[1], "its-introspection") == 0) {
>  		report_prefix_push(argv[1]);
>  		test_its_introspection();
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index ba2b31b..bfafec5 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -129,6 +129,13 @@ extra_params = -machine gic-version=3 -append 'its-introspection'
>  groups = its
>  arch = arm64
>  
> +[its-trigger]
> +file = gic.flat
> +smp = $MAX_SMP
> +extra_params = -machine gic-version=3 -append 'its-trigger'
> +groups = its
> +arch = arm64
> +
>  # Test PSCI emulation
>  [psci]
>  file = psci.flat
> -- 
> 2.20.1
>

Thanks,
drew 


