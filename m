Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B9C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C84C20721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtRTRokb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C84C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKGun-00065n-9C
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jKGu5-0005YH-BO
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jKGu3-0004JG-Gi
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:38:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58538
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jKGu3-0004IY-Av
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585899490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ShhmZm72SQhR4eIFmmC27wtjg2NRVT2I6JWq3826bM=;
 b=gtRTRokb4+lf8kRy3aO0kg1NW4jTTZw6r3aYXY9Obrw/WLKQQTcXNSPtmrwvea3Fq4n46O
 6lDXJyxn/QfdN+pLu1p85RjZEL0FfzE16EnhrpJPKVEm+zRqYyHFrSo4b2K+mgtLYPU3G/
 nl9Dx7/HoJfRzsUCgnsRJInGeyxa6ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-27GNLgHAPASwY-YYKh5Jsw-1; Fri, 03 Apr 2020 03:38:08 -0400
X-MC-Unique: 27GNLgHAPASwY-YYKh5Jsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B2B38017CE;
 Fri,  3 Apr 2020 07:38:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB9EC99E09;
 Fri,  3 Apr 2020 07:37:57 +0000 (UTC)
Date: Fri, 3 Apr 2020 09:37:54 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH kvm-unit-tests] fixup! arm/arm64: ITS: pending table
 migration test
Message-ID: <20200403073754.6q6njhh25s2zutic@kamzik.brq.redhat.com>
References: <20200402145227.20109-1-eric.auger@redhat.com>
 <20200402180148.490026-1-drjones@redhat.com>
 <a13e00e8-b699-103a-af6c-7807b67f8c70@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a13e00e8-b699-103a-af6c-7807b67f8c70@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On Fri, Apr 03, 2020 at 07:07:10AM +0200, Auger Eric wrote:
> Hi Drew,
> 
> On 4/2/20 8:01 PM, Andrew Jones wrote:
> > [ Without the fix this test would hang, as timeouts don't work with
> >   the migration scripts (yet). Use errata to skip instead of hang. ]
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  arm/gic.c  | 18 ++++++++++++++++--
> >  errata.txt |  1 +
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arm/gic.c b/arm/gic.c
> > index ddf0f9d09b14..c0781f8c2c80 100644
> > --- a/arm/gic.c
> > +++ b/arm/gic.c
> > @@ -12,6 +12,7 @@
> >   * This work is licensed under the terms of the GNU LGPL, version 2.
> >   */
> >  #include <libcflat.h>
> > +#include <errata.h>
> >  #include <asm/setup.h>
> >  #include <asm/processor.h>
> >  #include <asm/delay.h>
> > @@ -812,13 +813,23 @@ static void test_its_migration(void)
> >  	check_lpi_stats("dev7/eventid=255 triggers LPI 8196 on PE #2 after migration");
> >  }
> >  
> > +#define ERRATA_UNMAPPED_COLLECTIONS "ERRATA_8c58be34494b"
> > +
> >  static void test_migrate_unmapped_collection(void)
> >  {
> > -	struct its_collection *col;
> > -	struct its_device *dev2, *dev7;
> > +	struct its_collection *col = NULL;
> > +	struct its_device *dev2 = NULL, *dev7 = NULL;
> > +	bool test_skipped = false;
> >  	int pe0 = 0;
> >  	u8 config;
> >  
> > +	if (!errata(ERRATA_UNMAPPED_COLLECTIONS)) {
> > +		report_skip("Skipping test, as this test hangs without the fix. "
> > +			    "Set %s=y to enable.", ERRATA_UNMAPPED_COLLECTIONS);
> > +		test_skipped = true;
> > +		goto do_migrate;
> out of curiosity why do you still do the migration and not directly return.

That won't work for the same reason the migration failure doesn't work.
The problem is with the migration scripts not completing when a migration
test doesn't successfully migrate. I plan to fix that when I get a bit of
time, and when I do, I'll post a patch removing this errata as well, as
it will no longer be needed to avoid test hangs. Anybody testing on a
kernel without the kernel fix after the migration scripts are fixed will
just get an appropriate FAIL instead.

Thanks,
drew

> 
> Besides, what caused the migration to fail without 8c58be34494b is
> bypassed so:
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> Thank you for the fixup
> 
> Eric
> 
> > +	}
> > +
> >  	if (its_setup1())
> >  		return;
> >  
> > @@ -830,9 +841,12 @@ static void test_migrate_unmapped_collection(void)
> >  	its_send_mapti(dev2, 8192, 0, col);
> >  	gicv3_lpi_set_config(8192, LPI_PROP_DEFAULT);
> >  
> > +do_migrate:
> >  	puts("Now migrate the VM, then press a key to continue...\n");
> >  	(void)getchar();
> >  	report_info("Migration complete");
> > +	if (test_skipped)
> > +		return;
> >  
> >  	/* on the destination, map the collection */
> >  	its_send_mapc(col, true);
> > diff --git a/errata.txt b/errata.txt
> > index 7d6abc2a7bf6..b66afaa9c079 100644
> > --- a/errata.txt
> > +++ b/errata.txt
> > @@ -5,4 +5,5 @@
> >  9e3f7a296940    : 4.9                           : arm64: KVM: pmu: Fix AArch32 cycle counter access
> >  7b6b46311a85    : 4.11                          : KVM: arm/arm64: Emulate the EL1 phys timer registers
> >  6c7a5dce22b3    : 4.12                          : KVM: arm/arm64: fix races in kvm_psci_vcpu_on
> > +8c58be34494b    : 5.6                           : KVM: arm/arm64: vgic-its: Fix restoration of unmapped collections
> >  #---------------:-------------------------------:---------------------------------------------------
> > 
> 
> 


