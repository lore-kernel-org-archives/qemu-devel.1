Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF6C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D339A21734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D339A21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49507 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdsV-0005j6-Aw
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:30:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRdrP-00050e-4h
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRdrO-0003Tc-22
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRdrN-0003Sn-ST
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:29:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B35003078AB7;
	Fri, 17 May 2019 14:29:15 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 03B5D5D9CD;
	Fri, 17 May 2019 14:29:09 +0000 (UTC)
Date: Fri, 17 May 2019 16:29:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190517162903.4fc94708@Igors-MacBook-Pro>
In-Reply-To: <20190517125957.56uoupbo3ai4jybr@master>
References: <20190517005114.19456-1-richardw.yang@linux.intel.com>
	<20190517131116.02b25408@Igors-MacBook-Pro>
	<20190517125957.56uoupbo3ai4jybr@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 17 May 2019 14:29:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/acpi: ACPI_PCI should depends on both
 ACPI and PCI
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
Cc: mst@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 12:59:57 +0000
Wei Yang <richard.weiyang@gmail.com> wrote:

> On Fri, May 17, 2019 at 01:11:16PM +0200, Igor Mammedov wrote:
> >On Fri, 17 May 2019 08:51:14 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >
> >> Pointed out by Philippe Mathieu-Daud?? <philmd@redhat.com>.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  hw/acpi/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> >> index 7265843cc3..7c59cf900b 100644
> >> --- a/hw/acpi/Kconfig
> >> +++ b/hw/acpi/Kconfig
> >> @@ -25,7 +25,7 @@ config ACPI_NVDIMM
> >>  
> >>  config ACPI_PCI
> >>      bool
> >> -    depends on ACPI
> >> +    depends on ACPI && PCI
> >>  
> >>  config ACPI_VMGENID
> >>      bool
> >
> >are you sure you didn't miss anything?
> >
> 
> This patch is based on the comment in
> http://qemu.11.n7.nabble.com/PATCH-v4-0-6-Extract-build-mcfg-tt650106.html#a655913
> 
> My understanding is not correct?

That wasn't the end of discussion, it continued on until Philippe suggested
the below changes

> 
> >On Fri, 17 May 2019 10:37:42 +0200
> >Philippe Mathieu-Daud?? <philmd@redhat.com> wrote:
> >
> >[...]
> >> 
> >> config ARM_VIRT
> >>     ...
> >>     select ACPI_PCI
> >> 
> >> config ACPI_PCI
> >>     bool
> >>     depends on ACPI && PCI
> >> 
> >
> >
> 


