Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591FEC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFDC214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFDC214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60011 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFqp-0008Gt-FW
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:14:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFq5-0007vw-QC
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFq4-00025y-Ts
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:14:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFq4-000250-OF
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:14:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id o189so1628594wmb.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 23:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=PhbYnUtJqeTbY+W8PWkkiFUPpr742ZzZBzeNmbbir1A=;
	b=GYl/CI25+QOOSjvMNukMFtC7KE7BG9yqy/zogj1qdNvszXCL4UNrnuGTSPBptKPA09
	4/qFX5ExRMWftSTAD4mnOe7M+XP6mr7aFoyS8pQmJOKBY2PLaknYYLqSA1pp2C0um4fI
	fSGCutlhIteijHdm5Aio0Qck5BUWXsTXDZOc8CFvJqqg3E7I4vHc5Qs68/gpTxmKlr02
	xeQeH0Vpz7E7XFpdPi9f+dqM1y/pTxQx7v+/vaAmFEAq6Z6NJMSGwOx9Qui8wSjmUZXM
	pS9pSRibuliWeJuF9lzHhXD1rLOykAntSHk+iP2cjovWqksz2rYdq7lPXae7uv+wDRjr
	0F2g==
X-Gm-Message-State: APjAAAWQ0bjFwFmb5ZjhWz6hRI9Q0vPAOeBTJozWvGHeYX/Ph80j1o/N
	opkjAf+UWl8jn/RgaAhAwNVp4g==
X-Google-Smtp-Source: APXvYqzXdj2Mi2ORfDFRi/4HBrgptkTZ67oPDSOQ8BnpepeMMR0QOiyGOb14ESeGnuEq0S0IGgVp3g==
X-Received: by 2002:a1c:3982:: with SMTP id g124mr1577277wma.25.1557296039796; 
	Tue, 07 May 2019 23:13:59 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	g185sm1063258wmf.30.2019.05.07.23.13.58
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 23:13:59 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-8-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f6fa25a9-2ee0-d7c6-c65f-ca4faefe1ffe@redhat.com>
Date: Wed, 8 May 2019 08:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556808723-226478-8-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4 07/15] tests: acpi: move
 boot_sector_init() into x86 tests branch
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
> boot_sector_init() won't be used by arm/virt board, so move it from
> global scope to x86 branch that uses it.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v3:
>   - fix checkpatch errors triggered by moved old code (ident/space/braces)
> ---
>  tests/bios-tables-test.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index e2fc341..4d13a3c 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -788,13 +788,14 @@ int main(int argc, char *argv[])
>      const char *arch = qtest_get_arch();
>      int ret;
>  
> -    ret = boot_sector_init(disk);
> -    if(ret)
> -        return ret;
> -
>      g_test_init(&argc, &argv, NULL);
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        ret = boot_sector_init(disk);
> +        if (ret) {
> +            return ret;
> +        }
> +
>          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
>          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> 

