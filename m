Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B077C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 19:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D760F2076D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8vtdGGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D760F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWPLu-0007vm-15
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 15:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jWPL3-0007TO-GN; Wed, 06 May 2020 15:04:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jWPL2-0008Q2-Dp; Wed, 06 May 2020 15:04:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so3478679wra.7;
 Wed, 06 May 2020 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zI2rVsBZU/4DMsKQSGJkMc32llG6pwBy1ecLqPkSI7g=;
 b=E8vtdGGL+17QzPBJtAa9W3tTi94Fgj59ETg7/RaYGvfCX6fXLi4+7GDcXed2Q/j005
 XGqEVHRj7j6GWeS+UT5Ida2WifIjZIJzrfJlwEeqaXNpbJiJ20Wp3wthQrg8AfNASolx
 f0xA3X8LaGCfNdK5RxAvBBtRoMxgDcY1KocAA1l/PPU3e2Ww8zxZpbbUqFHB1o1gbzZB
 esJF0RfZ1/BvjQxREkeJCJQZw5etgHhzkJQweYCEfdfRvxUVhG7rtBsvQNAWjHR6M1hO
 PrlUvrkPUubBZMHLYDHsxf4yZtr8uGQIf3YiRTN4mV6R0xi5nHMyi/OEnfkOAv+q1P4W
 RsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zI2rVsBZU/4DMsKQSGJkMc32llG6pwBy1ecLqPkSI7g=;
 b=bpTX4+dh72FlzgNcyfW+VQ9JqKTZe7Kylivqz0L3u6Dg6mdhzBwMzw/k5GRYbW3P5C
 5i76X9933iZ/9/ZFxGJ0vTtzLpgJIZd6BYoASw6EaZs9yoGi1smo8dbm8IRPbipMdDQB
 LQeWmOH95cHdQ26i+ZG104wf1vLv7HluOVG7ygzEmLU631M19MiIHnTg+XJckqy/Jifn
 gtU4/I1ySIIdjK8m1gx/6KVLPY11okWSX+BL7bF9LdbG+2TliskLhcbm17bQumsuewbi
 MalnqrFCiHftdjy8VaXOCFJ383RSo0bvOOAgH+DuMOyIUZiH/ieFpxQyhyVnkleJdKp5
 DsTw==
X-Gm-Message-State: AGi0PuYL5AGGapBwZhND+3s+eGHsyaF3YfGL3ggsWE+7tw+EJRp/vj0F
 8z4LWB60f88/cNHmB4RYh5MZgPoEdAIsIwZuBcE=
X-Google-Smtp-Source: APiQypJ695dUm52RTtTasrBQFCirffcM4KKxo32D8lHArg30LaioHoUBnM58Vgt6YYgMOZj02ulQmJOvbIbJGVVR6p4=
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr9080420wrx.107.1588791850587; 
 Wed, 06 May 2020 12:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-14-david@redhat.com>
In-Reply-To: <20200506094948.76388-14-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 6 May 2020 21:03:59 +0200
Message-ID: <CAM9Jb+iP8EmMXmHneUSNo+kN75jcF2q0sUF+XzRkh2bV=o4Tbw@mail.gmail.com>
Subject: Re: [PATCH v1 13/17] hmp: Handle virtio-mem when printing memory
 device info
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Print the memory device info just like for other memory devices.
>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  monitor/hmp-cmds.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 7f6e982dc8..4b3638a2a6 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1805,6 +1805,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>      MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
>      MemoryDeviceInfoList *info;
>      VirtioPMEMDeviceInfo *vpi;
> +    VirtioMEMDeviceInfo *vmi;
>      MemoryDeviceInfo *value;
>      PCDIMMDeviceInfo *di;
>
> @@ -1839,6 +1840,21 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>                  monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
>                  monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
>                  break;
> +            case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
> +                vmi = value->u.virtio_mem.data;
> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> +                               MemoryDeviceInfoKind_str(value->type),
> +                               vmi->id ? vmi->id : "");
> +                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vmi->memaddr);
> +                monitor_printf(mon, "  node: %" PRId64 "\n", vmi->node);
> +                monitor_printf(mon, "  requested-size: %" PRIu64 "\n",
> +                               vmi->requested_size);
> +                monitor_printf(mon, "  size: %" PRIu64 "\n", vmi->size);
> +                monitor_printf(mon, "  max-size: %" PRIu64 "\n", vmi->max_size);
> +                monitor_printf(mon, "  block-size: %" PRIu64 "\n",
> +                               vmi->block_size);
> +                monitor_printf(mon, "  memdev: %s\n", vmi->memdev);
> +                break;
>              default:
>                  g_assert_not_reached();
>              }
> --
> 2.25.3

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

