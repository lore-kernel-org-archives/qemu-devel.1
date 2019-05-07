Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1875AC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD502053B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD502053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0Dr-0000Uw-0V
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 09:33:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO0CV-0008Gg-7Y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO0CU-0002H1-Cd
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:32:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hO0CU-0002FE-6c
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:32:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id d12so1894206wrm.8
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 06:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=IE5iNsJFi1l/kJoxO60l0ZAvfP0pWejDliOGPCSh0TA=;
	b=Zi/8G97+fxzOZyvRPgQvGn1OuhXFTd0MKP+UO8tmacwHYqzhtrC7sV8jgO1TJXidjQ
	1jDE9EOQo7ifhdVw/fOpj0p3WLswbvq7jWK5i4nyYTTm2IENtIrti5rkOdicjgHRwrQz
	YHr5tt8mj9x0oQJWGdvjec/s/bdjnYXMECf7ytih8SjjiA9o4QfXf3F9z0bAtzDkl0su
	K+RngIgh9IUFFzczG/08oBO88r2sEJw3AM/hwomZbt5YYm5iLDzA/wMcT2mLhRpNBoEO
	/vvPuZMj5Wg1LtYCnrKVjOZDHmoebeEw2hG0EGgk6aK2VxIapQC5MjbMpF7/Ncmhq+We
	Ut+w==
X-Gm-Message-State: APjAAAUGN4m0VZbBGBDDWDgSCtibQjCul/PeQ0gfoJKnRVF6+V2xbsa4
	zgTO/P871JWpJjbww4Vpnstg+g==
X-Google-Smtp-Source: APXvYqyGq0KdFUkWmTYajpS08LWpqqYSAZFJLh2XK6/nztlJkaUfi3pzrCqsQoRyu8oQf822XGTyUg==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr4973510wrv.285.1557235925078; 
	Tue, 07 May 2019 06:32:05 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z7sm18364977wme.26.2019.05.07.06.32.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 06:32:04 -0700 (PDT)
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20190507122748.18506-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dfeead63-ac78-4c65-2e05-9a2efb91971d@redhat.com>
Date: Tue, 7 May 2019 15:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507122748.18506-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] hw/i386/Kconfig: The Q35 machine requires
 the ICH9_AHCI device
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 2:27 PM, Philippe Mathieu-Daudé wrote:
> The Q35 machine uses the ICH9 chipset which is composed of various
> sub-devices. There is currently no generic Kconfig selector that
> selects all the required devices. Meanwhile, force the Q35 machine
> to select the 'ich9-ahci' device.
> 
> This fixes:
> 
>   $ ./configure --without-default-devices && \
>     ./i386-softmmu/qemu-system-i386 -nodefaults -M q35
>   qemu-system-i386: Unknown device 'ich9-ahci' for bus 'PCIE'
>   Aborted (core dumped)
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
I forgot:

Based-on: <20190430071405.16714-3-thuth@redhat.com>
"hw/ide/ahci: Add a Kconfig switch for the AHCI-ICH9 device"

>  hw/i386/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index a6aed7c1313..98178882169 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -80,7 +80,7 @@ config Q35
>      select PC_ACPI
>      select PCI_EXPRESS_Q35
>      select LPC_ICH9
> -    select AHCI
> +    select AHCI_ICH9
>      select DIMM
>      select SMBIOS
>      select VMPORT
> 

