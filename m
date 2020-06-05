Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CD0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BBF206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BBF206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBsL-0004MR-1N
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jhBr9-0002y7-KJ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:53:55 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:13910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jhBr8-0005m0-FU
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:53:55 -0400
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: /juzaFSyuxSsjxkI8C+yClErZVYhQFdTvuPWQcgDMxe+zaTz7wXvLS40SZ//qtk/hCu9J7HjTM
 88u3dVeRA9Or9FWXGF3rZmWL/+ByENZhhUTOI8Zx+6To+WUC+Uvc5Fo2w+1Wz8Ru7stZcZsz7i
 4by3E45V6cHE2bXi+glSXt/f86NO1f24YkO6mk4tYHT2A7CFZdHSstV1Q4SS4UpLZPCpkP1Sdq
 0yAcCI4sSZY2o/8Zrz054bbIp/+WIoHg+E++TNX5UWPr9Q+Ig7xozXHvj2qv04rn/1JElZ7+30
 kcA=
X-SBRS: 2.7
X-MesageID: 20076016
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,476,1583211600"; d="scan'208";a="20076016"
Date: Fri, 5 Jun 2020 13:53:40 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5] xen: fix build without pci passthrough
Message-ID: <20200605125340.GP2105@perard.uk.xensource.com>
References: <20200604183141.32044-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200604183141.32044-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=anthony.perard@citrix.com; helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 08:53:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 02:31:41PM -0400, Paolo Bonzini wrote:
> diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
> index 340b2c5096..3fc715e595 100644
> --- a/hw/xen/Makefile.objs
> +++ b/hw/xen/Makefile.objs
> @@ -1,6 +1,7 @@
>  # xen backend driver support
> -common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-bus-helper.o xen-backend.o
> +common-obj-y += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-bus-helper.o xen-backend.o
>  
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
> +obj-$(call $(lnot, $(CONFIG_XEN_PCI_PASSTHROUGH))) += xen_pt_stub.o

With this instead been spelled:
    obj-$(call lnot,$(CONFIG_XEN_PCI_PASSTHROUGH)) += xen_pt_stub.o

I think the other changes are fine.

Thanks,

-- 
Anthony PERARD

