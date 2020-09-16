Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75FE20684
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR8jj9uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75FE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIS0I-0006B6-MD
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIRzR-0005Hp-H6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:36:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIRzL-0007qa-E4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600241782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMTdnwTk+hZQbEsb62KQmWRn++1cofya1jAhr01Iu/U=;
 b=BR8jj9uZezXHXaD6jBiUy+m4p/oOdhWaa4D/WfTQna+5E5FdTgCNaKlwXPMYn3cufPDGRc
 4aDOdd6rHHR2P8ine8VQpPZjgHFAJkvzA/F1hhQWLU633d+/ii3pedTGfxE84aLNyR5iT2
 2tykUvcuZEV8Owqyvex4hORPgrrkn74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-qH9NCGy-OPm7SgK9-UZscg-1; Wed, 16 Sep 2020 03:36:20 -0400
X-MC-Unique: qH9NCGy-OPm7SgK9-UZscg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9A2E8030BD;
 Wed, 16 Sep 2020 07:36:18 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B01067CF5;
 Wed, 16 Sep 2020 07:36:09 +0000 (UTC)
Date: Wed, 16 Sep 2020 09:36:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v4 10/11] tests/acpi: unit test exercizing hotplug off
 for pci root bus & bridge in i440fx
Message-ID: <20200916093608.616a40e1@redhat.com>
In-Reply-To: <20200916061335.14045-11-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
 <20200916061335.14045-11-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, jusual@redhat.com, qemu-devel@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGll?= =?UTF-8?B?dS1EYXVkw6k=?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 11:43:34 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> This change adds a unit test to exercize the case when hotplug is disabled both for
> pci root bus and the pci bridges by passing the following two switches to qemu:
> 
>   -global PIIX4_PM.acpi-root-pci-hotplug=off
>   -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off
> 
> bios-tables-test-allowed-diff.h documents the fact that a new DSDT acpi gold master
> binary blob we need to be added to test this. We will do the actual addition in the
> next patch in the series.



> The following link contains the disassembly of the DSDT table after passing the above
> two switches to qemu: https://pastebin.ubuntu.com/p/WvpYYjpPN8/

put this below --- line, please

> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |  1 +
>  tests/qtest/bios-tables-test.c              | 19 ++++++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..dea61d94f1 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/pc/DSDT.hpbrroot",
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 7632cfe1be..4c834474ad 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -768,6 +768,21 @@ static void test_acpi_piix4_bridge_hotplug(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_piix4_bridge_root_hotplug(void)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = MACHINE_PC;
> +    data.variant = ".hpbrroot";
> +    data.required_struct_types = base_required_struct_types;
> +    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> +    test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off "
> +                  "-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
> +                  "-device pci-bridge,chassis_nr=1", &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_tcg(void)
>  {
>      test_data data;
> @@ -1172,8 +1187,10 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
>          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
> -        qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> +        qtest_add_func("acpi/piix4/roothotplug", test_acpi_piix4_root_hotplug);
>          qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
> +        qtest_add_func("acpi/piix4/disablehp",
> +                       test_acpi_piix4_bridge_root_hotplug);
>          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
>          qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
>          qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);


