Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA4C56201
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AAD21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzQcpmbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AAD21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLtu-0007ik-67
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXLlk-0006zd-Hz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:56 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXLli-0000Sg-Ft
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:56 -0400
Received: by mail-ed1-x542.google.com with SMTP id o18so781443edq.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0p05rdut0MOqeeNLLeNgdslot/LAqbJsW464E94Ddf0=;
 b=BzQcpmbFR+E5TNxYUDUW/IaySG+CjRLCCh3A8vSeeCiGJ38030sNhAGCFOGyvGrdYS
 ruGqURdPD3ShcFFrjgYB6M143eKZaNyZYMKF+iQSeDjuZMxfdB5pHSBQDenv/Jlc1vd+
 FaTTeo/bICN5kMNPmD3ZE9HmS26Z5KwXdJOmdqesmhK6cTep2nq6w4eXmgvM8hDPABaH
 G2o9/gVVVwPAPbK9l5zBnPAG6PcqroVXifoT8ofRPQ26u9JK2lAT2pdqiBdHGR5hwpMZ
 tK1FORKno25cUkjaMChRwuugQH14n6aiXMe3DVvAEmO5XBd+VSxqrGXSdXbdBhaAvyd9
 1krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0p05rdut0MOqeeNLLeNgdslot/LAqbJsW464E94Ddf0=;
 b=gUKs+bGU6PqmWpcaGHHpmluWKOYNnuh9jJBdDwqX5IAiBAwu5omIv+wt2EhyMP2eRX
 i4/QiHYacS+0u+0P7L/lndXq+a878lU8OF4cje1MME0SamjwFMyw6oBZpnast/URjNic
 pO0FGVqxu8SvXjRjXbx1jTSRede2oD/GqxFrfWocIorCw8FRPKNa1cJlhu/M2sXBk+9E
 0QjiEXp+80maolkjpYq+3KPbYNBVFrLt6ouKtMa3N1z9KzvNYO0ZNk9mbOY+HW8iWBRj
 8QpXbHYzfb7CYNac3VR4G5+vMxSySfbhKgMudSqlNB/XRK0vkvd/JPViNSb/b9jBhwzv
 VqSw==
X-Gm-Message-State: AOAM532VxkV5D/mcvQ0XBpr7b8NsWEcOCbA0ZnuAUWvWX36XXh/QVI8U
 oBOS7yoKymBGrQUr+R6r4iw=
X-Google-Smtp-Source: ABdhPJx2PQVyMh91eBKF8womVmrzpd0FUM8Yyl0spAfNdAIbZoAV4gz0eVJ9isIacGEqX5fdimDTNA==
X-Received: by 2002:aa7:cb8f:: with SMTP id r15mr1371551edt.356.1603792793017; 
 Tue, 27 Oct 2020 02:59:53 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i17sm628251edr.49.2020.10.27.02.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 02:59:52 -0700 (PDT)
Subject: Re: [PATCH] virtio-gpu: only compile virtio-gpu-3d.c for
 CONFIG_VIRGL=y
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Emmanuel Blot <eblot.ml@gmail.com>
References: <20201026142851.28735-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <98cee389-17ee-b006-1a5c-62f2eef37b1d@amsat.org>
Date: Tue, 27 Oct 2020 10:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026142851.28735-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:28 PM, Gerd Hoffmann wrote:
> There is no actual code in the CONFIG_VIRGL=n case.  So building is
> (a) pointless and (b) makes macos ranlib complain.
> 
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/virtio-gpu-3d.c | 4 ----
>  hw/display/meson.build     | 4 +++-
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 1bd33d7aedc6..0b0c11474dd3 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -17,8 +17,6 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-gpu.h"
>  
> -#ifdef CONFIG_VIRGL
> -
>  #include <virglrenderer.h>
>  
>  static struct virgl_renderer_callbacks virtio_gpu_3d_cbs;
> @@ -633,5 +631,3 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>  
>      return capset2_max_ver ? 2 : 1;
>  }
> -
> -#endif /* CONFIG_VIRGL */
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 0d5ddecd6503..5906b96b830e 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -57,7 +57,9 @@ softmmu_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d
>  if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>    virtio_gpu_ss = ss.source_set()
>    virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_GPU',
> -                    if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c', 'virtio-gpu-3d.c'), pixman, virgl])
> +                    if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c'), pixman, virgl])
> +  virtio_gpu_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRGL'],
> +                    if_true: [files('virtio-gpu-3d.c'), pixman, virgl])
>    virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
>    hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
>  endif

Mark suggested to test this patch to see if this solve the issue
introduced by commit da0dfe251d7 ("build: fix macOS --enable-modules
build") but it does not:

missing object type 'virtio-gpu-device'
Broken pipe
../tests/qtest/libqtest.c:176: kill_qemu() detected QEMU death from
signal 6 (Abort trap: 6)
ERROR qtest-aarch64/device-introspect-test - too few tests run (expected
6, got 5)
gmake: *** [Makefile.mtest:905: run-test-111] Error 1

