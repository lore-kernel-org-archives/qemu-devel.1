Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0DBC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 18:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D41204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 18:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D41204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57077 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMGaD-0007rG-JZ
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 14:37:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMGZP-0007SO-Gy
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMGZO-0003rU-FG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hMGZO-0003qy-1z
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D80B3082E60;
	Thu,  2 May 2019 18:36:32 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-207.rdu2.redhat.com
	[10.10.120.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 672EE608A5;
	Thu,  2 May 2019 18:36:25 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-12-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <370545b5-66fb-ed49-bd96-e270dcbdd56b@redhat.com>
Date: Thu, 2 May 2019 20:36:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1556808723-226478-12-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 02 May 2019 18:36:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 11/15] tests: acpi: allow to override
 default accelerator
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, linuxarm@huawei.com,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502183621.I72Vsux0epaPXtrszybAgD0UO7YFNO8MhVLCKv_h6NY@z>

On 05/02/19 16:51, Igor Mammedov wrote:
> By default test cases were run with 'kvm:tcg' accelerators to speed up
> tests execution. While it works for x86, were change of accelerator
> doesn't affect ACPI tables, the approach doesn't works for ARM usecase
> though.
> 
> In arm/virt case, KVM mode requires using 'host' cpu model, which
> isn't available in TCG mode. That could be worked around with 'max'
> cpu model, which works both for KVM and TCG. However in KVM mode it
> is necessary to specify matching GIC version, which also could use
> 'max' value to automatically pick GIC version suitable for host's CPU.
> Depending on host cpu type, different GIC versions would be used,
> which in turn leads to different ACPI tables (APIC) generated.
> As result while comparing with reference blobs, test would fail if
> host's GIC version won't match the version on the host where
> reference blobs where generated.
> 
> Let's keep testing simple for now and allow ARM tests run in TCG only
> mode. To do so introduce 'accel' parameter in test configuration, so
> test case could override default "kvm:tcg" with accelerator of choice.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 8302ffc..39c1e24 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -24,6 +24,7 @@
>  #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
>  
>  typedef struct {
> +    const char *accel;
>      const char *machine;
>      const char *variant;
>      const char *uefi_fl1;
> @@ -532,8 +533,8 @@ static void test_acpi_one(const char *params, test_data *data)
>          args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
>              "-drive if=pflash,format=raw,file=%s,readonly "
>              "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
> -            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
> -            data->cd, params ? params : "");
> +            data->machine, data->accel ? data->accel : "kvm:tcg",
> +            data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
>  
>      } else {
>          /* Disable kernel irqchip to be able to override apic irq0. */
> @@ -541,7 +542,8 @@ static void test_acpi_one(const char *params, test_data *data)
>              "-net none -display none %s "
>              "-drive id=hd0,if=none,file=%s,format=raw "
>              "-device ide-hd,drive=hd0 ",
> -             data->machine, "kvm:tcg", params ? params : "", disk);
> +             data->machine, data->accel ? data->accel : "kvm:tcg",
> +             params ? params : "", disk);
>      }
>  
>      data->qts = qtest_init(args);
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

