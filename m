Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5E1C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B6F20715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0aGfumH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B6F20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04I9-0000XS-JS
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j04HJ-0007fp-VZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j04HI-0006ZU-Cq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:06:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22899
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j04HI-0006ZB-7o
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581084399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ANWr1J4B+2ekgdtAkoqM5ghV0In7jIKf11OTWBZkeY=;
 b=A0aGfumH6T6xZA385aAbrY4xgPy0VspRKkrwqUqJATTA/AFDA/B7S56gCOBQsWspSu2thx
 5PKvl8lXbyLDDZfNWcy1WZ1zpHrEBsWNsm40xqvddNmVr8QOD8Ol6go1wl+QZVtntEpiC4
 6T3FR3JIP25AiFhb0qsYggMr4xSs7Rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-A3Xp7amqMniKgguMD0pKew-1; Fri, 07 Feb 2020 09:06:37 -0500
X-MC-Unique: A3Xp7amqMniKgguMD0pKew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D10800D54;
 Fri,  7 Feb 2020 14:06:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57A521001281;
 Fri,  7 Feb 2020 14:06:29 +0000 (UTC)
Date: Fri, 7 Feb 2020 15:06:27 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 14/14] arm/arm64: ITS: pending table
 migration test
Message-ID: <20200207140627.rikkw5coe7naxssb@kamzik.brq.redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-15-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128103459.19413-15-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Tue, Jan 28, 2020 at 11:34:59AM +0100, Eric Auger wrote:
> Add two new migration tests. One testing the migration of
> a topology where collection were unmapped. The second test
> checks the migration of the pending table.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - tests belong to both its and migration groups
> ---
>  arm/gic.c         | 150 ++++++++++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg |  16 +++++
>  2 files changed, 166 insertions(+)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index fa8626a..ec3dd3a 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -195,6 +195,7 @@ static void lpi_handler(struct pt_regs *regs __unused)
>  	smp_rmb(); /* pairs with wmb in lpi_stats_expect */
>  	lpi_stats.observed.cpu_id = smp_processor_id();
>  	lpi_stats.observed.lpi_id = irqnr;
> +	acked[lpi_stats.observed.cpu_id]++;
>  	smp_wmb(); /* pairs with rmb in check_lpi_stats */
>  }
>  
> @@ -239,6 +240,18 @@ static void secondary_lpi_test(void)
>  	while (1)
>  		wfi();
>  }
> +
> +static void check_lpi_hits(int *expected)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_cpus; i++) {
> +		if (acked[i] != expected[i])
> +			report(false, "expected %d LPIs on PE #%d, %d observed",
> +			       expected[i], i, acked[i]);

report_info
pass = false

> +		}
> +	report(true, "check LPI on all vcpus");

report(pass, ...);

> +}
>  #endif
>  
>  static void gicv2_ipi_send_self(void)
> @@ -594,6 +607,8 @@ static void gic_test_mmio(void)
>  static void test_its_introspection(void) {}
>  static void test_its_trigger(void) {}
>  static void test_its_migration(void) {}
> +static void test_migrate_unmapped_collection(void) {}
> +static void test_its_pending_migration(void) {}

I'm not sure what's worse. This pile of stubs or one #ifdef in main()
wrapping all the calls.

>  
>  #else /* __arch64__ */
>  
> @@ -666,6 +681,18 @@ static bool its_prerequisites(int nb_cpus)
>  	return false;
>  }
>  
> +static void set_lpi(struct its_device *dev, u32 eventid, u32 physid,
> +		    struct its_collection *col)
> +{
> +	if (!dev || !col)

I don't think col can be null, and this doesn't look like the right place
to check if dev is null.  If we're bothiner to call set_lpi, then I
think we should already expect dev to be good to go.

> +		report_abort("wrong device or collection");
> +
> +	its_send_mapti(dev, physid, eventid, col);
> +
> +	gicv3_lpi_set_config(physid, LPI_PROP_DEFAULT);
> +	its_send_invall(col);
> +}
> +
>  /*
>   * Setup the configuration for those mappings:
>   * dev_id=2 event=20 -> vcpu 3, intid=8195
> @@ -806,6 +833,121 @@ static void test_its_migration(void)
>  	its_send_int(dev7, 255);
>  	check_lpi_stats();
>  }
> +
> +static void test_migrate_unmapped_collection(void)
> +{
> +	struct its_collection *col;
> +	struct its_device *dev2, *dev7;
> +	u8 config;
> +
> +	if (its_setup1())
> +		return;
> +
> +	col = its_create_collection(nr_cpus - 1, nr_cpus - 1);
> +	dev2 = its_get_device(2);
> +	dev7 = its_get_device(7);
> +
> +	/* MAPTI with the collection unmapped */
> +	set_lpi(dev2, 0, 8192, col);
> +
> +	puts("Now migrate the VM, then press a key to continue...\n");
> +	(void)getchar();
> +	report(true, "Migration complete");

report_info

