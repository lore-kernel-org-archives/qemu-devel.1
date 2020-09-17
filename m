Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712FDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DA92083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCyggL+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DA92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoWZ-0000xw-Tx
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIoVQ-000897-K4
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:39:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIoVO-0003b4-Tt
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:39:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id a9so983991wmm.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OokP1xalyCA/WtffjPnoZgbqtMAV4UT7FkD5BcPQiAg=;
 b=hCyggL+poZcpwNirp5yIm8WUnRrGZQlbw4l0NthyVk7nmSMoa3VkuavJdmfqVgBz33
 85wQcZtLaWNw/gPcvaibDsxamkd6gEZERPChToFFVmufO0qK5HezeB5OA9GKvU7Cred2
 Q+gl8LvSQqKxwJA1hgXC19RIfHH+Flrd0rUyFIXk8k1zRAlVRbk5NqU+Ln2HkwPfx8Oc
 +JJwI1cINLEOk7aOx++ziUe4kAHV97+Arbg5isUjxflRlmjzdtLqQDIAJsfXRSJw8QPV
 yQwzBcmeEp8uUEflsHso2iZn/RwqMz64oA1zGeXZayB2tuXACFVyZ0O/uxmM04ldMejs
 Auuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OokP1xalyCA/WtffjPnoZgbqtMAV4UT7FkD5BcPQiAg=;
 b=cNPFP5ODMADTR/jXwS/kT3Ng7/Im3xiwcdlnsy8uOjPotXD1JMAato56omwAESFHHA
 xQLABwjW+ysytCOxbOzrAk+90sn6LuMC+J2sDt6ax/a6K92svfv8Ik5hBdWXkHnZNjUo
 y3rMMlW24EQ70pbVJzr63thWxog4/5Mz8tqwxkQqC9WiuS5M2nT9VNgA85j6MWZw3lEr
 /TNsrer0eIi8zaYMZK6dHKSXzxtL/ehTLjZU7UYTcEb9uIFG68nPDxTWP7LbqzppSQ2y
 qcxZP8hlLpKhYSbuB4YrbXnRA3BUxvaWAA+sBpObv2BuZZLRuKbHUIIYuB8X0M3gh/ZJ
 eweQ==
X-Gm-Message-State: AOAM533Yq5JfXAWRRDOOeYfxLgBljA32VaAu77KKdcrItmrycU5aGjio
 dtwaEM4u18VQxWDiiBukmt8=
X-Google-Smtp-Source: ABdhPJzMQGieLPBgRIYJo9njWVg5NbfdwPCw943wCj9hxwvFHlcw+0bpY91oxoEm+u+SliMHgaq+fw==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr8502650wmc.176.1600328336697; 
 Thu, 17 Sep 2020 00:38:56 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm9632015wme.12.2020.09.17.00.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 00:38:56 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_Why_QEMU_translates_one_instruction_to_a_TB?=
 =?UTF-8?B?77yf?=
To: casmac <climber.cui@qq.com>, qemu-devel <qemu-devel@nongnu.org>
References: <tencent_EAC696641F035EB7E9885302EAAE37455907@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
Message-ID: <386f54c9-0c57-17c2-4dc9-ebc239c1bf9d@amsat.org>
Date: Thu, 17 Sep 2020 09:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <tencent_EAC696641F035EB7E9885302EAAE37455907@qq.com>
Content-Type: text/plain; charset=gb18030
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 8:25 AM, casmac wrote:
> Hi all,
>      We try to add DSP architecure to QEMU 4.2. To load the COFF format
> object file, we have added loader code to load content from
>   the object file. The rom_add_blob() function is used. We firstly
> analyze the COFF file to figure out which sections are chained
>   together(so each chain forms a "memory blob"), and then allocate the
> memory blobs.
>  
>   The psuedo code looks like:
>  
>           for(i=0; i<BADTYPE; i++){
>             if(ary_sect_chain[i].exist)   //there is a chain of sections
> to allocate
>             {
>                 ary_sect_chain[i].mem_region = g_new(MemoryRegion, 1);
>                 memory_region_init_ram(...);
>                 memory_region_add_subregion(sysmem, ....);
>                 rom_add_blob(....);
>             }
>          }

Why do this silly mapping when you know your DSP memory map?

> ------------------------------------------------------
> ok.lds file:
> 
> MEMORY   /* MEMORY directive */
> {
>     ROM:            origin = 000000h    length = 001000h     /* 4K
> 32-bit words on-chip ROM (C31/VC33) */

Per the TI spru031f datasheet, this is external (there is no
on-chip ROM).

I have my doubts there is actually a ROM mapped here...
Is this linkscript used to *test* a BIOS written in SRAM by
some JTAG?

>     /* 256K 32-bit word off-chip SRAM (D.Module.VC33-150-S2) */
>     BIOS:       origin = 001000h      length = 000300h
>     CONF_UTL:   origin = 001300h      length = 000800h
>     FREE:       origin = 001B00h      length = 03F500h  /* 259328 32-bit
> words */
>     RAM_0_1:     origin = 809800h    length = 000800h     /* 2 x 1K
> 32-bit word on-chip SRAM (C31/VC33) */
>     RAM_2_3:     origin = 800000h    length = 008000h     /* 2 x 16K
> 32-bit word on-chip SRAM (VC33 only) */
> }

You probably want to use:

  memory_region_init_ram(&s->extsram, OBJECT(dev), "eSRAM",
                         256 * KiB, &error_fatal);
  memory_region_add_subregion(get_system_memory(),
                              0x000000, &s->extsram);

  memory_region_init_ram(&s->ocsram, OBJECT(dev), "iSRAM",
                         2 * KiB, &error_fatal);
  memory_region_add_subregion(get_system_memory(),
                              0x809800, &s->ocsram);

Then different areas of the object file will be loaded into
the either the iSRAM or the eSRAM.

