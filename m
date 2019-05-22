Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6677EC282DE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D17420881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D17420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTPz-0002Jg-BE
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:44:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTM6-0006e9-AU
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTAQ-0003Wi-Rs
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:28:36 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTAQ-0003Qf-IH; Wed, 22 May 2019 11:28:34 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MA88C-1hNNIj19je-00BgYr; Wed, 22 May 2019 17:28:23 +0200
To: Li Qiang <liq3ea@163.com>, alex.williamson@redhat.com, lvivier@redhat.com
References: <20190521151543.92274-1-liq3ea@163.com>
	<20190521151543.92274-5-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <79fbe9f0-9e9c-e336-6d8c-ace70910def8@vivier.eu>
Date: Wed, 22 May 2019 17:28:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190521151543.92274-5-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:47S8TV6j+NyPoexXxIrNiMRl+f69Ut2upVf0LZ/I+GRojZOpPVG
	uR2mCzp4iYcx303UJmdh/TcNDpglsj4pmrojftXFCKsh/HSNUAFA24jfJe6ieXKwcml5nte
	PBzxfbSa/hBS0vEQLRp7sc1cMGlfVLzpEZIxtNP7APaVFfwq7nToChS/FSLuDe3boyzLkQb
	7/U2uqw3Glynrz1XmMf2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bhrVebz6tMo=:43BxW8/E8POmQ7p6HYI6+5
	CiwEB/KB5wxBh0gMRmWsJauMi9PFicADfgai5Tw60rtFPr3hi9FVnEK3IUvUQaJDdEBg+juBB
	waK/nVCpfmdixs84B1bZ1FWaUpbCJCRkTdG+l82aKCbKV17C6rS455eKAfzQyutybT+FfPpGc
	fA50KsQuKauq4o1A5WeJSWJknxohwDryCQ3+QaseHZHRSLuTl1G4X9d7MpTmOF5sgjpiV3/bk
	HkCYeMNtJzBE+Q4+5fetZ6hmdp0ZQVbrULHNlxf3j4fUdE3yEvO1Dztu9sXQyofJ3jypX1TMQ
	lOckBdOJuCig3Gz55HgZ4Dnz85YAELujWpdLYZgXAr6keyfKBBY9KQnKSt1G6PidiYo2aWyUn
	Sfz8xjsGB69ff53lCYTPbIUNY18cKMnGveBCCUYq8lUXInaFxYFSmt3ZMBDXWNMwdVs+FHOrW
	opAXFo/bFxcnDigCVNiZlaxBar98NPpNKXO4wh23KW+u1wcpChvwZSAwI/ymRm1VrtcM3oHB+
	hkfvW/cqHr4iOKEZwDkxOrraprgjRR4enkzdlPxsnAkTvpptvWBGG26v+iaagos8lmOEqHK+h
	Hpd+tfa9otnFldbCRk961z31EDJRCYquOqADvHRB9jqo+AidnFTrl9ELCpV2XPS7KB8PhWFmR
	5Ir9WmmaRPY9I4DpOTIBS2CCWE9zCE3juBJkRAq+VKzN6hkqMaXKlMgyvEAnda7Anjan3BaKa
	BKvFp9EpoehG0GASeGzVHa4v5DpUeRI6pFDlSeTHckkVoQbcXhE91lavJu4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 4/4] pci: msix: move
 'MSIX_CAP_LENGTH' to header file
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
Cc: qemu-trivial@nongnu.org, liq3ea@gmail.com, philmd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/2019 17:15, Li Qiang wrote:
> 'MSIX_CAP_LENGTH' is defined in two .c file. Move it
> to hw/pci/msix.h file to reduce duplicated code.
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   hw/pci/msix.c         | 2 --
>   hw/vfio/pci.c         | 2 --
>   include/hw/pci/msix.h | 2 ++
>   3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 4e336416a7..d39dcf32e8 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -24,8 +24,6 @@
>   #include "qapi/error.h"
>   #include "trace.h"
>   
> -#define MSIX_CAP_LENGTH 12
> -
>   /* MSI enable bit and maskall bit are in byte 1 in FLAGS register */
>   #define MSIX_CONTROL_OFFSET (PCI_MSIX_FLAGS + 1)
>   #define MSIX_ENABLE_MASK (PCI_MSIX_FLAGS_ENABLE >> 8)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 08729e5875..8e555db12e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -35,8 +35,6 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   
> -#define MSIX_CAP_LENGTH 12
> -
>   #define TYPE_VFIO_PCI "vfio-pci"
>   #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
>   
> diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
> index 1f27658d35..08acfa836e 100644
> --- a/include/hw/pci/msix.h
> +++ b/include/hw/pci/msix.h
> @@ -4,6 +4,8 @@
>   #include "qemu-common.h"
>   #include "hw/pci/pci.h"
>   
> +#define MSIX_CAP_LENGTH 12
> +
>   void msix_set_message(PCIDevice *dev, int vector, MSIMessage msg);
>   MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector);
>   int msix_init(PCIDevice *dev, unsigned short nentries,
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

