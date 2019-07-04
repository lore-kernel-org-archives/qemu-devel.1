Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8CCC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21748218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21748218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiy6M-0004dz-9l
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiy3u-0003ZN-60
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiy3t-00019d-7o
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:29:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiy3t-00019I-1z
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:29:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id u18so5866619wru.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 02:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1cH5hVZBBgoU6awS2hFVrdVSkP9wUsD0YMx2zMptGOM=;
 b=Td+yYCmIfPlOcHTp4q0FYrO3cPOx2/rGQ3JQ2n4xdpKzMwC+bCFW8O2wGf28WJ/jlm
 IY3uNbusv2fRlIKwsmq4T6k7ierhj3d/qnEvAqf4S81sa44ED9a3zVxJ0OkeQF59vm7K
 kC153q9EJ5cCaKQnLUXLkp+cxM0OV1IsN91AKKvnfQnj4uynB/XjKAoXsZmVY4zSOifd
 txhdWY+TjnBZt1D01ZwudDDuf2PPQwRGSGS0yB5ygUmjF7L41thqCNWyNxEAUAIPMK/Y
 GFcZylotRgsbysW2VBG6DExGdNKgP2TZSe/RdaWq61AXNinDKyDincqufaiov04z0Bvz
 Zj9Q==
X-Gm-Message-State: APjAAAWLuggoX5mf2HJ8PQJRTctKUMF61VguMEDBmIgZiefRWUIOVscY
 S7+2yFaXw+Qkec90n1rgiM2Xjw==
X-Google-Smtp-Source: APXvYqwyxRBGg3oMhjbODfynsRuwtBhGnNcvrqaCAasB3hPscUze70VqS2sUeMAEAFPgR8zRC4Fmvg==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr12962812wro.271.1562232591994; 
 Thu, 04 Jul 2019 02:29:51 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id q1sm3314755wmq.25.2019.07.04.02.29.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 02:29:51 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190704082736.25258-1-imammedo@redhat.com>
 <20190704082736.25258-2-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ced2e973-89a6-9376-7f52-6cda84c02af5@redhat.com>
Date: Thu, 4 Jul 2019 11:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704082736.25258-2-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: acpi: do not require IASL for
 dumping AML blobs
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/19 10:27 AM, Igor Mammedov wrote:
> IASL isn't needed when dumping ACPI tables from guest for
> rebuild purposes. So move this part out from IASL branch.
> 
> Makes rebuild-expected-aml.sh work without IASL installed
> on host.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/bios-tables-test.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d863233fe9..13bd166b81 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -597,12 +597,10 @@ static void test_acpi_one(const char *params, test_data *data)
>      test_acpi_rxsdt_table(data);
>      test_acpi_fadt_table(data);
>  
> -    if (iasl) {
> -        if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
> -            dump_aml_files(data, true);
> -        } else {
> -            test_acpi_asl(data);
> -        }
> +    if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
> +        dump_aml_files(data, true);
> +    } else if (iasl) {
> +        test_acpi_asl(data);
>      }
>  
>      /*
> 

