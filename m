Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F3C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7419E216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7419E216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWM6-0005O9-IS
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpWLs-0004VM-GC
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpWLr-0005cw-Df
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:19:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpWLr-0005by-78
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:19:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so39010338wrr.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HoiYMAHM3YsXdSPqsmfjY1NWA5ADjuRjW1YCagHLg6g=;
 b=kdsW9v7DPZKjk8CXkQXsCJESO7jYDuUInZDcHDbvycIqhGtIuA/auTkuHcV2WIU/VU
 SzZR9idJEo/Tv9k/M1/14SYkEAeTr0x0nO1m3Cje0zmcpNmDObeRTL81TVoXsCY9NLTL
 7hBYSFgdVNq84Sb0Kn+PsjBYIpoRJadGuk7vGxFeRecHoJX6jZunX+afTeLdBX5kcEGC
 y0iASLccUZbEgdaw6w67sd3XEL8zHNjKVmqnGkhgogO9nXXtEnTxKneF3Q4hc0DhMFDz
 ElbqV0wNt5ubdEFQHcBrXfWR5ceod0uKIATVqc9va2xGc8e1rCFcP72MCloLc7qvXVo7
 MKNg==
X-Gm-Message-State: APjAAAVi3xcrqdNWE/pGQWXXU2bDhWUaee1BN61yu7KyEppQcM/AMSOi
 e/u6/Q6l2OfQtBbeMitw9HsOaw==
X-Google-Smtp-Source: APXvYqyS8X16wqSoIRt6BE7QVxng1D5IQerHcsU33xN22qHmI1hqASfNs+ked6cKveaAPXYmSgBynw==
X-Received: by 2002:a5d:4a02:: with SMTP id m2mr73554570wrq.78.1563794370025; 
 Mon, 22 Jul 2019 04:19:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id b203sm47840540wmd.41.2019.07.22.04.19.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 04:19:29 -0700 (PDT)
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
References: <20190722061752.22114-1-npiggin@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <40dac685-ad1c-db9c-47af-4350acae4f9d@redhat.com>
Date: Mon, 22 Jul 2019 13:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722061752.22114-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 2/3] i386: use machine class ->wakeup
 method
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
Cc: "Liu, Jinsong" <jinsong.liu@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/19 08:17, Nicholas Piggin wrote:
> Move the i386 suspend_wakeup logic out of the fallback path, and into
> the new ->wakeup method.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/i386/pc.c | 8 ++++++++
>  vl.c         | 2 --
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 549c437050..78c03d7f9d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2828,6 +2828,13 @@ static void pc_machine_reset(MachineState *machine)
>      }
>  }
>  
> +static void pc_machine_wakeup(MachineState *machine)
> +{
> +    cpu_synchronize_all_states();
> +    pc_machine_reset(machine);
> +    cpu_synchronize_all_post_reset();
> +}
> +
>  static CpuInstanceProperties
>  pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  {
> @@ -2940,6 +2947,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_IDE;
>      mc->max_cpus = 255;
>      mc->reset = pc_machine_reset;
> +    mc->wakeup = pc_machine_wakeup;
>      hc->pre_plug = pc_machine_device_pre_plug_cb;
>      hc->plug = pc_machine_device_plug_cb;
>      hc->unplug_request = pc_machine_device_unplug_request_cb;
> diff --git a/vl.c b/vl.c
> index 45ea034410..3f50dd685b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1567,8 +1567,6 @@ static void qemu_system_wakeup(void)
>  
>      if (mc && mc->wakeup) {
>          mc->wakeup(current_machine);
> -    } else {
> -        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
>      }
>  }
>  
> 

Looks good, I wouldn't mind adding a machine_reset() function with most
of the code from qemu_system_reset but it can be done later.

Paolo

