Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFDF20575
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3R+v/H8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFDF20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGiSF-00064h-5b
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kGiQf-0004oH-8f
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kGiQc-0002mO-7B
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599828320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkikKsRrPxorzud/urJFE+7h/c8rgtsBLA+rgvL/ih0=;
 b=W3R+v/H81jgpqbV6/zfq6Htxzmqum6umXhywBXhjxND3POIukVkgh127xay/N6nIWZ2vhk
 YeTgq/p7wAMfxkBvTIwnuZbJ6DiCHHNU+N4WZPzI6kqpPYxWikVAnGQjZbtY8+9tYSirtS
 bigXhcPhE1DypINuMVcG5zwe/KF25mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-jM0PSWArOLa1NC8fG-qAeQ-1; Fri, 11 Sep 2020 08:45:19 -0400
X-MC-Unique: jM0PSWArOLa1NC8fG-qAeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0984810BBECE;
 Fri, 11 Sep 2020 12:45:18 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EDA2100238C;
 Fri, 11 Sep 2020 12:45:10 +0000 (UTC)
Date: Fri, 11 Sep 2020 14:45:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v1 2/3] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Message-ID: <20200911144509.6c16d081@redhat.com>
In-Reply-To: <448ada27-1a94-44ed-89fa-001a70213ad7@Spark>
References: <20200905103520.12626-1-ani@anisinha.ca>
 <20200905103520.12626-3-ani@anisinha.ca>
 <448ada27-1a94-44ed-89fa-001a70213ad7@Spark>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 08:18:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 22:34:20 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> On Sep 5, 2020, 16:05 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> > This change adds a new unit test for the global flag
> > 'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
> > bridges in i440fx. The flag can be used to turn off acpi based hotplug support
> > for all the slots of the pci bus.
> >
> > Tested on the upstream qemu master branch on top of tag v5.1.0  
> 
> Can someone please review this?
Hi,
Are there other patches of yours,
that should be applied/reviewed before this one?

> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> >
> >
> > ---
> > tests/qtest/bios-tables-test.c | 15 +++++++++++++++
> > 1 file changed, 15 insertions(+)
> >
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index a2c0070306..e52a36e775 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -723,6 +723,20 @@ static void test_acpi_piix4_root_hotplug(void)
> > free_test_data(&data);
> > }
> >
> > +static void test_acpi_piix4_bridge_hotplug(void)
> > +{
> > + test_data data;
> > +
> > + memset(&data, 0, sizeof(data));
> > + data.machine = MACHINE_PC;
> > + data.variant = ".hpbridge";
> > + data.required_struct_types = base_required_struct_types;
> > + data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> > + test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
> > + "-device pci-bridge,chassis_nr=1", &data);
> > + free_test_data(&data);
> > +}
> > +
> > static void test_acpi_q35_tcg(void)
> > {
> > test_data data;
> > @@ -1117,6 +1131,7 @@ int main(int argc, char *argv[])
> > qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
> > qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
> > qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> > + qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
> > qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> > qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
> > qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
> > --
> > 2.17.1
> >  


