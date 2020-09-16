Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E96AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990A8206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/02h5Dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990A8206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIRTR-0006TV-AR
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIRRZ-0005v6-W3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:01:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58179
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIRRV-0003FO-VW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600239683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJwsHq3V5w92Q5Ht4HGhu7xOH/8/vET5wO6QhrdJCiw=;
 b=C/02h5DhgkwOaiaazXdeuJ6m2VivUJjc+8rscEDQxk5l0sy1bQSVMCiWLtbIiGc8oNhCAN
 u7Q+SZ2aLVG4aB42CF8YjbrUthq4AuL0QiRfu5zfgo45MY79MIaEZ7slQ8KeXjogHvhx7S
 nHtqe5LNCWka7d28LWdvlTwyiQbGZi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-9qa4W5p_P2KVft3y_UaXOQ-1; Wed, 16 Sep 2020 03:01:21 -0400
X-MC-Unique: 9qa4W5p_P2KVft3y_UaXOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13DF8801AE2;
 Wed, 16 Sep 2020 07:01:20 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 199235DDB6;
 Wed, 16 Sep 2020 07:01:10 +0000 (UTC)
Date: Wed, 16 Sep 2020 09:01:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v4 07/11] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Message-ID: <20200916090109.1e4b1437@redhat.com>
In-Reply-To: <20200916061335.14045-8-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
 <20200916061335.14045-8-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:37:10
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

On Wed, 16 Sep 2020 11:43:31 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> This change adds a new unit test for the global flag
> 'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
> bridges in i440fx. The flag can be used to turn off acpi based hotplug support
> for all pci bridges.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  tests/qtest/bios-tables-test.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index d8c7d57557..7632cfe1be 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -754,6 +754,20 @@ static void test_acpi_piix4_root_hotplug(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_piix4_bridge_hotplug(void)
s/bridge_hotplug/no_bridge_hotplug/

> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = MACHINE_PC;
> +    data.variant = ".hpbridge";
> +    data.required_struct_types = base_required_struct_types;
> +    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> +    test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
> +                  "-device pci-bridge,chassis_nr=1", &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_tcg(void)
>  {
>      test_data data;
> @@ -1159,6 +1173,7 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
>          qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> +        qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
s/brhotplug/no_bridge_hotplug/
or add bridge group and do
s:brhotplug:bridge/hotplug/off:
and move other bridge tests under it

>          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
>          qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
>          qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);


