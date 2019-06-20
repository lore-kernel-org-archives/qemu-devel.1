Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77604C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501B520679
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501B520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdxlw-0006Kq-ER
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:10:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdxgP-0003O0-0A
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdxXI-0008UH-R1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:57:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdxXI-0008Tj-Id
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:55:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so3279879wma.4
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 06:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nhVe87aMDdw5myT9bafXi1N4z3PHZ8boKUSs+9mzcLo=;
 b=AS01VXRKs7h15dI0/HnGoeQ2+ifRTZp/17steAcBrEiPrfn5O6k3wKekSM6iZbmewJ
 shCxj9angcMFD8UBAaodxeLgOYwnsDnTuqcyBT10VlUV3BGNwOLGrQeTGgHO6ocXD4k8
 lj/v/R9I2S1s4cJQb7oT47t1/ehVSNWZf6qbn7Edsdn4sF6MY2NKnWRWpOQtqu5b5EWl
 u9J1NzhOlgrc4eXiVFdKuZWZlWfuImiaNwNWuSbcJQij9xlEzwkMlY5DOwVMyTpsUlTN
 y2jhykOTF3FJLGNvEe36eWn1Dn1W1U1znKHVv1blY4ZSP6nwuJ3aqMBV4ygZj7f1sTxZ
 dAUg==
X-Gm-Message-State: APjAAAUiyc4OeXv/nIzd32RkyEdVG7BEo1UAUVywUM0k8RiwYBz8Zk1k
 xQw8EcqeVSC9Aw9+/1xNescRWA==
X-Google-Smtp-Source: APXvYqzHMJdYtjcm7+vIq4oo3sHB9Eci4xnuAVlEdTxs3FHHMnm+xGdS+eHtkXfPHJTf35mOjgvUSg==
X-Received: by 2002:a1c:2284:: with SMTP id i126mr2883027wmi.145.1561038931530; 
 Thu, 20 Jun 2019 06:55:31 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y6sm5597652wmd.16.2019.06.20.06.55.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 06:55:30 -0700 (PDT)
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20190620122132.10075-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <af0ee25d-50fb-5985-d0fe-a2b7e9a7d8ba@redhat.com>
Date: Thu, 20 Jun 2019 15:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620122132.10075-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH RESEND v5 0/3] fw_cfg: Add
 edk2_add_host_crypto_policy()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Igor (suggested by Laszlo, for his QOM experience on
UserCreatableClass).

On 6/20/19 2:21 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series add edk2_add_host_crypto_policy() and the Edk2Crypto object.
> 
> The Edk2Crypto object is used to hold configuration values specific
> to EDK2.
> 
> So far only the 'https' policy is supported.
> 
> A usercase example is the 'HTTPS Boof' feature of OVMF [*].
> 
> Usage example:
> 
> $ qemu-system-x86_64 \
>     --object edk2_crypto,id=https,\
>         ciphers=/etc/crypto-policies/back-ends/openssl.config,\
>         cacerts=/etc/pki/ca-trust/extracted/edk2/cacerts.bin
> 
> (On Fedora these files are provided by the ca-certificates and
> crypto-policies packages).
> 
> [*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
> 
> Since v4:
> - Addressed Laszlo comments (see patch#1 description)
> Since v3:
> - Addressed Markus' comments (do not care about heap)
> Since v2:
> - Split of
> Since v1:
> - Addressed Michael and Laszlo comments.
> 
> Please review,
> 
> Phil.
> 
> $ git backport-diff -u fw_cfg_edk2_crypto_policies-v3
> Key:
> [####] : number of functional differences between upstream/downstream patch
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/3:[0164] [FC] 'hw/firmware: Add Edk2Crypto and edk2_add_host_crypto_policy()'
> 002/3:[----] [--] 'hw/i386: Use edk2_add_host_crypto_policy()'
> 003/3:[----] [--] 'hw/arm/virt: Use edk2_add_host_crypto_policy()'
> 
> v4: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04300.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02965.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html
> 
> Philippe Mathieu-Daudé (3):
>   hw/firmware: Add Edk2Crypto and edk2_add_host_crypto_policy()
>   hw/i386: Use edk2_add_host_crypto_policy()
>   hw/arm/virt: Use edk2_add_host_crypto_policy()
> 
>  MAINTAINERS                             |   2 +
>  hw/Makefile.objs                        |   1 +
>  hw/arm/virt.c                           |   7 +
>  hw/firmware/Makefile.objs               |   1 +
>  hw/firmware/uefi_edk2_crypto_policies.c | 209 ++++++++++++++++++++++++
>  hw/i386/pc.c                            |   7 +
>  include/hw/firmware/uefi_edk2.h         |  30 ++++
>  7 files changed, 257 insertions(+)
>  create mode 100644 hw/firmware/Makefile.objs
>  create mode 100644 hw/firmware/uefi_edk2_crypto_policies.c
>  create mode 100644 include/hw/firmware/uefi_edk2.h
> 

