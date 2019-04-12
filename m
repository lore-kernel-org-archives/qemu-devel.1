Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2ABC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D207220674
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D207220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEuDy-0006ha-3p
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:20:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEuCr-0006Eg-RU
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEuCq-0008It-SF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:18:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEuCq-0008Hs-Ju
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:18:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so11442468wrn.6
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=A0JMccryKbAcz5l1AwiPmUzRKbvs8IeRaj2pQ8QTtOg=;
	b=ghAI9TFNWyeGlHjOMjGXrOXVZnBMlNG/CCy+yqXCie3AvlaSrnqkMNH1d/ZKZ7n55A
	7npC/mic7YbhSB05tcmBTyJL4O1n4bT0bFSfwr04SBGdgZpWWBQ+qJyeSYVbTbjcEdvJ
	uB1eovu1vJlVruLmFA8No/EqSUFY+4ImltEv4OXXPFblCgQHEPZjb1z4o+hO60XLHpC+
	oMajqGTuKO4ERXVSUjtSyyLzvqTBZe4FzF/6TtCn1T3wN8Zv8OXXojfPE2B/u3DdMRUX
	hC+VN/JCTuDaY3oc/eUZFRpJwQnc3wjjxp1xqDT3zF6tBfao9TEx5MNRz8HnnzdtoBFv
	n5rw==
X-Gm-Message-State: APjAAAUxck0VNldsRwlv1EiNXfs8vTkBAjiPJ57RVp70RkTiCwzcwe1F
	c/VcjpulNp4cJC+J86P6B40hnQ==
X-Google-Smtp-Source: APXvYqx8Fdg+SeXMpaIYL98Ip9Nvn39gyha2MDVBdE/94hC0ljlKiipaHyZGCFgnlmKN+bFofc430A==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr27939601wrp.72.1555067931585; 
	Fri, 12 Apr 2019 04:18:51 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v14sm51504630wrr.20.2019.04.12.04.18.50
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 04:18:50 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-2-armbru@redhat.com>
	<0eea5ddb-1efb-8fdf-4a37-9bc2daf86e2b@redhat.com>
	<03fb5b6f-7d95-3b9b-3172-e37825402036@redhat.com>
	<8d6c1ced-1e7b-9e52-3afb-3fe1197f7a02@redhat.com>
	<87bm1br788.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6dbb3173-b2e2-361e-9bfd-cdbcb308eb50@redhat.com>
Date: Fri, 12 Apr 2019 13:18:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm1br788.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/2] pflash_cfi01: New
 pflash_cfi01_legacy_drive()
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
	qemu-devel@nongnu.org, mreitz@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412111845.P1Jsi0PNmRhM2nIWBBwDITAdpMVV-yKWSBsdkH_Ks3c@z>

On 4/12/19 9:52 AM, Markus Armbruster wrote:
> I append a patch I can describe.  Would it work for you?
> 
> 
> 
> pc: Split pc_system_firmware_init()'s legacy -drive loop
> 
> The loop does two things: map legacy -drive to properties, and collect
> all the backends for use after the loop.  The next patch will factor
> out the former for reuse in hw/arm/virt.c.  To make that easier, do
> each thing in its own loop.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/i386/pc_sysfw.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c628540774..90db9b57a4 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -269,6 +269,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  {
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      int i;
> +    BlockBackend *blk;
>      DriveInfo *pflash_drv;
>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>      Location loc;
> @@ -280,23 +281,26 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
> +        blk = pflash_cfi01_get_blk(pcms->flash[i]);
>          pflash_drv = drive_get(IF_PFLASH, 0, i);
>          if (!pflash_drv) {
>              continue;
>          }
>          loc_push_none(&loc);
>          qemu_opts_loc_restore(pflash_drv->opts);
> -        if (pflash_blk[i]) {
> +        if (blk) {
>              error_report("clashes with -machine");
>              exit(1);
>          }
> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
> -        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
> -                            "drive", pflash_blk[i], &error_fatal);
> +        qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
> +                            blk_by_legacy_dinfo(pflash_drv), &error_fatal);
>          loc_pop(&loc);
>      }
>  
> +    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
> +    }
> +
>      /* Reject gaps */
>      for (i = 1; i < ARRAY_SIZE(pcms->flash); i++) {
>          if (pflash_blk[i] && !pflash_blk[i - 1]) {
> -- 2.17.2

Works for me! Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

