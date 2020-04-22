Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA2C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B830C2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/TgjExf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B830C2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFaV-0007lq-RC
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFWz-0002Ox-JO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFWz-0000Wr-2T
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:35:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFWy-0000V8-JZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHAB0cua9vWTj2rIbJycC3cf+oUjpag14W6EGNcfepQ=;
 b=O/TgjExf6gnedeN9KhkYGW4q0Hc67mSH3J2QeVMXfUb2PghlIkP4i/uVAgd3xDiZklfabV
 /zzWv/HSuqUR+Y2u1tf3drIk3YVdn/V9kaf/QcYMNXPXBsmGkIpmimcBhTPmG+kBewlk1y
 h4NNJaT7VNsur48wYaH6anod5s5jdxE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-ZYajiTDvOw6_f9i6dvphkA-1; Wed, 22 Apr 2020 09:35:09 -0400
X-MC-Unique: ZYajiTDvOw6_f9i6dvphkA-1
Received: by mail-wr1-f71.google.com with SMTP id 11so1061372wrc.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pHAB0cua9vWTj2rIbJycC3cf+oUjpag14W6EGNcfepQ=;
 b=Bvdw9uGaqT6d2lW/gZ2VuEOfVW2Sj095GjsHOta+lkmWneeyw4yGcH2tu1VXjmhLuY
 ChCP5E5lKx4E2FATf+XaGoXBAegk90UrtQxHRm7gWJ8M/Fer6MoOCghWRH35NoN1Hez+
 R6r589vcMeySZDbGe3sKIoDlSRKYj17C0k5LM0TIK+qRWxb/hejDgrXhvg/A4Ebqi2C6
 YHssQUskC9sMZQU99E/1bnbf7JUcjuhvztQjQKOelp5cwaPhow/BgZn5FN++jnvv/T4d
 cbIw42GzOIZ3wICAQwimQgDgbyMNtsDhDTo7yRn/p53RrqNP/3GtcC0NurHx+aGNl9dm
 DxYw==
X-Gm-Message-State: AGi0PuZAXKC0JYDqLuJCPuDyd0VEk7hWh0kglzMaT3eMRf14PDjb1FGg
 3/2wUNyj92KNtkX1bhJaiW7foTJrU431cVh8NhcMXv7yakMw3YZHitwTXZYgXq9/zj++mn8fdkK
 7FmdiFKxO0i8YOJc=
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr10505141wmc.63.1587562508038; 
 Wed, 22 Apr 2020 06:35:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypKjO9a++rXY9a+neTeUI3Lpn3Umv62oZmGHFKpyLMepF+o/a4A3M9u4oT/zFPadIjoXI8T/vA==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr10505126wmc.63.1587562507888; 
 Wed, 22 Apr 2020 06:35:07 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j68sm8280408wrj.32.2020.04.22.06.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 06:35:07 -0700 (PDT)
Subject: Re: [PATCH v2 12/14] tests/test-logging: Fix test for -dfilter
 0..0xffffffffffffffff
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-13-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b72369a-482c-a32f-648d-050c22dadf2e@redhat.com>
Date: Wed, 22 Apr 2020 15:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422130719.28225-13-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 4/22/20 3:07 PM, Markus Armbruster wrote:
> Fixes: 58e19e6e7914354242a67442d0006f9e31684d1a
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-logging.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-logging.c b/tests/test-logging.c
> index 6387e4933f..8580b82420 100644
> --- a/tests/test-logging.c
> +++ b/tests/test-logging.c
> @@ -73,10 +73,10 @@ static void test_parse_range(void)
>       g_assert(qemu_log_in_addr_range(UINT64_MAX));
>       g_assert_false(qemu_log_in_addr_range(UINT64_MAX - 1));
>   
> -    qemu_set_dfilter_ranges("0..0xffffffffffffffff", &err);
> +    qemu_set_dfilter_ranges("0..0xffffffffffffffff", &error_abort);

Why sometime use this form, ...

>       g_assert(qemu_log_in_addr_range(0));
>       g_assert(qemu_log_in_addr_range(UINT64_MAX));
> -
> +
>       qemu_set_dfilter_ranges("2..1", &err);
>       error_free_or_abort(&err);

... and then this other form?

>   
> 


