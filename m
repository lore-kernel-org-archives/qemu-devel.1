Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF5C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E0A21D41
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhK9TS9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E0A21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHoEv-0001cC-E8
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHoED-0001B6-P8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHoEC-00064k-1k
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600088943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dqHD5wEn/mpaCHDqIYyoPA6gcpbDzByBulcFdmcDgY=;
 b=hhK9TS9gAifuNXiBSTn9taETbtz8BqKau/gegmp77jCxPZ58rNpoDkP2nWJLADtJ8EcKsl
 bt6x8n5uZJotcL74OaOux/NQX4xqVzI2ylK5glFKbA15cVDVA10Wc4Lcj/ylv2zzX5YdfQ
 jeCIoNQPbHWKhjzuDpt3CsDNzvCieog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-aumHyt36NxK-PHJ7nMIxZg-1; Mon, 14 Sep 2020 09:08:34 -0400
X-MC-Unique: aumHyt36NxK-PHJ7nMIxZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BC3418BE164;
 Mon, 14 Sep 2020 13:08:00 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EAE67B7AD;
 Mon, 14 Sep 2020 13:07:53 +0000 (UTC)
Date: Mon, 14 Sep 2020 15:07:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH 7/9] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Message-ID: <20200914150751.50e3ccd7@redhat.com>
In-Reply-To: <20200914144220.2e27d40a@redhat.com>
References: <20200911180755.28409-1-ani@anisinha.ca>
 <20200911180755.28409-7-ani@anisinha.ca>
 <20200914144220.2e27d40a@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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

On Mon, 14 Sep 2020 14:42:20 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 11 Sep 2020 23:37:53 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
> 
> > This change adds a new unit test for the global flag
> > 'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
> > bridges in i440fx. The flag can be used to turn off acpi based hotplug support
> > for all the slots of the pci bus.  
> not true or not clear,
> should be 
>  "turn off acpi based hotplug support on all PCI bridges"
> 
> > Tested on the upstream qemu master branch.  
> Doesn't belong to commit message

with above fixed:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> > 
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  tests/qtest/bios-tables-test.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index d8c7d57557..7632cfe1be 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -754,6 +754,20 @@ static void test_acpi_piix4_root_hotplug(void)
> >      free_test_data(&data);
> >  }
> >  
> > +static void test_acpi_piix4_bridge_hotplug(void)
> > +{
> > +    test_data data;
> > +
> > +    memset(&data, 0, sizeof(data));
> > +    data.machine = MACHINE_PC;
> > +    data.variant = ".hpbridge";
> > +    data.required_struct_types = base_required_struct_types;
> > +    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> > +    test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
> > +                  "-device pci-bridge,chassis_nr=1", &data);
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_q35_tcg(void)
> >  {
> >      test_data data;
> > @@ -1159,6 +1173,7 @@ int main(int argc, char *argv[])
> >          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
> >          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
> >          qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> > +        qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
> >          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> >          qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
> >          qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);  
> 
> 


