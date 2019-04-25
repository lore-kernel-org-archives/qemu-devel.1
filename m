Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B91C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 23:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BB020717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 23:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BB020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJnW9-0005mw-HE
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 19:11:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJnQL-0000sy-6q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJnDI-0005RZ-T8
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:51:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJnDG-0005PA-Sb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:51:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so1246934wml.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 15:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=IU5UJBuhFXGGDvEgWcZM9aYlS0j+byjsNMPbMY2GKOQ=;
	b=C01fh59Ly7VaskTS+oShvL8Bz9HNOh5v6calwi+2Sv3IjxoX/a/0ANjrz6g3MUWYaB
	MHgVjx/Xmiqku+s7oM5fT5k813m1MU/BpD7B7NpEQkrPT5W6HBqNJQ2PrHpO9ccsQbp5
	9CFomwjMOodmGiFxRUntdLwO4JI1daqtFr1Ap5Z+0akBofIA9z8MxcIWlomZD4Q4hO02
	Pp9VyMP8IPn2iOde6TkOV44BZOst1TPkc3lNMq6V4Pcq/swzME9xGLDW24sQZcoBd60j
	qlNyuUO77IkGI5P/6pzgkcHvlTMdl2sqiDcqbrhgnCUJWQjTieY9UevZwaqCN07wVfOV
	Ge5g==
X-Gm-Message-State: APjAAAUynplWlXOr8XA11eTiReEsa49nIB7xapFxjVICuE6qewU5u2ni
	jxNk8RsEUPgHRllkp37stz8ryA==
X-Google-Smtp-Source: APXvYqxrgrtO0jCbO0yWuUQHr4CJ6d5DlBNgHWu+weX5ntrMy5v4BJaM5n32XbeN6yDilVI5kANawQ==
X-Received: by 2002:a1c:c012:: with SMTP id q18mr1469861wmf.140.1556232686276; 
	Thu, 25 Apr 2019 15:51:26 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122])
	by smtp.gmail.com with ESMTPSA id e3sm7503978wro.35.2019.04.25.15.51.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 15:51:25 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2f02bf38-4bb0-9ca4-438a-b753d6ab5f49@redhat.com>
Date: Fri, 26 Apr 2019 00:51:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 00/29] Kconfig dependencies
 for ARM machines
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
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425225120.zouMRazEVsP4XoDGFUmiTH-oc9390qypDzyh5kSwVF0@z>

Hi Thomas,

On 4/18/19 8:00 PM, Thomas Huth wrote:
> This series reworks the default-configs/arm-softmmu.mak and
> default-configs/aarch64-softmmu.mak files to use the new Kconfig-style
> dependencies instead.
> 
> Some of the patches are slightly based on the work by Ákos Kovács:
> 
>  https://lists.nongnu.org/archive/html/qemu-devel/2013-08/msg03730.html
> 
> The other patches have been created by looking at the sources and finding
> out the dependencies the hard way via trial-and-error (i.e. by enabling
> only one machine at a time and checking whether it can be compiled and
> started).
> 
> v5:
>  - Rebased the series to the current master branch
>  - Added "hw/usb/hcd-ohci: Move PCI-related code into a separate file"
>    patch and got rid of unneeded dependencies to CONFIG_PCI in the
>    ARM machines that do not have a PCI bus
> 
> v4:
>  - Rebased the series to Paolo's latest kconfig tree
> 
> v3:
>  - Addressed review feedback from v2
>  - Included patches to clean up the PCI dependencies of AHCI and SDHCI
>    (so CONFIG_AHCI and CONFIG_SDHCI do not depend on CONFIG_PCI anymore)
>  - Added an additional patch for the new "musca" machines
> 
> v2: Adressed review-feedback from v1
>  - CONFIG_SDHCI and CONFIG_AHCI now select CONFIG_PCI
>  - Added switches for MICROBIT and EMCRAFT_SF2
> 
> Thomas Huth (29):
>   hw/pci/pci-stub: Add msi_enabled() and msi_notify() to the pci stubs
>   hw/ide/ahci: Add a Kconfig switch for the AHDI-ICH9 device
>   hw/usb/hcd-ohci: Move PCI-related code into a separate file
>   hw/arm: Express dependencies of the exynos machines with Kconfig
>   hw/arm: Express dependencies of the highbank machines with Kconfig
>   hw/arm: Express dependencies of integratorcp with Kconfig
>   hw/arm: Express dependencies of the fsl-imx31 machine with Kconfig
>   hw/arm: Express dependencies of musicpal with Kconfig
>   hw/arm: Express dependencies of the OMAP machines with Kconfig
>   hw/arm: Express dependencies of stellaris with Kconfig
>   hw/arm: Express dependencies of realview, versatile and vexpress with
>     Kconfig
>   hw/arm: Express dependencies of the PXA2xx machines with Kconfig
>   hw/arm: Express dependencies of xilinx-zynq with Kconfig
>   hw/arm: Express dependencies of collie with Kconfig
>   hw/arm: Express dependencies of the aspeed boards with Kconfig
>   hw/arm: Express dependencies of the virt machine with Kconfig
>   hw/arm: Express dependencies of netduino / stm32f2xx with Kconfig
>   hw/arm: Express dependencies of allwinner / cubieboard with Kconfig
>   hw/arm: Express dependencies of the MPS2 boards with Kconfig
>   hw/arm: Express dependencies of the raspi machines with Kconfig
>   hw/arm: Express dependencies of canon-a1100 with Kconfig
>   hw/arm: Express dependencies of sabrelite with Kconfig
>   hw/arm: Express dependencies of the MSF2 / EMCRAFT_SF2 machine with
>     Kconfig
>   hw/arm: Express dependencies for remaining IMX boards with Kconfig
>   hw/arm: Express dependencies of the microbit / nrf51 machine with
>     Kconfig
>   hw/arm: Express dependencies of the ZynqMP zcu102 machine with Kconfig
>   hw/arm: Express dependencies of the xlnx-versal-virt machine with
>     Kconfig
>   hw/arm: Express dependencies of the musca machines with Kconfig
>   hw/arm: Remove hard-enablement of the remaining PCI devices

I tested each machines of your series.
I replaced patch #3 "hw/usb/hcd-ohci: Move PCI-related code into a
separate file" by your more recent series "Fix ohci_die() and move PCI
code to separate file",
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03344.html

So for all patches except 3/29:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
(well, I also tested it, but expect you to use the splitted respin)

Regards,

Phil.

