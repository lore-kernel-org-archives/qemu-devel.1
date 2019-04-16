Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A71C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1D92073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1D92073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGS3p-00008k-8l
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 13:39:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGS2q-00088S-7a
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGS2i-0006Td-1w
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:38:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hGS2h-0006Sd-RC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:38:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so73942wml.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=gSUCcgG6wPa0hvMtI0TJYrUwX5y+E+Fsm3WwCaySzdY=;
	b=ExjSHFDVRxyQgFE5wLwE9/WQ9OMq+5mvGSW/7Tt70/EqzjUoYtXo9YZcweH83GcjO+
	AIZkwllhBqHc87youVBpYEtk9t2WSBe/lyppeqNplM0BQN2z6//ogdcuvXC1idnPVTc+
	N3bvHzoZWLFZEZ/16U33iOhoFMICYSKnqdowM1d9ven9vx8/4ID4mpstJW214yjyWAom
	3l13tg0g6EKVTl585DJbCv5l1P2G1XdU9BHhgLQGn4yJMiM8e7ftRz+NP0gF9dAuJqp0
	i4jVMuMhL3oBv4qVjqvNqZcSXkmykr8g6JXUXLQoK+jJXVKx9lpdi5g3RHWShF2QKj2X
	mI+g==
X-Gm-Message-State: APjAAAVqWXiK0GXfnvHQocR0VcYEmtn1cbvbJZm/RyH0bFjzxwRFCGYe
	TKm4uy3hnHqpED0076jCZWTjZw==
X-Google-Smtp-Source: APXvYqxiAqWgxx0kHtdcrsWWyhOHZHhWFH6UR33kr2k1BsTFRH+d86OaHGrV1AaCyJDgbq2pqn5cuA==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr26572360wmj.44.1555436326157; 
	Tue, 16 Apr 2019 10:38:46 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z18sm79910257wrr.90.2019.04.16.10.38.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 10:38:45 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190416091348.26075-1-armbru@redhat.com>
	<20190416091348.26075-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ae1c979b-9cb2-cbaa-584c-b70dbf97d1e4@redhat.com>
Date: Tue, 16 Apr 2019 19:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416091348.26075-2-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 1/3] pc: Rearrange
 pc_system_firmware_init()'s legacy -drive loop
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
	mreitz@redhat.com, qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416173839.X3kFk-w81LyCmZaVD3wLmBjBaR-rHD7ARDejJ_mpHqU@z>

On 4/16/19 11:13 AM, Markus Armbruster wrote:
> The loop does two things: map legacy -drive to properties, and collect
> all the backends for use after the loop.  The next patch will factor
> out the former for reuse in hw/arm/virt.c.  To make that easier,
> rearrange the loop so it does the first thing first, and the second
> thing second.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/i386/pc_sysfw.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c628540774..75925f5d3f 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -280,21 +280,19 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>          pflash_drv = drive_get(IF_PFLASH, 0, i);
> -        if (!pflash_drv) {
> -            continue;
> +        if (pflash_drv) {
> +            loc_push_none(&loc);
> +            qemu_opts_loc_restore(pflash_drv->opts);
> +            if (pflash_cfi01_get_blk(pcms->flash[i])) {
> +                error_report("clashes with -machine");
> +                exit(1);
> +            }
> +            qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
> +                                blk_by_legacy_dinfo(pflash_drv), &error_fatal);
> +            loc_pop(&loc);
>          }
> -        loc_push_none(&loc);
> -        qemu_opts_loc_restore(pflash_drv->opts);
> -        if (pflash_blk[i]) {
> -            error_report("clashes with -machine");
> -            exit(1);
> -        }
> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
> -        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
> -                            "drive", pflash_blk[i], &error_fatal);
> -        loc_pop(&loc);
> +        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>      }
>  
>      /* Reject gaps */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

