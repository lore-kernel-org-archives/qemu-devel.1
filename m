Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0D0C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20A520818
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20A520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51603 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3Md-00016P-Vi
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:17:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG3Lg-0000kX-EN
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG3Lf-0005U0-0p
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:16:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hG3Le-0005TN-OE
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:16:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so22452115wrn.6
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8gBpQB9/trEtwxjbJxEUzFTqveHsjwYbEveLUTlX1W0=;
	b=Jm2fAwj/WIuKH79HX8P/B3DhJ2QEthQhqE3OJnLYNOUGSdwQrViWvPzVjGhmoUrQKe
	VJe4qiGuzTnvjYpQS3LBoOth59m2+Hk9A/RXB5v9NFdKsglKEG6mwKinzKd+7WLjS6GP
	G/ipZr9XhpjM/gXcVl4xJogBNj6IeoSU3f4+xvMCK7dcFG6F45YOaHjH+RcTRp/aVVj1
	1gXoOnEsuFzeEVbrWLcpmJ+8JwUmPDN9drCQSH0kb9x7vLB/ofc5V0LJwAG9hw6TK2t6
	phMaejXwGC9qAepicx8QINkWCGGjPsaPJmkIwzvk+dUrKLVNN1O2XBPISLFXTMLX6XUE
	4z4A==
X-Gm-Message-State: APjAAAXzr7sXJl8sMccpTvu1RTjtgZklTjuv+hzm4D3NqHuNAGeS1JjJ
	Tx3v/XgkO1tWduXourzH1TYvwQ==
X-Google-Smtp-Source: APXvYqzhnHXmkqNMlX+CneIoF7DvbF5XoiQ94FWT92sY64olm/RZg/5vdx/AAKDQ/NpWZMEBFQ9gtg==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr29831047wrx.76.1555341401370;
	Mon, 15 Apr 2019 08:16:41 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	t15sm50218191wrx.22.2019.04.15.08.16.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 08:16:40 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f16cbd3d-589d-2af8-1d86-b595ef0d0255@redhat.com>
Date: Mon, 15 Apr 2019 17:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555334842-195718-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hppa: drop usage of
 memory_region_allocate_system_memory() for ROM
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
Cc: David Hildenbrand <david@redhat.com>, Helge Deller <deller@gmx.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415151633.0QEHELbdTvZo1MydRdbv9fvpO5XLU_7WTPg5nQ5lrV0@z>

On 4/15/19 3:27 PM, Igor Mammedov wrote:
> machine_hppa_init() violates memory_region_allocate_system_memory() contract
> by calling it multiple times which could break with -mem-path. Replace
> the second usage (for 'rom') with memory_region_init_ram() instead.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/hppa/machine.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index d1b1d3c..b413913 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -158,9 +158,8 @@ static void machine_hppa_init(MachineState *machine)
>      g_free(firmware_filename);
>  
>      rom_region = g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(rom_region, OBJECT(machine),
> -                                         "firmware",
> -                                         (FIRMWARE_END - FIRMWARE_START));
> +    memory_region_init_ram(rom_region, NULL, "firmware",
> +                           (FIRMWARE_END - FIRMWARE_START), &error_fatal);
>      memory_region_add_subregion(addr_space, FIRMWARE_START, rom_region);
>  
>      /* Load kernel */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

