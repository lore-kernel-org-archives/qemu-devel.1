Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C77C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6C3218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6C3218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiy8b-00077e-Qi
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiy7J-0005wd-3P
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiy7I-0004Ac-3M
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:33:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiy7G-00049c-BN
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:33:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so4851136wme.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 02:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y8INYuNFwmwLc+0IHNKltXOFBok0xhiloT7Sv1jq5vA=;
 b=UrCz1/iSXZbq5Y45tLi3xAnogAvSXWlhDff56zbVVKlY04hM1CIYwbW0yHL8KZab58
 6UVyC3xtFx1O2TPsaXvtLKMy0RkdAhzO6Z1Jla+PADr4e+1z8CGsfbf5nhOe3p+EBvcd
 7rep7uVDCNo4w41vAWX8bA1peZLDmZa/ZqjHUfNY1eef8+gNtNlgI2HcL7UAYlvGpwx9
 RC6fp3hTgptYAYMRhkspjJYbrAk+7HMu02J5W0dXK5mPcUPe6YVpjzXNXhc7hBfCk+Ji
 +/T1Qa19ySCyrGynxb0WRZLbQFz9NgvH0UZ7vQPs15gqMzZnnLCI75FCFFqIxv3vV44w
 t57A==
X-Gm-Message-State: APjAAAXO3FTsdzaaQNzboyNap7lAQ21AFxwJx/UL1MWut3rzuHQJaUog
 InZ8zcACztsH7saIoHhRRAa1Zw==
X-Google-Smtp-Source: APXvYqxn75CWSe5O46dzvZOOzJqLIRP8+dgBAwfA9Ux4Wtj/c4VaQ6E/uUymEZTz0vgl5HSOoJ2V9w==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr12115022wmh.141.1562232801391; 
 Thu, 04 Jul 2019 02:33:21 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id w14sm3479355wrk.44.2019.07.04.02.33.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 02:33:20 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190704082736.25258-1-imammedo@redhat.com>
 <20190704082736.25258-3-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c553e0b6-95e2-af3c-47b8-7db84f77a532@redhat.com>
Date: Thu, 4 Jul 2019 11:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704082736.25258-3-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: acpi: do not skip tests when
 IASL is not installed
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
Cc: Thomas Huth <thuth@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/19 10:27 AM, Igor Mammedov wrote:
> tests do binary comparition so we can check tables without
> IASL. Move IASL condition right before decompilation step
> and skip it if IASL is not installed.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 13bd166b81..a356ac3489 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -389,6 +389,14 @@ static void test_acpi_asl(test_data *data)
>          all_tables_match = all_tables_match &&
>              test_acpi_find_diff_allowed(exp_sdt);
>  
> +        /*
> +         * don't try to decompile if IASL isn't present, in this case user
> +         * will just 'get binary file mismatch' warnings and test failure
> +         */
> +        if (!iasl) {
> +            continue;
> +        }
> +
>          err = load_asl(data->tables, sdt);
>          asl = normalize_asl(sdt->asl);
>  
> @@ -431,6 +439,11 @@ static void test_acpi_asl(test_data *data)
>          g_string_free(asl, true);
>          g_string_free(exp_asl, true);
>      }
> +    if (!iasl && !all_tables_match) {
> +        fprintf(stderr, "to see ASL diff between mismatched files install IASL,"
> +                " rebuild QEMU from scratch and re-run tests with V=1"
> +                " environment variable set");

I guess remember Thomas asked to use g_printerr() instead of fprintf()
in tests/*.c.

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    }
>      g_assert(all_tables_match);
>  
>      free_test_data(&exp_data);
> @@ -599,7 +612,7 @@ static void test_acpi_one(const char *params, test_data *data)
>  
>      if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
>          dump_aml_files(data, true);
> -    } else if (iasl) {
> +    } else {
>          test_acpi_asl(data);
>      }
>  
> 

