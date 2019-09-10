Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DDC49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185F020872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="c1Irdjr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185F020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ddv-0004Wc-Jk
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i7dSw-0002ff-UK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i7dSv-0008I3-80
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:33:42 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:34882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i7dSu-0008Gp-Mz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:33:41 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 44A1596F53;
 Tue, 10 Sep 2019 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1568111617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cmSYdqiPJ5xRzAsYP5CLn+qxleOls451ytuNUmEygM=;
 b=c1Irdjr05QIGRcFhCVWP2MESiTcFBIf6GZwEQIuKiiUZjL252oTzX/DR7NkWl3qmkZMXRF
 Kc/bhrlntw+dgTS+l+OTp3wr41ZxjOJjRLTMNZLtJ2gEfAlc+xWPS8ltcXIz5xkoV0fH4Q
 EdcmtXo/av89wmZbnCSIhoialHsgwV0=
To: qemu-devel@nongnu.org
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <930be578-ab77-178f-0055-a04541249eca@greensocs.com>
Date: Tue, 10 Sep 2019 12:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190821163341.16309-1-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1568111617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cmSYdqiPJ5xRzAsYP5CLn+qxleOls451ytuNUmEygM=;
 b=LXMk17gZBvi4xpU7oVIWQSlfh3GDJQNrqDvHaBDGW/bcRM+0UmVwQ2fvNe5teITSTOQRkQ
 a26rCyQ9NfDcTQGv5m6tIrfoxM7fZIgXaJgArjjr5sRNDDWl8p0sXycuXwN3nXlVg5Q5mY
 Okpy//ppztYhvnCmL600M7tIgXJocMU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1568111617; a=rsa-sha256; cv=none;
 b=asNTp2/l4pM3rDw6Babo7GC0GK72PhI9Vp2/ecZ8LKg/UOjfsb6mB9HN81RDQ7RBq7C3S/
 JVMxMtqnUyBZwk7S8NM09AftpBO5pPeNpcUB8jbDpYfI31rfmPemRziAjlNUwCjtu/GaXQ
 /TEb7AczUjgNFi7xC7qJ4NcuUiF1u0I=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v4 00/10] Multi-phase reset mechanism
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, berrange@redhat.com,
 ehabkost@redhat.com, mark.burton@greensocs.com, pbonzini@redhat.com,
 philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping !

Any comments ?

Thanks,
Damien

