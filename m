Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81037C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1D52076C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hB/k07K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1D52076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tIE-00025W-7B
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5tHC-0001IX-1n
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5tH9-00080C-GB
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597248409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9UlHgnsfZ8cwOm+/mzU6rWKElr2PrA8XqEjXuXO3Cc8=;
 b=hB/k07K3aoVJFcIv7rCCd0fsWt4bjXLaEVRZn4kmfFUTFiJc3PkzxeQeLvIWAn4/4QnwHo
 RYpQeLxOLso8JH3joaXNJkI9Ehn14qzy5TAEF0QjDq47LghTs3ygC/urcqPP8KV7Tn4xBl
 oqriNZNTD3IfZsB3o0rAyBlnMwO32F0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-F7xnOGEUMO6gmhScIiaLYg-1; Wed, 12 Aug 2020 12:06:48 -0400
X-MC-Unique: F7xnOGEUMO6gmhScIiaLYg-1
Received: by mail-wr1-f71.google.com with SMTP id b8so1081960wrr.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 09:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9UlHgnsfZ8cwOm+/mzU6rWKElr2PrA8XqEjXuXO3Cc8=;
 b=nRji5C7KRYile9K646fEE35mthHAB2SpGNFLxN5nCeQ0diB2LHhTxzQoF6zBUcm3JU
 wj8O0j/KIb1jEJlx7WvEGPc+Kl2UiM8a05Jn8xMvA9pbwWY95grpzcR8rfEYs4SzJcn4
 jCIREITukLhxd3XURUfQViVNgWcc3gCHFtoAe5M23hCS7t+dSYARBb1StDvk1L9RSaN2
 jwN9lP++gAZfx2e6aT0vbYu7D6F5sx+pWV2173xGA8C//5E7vNd9pS5hJU10CX0rnW2M
 5yy9cRp7fDpVO6glvuXgBWsXlvHxbrYVOQRz+VLnx9VW1Kgn2R/FGiJafNFLIK8mjiTo
 m30g==
X-Gm-Message-State: AOAM5310MCjbwtayaNWoymZ/QpSJ8qzyryRCF0hGPGFuU/Ue+4vbBp//
 g7k92tldo5U/iEgvI5tf/u4T50/cwyay6DKQwsu9BjMmPsz6TQ6qCatfVPwtfzKJXpm21/AfN6i
 ZPqmFeq8DGbSsNA4=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr361162wmb.179.1597248406913; 
 Wed, 12 Aug 2020 09:06:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk4Ag0cXETmpJ7XtJv3ojCEmJ7E6DBev9MYf7tUqAs9x3TJqtxFWRNesXZFXX9LfBGhHflGA==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr361129wmb.179.1597248406658; 
 Wed, 12 Aug 2020 09:06:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w1sm4285616wmc.18.2020.08.12.09.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 09:06:45 -0700 (PDT)
Subject: Re: [RFC v4 03/14] cpus: extract out TCG-specific code to accel/tcg
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200811210326.4425-1-cfontana@suse.de>
 <20200811210326.4425-4-cfontana@suse.de>
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
Message-ID: <2cff5acb-467d-cd5e-bed5-8efecd74b335@redhat.com>
Date: Wed, 12 Aug 2020 18:06:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200811210326.4425-4-cfontana@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:15:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 11:03 PM, Claudio Fontana wrote:
> TCG is the first accelerator to register a "CpusAccel" interface
> on initialization, providing functions for starting a vcpu,
> kicking a vcpu, sychronizing state and getting virtual clock
> and ticks.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/tcg/Makefile.objs |   1 +
>  accel/tcg/tcg-all.c     |  12 +-
>  accel/tcg/tcg-cpus.c    | 541 ++++++++++++++++++++++++++++++++++++++++++++++++
>  accel/tcg/tcg-cpus.h    |  17 ++
>  softmmu/cpus.c          | 498 +-------------------------------------------
>  5 files changed, 568 insertions(+), 501 deletions(-)
>  create mode 100644 accel/tcg/tcg-cpus.c
>  create mode 100644 accel/tcg/tcg-cpus.h
[...]
>  /***********************************************************/
>  void hw_error(const char *fmt, ...)
>  {
> @@ -328,9 +247,7 @@ int64_t cpus_get_virtual_clock(void)
>      if (cpus_accel && cpus_accel->get_virtual_clock) {
>          return cpus_accel->get_virtual_clock();
>      }
> -    if (icount_enabled()) {
> -        return icount_get();
> -    } else if (qtest_enabled()) { /* for qtest_clock_warp */
> +    if (qtest_enabled()) { /* for qtest_clock_warp */
>          return qtest_get_virtual_clock();
>      }
>      return cpu_get_clock();
> @@ -338,7 +255,7 @@ int64_t cpus_get_virtual_clock(void)
>  
>  /*
>   * return the time elapsed in VM between vm_start and vm_stop.  Unless
> - * icount is active, cpu_get_ticks() uses units of the host CPU cycle
> + * icount is active, cpus_get_elapsed_ticks() uses units of the host CPU cycle

This change belongs to the previous patch, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   * counter.
>   */
>  int64_t cpus_get_elapsed_ticks(void)
> @@ -346,9 +263,6 @@ int64_t cpus_get_elapsed_ticks(void)
>      if (cpus_accel && cpus_accel->get_elapsed_ticks) {
>          return cpus_accel->get_elapsed_ticks();
>      }
> -    if (icount_enabled()) {
> -        return icount_get();
> -    }
>      return cpu_get_ticks();
>  }
>  
> @@ -482,10 +396,6 @@ static void qemu_kvm_destroy_vcpu(CPUState *cpu)
>      }
>  }
>  
> -static void qemu_tcg_destroy_vcpu(CPUState *cpu)
> -{
> -}
> -
>  static void qemu_cpu_stop(CPUState *cpu, bool exit)
>  {
>      g_assert(qemu_cpu_is_self(cpu));
> @@ -506,22 +416,6 @@ void qemu_wait_io_event_common(CPUState *cpu)
>      process_queued_cpu_work(cpu);
>  }


