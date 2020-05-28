Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2C2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18CA215A4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRhlZDa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18CA215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHDw-0006JQ-22
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeHCu-0005iv-C3
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:00:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeHCs-0004Pp-Es
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590667217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Rxh2h2hSr9D6priQvYcc5MMy17vDMzXvGGSx6ycb+l4=;
 b=bRhlZDa1D/q+/eoWtJChG8zyWbu46s78wBz8ORmW4hXQ/Izkel0EfvthjdUs6ih02PMLnB
 caxg9xxFbeYqHkHvOQbN26exsOkHNDJ8t/XXoSoM1jW6TiCxgyLtfKWlVBeVcgs4PlVpz3
 lzsobsvgnYP4y/FXphEhsOBXdIkNeHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-n5-llKG0N2KB-KmOlh99Gg-1; Thu, 28 May 2020 08:00:15 -0400
X-MC-Unique: n5-llKG0N2KB-KmOlh99Gg-1
Received: by mail-wr1-f71.google.com with SMTP id l1so8833309wrc.8
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 05:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Rxh2h2hSr9D6priQvYcc5MMy17vDMzXvGGSx6ycb+l4=;
 b=hcl+4yuIUHJrKC+yDUYbVear5c9hHht6R0UDp5ycmtZ4xDn1OcJ5F8oxduZywxdxR5
 YJ0lbmaAM20c57qTTYUhifZCmLTvtG9YZBb0ijxXkOIxjXnYyuU+1SzihyQ+KVsO5ZpY
 o+DA6sFwUJXHqJiRb3iVNVZtzOcYK5cbshufZeC1/I8d2qI259MTFQSXuxqewtVGiw8l
 b1W3wDMLdC0wusA29vSEc8pGkuo8dYQg8vLV46Jv3izO7nPxsjoxlA9mPEFz6h6hRrZE
 0+UqGI5qX1QKk8XfaB8t5vz8fLJYY6EHhdFwJkJT4/vNAfduNEASsv8v59/J/vpjDmy6
 OdqQ==
X-Gm-Message-State: AOAM5307C9xOc/zR6+KrxtpSV06VYw+Xj7qcWCyQKEkBTn8Fd1GWApxW
 O87k0ziMlGDG5MmvfmX1M8U46edLQvePPf5cMyJnlNsGMAFK07BQrSPYIbOH2C6o2ODfq2ywvA+
 6h0rUv4Z5poDo7qc=
X-Received: by 2002:adf:a407:: with SMTP id d7mr3232314wra.368.1590667214142; 
 Thu, 28 May 2020 05:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk7wjTwpsqEx60C6vGP6sinaOPmmbNcLrShVCLoUfJrtLVbdo17Vx3g8O9q6vRNAn41H76QA==
X-Received: by 2002:adf:a407:: with SMTP id d7mr3232292wra.368.1590667213848; 
 Thu, 28 May 2020 05:00:13 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id p16sm5512125wru.27.2020.05.28.05.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 05:00:12 -0700 (PDT)
Subject: Re: [RFC] some semihosting interrogation
To: Fred Konrad <konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <141c5b32-31cd-1a1d-b1aa-692b9002dac9@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <8771e99e-764b-52aa-55c4-a528d0804a34@redhat.com>
Date: Thu, 28 May 2020 14:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <141c5b32-31cd-1a1d-b1aa-692b9002dac9@adacore.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Fred,

On 5/28/20 11:44 AM, Fred Konrad wrote:
> Hi all,
> 
> Just wonderring if there is any reason not to be able to defer
> qemu_semihosting_connect_chardevs a little more to be able to specify
> chardev=serial0?
> 
> Like:
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 6390cf0..9fa1553 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4333,8 +4333,6 @@ void qemu_init(int argc, char **argv, char **envp)
> 
>      qemu_opts_foreach(qemu_find_opts("chardev"),
>                        chardev_init_func, NULL, &error_fatal);
> -    /* now chardevs have been created we may have semihosting to
> connect */
> -    qemu_semihosting_connect_chardevs();
> 
>  #ifdef CONFIG_VIRTFS
>      qemu_opts_foreach(qemu_find_opts("fsdev"),
> @@ -4484,6 +4482,9 @@ void qemu_init(int argc, char **argv, char **envp)
>      if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>          exit(1);
> 
> +    /* now chardevs have been created we may have semihosting to
> connect */
> +    qemu_semihosting_connect_chardevs();

Cc'ing Markus for this part because he had headaches recently moving
things around there; but the change looks.

> +
>      /* If no default VGA is requested, the default is "none".  */
>      if (default_vga) {
>          vga_model = get_default_vga_model(machine_class);
> 
> Also I found out that the trailing \0 is sent to the chardev
> (console.c:copy_user_string) is that expected in case of semihosting?

No, your patch fixes a bug.

> 
> static GString *copy_user_string(CPUArchState *env, target_ulong addr)
> {
>     CPUState *cpu = env_cpu(env);
>     GString *s = g_string_sized_new(128);
>     uint8_t c;
> 
>     do {
>         if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
>             if (c) {
>                 s = g_string_append_c(s, c);
>             }
>         } else {
>             qemu_log_mask(LOG_GUEST_ERROR,
>                           "%s: passed inaccessible address " TARGET_FMT_lx,
>                           __func__, addr);
>             break;
>         }
>     } while (c!=0);
> 
>     return s;
> }
> 
> I can roll out two patches if needed..
> 
> Cheers,
> Fred
> 


