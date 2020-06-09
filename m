Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECC9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09ADD207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rg2sDSqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ADD207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicEi-0003qR-5w
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicCd-0001LF-KH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:13:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicCc-0002IF-S4
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3lzSLGxJ8WgRzoyp9NolnrgEUC6tjBqCyG0KDbIHi0=;
 b=Rg2sDSqNz6mSUZRA+rtHXrL0X8hkZG8/Yib8T5MElWpJrvDYFLsgJmBy9lW2UeYM51StFY
 UkcWSQS/PloyuYYy/Xpjjf5hprG+cxGSoyrT/2VOiHzaJ/R70EN8uIjbVsKR845DSwfMV9
 5lYphO8PLBcT7vqcyC+3RT0K3+anc6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-NOY5WbszN2anTZ7NwNEvOA-1; Tue, 09 Jun 2020 07:13:56 -0400
X-MC-Unique: NOY5WbszN2anTZ7NwNEvOA-1
Received: by mail-wm1-f70.google.com with SMTP id p24so530083wma.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O3lzSLGxJ8WgRzoyp9NolnrgEUC6tjBqCyG0KDbIHi0=;
 b=bzpgytSgCmY7MgxGfykwW6P0qRsyyU2pvohpWCkYKu5aoZNWut/hauCBUhIHHHIc0H
 pwifm8CrW7Yd8Ts+YYzXESVKhTDrkmfukc5zkwI8HMd++3EO5G2a7XruFhnWLeAN7/TZ
 UUxfn/P5YC5U1l+x4nORbkAFZ0BSYmxmrPezBfn7Ro/0zNEgthfaRcAAr2+DH36ogsvL
 GTcC8sBye3zy5GLQMwAqGwtYu5ioNL0gsPIlM/ZebmGKNntdKvkZ86H9KQMwYCGd36Vz
 rQgLm/WnGP5U6B6qHoku7IRVg0FXqrfkLr3q+WJPYVKUXYul5VuEpPSVI5LA6n98xTr9
 ntpQ==
X-Gm-Message-State: AOAM531kINJ5mZUb+soVJJFPu3nqvRXrFdumqVFL0V3Yommo3dANNrO3
 VMuHBbu+lF/pzHTPsiFT0jN9+6LzxBmumnfHK2Dn1gOgedznAH5WlGzPa/82kpWaKu5h2tX27Hb
 sAlb4rpmSBp5mE1E=
X-Received: by 2002:adf:f582:: with SMTP id f2mr4186332wro.204.1591701235066; 
 Tue, 09 Jun 2020 04:13:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7CEeV1+7lXiLRFYok5rBbukk8N3FMNoofh40xzDiHh3/3TzmlrCYg3pn55HLPW4csjHJ2JQ==
X-Received: by 2002:adf:f582:: with SMTP id f2mr4186295wro.204.1591701234805; 
 Tue, 09 Jun 2020 04:13:54 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id 50sm3179768wra.1.2020.06.09.04.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:13:54 -0700 (PDT)
Subject: Re: [RFC PATCH 26/35] hw/openrisc/cputimer: Emit warning when old
 code is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-27-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4cdb0948-56b8-6d72-2030-ea00186c47bc@redhat.com>
Date: Tue, 9 Jun 2020 13:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-27-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/20 18:00, Philippe Mathieu-Daudé wrote:
> This code hasn't been QOM'ified yet. Warn the user.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/openrisc/cputimer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
> index 93268815d8..60f2c9667f 100644
> --- a/hw/openrisc/cputimer.c
> +++ b/hw/openrisc/cputimer.c
> @@ -22,6 +22,7 @@
>  #include "cpu.h"
>  #include "migration/vmstate.h"
>  #include "qemu/timer.h"
> +#include "hw/qdev-deprecated.h"
>  
>  #define TIMER_PERIOD 50 /* 50 ns period for 20 MHz timer */
>  
> @@ -135,6 +136,8 @@ static const VMStateDescription vmstate_or1k_timer = {
>  
>  void cpu_openrisc_clock_init(OpenRISCCPU *cpu)
>  {
> +    qdev_warn_deprecated_function_used();
> +
>      cpu->env.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &openrisc_timer_cb, cpu);
>      cpu->env.ttmr = 0x00000000;
>  
> 


I was about to give this a pass, but if we did so it should be the CPU
itself that calls cpu_openrisc_clock_init (not openrisc_sim_init).

Paolo


