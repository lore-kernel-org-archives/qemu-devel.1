Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAECCC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A556220644
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A556220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJf2s-0000WJ-Gs
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:08:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJf1Z-000815-Jf
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJf1X-0006Ae-H7
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:06:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJf1W-00068H-Tg
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:06:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so19194922wru.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=++1XX3+8k55A2Ila7MS9KJPTa3AUixyAgpwW0iiITRU=;
	b=ELL3BHtGzLWrTRQbjfyTbrEgXOqDfNUenx4D2aJIhy+nnW5UC3SYGPP8W1H4dI0zhn
	5qXLqlCrrFSCfZhI5iTnohCM5IWPb3RllaAMAJUBz9900DO2iR/rqIS8PsOS5Y2rrN4E
	sWpHutKoP0OMuVo8fib9xX8VMTmVfa+SZTq2ZV5JMhqzqJkA80bip/nBeziBeTGOScx+
	YQSsv90Jc5zuCx1JKhEGaU8K85SA+FzEaB6DvMf1+nmcdRd2NY+YlIqvBwWibOu8D4pk
	PAXa9sf+bDE7+pgM7e3ayhUxMbMGF5v6AZxYQVVI6bqoo1g6/mkUXE+Vl2kSAaPrrv6T
	Ux9A==
X-Gm-Message-State: APjAAAX6xF6b+rAbS2aaXCzH67WOWEgVKDtsRrRClzKA30JVCHcmbkpP
	M66rQr4zL5h8Gmf/mXDPo6GH4g==
X-Google-Smtp-Source: APXvYqy8BYAx144HNRTNnSYopzBscGHdIsWMoI6vFPxaU/R4GBeHbMrgTd4fj+uUSBipBxtM5Pvtmw==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr28576571wru.227.1556201208083; 
	Thu, 25 Apr 2019 07:06:48 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	62sm28308476wrm.18.2019.04.25.07.06.46
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 07:06:47 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7d4fdf95-f3b9-786a-9869-fdfca87d6a59@redhat.com>
Date: Thu, 25 Apr 2019 16:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-2-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 01/29] hw/pci/pci-stub: Add
 msi_enabled() and msi_notify() to the pci stubs
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
Message-ID: <20190425140642.Hq8dHeArMnKd6FKG-Z1stxwMkBg4azlKY1WD9UWfs94@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Some machines have an AHCI adapter, but no PCI. To be able to
> compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
> functions msi_enabled() and msi_notify() for linking.
> This is required for the new Kconfig-like build system, if a user
> wants to compile a QEMU binary with just one machine that has AHCI,
> but no PCI, like the ARM "cubieboard" for example.
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/pci/pci-stub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index b941a0e842..c04a5df651 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -53,3 +53,14 @@ uint16_t pci_requester_id(PCIDevice *dev)
>      g_assert(false);
>      return 0;
>  }
> +
> +/* Required by ahci.c */
> +bool msi_enabled(const PCIDevice *dev)
> +{
> +    return false;
> +}
> +
> +void msi_notify(PCIDevice *dev, unsigned int vector)
> +{
> +    g_assert_not_reached();
> +}
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

