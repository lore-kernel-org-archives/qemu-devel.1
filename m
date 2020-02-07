Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D762FC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DBE214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMwhOzFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DBE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j041j-0003qA-RO
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j040s-0003A0-QL
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j040q-0003Uj-8S
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:49:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j040p-0003SE-PW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581083378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VOIjXov5kQDUhae9H0DVjH91jtc/2iL9+dlWgbtSNhc=;
 b=LMwhOzFQpFOL5Js3Nj+ZvpQ3bd1yATrbzV0P7/38wGfID89kim+I0oBRvIkOW1dRPA+QTQ
 pV/fxMghKDGvZFdZFkeh3dGypQqSiSdVgb/cAVn98IrObK5skUoR+NpJRTeA5j7XfENF83
 AS4RqUyfRle+Lhyb6fUPEhcK6eZDWoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-iu_i3WB_N92I32utPkPPYg-1; Fri, 07 Feb 2020 08:49:36 -0500
X-MC-Unique: iu_i3WB_N92I32utPkPPYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41E398B7874;
 Fri,  7 Feb 2020 13:49:34 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF79F5E241;
 Fri,  7 Feb 2020 13:49:26 +0000 (UTC)
Date: Fri, 7 Feb 2020 14:49:23 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 13/14] arm/arm64: ITS: migration tests
Message-ID: <20200207134923.4gh5cz2qokuzei2m@kamzik.brq.redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-14-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128103459.19413-14-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Tue, Jan 28, 2020 at 11:34:58AM +0100, Eric Auger wrote:
> This test maps LPIs (populates the device table, the collection table,
> interrupt translation tables, configuration table), migrates and make
> sure the translation is correct on the destination.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arm/gic.c                | 59 ++++++++++++++++++++++++++++++++++++----
>  arm/unittests.cfg        |  8 ++++++
>  lib/arm/asm/gic-v3-its.h |  2 ++
>  lib/arm/gic-v3-its.c     | 22 +++++++++++++++
>  4 files changed, 85 insertions(+), 6 deletions(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index 50104b1..fa8626a 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -593,6 +593,7 @@ static void gic_test_mmio(void)
>  
>  static void test_its_introspection(void) {}
>  static void test_its_trigger(void) {}
> +static void test_its_migration(void) {}
>  
>  #else /* __arch64__ */
>  
> @@ -665,13 +666,19 @@ static bool its_prerequisites(int nb_cpus)
>  	return false;
>  }
>  
> -static void test_its_trigger(void)
> +/*
> + * Setup the configuration for those mappings:
> + * dev_id=2 event=20 -> vcpu 3, intid=8195
> + * dev_id=7 event=255 -> vcpu 2, intid=8196
> + * LPIs ready to hit
> + */
> +static int its_setup1(void)
>  {
>  	struct its_collection *col3, *col2;
>  	struct its_device *dev2, *dev7;
>  
>  	if (its_prerequisites(4))
> -		return;
> +		return -1;

Why not make its_setup1 a bool? Where true means success and false mean
failure?

>  
>  	dev2 = its_create_device(2 /* dev id */, 8 /* nb_ites */);
>  	dev7 = its_create_device(7 /* dev id */, 8 /* nb_ites */);
> @@ -685,14 +692,10 @@ static void test_its_trigger(void)
>  	its_send_invall(col2);
>  	its_send_invall(col3);
>  
> -	report_prefix_push("int");
>  	/*
>  	 * dev=2, eventid=20  -> lpi= 8195, col=3
>  	 * dev=7, eventid=255 -> lpi= 8196, col=2
> -	 * Trigger dev2, eventid=20 and dev7, eventid=255
> -	 * Check both LPIs hit
>  	 */
> -
>  	its_send_mapd(dev2, true);
>  	its_send_mapd(dev7, true);
>  
> @@ -703,6 +706,23 @@ static void test_its_trigger(void)
>  		       20 /* event id */, col3);
>  	its_send_mapti(dev7, 8196 /* lpi id */,
>  		       255 /* event id */, col2);
> +	return 0;
> +}
> +
> +static void test_its_trigger(void)
> +{
> +	struct its_collection *col3, *col2;
> +	struct its_device *dev2, *dev7;
> +
> +	if (its_setup1())
> +		return;
> +
> +	col3 = its_get_collection(3);
> +	col2 = its_get_collection(2);
> +	dev2 = its_get_device(2);
> +	dev7 = its_get_device(7);
> +
> +	report_prefix_push("int");
>  
>  	lpi_stats_expect(3, 8195);
>  	its_send_int(dev2, 20);
> @@ -763,6 +783,29 @@ static void test_its_trigger(void)
>  	check_lpi_stats();
>  	report_prefix_pop();
>  }
> +
> +static void test_its_migration(void)
> +{
> +	struct its_device *dev2, *dev7;
> +
> +	if (its_setup1())
> +		return;
> +
> +	dev2 = its_get_device(2);
> +	dev7 = its_get_device(7);
> +
> +	puts("Now migrate the VM, then press a key to continue...\n");
> +	(void)getchar();
> +	report(true, "Migration complete");

This seems more like a report_info place. If migration fails and
we don't complete we'll never get the report FAIL anyway.

> +
> +	lpi_stats_expect(3, 8195);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats();
> +
> +	lpi_stats_expect(2, 8196);
> +	its_send_int(dev7, 255);
> +	check_lpi_stats();
> +}
>  #endif
>  
>  int main(int argc, char **argv)
> @@ -800,6 +843,10 @@ int main(int argc, char **argv)
>  		report_prefix_push(argv[1]);
>  		test_its_trigger();
>  		report_prefix_pop();
> +	} else if (!strcmp(argv[1], "its-migration")) {
> +		report_prefix_push(argv[1]);
> +		test_its_migration();
> +		report_prefix_pop();
>  	} else if (strcmp(argv[1], "its-introspection") == 0) {
>  		report_prefix_push(argv[1]);
>  		test_its_introspection();
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index bfafec5..8b8ec79 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -136,6 +136,14 @@ extra_params = -machine gic-version=3 -append 'its-trigger'
>  groups = its
>  arch = arm64
>  
> +[its-migration]
> +file = gic.flat
> +smp = $MAX_SMP
> +accel = kvm
> +extra_params = -machine gic-version=3 -append 'its-migration'
> +groups = its migration
> +arch = arm64
> +
>  # Test PSCI emulation
>  [psci]
>  file = psci.flat
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 0e5c5b6..febc2b2 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -151,6 +151,8 @@ extern void its_send_invall(struct its_collection *col);
>  extern void its_send_movi(struct its_device *dev,
>  			  struct its_collection *col, u32 id);
>  extern void its_send_sync(struct its_collection *col);
> +extern struct its_device *its_get_device(u32 id);
> +extern struct its_collection *its_get_collection(u32 id);
>  
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING           (1ULL << 0)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375       (1ULL << 1)
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index c2dcd01..099940e 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -219,3 +219,25 @@ struct its_collection *its_create_collection(u32 col_id, u32 pe)
>  	its_data.nr_collections++;
>  	return new;
>  }
> +
> +struct its_device *its_get_device(u32 id)
> +{
> +	int i;
> +
> +	for (i = 0; i < GITS_MAX_DEVICES; i++) {
> +		if (its_data.devices[i].device_id == id)
> +			return &its_data.devices[i];
> +	}
> +	return NULL;
> +}
> +
> +struct its_collection *its_get_collection(u32 id)
> +{
> +	int i;
> +
> +	for (i = 0; i < GITS_MAX_COLLECTIONS; i++) {
> +		if (its_data.collections[i].col_id == id)
> +			return &its_data.collections[i];
> +	}
> +	return NULL;
> +}

The callers aren't checking for NULL. Should we assert here
or in the caller?

Thanks,
drew


> -- 
> 2.20.1
> 


