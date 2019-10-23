Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE343CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814422064B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814422064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPq3-0002Vv-Nc
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 19:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPp0-0001RS-2k
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPoz-0003Wt-2n
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPoy-0003Wd-Sk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:13:41 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B9513DE31
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 23:13:39 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id 7so11893516wrl.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 16:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q/kahgxTs8oi0snCEUdyH706xxWE0cVeQlvMyxh0e0I=;
 b=RW3jBBsHDOGZIAT37TYleGP9NnyucHqNXfTWWsGlHYx5gnk255Zb+GaGVZ0aDrHCc8
 8BGhmveBcNFi7z46Zkv3QXZ4sB+/aFQjEu2CrW+q1O4ZqlylmUuDWXzyfRnCV1ClysGB
 P+pX9UQTGO6/razqmS6wuTs61CRtJE34vqrx0ZP5ezg1wq7l/yHZlxqo/gzAjHY9fyT7
 Mx51K4oPPA3WprhkI4aQuRGw2kdG+tbCn3qSTeOKAt4xlfMFT5eR4ifdyhpUa/M2SMT3
 rPlAuNYmZhTRqmSRaHu/NfZgnskNm0aY1hE1s3S31asrSsIKexOSLrEBB2wl3l3V91Tm
 XTNQ==
X-Gm-Message-State: APjAAAXTWif3L43HsnzpdRE20YYhqTKMr4ofbJ34kDa8vdCTvaHde58g
 Pz8qmdlzLxwk2EW5ke3VsMtxUfacVMaWVvmQf+ukL3LJw0uO7vNlbafVNZ+ka5OmcEZmnPPfcpj
 udWjkmh7ta3rmMPM=
X-Received: by 2002:a1c:5641:: with SMTP id k62mr2010066wmb.97.1571872418277; 
 Wed, 23 Oct 2019 16:13:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmODej7GTwJUBFDO8bMqAOc+KLqmcGzysSSy2U4huxJQk7QJQG2PLIJIWDgDAnOgSTKc2aLA==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr2010052wmb.97.1571872418106; 
 Wed, 23 Oct 2019 16:13:38 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id v10sm989726wmg.48.2019.10.23.16.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 16:13:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] pci: pass along the return value of dma_memory_rw
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20191011070141.188713-1-its@irrelevant.dk>
 <20191011070141.188713-2-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <455e6dee-8dd8-fae7-5a2f-e175b9d1cb8d@redhat.com>
Date: Thu, 24 Oct 2019 01:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011070141.188713-2-its@irrelevant.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 9:01 AM, Klaus Jensen wrote:
> Some might actually care about the return value of dma_memory_rw. So
> let us pass it along instead of ignoring it.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   include/hw/pci/pci.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index f3f0ffd5fb78..4e95bb847857 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -779,8 +779,7 @@ static inline AddressSpace *pci_get_address_space(P=
CIDevice *dev)
>   static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>                                void *buf, dma_addr_t len, DMADirection =
dir)
>   {
> -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
> -    return 0;
> +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, d=
ir);
>   }
>  =20
>   static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

