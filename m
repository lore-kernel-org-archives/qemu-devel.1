Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC5C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA6F20787
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9u149uI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA6F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38051 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvGg-0002L8-3T
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEvFv-0001PL-Tb
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEvFu-0005Xs-IM
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:30:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEvFu-0005XU-Dm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584624638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvKR+5gfMPOKCtgcftmiYAtC1EXz/tV0uO8Ho7CaiqQ=;
 b=G9u149uI94Up9+wmlyf+nbZnQj0/YMuEDUAxVZXc63BLaB8nJARpEB0gGo5opWwV7cQKyd
 CGwg1miHTlIrEPX/JTSc4yDCOB/3gZrI59Twiy7bowqa6vZ322Lvyx2ilzhLBTU0QRDeHl
 Lwcy+DUZ6+P/O59a0vrrrv7t63pB7oM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-bo1VjekXMzGtLmZH69C12w-1; Thu, 19 Mar 2020 09:30:36 -0400
X-MC-Unique: bo1VjekXMzGtLmZH69C12w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7689E8010EB;
 Thu, 19 Mar 2020 13:30:35 +0000 (UTC)
Received: from localhost (unknown [10.40.208.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 990041001925;
 Thu, 19 Mar 2020 13:30:30 +0000 (UTC)
Date: Thu, 19 Mar 2020 14:30:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v4 2/2] tests/bios-tables-test: add smbios cpu speed test
Message-ID: <20200319143028.491b2f09@redhat.com>
In-Reply-To: <20200318064820.19363-3-guoheyi@huawei.com>
References: <20200318064820.19363-1-guoheyi@huawei.com>
 <20200318064820.19363-3-guoheyi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 14:48:20 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> Add smbios type 4 CPU speed check for we added new options to set
> smbios type 4 "max speed" and "current speed". The default value
> should be 2000 when no option is specified, just as the old version
> did.
> 
> We add the test case to one machine of each architecture, though it
> doesn't really run on aarch64 platform for smbios test can't run on
> uefi only platform yet.
I suggest to drop aarch64 part then as it just wastes resources,
alternatively you can enable smbios tests with UEFI.
(Not sure if uefi already exposes smbios entry point in test structure,
CCing Lazslo)

> 
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> 
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a597bbacf..f2d2e97b4a 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -77,6 +77,8 @@ typedef struct {
>      GArray *tables;
>      uint32_t smbios_ep_addr;
>      struct smbios_21_entry_point smbios_ep_table;
> +    uint16_t smbios_cpu_max_speed;
> +    uint16_t smbios_cpu_curr_speed;
>      uint8_t *required_struct_types;
>      int required_struct_types_len;
>      QTestState *qts;
> @@ -560,6 +562,31 @@ static inline bool smbios_single_instance(uint8_t type)
>      }
>  }
>  
> +static bool smbios_cpu_test(test_data *data, uint32_t addr)
> +{
> +    uint16_t expect_speed[2];
> +    uint16_t real;
> +    int offset[2];
> +    int i;
> +
> +    /* Check CPU speed for backward compatibility */
> +    offset[0] = offsetof(struct smbios_type_4, max_speed);
> +    offset[1] = offsetof(struct smbios_type_4, current_speed);
> +    expect_speed[0] = data->smbios_cpu_max_speed ? : 2000;
> +    expect_speed[1] = data->smbios_cpu_curr_speed ? : 2000;
> +
> +    for (i = 0; i < 2; i++) {
> +        real = qtest_readw(data->qts, addr + offset[i]);
> +        if (real != expect_speed[i]) {
> +            fprintf(stderr, "Unexpected SMBIOS CPU speed: real %u expect %u\n",
> +                    real, expect_speed[i]);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static void test_smbios_structs(test_data *data)
>  {
>      DECLARE_BITMAP(struct_bitmap, SMBIOS_MAX_TYPE+1) = { 0 };
> @@ -582,6 +609,10 @@ static void test_smbios_structs(test_data *data)
>          }
>          set_bit(type, struct_bitmap);
>  
> +        if (type == 4) {
> +            g_assert(smbios_cpu_test(data, addr));
> +        }
> +
>          /* seek to end of unformatted string area of this struct ("\0\0") */
>          prv = crt = 1;
>          while (prv || crt) {
> @@ -716,6 +747,11 @@ static void test_acpi_q35_tcg(void)
>      data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
>      test_acpi_one(NULL, &data);
>      free_test_data(&data);
> +
> +    data.smbios_cpu_max_speed = 3000;
> +    data.smbios_cpu_curr_speed = 2600;
> +    test_acpi_one("-smbios type=4,max-speed=3000,current-speed=2600", &data);
> +    free_test_data(&data);
>  }
>  
>  static void test_acpi_q35_tcg_bridge(void)
> @@ -1017,6 +1053,12 @@ static void test_acpi_virt_tcg(void)
>  
>      test_acpi_one("-cpu cortex-a57", &data);
>      free_test_data(&data);
> +
> +    data.smbios_cpu_max_speed = 2900;
> +    data.smbios_cpu_curr_speed = 2700;
> +    test_acpi_one("-cpu cortex-a57 "
> +                  "-smbios type=4,max-speed=2900,current-speed=2700", &data);
> +    free_test_data(&data);
>  }
>  
>  int main(int argc, char *argv[])


