Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C99DC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F99120850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F99120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyww-0004FE-8H
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:22:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEyw1-0003JY-Jv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEyvz-0002Au-Le
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:21:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEyvw-00028t-5s
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:21:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so12670263wra.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UCu8QWsD7L34HbO1/b+gpi3AWoEZGGUfVix5kEiHkwk=;
	b=mh34vjAdGTIR3LOOpxWs5m7lFwK2nbB88fOfGCWaRm3RPV95bJoN1vubZg6konPXyD
	PpKwpPv8olFrxFy34984zJRzne54i/HnY+aZs9XbNzx234u+HGGxFD2JclphhfXYVNA8
	x9UHKzxztLYXwN5DS5on/zHFpsziXoNil6T/5Uc0gKrULETXd9o2sOy0Uvy5A8uW87nu
	CK27kW4+tvvkEif72WVCdDbKAM924TiLcsl5mgC1rDLnFBw0j071MUL2pEjcw2kG90ZB
	x62JVKja5h1v1FjUEYj8MrGZOFOxv+qrm326U2EhZ5LaDRfiErwfQyGgIq/mTB0HZyBZ
	4Ygg==
X-Gm-Message-State: APjAAAX/y4vXTXM8SmCnb79QDlgiusGlOdH3RM36pEeJfg1BRFz9JLbP
	O0HRq0cNTyGZArKBq3pyDpWf0Q==
X-Google-Smtp-Source: APXvYqzgHiQnPqg4DBDdSXNP910e2Hi910qj5jffNxNekOFJyxmSdFdMR3Igaau4x9FM/5RtnG+3Dg==
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr17403032wrn.60.1555086103129; 
	Fri, 12 Apr 2019 09:21:43 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	n4sm42066694wrx.39.2019.04.12.09.21.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 09:21:42 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190412152619.23542-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2c7385cf-78ba-3331-53f0-1973408f0e4d@redhat.com>
Date: Fri, 12 Apr 2019 18:21:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412152619.23542-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800
 and n810 machines
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
Cc: libvir-list@redhat.com,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412162141.FjiXMJF-QailBxZOHMXpg_alxtmNPHtwH4UEJ5sQtVI@z>

On 4/12/19 5:26 PM, Thomas Huth wrote:
> These machines depend on the deprecated bluetooth subsystem. In case we
> finally decide to remove the bluetooth subsystem, we likely need to
> remove the n800 and n810 machines, too, so mark them now as deprecated.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/nseries.c     | 3 +++
>  qemu-deprecated.texi | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index 906b7ca22d..66e50b850c 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -1309,6 +1309,9 @@ static void n8x0_init(MachineState *machine,
>      struct n800_s *s = (struct n800_s *) g_malloc0(sizeof(*s));
>      int sdram_size = binfo->ram_size;
>  
> +    warn_report("The n800 and n810 machines are deprecated. Please use a "
> +                "different Arm machine instead.");
> +

Unrelated to this patch, but can you add a similar warning in
uart_hci_init() to make obvious that the bluetooth subsystem is now
deprecated?

>      s->mpu = omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
>  
>      /* Setup peripherals
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2219386769..4de7452fac 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -145,6 +145,12 @@ This machine type uses an unmaintained firmware, broken in lots of ways,
>  and unable to start post-2004 operating systems. 40p machine type should be
>  used instead.
>  
> +@subsection n800 and n810 (Arm) (since 4.1)
> +
> +These machines depend on the deprecated bluetooth subsystem. When the
> +bluetooth subsystem will be removed, the n800 and n810 machines will be
> +deleted, too. If possible, use a different Arm board instead.
> +
>  @section Device options
>  
>  @subsection Block device options
> 

