Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C64C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B25207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnRLO4pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B25207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIoh-0006gS-D6
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeInn-0005Bc-Rp
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:42:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55814
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeInm-0000qV-2e
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590673348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rlJVqEiH7Fw2PY6F9zDlLiwb9QanHmUIHaflSWvE1+Q=;
 b=CnRLO4pljq7jSL/F1ocRN/8Y0icNkcpk39cO70hovnWyulFd8SA5D/c38/ua8VeBTB9vyK
 /g7pt/J+QvIFGtjh1/U84aCnmJxq49301RKNwcetPRMWcxiv7FKH79dKj0PZmzbXgxeJ0c
 5GAvUX/xjyKti6cIDhseu6Fj1ZT+AWA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-0nn6tL7kPXG9BuAh0bz6rg-1; Thu, 28 May 2020 09:42:26 -0400
X-MC-Unique: 0nn6tL7kPXG9BuAh0bz6rg-1
Received: by mail-wm1-f72.google.com with SMTP id j128so746379wmj.6
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 06:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rlJVqEiH7Fw2PY6F9zDlLiwb9QanHmUIHaflSWvE1+Q=;
 b=QoDDFwGVPN9tUOD+vUYnRtqgJ2brgXvNOFNtGjCna+q2Z4S17S+nXwHDbi1JAdVnWr
 hdJJ7peK1gef1xNVOoDiJThvgNQyKW4065OReEnyA+9RHgQl84VEsW3RvTQwcJ27GPlb
 g7HrFdYe/WFcuLfsgiS0uHyZviWyGjhwbhTKkBR7jMCK5oU/NxaTSvPwUFvkuYKFA0Rn
 9UfQ3Tlr+ykkez2nry9UwtDPBE4fzHDUsPssBvsIqVG8eK7fqhzJEY8S5/fmpM1eS5di
 CAxK5k7NFLWvCa+sk9i4LZ1WG6g83sHY+KLRd5jigUtWgBiQE/TXQich97F0l22eJjUg
 G/zA==
X-Gm-Message-State: AOAM532/oYerDRHFcyglxVTCKUDWdXwQuznVz5C4NyV4psuSz/qYyfJX
 krhdoNtSOy9DIIKqukE87K2PzFtH1SwUPUZ5aHKWjjWNc7alFdh4m7+EAkI76ulH2MckS7Xnint
 3ozqMiaVayyG/Q8g=
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr3778399wmn.68.1590673345210; 
 Thu, 28 May 2020 06:42:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhj7RjXC16QN0NkKGR+M5/a9BwJ5hX0pVccgYYXQCLXMU7UdIJ0a1bGEmNR8m4e4nup25Qcw==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr3778383wmn.68.1590673344974; 
 Thu, 28 May 2020 06:42:24 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id r5sm6288901wrq.0.2020.05.28.06.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 06:42:24 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] microvm: drop max-ram-below-4g support
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200528134035.32025-1-kraxel@redhat.com>
 <20200528134035.32025-3-kraxel@redhat.com>
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
Message-ID: <16e2f252-741e-59ec-9e02-aaf5363bc9f3@redhat.com>
Date: Thu, 28 May 2020 15:42:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528134035.32025-3-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 imammedo@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 3:40 PM, Gerd Hoffmann wrote:
> Not useful for microvm and allows users to shoot themself
> into the foot (make ram + mmio overlap).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/microvm.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 44f940813b07..5e931975a06d 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -173,25 +173,6 @@ static void microvm_memory_init(MicrovmMachineState *mms)
>      ram_addr_t lowmem = 0xc0000000; /* 3G */
>      int i;
>  
> -    /*
> -     * Handle the machine opt max-ram-below-4g.  It is basically doing
> -     * min(qemu limit, user limit).
> -     */
> -    if (!x86ms->max_ram_below_4g) {
> -        x86ms->max_ram_below_4g = 4 * GiB;
> -    }
> -    if (lowmem > x86ms->max_ram_below_4g) {
> -        lowmem = x86ms->max_ram_below_4g;
> -        if (machine->ram_size - lowmem > lowmem &&
> -            lowmem & (1 * GiB - 1)) {
> -            warn_report("There is possibly poor performance as the ram size "
> -                        " (0x%" PRIx64 ") is more then twice the size of"
> -                        " max-ram-below-4g (%"PRIu64") and"
> -                        " max-ram-below-4g is not a multiple of 1G.",
> -                        (uint64_t)machine->ram_size, x86ms->max_ram_below_4g);
> -        }
> -    }
> -
>      if (machine->ram_size > lowmem) {
>          x86ms->above_4g_mem_size = machine->ram_size - lowmem;
>          x86ms->below_4g_mem_size = lowmem;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


