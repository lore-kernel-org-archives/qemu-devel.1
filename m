Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC878C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802E5208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802E5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43955 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKQO-0001Pt-HL
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:07:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hJKNr-0008Uq-WE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hJKNp-0003EY-W5
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:04:31 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:58042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hJKNk-00035f-1u
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:04:27 -0400
Received: from player750.ha.ovh.net (unknown [10.108.54.67])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B7E7D1E3EBC
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 18:04:10 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player750.ha.ovh.net (Postfix) with ESMTPSA id DAE3152F55F1;
	Wed, 24 Apr 2019 16:04:03 +0000 (UTC)
Date: Wed, 24 Apr 2019 18:04:01 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190424180401.67985be2@bahia.lan>
In-Reply-To: <20190424041959.4087-2-david@gibson.dropbear.id.au>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
	<20190424041959.4087-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9870201533368605158
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrhedugdefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.121.62.11
Subject: Re: [Qemu-devel] [PATCH v2 1/3] pcie: Remove redundant test in
 pcie_mmcfg_data_{read, write}()
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424160401.vZIuNl5-h7toytxjlAV5ibnEb-KPAjLz1cPWuXvO6Ow@z>

On Wed, 24 Apr 2019 14:19:57 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> These functions have an explicit test for accesses above the device's
> config size.  But pci_host_config_{read,write}_common() which they're
> about to call already have checks against the config space limit and
> do the right thing.  So, remove the redundant tests.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/pci/pcie_host.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
> index 553db56778..1ee4945a6d 100644
> --- a/hw/pci/pcie_host.c
> +++ b/hw/pci/pcie_host.c
> @@ -47,11 +47,6 @@ static void pcie_mmcfg_data_write(void *opaque, hwaddr mmcfg_addr,
>      }
>      addr = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
>      limit = pci_config_size(pci_dev);
> -    if (limit <= addr) {
> -        /* conventional pci device can be behind pcie-to-pci bridge.
> -           256 <= addr < 4K has no effects. */
> -        return;
> -    }
>      pci_host_config_write_common(pci_dev, addr, limit, val, len);
>  }
>  
> @@ -70,11 +65,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
>      }
>      addr = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
>      limit = pci_config_size(pci_dev);
> -    if (limit <= addr) {
> -        /* conventional pci device can be behind pcie-to-pci bridge.
> -           256 <= addr < 4K has no effects. */
> -        return ~0x0;
> -    }
>      return pci_host_config_read_common(pci_dev, addr, limit, len);
>  }
>  


