Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB222C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEEB2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYuUkKvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEEB2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1rb-0005hk-Ac
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1qv-0005GM-Tu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1qu-0003ON-AY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600856299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wr2I8uH1/ILRHaLobc8IE3nnBw7Dz899BmIShYduPNU=;
 b=hYuUkKvHZ01rtgwVUdGaN70/crlfbsPN8RIOiQb3FJxULhuLf41hZtLd57s8JSRM0Btksz
 WwqGbeuH8LvWvHrXOVFXFqwiYATwToVciKK2AvzaVNWEGU5bEAfik7joNnQdfagbLEQ7MD
 qB2qxFU7QxZ0907YKJCSQDZeM8q5OvU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Fts7BJlNPESrJAfCSvsuKA-1; Wed, 23 Sep 2020 06:18:18 -0400
X-MC-Unique: Fts7BJlNPESrJAfCSvsuKA-1
Received: by mail-wm1-f70.google.com with SMTP id b14so1197403wmj.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wr2I8uH1/ILRHaLobc8IE3nnBw7Dz899BmIShYduPNU=;
 b=YcJXRN7vqgY2dEJPnQlfix0oZ+TAHRAEPvbdvlBSQiy6/0SRGxS/zR/Xc9N9RkI1VC
 7felAyHCUkehC/yD8Zt4pM0xXmZMzLvGP13Dt/8E10+3YxsyHnCChkG6T09IvKV3PSvI
 PZazyMUpEvpw7CViNInehR7Ljo+1sMexM562vVOZfPu1FRL2y+PBhdQuKmEoyxC+7tvM
 XoTS2DOjzH34SrYsJexH08hBR/Wmci23WGtGK1MYEYdDHMKo4AkpSM0rLDu37KC3nm5g
 UCfbTtIx8MNXmsENeS3ZUOaGcx84ba2froBSmTVurBOkom/eRsTGJM5OMHqaRpFN8GjJ
 Q6sw==
X-Gm-Message-State: AOAM531ThSmGcIpa8BWBh6UuM4L5+MeH5AoPTlDyEDMdrThHeG9r9unq
 ihWZPKHEKRPXOd37IlHLaosIjGEL7mW7/OilZeY8PygTfydjhsYcIsL8FxVwze9/Nf5LK+/6lX+
 HF9qd+4vXYdKEBgE=
X-Received: by 2002:a1c:8f:: with SMTP id 137mr5715185wma.158.1600856296416;
 Wed, 23 Sep 2020 03:18:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOly7u8jMez+ppuQWe9YXJlg9hQ6juKs1auqCYlt1fLvvYO9e6ZLAwkh7tSsdcpJptE93Lqg==
X-Received: by 2002:a1c:8f:: with SMTP id 137mr5715167wma.158.1600856296220;
 Wed, 23 Sep 2020 03:18:16 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a17sm32699552wra.24.2020.09.23.03.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 03:18:15 -0700 (PDT)
Subject: Re: [PATCH] kvm: remove now unnecessary stubs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Claudio Fontana <cfontana@suse.de>
References: <20200923091743.1593109-1-pbonzini@redhat.com>
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
Message-ID: <3a9e4076-1088-ff70-5158-6f32ffbfa8c7@redhat.com>
Date: Wed, 23 Sep 2020 12:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923091743.1593109-1-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 11:17 AM, Paolo Bonzini wrote:
> These two stubs are now used only in accel/kvm/kvm-all.c
> and accel/kvm/kvm-cpus.c.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  accel/stubs/kvm-stub.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 680e099463..d3874526f5 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -36,10 +36,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
>  {
>  }
>  
> -void kvm_cpu_synchronize_state(CPUState *cpu)
> -{
> -}
> -
>  bool kvm_has_sync_mmu(void)
>  {
>      return false;
> @@ -149,11 +145,6 @@ bool kvm_has_free_slot(MachineState *ms)
>      return false;
>  }
>  
> -void kvm_init_cpu_signals(CPUState *cpu)
> -{
> -    abort();
> -}
> -
>  bool kvm_arm_supports_user_irq(void)
>  {
>      return false;
> 


