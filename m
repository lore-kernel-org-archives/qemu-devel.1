Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB50C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD832075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnHmfXc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD832075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtz3N-0002w7-Ml
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtz2O-0002Lf-P5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:50:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58681
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtz2N-0007ql-9n
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594410621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bu762bAt6ancOo0D8yW2M5mylzUvStKHJZxz0iX1nX0=;
 b=CnHmfXc8B9yqTg6vikpDZwr0atqYngJBZtFthzHXXaiaWkMqAFpBWdjbE2v5rYlS0oJkH8
 JCx5O8wdbmCr2Qih5JLIW2VsOSQCyX+KG96A1iF59WTxFdfIfJZE6cKq+a5q/0rT90yzYv
 1zXLaZbyzyBiIoA4kSi2VXsuxldL9G4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-Dohp9c58PruyWu9q0AX2HQ-1; Fri, 10 Jul 2020 15:50:18 -0400
X-MC-Unique: Dohp9c58PruyWu9q0AX2HQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAF6C8027EB;
 Fri, 10 Jul 2020 19:50:16 +0000 (UTC)
Received: from localhost (unknown [10.40.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF71278A5A;
 Fri, 10 Jul 2020 19:50:00 +0000 (UTC)
Date: Fri, 10 Jul 2020 21:49:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 19/20] tests/acpi: add microvm test
Message-ID: <20200710214958.36978f12@redhat.com>
In-Reply-To: <20200707125356.32450-20-kraxel@redhat.com>
References: <20200707125356.32450-1-kraxel@redhat.com>
 <20200707125356.32450-20-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  7 Jul 2020 14:53:55 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 24b715dce780..b5b98d5c0742 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1007,6 +1007,20 @@ static void test_acpi_virt_tcg_memhp(void)
>  
>  }
>  
> +static void test_acpi_microvm_tcg(void)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = "microvm";

> +    data.required_struct_types = base_required_struct_types;
> +    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
I vaguely recall this belongs to smbios tables, does actually microvm provide them?

> +    data.blkdev = "virtio-blk-device";
> +    test_acpi_one(" -machine microvm,acpi=on,rtc=off",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_virt_tcg_numamem(void)
>  {
>      test_data data = {
> @@ -1118,6 +1132,7 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
>          qtest_add_func("acpi/piix4/acpihmat", test_acpi_piix4_tcg_acpi_hmat);
>          qtest_add_func("acpi/q35/acpihmat", test_acpi_q35_tcg_acpi_hmat);
> +        qtest_add_func("acpi/microvm", test_acpi_microvm_tcg);
>      } else if (strcmp(arch, "aarch64") == 0) {
>          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>          qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);


