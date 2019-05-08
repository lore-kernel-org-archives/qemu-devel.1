Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC799C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835CA214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835CA214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFst-0001c9-M5
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:16:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFrD-0000BD-E2
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFrC-0003CL-9S
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFrC-0003BV-39
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so6240417wre.7
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 23:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=R4pUo8Ju3eURpX7tU2Eh7e28UD3RL8PFRaCjeZ458oM=;
	b=tQGRNcdUa99BmHjbkQzWa97cViUeaAR1FPHjRBR77ZPduLrButoaOFUQwuAl+oEOWd
	7gncbhJ967c3s+HexlZMtCkCMM3ojXrbblO7ezIVHoVOvtCTKDXUH91KB3jCoHPuLqUy
	TVaS8T5pZof7fzItmlW89EiQwWYiUFa3eJ+8QYM/dOotN9bPftCTzjwy5uYcQCYdY0ai
	gpHvC0fPhi6VWjDcHLBaQWyxHmOklSGN9bZPyltv0gRGATXMwzFBQwznKHNdIlJaIMRu
	kWtlRx/Gb4Mq6jeV5PO9j4QfJQRlZzEhTjh6jmONuuQayK0ipevnPXbJW8d+KqzBBr1V
	haow==
X-Gm-Message-State: APjAAAUeHOeQQAvy/0YcGsbmDut7bFUTklARpHoG/3VwbmSN3LutrICc
	CgWdRxLaSbKMPxxw6/hqfdBGPQ==
X-Google-Smtp-Source: APXvYqwvMxw0PZUgcQb+RX+k32eNu2GlcN0vDtFWY3lithZRGxzHd0UclVHnZrd5XflfieBS+jZn+g==
X-Received: by 2002:adf:dccf:: with SMTP id x15mr1284152wrm.139.1557296108987; 
	Tue, 07 May 2019 23:15:08 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id q3sm8269446wrr.16.2019.05.07.23.15.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 23:15:08 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-5-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c5930813-125a-a79b-bfda-d9f816f06f3f@redhat.com>
Date: Wed, 8 May 2019 08:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556808723-226478-5-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v4 04/15] tests: acpi: make pointer to RSDP
 64bit
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
	xuwei5@hisilicon.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/2/19 4:51 PM, Igor Mammedov wrote:
> In case of UEFI, RSDP doesn't have to be located in lowmem,
> it could be placed at any address. Make sure that test won't
> break if it is placed above the first 4Gb of address space.
> 
> PS:
> While at it cleanup some local variables as we don't really
> need them.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v4:
>  - move acpi_fetch_rsdp_table(s/uint32_t addr/uint64_t addr/) to
>    this patch where it belongs from
>    "tests: acpi: make RSDT test routine handle XSDT"
>    (Wei Yang <richardw.yang@linux.intel.com>)
> v2:
>   - s/In case of UEFI/In case of UEFI,/ (Laszlo Ersek <lersek@redhat.com>)
> ---
>  tests/acpi-utils.h       |  2 +-
>  tests/acpi-utils.c       |  2 +-
>  tests/bios-tables-test.c | 10 ++++------
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index f55ccf9..1da6c10 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -46,7 +46,7 @@ typedef struct {
>  
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>  uint32_t acpi_find_rsdp_address(QTestState *qts);
> -void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
> +void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                        const uint8_t *addr_ptr, int addr_size, const char *sig,
>                        bool verify_checksum);
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index a0d49c4..c216b9e 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -51,7 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
>      return off;
>  }
>  
> -void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
> +void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
>  {
>      uint8_t revision;
>  
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d6ab121..a164d27 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -26,7 +26,7 @@
>  typedef struct {
>      const char *machine;
>      const char *variant;
> -    uint32_t rsdp_addr;
> +    uint64_t rsdp_addr;
>      uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
>      GArray *tables;
>      uint32_t smbios_ep_addr;
> @@ -86,13 +86,11 @@ static void test_acpi_rsdp_address(test_data *data)
>  
>  static void test_acpi_rsdp_table(test_data *data)
>  {
> -    uint8_t *rsdp_table = data->rsdp_table, revision;
> -    uint32_t addr = data->rsdp_addr;
> +    uint8_t *rsdp_table = data->rsdp_table;
>  
> -    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
> -    revision = rsdp_table[15 /* Revision offset */];
> +    acpi_fetch_rsdp_table(data->qts, data->rsdp_addr, rsdp_table);
>  
> -    switch (revision) {
> +    switch (rsdp_table[15 /* Revision offset */]) {
>      case 0: /* ACPI 1.0 RSDP */
>          /* With rev 1, checksum is only for the first 20 bytes */
>          g_assert(!acpi_calc_checksum(rsdp_table,  20));
> 

