Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812DCC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E6F20857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E6F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55731 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDWrM-0005tq-BQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:11:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDWqL-0005FB-7y
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDWqJ-0003ZW-3P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:09:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDWqH-0003WU-4B
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:09:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so17044904wra.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 09:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wmhIey4BFEtDqQ7BYyr3nktmGrdzjRzr/yegYGYhJ8Q=;
	b=hXPylRtCyl/RmypYQMFHuet3uvY3QHKjns4EJhD0OqHXQvSAh8C52E0/tOBOyaQ0z8
	CtZx/s74sNMQ8XJiKmzwco0B6QGMfZTnEv40oK+rw4P56nkEkY/66f9eHOkKoAOl6X3q
	gL7+NEYPs8yMP8oD/zu88znh+6BFSCGBzbBjQZ0629D/Iy9pLswFpa6i+vLThUUJlJZq
	K52lgfFgmxrl6pQNOeyz/oBPLcdORJc8Ip+M/ytnBDxzzFHuVCfgj5bmSoufA5Cr9q29
	LDMuMaJmkv09ABbyAAvfB9MVFn0I3jR7skGAC4swgpBnRXw8WdizM3cmmhp/+5be3L9J
	k0CA==
X-Gm-Message-State: APjAAAV7ciWCU8ZJ9CxvuUDD6cfAlQjBYUpOX9FthDW69mZhPOEJePxV
	HXXv2DuL56jRom6N7UDPnj4Afg==
X-Google-Smtp-Source: APXvYqw9opc8nEfJRDnrtesXvjIfGkJBYdyaP0D/EL4kuBbJIzQxAhYJLPsbEioNMdC9Bd9C+QIq+g==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr18583847wrp.31.1554739788746; 
	Mon, 08 Apr 2019 09:09:48 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	z17sm15683324wmc.7.2019.04.08.09.09.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 09:09:48 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190408153003.20596-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f4a9a69c-e952-3252-578c-ec729c57886f@redhat.com>
Date: Mon, 8 Apr 2019 18:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408153003.20596-1-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2] hmp: Fix drive_add ... format=help crash
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
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-stable@nongnu.org,
	qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408160946.R2bJxHoYqsJrHDE6Y_OmODy2kDkGQ46cibnD1SOXNEc@z>

On 4/8/19 5:30 PM, Markus Armbruster wrote:
> drive_new() returns null without setting an error when it provided
> help.  add_init_drive() assumes null means failure, and crashes trying
> to report a null error.
> 
> Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2: Make tests/test-hmp.c cover the bug
> 
>  device-hotplug.c | 2 +-
>  tests/test-hmp.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/device-hotplug.c b/device-hotplug.c
> index 6090d5f1e9..6153259d71 100644
> --- a/device-hotplug.c
> +++ b/device-hotplug.c
> @@ -48,7 +48,7 @@ static DriveInfo *add_init_drive(const char *optstr)
>  
>      mc = MACHINE_GET_CLASS(current_machine);
>      dinfo = drive_new(opts, mc->block_default_type, &err);
> -    if (!dinfo) {
> +    if (err) {
>          error_report_err(err);
>          qemu_opts_del(opts);
>          return NULL;
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 8c49d2fdf1..54a01824dc 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -31,6 +31,7 @@ static const char *hmp_cmds[] = {
>      "cpu 0",
>      "device_add ?",
>      "device_add usb-mouse,id=mouse1",
> +    "drive_add ignored format=help",
>      "mouse_button 7",
>      "mouse_move 10 10",
>      "mouse_button 0",
> 

