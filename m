Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07E9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A30721532
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwwjzBLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A30721532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFN3o-00018B-8K
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFN31-0000Ea-VY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:43:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFN2z-0005bR-B4
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599507803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z++SeE3fXfeQuq7S4ZDYekEnVFmX5JMrbPFlyU05rmQ=;
 b=PwwjzBLbQhAxvNQ4MJHgo5TKzeo31gtT10VsUpD18C2o9nO/CtOfAqRcw3RIsxLe2GVU3U
 +MuRgyy906muHwMvZdbyPIQ631cqtqBtPphjv/ol48XFraf+tM4+e5BywB6Lb0aPqVHh9m
 S3TvYEEVZaG4bUE7cXXW21WF8D1wbuY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-i-CoOYoMMteM0M0NJotOHw-1; Mon, 07 Sep 2020 15:43:22 -0400
X-MC-Unique: i-CoOYoMMteM0M0NJotOHw-1
Received: by mail-wr1-f71.google.com with SMTP id v12so6034851wrm.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Z++SeE3fXfeQuq7S4ZDYekEnVFmX5JMrbPFlyU05rmQ=;
 b=KlBPaydhHl1tuUNknGrTKADATLDNLBjQwG3mhY3nV9K5cn0ILlx+uv13Ta4T6Fy2xz
 x7SZ71U4H0kI1cFDi4eqex84dyP+jOiIw0R/Tjnu3TKviemkGFfudJ5JdI3jaf3wDEfc
 C5BHOcvnBWIB7Zs88QY2/iDaQDR9hhDhLwjZXmYW7FAuC21sMUSIkrBiddsw7cnNnTxY
 qsn7IZJk76StaDGQZtfuoZ1D0l6S1PqLYUbdIrrjJ9p0GU9xnbp2w2njMJQZPWhF5cqb
 J/5u1Jql4/7E6txTPO2fsicp8fudG/x6gA6rAg45+9D3Bu4hFENQnWxIDqCffRyJEntP
 +QYA==
X-Gm-Message-State: AOAM5305A2G/S6C8/XEMPL2cImJKpYc+o5mkVg2Jc5jL0SUgxs8RBQja
 uZUuQT5YlEjSUL1BQU/yPcsMYrvDKRLU4dop7DYWOE+hTnctV59ZGNAS3eCNG2cdL51pA6mhCkH
 he4Y+aybVBBQoVDE=
X-Received: by 2002:adf:e385:: with SMTP id e5mr22753765wrm.129.1599507800972; 
 Mon, 07 Sep 2020 12:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZi2hbNW+sg0CYtMh9DhVnoJdY8nSctwBc3U5dPEGMFVyHHrHaeu9cjYbZMR+8oxgxZEvsxg==
X-Received: by 2002:adf:e385:: with SMTP id e5mr22753749wrm.129.1599507800746; 
 Mon, 07 Sep 2020 12:43:20 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm3651385wme.12.2020.09.07.12.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 12:43:19 -0700 (PDT)
Subject: Re: [PATCH] Simplify the .gitignore file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200907174255.179652-1-thuth@redhat.com>
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
Message-ID: <e6755ee5-5d41-da76-1a34-e4a05fd76663@redhat.com>
Date: Mon, 7 Sep 2020 21:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907174255.179652-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 7:42 PM, Thomas Huth wrote:
> Now that we always do out-of-tree builds (and the in-tree builds are
> faked via a "build" directory), we can simplify out .gitignore file
> quite a bit.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitignore | 158 -----------------------------------------------------
>  1 file changed, 158 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 4ccb9ed975..bb916594eb 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,165 +1,7 @@
>  /GNUmakefile
>  /build/
> -/.doctrees
> -/config-devices.*
> -/config-all-devices.*
> -/config-all-disas.*
> -/config-host.*
> -/config-target.*
> -/config.status
> -/config-temp
> -/tools/virtiofsd/50-qemu-virtiofsd.json
> -/elf2dmp
> -/trace-events-all
> -/trace/generated-events.h
> -/trace/generated-events.c
> -/trace/generated-helpers-wrappers.h
> -/trace/generated-helpers.h
> -/trace/generated-helpers.c
> -/trace/generated-tcg-tracers.h
> -/ui/shader/texture-blit-frag.h
> -/ui/shader/texture-blit-vert.h
> -/ui/shader/texture-blit-flip-vert.h
> -/ui/input-keymap-*.c.inc
> -*-timestamp
> -/*-softmmu
> -/*-darwin-user
> -/*-linux-user
> -/*-bsd-user
> -/ivshmem-client
> -/ivshmem-server
> -/libdis*
> -/libuser
> -/linux-headers/asm
> -/qga/qapi-generated
> -/qapi-gen-timestamp
> -/qapi/qapi-builtin-types.[ch]
> -/qapi/qapi-builtin-visit.[ch]
> -/qapi/qapi-commands-*.[ch]
> -**/qapi/qapi-commands.[ch]
> -**/qapi/qapi-emit-events.[ch]
> -/qapi/qapi-events-*.[ch]
> -**/qapi/qapi-events.[ch]
> -**/qapi/qapi-init-commands.[ch]
> -**/qapi/qapi-introspect.[ch]
> -/qapi/qapi-types-*.[ch]
> -**/qapi/qapi-types.[ch]
> -/qapi/qapi-visit-*.[ch]
> -!/qapi/qapi-visit-core.c
> -**/qapi/qapi-visit.[ch]
> -**/qapi/qapi-doc.texi
> -/qemu-edid
> -/qemu-img
> -/qemu-nbd
> -/qemu-options.def
> -/qemu-options.texi
> -/qemu-img-cmds.texi
> -/qemu-img-cmds.h
> -/qemu-io
> -/qemu-ga
> -/qemu-bridge-helper
> -/qemu-keymap
> -/qemu-monitor.texi
> -/qemu-monitor-info.texi
> -/qemu-storage-daemon
> -/qemu-version.h
> -/qemu-version.h.tmp
> -/module_block.h
> -/scsi/qemu-pr-helper
> -/vhost-user-scsi
> -/vhost-user-blk
> -/vhost-user-gpu
> -/vhost-user-input
> -/fsdev/virtfs-proxy-helper
> -*.tmp

