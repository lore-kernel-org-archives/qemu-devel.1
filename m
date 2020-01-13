Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA3C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC281206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieuvtBxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC281206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3Pn-00047u-3M
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ir3P4-0003hH-C5
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ir3P2-0005z8-Ee
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:21:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ir3P2-0005xs-AG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578936083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0XkcfwbLbTxexmf9zve6b529lGv2sL04AzlNOtnKRyc=;
 b=ieuvtBxJ1WIRzz4G3h/oc9skPax8P+dWqM17hiMfWMDjZuK6rpn/nGgWkstuyKGT8UrceZ
 8LqA2IF7Xhi2xC8aeS+zN4uf8bUT7pyOXTUoYRtorDwKn5738iVPLJResTayniUglA4Kby
 P7ZwZVsMUrCxfZ5m4LqVeGoTK2JfiDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-Z6U0HnzSMdiwh647B2R61w-1; Mon, 13 Jan 2020 12:21:20 -0500
X-MC-Unique: Z6U0HnzSMdiwh647B2R61w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E923D10054E3;
 Mon, 13 Jan 2020 17:21:17 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F92B60BF1;
 Mon, 13 Jan 2020 17:21:12 +0000 (UTC)
Date: Mon, 13 Jan 2020 18:21:10 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 06/16] arm/arm64: ITS: Test BASER
Message-ID: <20200113172110.27p3bgozit6djf7k@kamzik.brq.redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
 <20200110145412.14937-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145412.14937-7-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

On Fri, Jan 10, 2020 at 03:54:02PM +0100, Eric Auger wrote:
> Add helper routines to parse and set up BASER registers.
> Add a new test dedicated to BASER<n> accesses.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - remove everything related to memory attributes
> - s/dev_baser/coll_baser/ in report_info
> - add extra line
> - removed index filed in its_baser
> ---
>  arm/gic.c                | 21 ++++++++++-
>  arm/unittests.cfg        |  6 +++
>  lib/arm/asm/gic-v3-its.h | 14 +++++++
>  lib/arm/gic-v3-its.c     | 80 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 120 insertions(+), 1 deletion(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index adeb981..3597ac3 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -531,11 +531,26 @@ static void test_its_introspection(void)
>  		    typer->collid_bits);
>  	report(typer->eventid_bits && typer->deviceid_bits &&
>  	       typer->collid_bits, "ID spaces");
> -	report(!typer->hw_collections, "collections only in ext memory");
>  	report_info("Target address format %s",
>  			typer->pta ? "Redist basse address" : "PE #");
>  }
>  
> +static void test_its_baser(void)
> +{
> +	struct its_baser *dev_baser, *coll_baser;
> +
> +	if (!gicv3_its_base()) {
> +		report_skip("No ITS, skip ...");
> +		return;
> +	}
> +
> +	dev_baser = its_lookup_baser(GITS_BASER_TYPE_DEVICE);
> +	coll_baser = its_lookup_baser(GITS_BASER_TYPE_COLLECTION);
> +	report(dev_baser && coll_baser, "detect device and collection BASER");
> +	report_info("device baser entry_size = 0x%x", dev_baser->esz);
> +	report_info("collection baser entry_size = 0x%x", coll_baser->esz);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	if (!gic_init()) {
> @@ -571,6 +586,10 @@ int main(int argc, char **argv)
>  		report_prefix_push(argv[1]);
>  		test_its_introspection();
>  		report_prefix_pop();
> +	} else if (strcmp(argv[1], "its-baser") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_its_baser();
> +		report_prefix_pop();
>  	} else {
>  		report_abort("Unknown subtest '%s'", argv[1]);
>  	}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index bd20460..2234a0f 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -128,6 +128,12 @@ smp = $MAX_SMP
>  extra_params = -machine gic-version=3 -append 'its-introspection'
>  groups = its
>  
> +[its-baser]
> +file = gic.flat
> +smp = $MAX_SMP
> +extra_params = -machine gic-version=3 -append 'its-baser'
> +groups = its

Do these tests need to be run separately from the its-introspection tests
for some reason? If not, then I'd combine them.

Thanks,
drew