On 8/21/19 6:33 PM, Damien Hedde wrote:
> Hi all,
> 
> Here's the 4th version of the multi-phase reset proposal patches.
> Previous version can be found here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06365.html
> 
> The purpose of this series is to split the current reset procedure into
> multiple phases. This will help to solve some ordering difficulties we have
> during reset. Please see patch 4 which adds documentation for more details.
> 
> Compared to previous version, I've reduced the scope of the series to
> multi-phase basics. In particular, I've removed migration-related features
> which can be added and discussed later when we've settled the api. I've also
> not included the change to the new api for the ~20 impacted files because it
> highly depends on whether we handle cold vs warm reset difference or not. I'll
> handle them when we'll advance on this point.
> 
> I've isolated in patch 2 to 4, the multi-phase base mechanism handling only
> cold reset as suggested by David.
> Patches 5 and 6 do trivial modifications related to the registration of reset
> handler in the main system reset.
> Patch 7 handles the hotplug device reset case.
> These first 7 patches form a multi-phase basics independent subset; the first 6
> do not modify the behavior. I'd really like to move forward on them as we have
> things depending on the basic multi-phase capability only (in particular the
> clock-tree support).
> 
> Nevertheless I've kept in this series the addition of warm reset (in patches 8
> to 10) so we can continue the discussion. Even if we don't introduce warm
> reset, it allows discussion about multiple reset type support.
> Maybe I should have put these 3 patches in their own (rfc ?) series, since
> there was lot of questioning about the warm reset and talking about handling
> other resets like bus specific ones.
> 
> I've tested that the actual reset order was not modified by these patches by
> tracing calls to individual reset method after and before applying the series.
> 
> 
> Changes v3 -> v4
> general:
>     + various comments and typos
> patch 1: add device_legacy_reset function to prepare for reset api change
>     + squash of 2 patches from v3 (asked by Peter and David)
> patch 2: Create Resettable QOM interface
>     + ResetType enum (only cold for now) (David and Philippe's remark)
>     + ResetState to factorize most of the code (to address David's concern)
>     + all phases order is now children-to-parent (Peter's remark)
>     + assert/deassert removed to isolate migration related features
> patch 3: add Resettable interface in Bus and Device classes
>     + squash of 2 patches (make Device and Bus Resettable & switch to
>       resettable api) since patch 2 has reduced their size.
>     + adaptation to patch 2 changes (warm reset, state and methods)
>     + isolate hotplug reset change into patch 7 (Peter's remark)
>     + fix qdev/qbus_reset_not doing a cold reset (Peter's remark)
>     + call helper device_reset_cold instead of device_reset (David's remark)
> patch 4: docs/devel/reset.txt: create doc about Resettable interface
>     + various improvements
>     + in this patch, doc is reduced to cold multi-phase reset with no "in reset"
>       state (other parts are kept for following commits)
> patch 5: vl.c: replace deprecated qbus_reset_all registration
>     + suggested comment improvement from Peter
> patch 6: hw/s390x/ipl.c: replace deprecated qbus_reset_all registration
>     + suggested comment improvement from Peter
> 
> Thanks for your feedback,
> Damien
> 
> Damien Hedde (10):
>   add device_legacy_reset function to prepare for reset api change
>   hw/core: create Resettable QOM interface
>   hw/core: add Resettable interface in Bus and Device classes
>   docs/devel/reset.txt: create doc about Resettable interface
>   vl.c: replace deprecated qbus_reset_all registration
>   hw/s390x/ipl.c: replace deprecated qbus_reset_all registration
>   hw/core/qdev: replace deprecated device_legacy_reset when hotplugging
>     device
>   hw/core/resettable: add support for warm reset
>   hw/core/: add warm reset helpers for devices and buses
>   docs/devel/reset.txt: add documentation about warm reset
> 
>  Makefile.objs            |   1 +
>  docs/devel/reset.txt     | 284 +++++++++++++++++++++++++++++++++++++++
>  hw/audio/intel-hda.c     |   2 +-
>  hw/core/Makefile.objs    |   1 +
>  hw/core/bus.c            |  64 +++++++++
>  hw/core/qdev.c           |  86 +++++++++---
>  hw/core/resettable.c     | 199 +++++++++++++++++++++++++++
>  hw/core/trace-events     |  36 +++++
>  hw/hyperv/hyperv.c       |   2 +-
>  hw/i386/pc.c             |   2 +-
>  hw/ide/microdrive.c      |   8 +-
>  hw/intc/spapr_xive.c     |   2 +-
>  hw/ppc/pnv_psi.c         |   2 +-
>  hw/ppc/spapr_pci.c       |   2 +-
>  hw/ppc/spapr_vio.c       |   2 +-
>  hw/s390x/ipl.c           |  10 +-
>  hw/s390x/s390-pci-inst.c |   2 +-
>  hw/scsi/vmw_pvscsi.c     |   2 +-
>  hw/sd/omap_mmc.c         |   2 +-
>  hw/sd/pl181.c            |   2 +-
>  include/hw/qdev-core.h   | 100 +++++++++++++-
>  include/hw/resettable.h  | 171 +++++++++++++++++++++++
>  tests/Makefile.include   |   1 +
>  vl.c                     |  10 +-
>  24 files changed, 949 insertions(+), 44 deletions(-)
>  create mode 100644 docs/devel/reset.txt
>  create mode 100644 hw/core/resettable.c
>  create mode 100644 hw/core/trace-events
>  create mode 100644 include/hw/resettable.h
> 