> +
> +	/* on the destination, map the collection */
> +	its_send_mapc(col, true);
> +
> +	lpi_stats_expect(2, 8196);
> +	its_send_int(dev7, 255);
> +	check_lpi_stats();
> +
> +	config = gicv3_lpi_get_config(8192);
> +	report(config == LPI_PROP_DEFAULT,
> +	       "Config of LPI 8192 was properly migrated");
> +
> +	lpi_stats_expect(nr_cpus - 1, 8192);
> +	its_send_int(dev2, 0);
> +	check_lpi_stats();
> +
> +	/* unmap the collection */
> +	its_send_mapc(col, false);
> +
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 0);
> +	check_lpi_stats();
> +
> +	/* remap event 0 onto lpiid 8193 */
> +	set_lpi(dev2, 0, 8193, col);
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 0);
> +	check_lpi_stats();
> +
> +	/* remap the collection */
> +	its_send_mapc(col, true);
> +	lpi_stats_expect(nr_cpus - 1, 8193);
> +}
> +
> +static void test_its_pending_migration(void)
> +{
> +	struct its_device *dev;
> +	struct its_collection *collection[2];
> +	int expected[NR_CPUS];

expected = malloc(nr_cpus * sizeof(int));

I know there are other places using NR_CPUS right now that don't have to,
but we shouldn't add more. Eventually I'll change the other places too.

> +	u64 pendbaser;
> +	void *ptr;
> +	int i;
> +
> +	if (its_prerequisites(4))
> +		return;
> +
> +	dev = its_create_device(2 /* dev id */, 8 /* nb_ites */);
> +	its_send_mapd(dev, true);
> +
> +	collection[0] = its_create_collection(nr_cpus - 1, nr_cpus - 1);
> +	collection[1] = its_create_collection(nr_cpus - 2, nr_cpus - 2);
> +	its_send_mapc(collection[0], true);
> +	its_send_mapc(collection[1], true);
> +
> +	/* disable lpi at redist level */
> +	gicv3_lpi_rdist_ctrl(nr_cpus - 1, false);
> +	gicv3_lpi_rdist_ctrl(nr_cpus - 2, false);
> +
> +	/* even lpis are assigned to even cpu */
> +	for (i = 0; i < 256; i++) {
> +		struct its_collection *col = i % 2 ? collection[0] :
> +						     collection[1];
> +		int vcpu = col->target_address >> 16;

I'm lost with the even/odd (nr_cpus - 1)/(nr_cpus - 2) stuff, and won't
it swap if nr_cpus is odd vs. even?

Shouldn't we just have something like

  pe1 = nr_cpus - 1;
  pe2 = nr_cpus - 2;
  col1 = its_create_collection(pe1, pe1);
  col2 = its_create_collection(pe2, pe2);

without mentioning even and odd?

> +
> +		its_send_mapti(dev, 8192 + i, i, col);
> +		gicv3_lpi_set_config(8192 + i, LPI_PROP_DEFAULT);
> +		gicv3_lpi_set_pending_table_bit(vcpu, 8192 + i, true);
> +	}
> +	its_send_invall(collection[0]);
> +	its_send_invall(collection[1]);
> +
> +	/* Set the PTZ bit on each pendbaser */
> +
> +	expected[nr_cpus - 1] = 128;
> +	expected[nr_cpus - 2] = 128;
> +
> +	ptr = gicv3_data.redist_base[nr_cpus - 1] + GICR_PENDBASER;
> +	pendbaser = readq(ptr);
> +	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
> +
> +	ptr = gicv3_data.redist_base[nr_cpus - 2] + GICR_PENDBASER;
> +	pendbaser = readq(ptr);
> +	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
> +
> +	gicv3_lpi_rdist_ctrl(nr_cpus - 1, true);
> +	gicv3_lpi_rdist_ctrl(nr_cpus - 2, true);
> +
> +	puts("Now migrate the VM, then press a key to continue...\n");
> +	(void)getchar();
> +	report(true, "Migration complete");

report_info

> +
> +	mdelay(1000);

This delay needs a comment explaining why it's here.

> +
> +	check_lpi_hits(expected);
> +}
>  #endif
>  
>  int main(int argc, char **argv)
> @@ -847,6 +989,14 @@ int main(int argc, char **argv)
>  		report_prefix_push(argv[1]);
>  		test_its_migration();
>  		report_prefix_pop();
> +	} else if (!strcmp(argv[1], "its-pending-migration")) {
> +		report_prefix_push(argv[1]);
> +		test_its_pending_migration();
> +		report_prefix_pop();
> +	} else if (!strcmp(argv[1], "its-migrate-unmapped-collection")) {
> +		report_prefix_push(argv[1]);
> +		test_migrate_unmapped_collection();
> +		report_prefix_pop();
>  	} else if (strcmp(argv[1], "its-introspection") == 0) {
>  		report_prefix_push(argv[1]);
>  		test_its_introspection();
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index 8b8ec79..d917157 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -144,6 +144,22 @@ extra_params = -machine gic-version=3 -append 'its-migration'
>  groups = its migration
>  arch = arm64
>  
> +[its-pending-migration]
> +file = gic.flat
> +smp = $MAX_SMP
> +accel = kvm
> +extra_params = -machine gic-version=3 -append 'its-pending-migration'
> +groups = its migration
> +arch = arm64
> +
> +[its-migrate-unmapped-collection]
> +file = gic.flat
> +smp = $MAX_SMP
> +accel = kvm
> +extra_params = -machine gic-version=3 -append 'its-migrate-unmapped-collection'
> +groups = its migration
> +arch = arm64
> +
>  # Test PSCI emulation
>  [psci]
>  file = psci.flat
> -- 
> 2.20.1
> 
>

Thanks,
drew 