I'm not sure about this one.

> -*.[1-9]
> -*.a
> -*.aux
> -*.cp
> -*.exe
> -*.msi
> -*.dll
> -*.so
> -*.fn
> -*.ky

Need to double-check where this come from.

> -*.log
> -*.pdf
> -*.pod
> -*.cps
> -*.fns
> -*.kys
> -*.pg
> -*.pyc
> -*.toc
> -*.tp
> -*.vr
> -*.d
> -!/.gitlab-ci.d
> -!/scripts/qemu-guest-agent/fsfreeze-hook.d
> -*.o
> -.sdk

Need to double-check where this come from.

> -*.gcda
> -*.gcno
> -*.gcov
> -/pc-bios/bios-pq/status
> -/pc-bios/edk2-*.fd

I'm not sure about this one but will check.

> -/pc-bios/vgabios-pq/status
> -/pc-bios/optionrom/linuxboot.asm
> -/pc-bios/optionrom/linuxboot.bin
> -/pc-bios/optionrom/linuxboot.raw
> -/pc-bios/optionrom/linuxboot.img
> -/pc-bios/optionrom/linuxboot_dma.asm
> -/pc-bios/optionrom/linuxboot_dma.bin
> -/pc-bios/optionrom/linuxboot_dma.raw
> -/pc-bios/optionrom/linuxboot_dma.img
> -/pc-bios/optionrom/pvh.asm
> -/pc-bios/optionrom/pvh.bin
> -/pc-bios/optionrom/pvh.raw
> -/pc-bios/optionrom/pvh.img
> -/pc-bios/optionrom/multiboot.asm
> -/pc-bios/optionrom/multiboot.bin
> -/pc-bios/optionrom/multiboot.raw
> -/pc-bios/optionrom/multiboot.img
> -/pc-bios/optionrom/kvmvapic.asm
> -/pc-bios/optionrom/kvmvapic.bin
> -/pc-bios/optionrom/kvmvapic.raw
> -/pc-bios/optionrom/kvmvapic.img
> -/pc-bios/s390-ccw/s390-ccw.elf
> -/pc-bios/s390-ccw/s390-ccw.img
> -/docs/built
> -/docs/interop/qemu-ga-qapi.texi
> -/docs/interop/qemu-ga-ref.html
> -/docs/interop/qemu-ga-ref.info*
> -/docs/interop/qemu-ga-ref.txt
> -/docs/interop/qemu-qmp-qapi.texi
> -/docs/interop/qemu-qmp-ref.html
> -/docs/interop/qemu-qmp-ref.info*
> -/docs/interop/qemu-qmp-ref.txt
> -/docs/version.texi
> -/contrib/vhost-user-gpu/50-qemu-gpu.json
> -*.tps

Need to double-check where this come from.

> -.stgit-*

Need to double-check where this come from.

>  .git-submodule-status
>  cscope.*
>  tags
>  TAGS
> -docker-src.*
>  *~
> -*.ast_raw
> -*.depend_raw

Coccinelle generated in source tree, please keep.

> -trace.c
> -trace-ust.h
> -trace-ust.h
> -trace-dtrace.h
> -trace-dtrace.dtrace
> -trace-root.h
> -trace-root.c
> -trace-ust-root.h
> -trace-ust-root.h
> -trace-ust-all.h
> -trace-ust-all.c
> -trace-dtrace-root.h
> -trace-dtrace-root.dtrace
> -trace-ust-all.h
> -trace-ust-all.c
> -/target/arm/decode-sve.c.inc
> 


