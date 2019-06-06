Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0FFC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C8720645
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C8720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvEN-000367-2o
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:27:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYvDg-0002nV-Nj
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYvDf-0000a9-RY
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hYvDf-00082u-MK
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A74A19CF77;
	Thu,  6 Jun 2019 16:25:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D8607C43D;
	Thu,  6 Jun 2019 16:25:44 +0000 (UTC)
Date: Thu, 6 Jun 2019 18:25:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190606182540.6afb128b@redhat.com>
In-Reply-To: <8f765b45-c67e-b6cc-e8eb-8a8a291aeb50@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-5-tao3.xu@intel.com>
	<20190524143534.7dfdcd57@redhat.com>
	<8f765b45-c67e-b6cc-e8eb-8a8a291aeb50@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 06 Jun 2019 16:25:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 04/11] acpi: introduce
 AcpiDeviceIfClass.build_mem_ranges hook
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Jun 2019 13:15:43 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 5/24/2019 8:35 PM, Igor Mammedov wrote:
> > On Wed,  8 May 2019 14:17:19 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >   
> >> Add build_mem_ranges callback to AcpiDeviceIfClass and use
> >> it for generating SRAT and HMAT numa memory ranges.
> >>
> >> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> >> Co-developed-by: Liu Jingqi <jingqi.liu@intel.com>
> >> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> >> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >> ---  
> ...
> >> diff --git a/stubs/pc_build_mem_ranges.c b/stubs/pc_build_mem_ranges.c
> >> new file mode 100644
> >> index 0000000000..0f104ba79d
> >> --- /dev/null
> >> +++ b/stubs/pc_build_mem_ranges.c
> >> @@ -0,0 +1,6 @@
> >> +#include "qemu/osdep.h"
> >> +#include "hw/i386/pc.h"
> >> +
> >> +void pc_build_mem_ranges(AcpiDeviceIf *adev, MachineState *machine)
> >> +{
> >> +}  
> > 
> > why do you need stub?
> >   
> Hi Igor,
> 
> I have questions here, I use stub here because we add hook pointer in 
> piix4.c but other arch such mips use piix4. Without stub, it will failed 
> when compile, like pc_madt_cpu_entry.
> Or there are other way to make it use just in pc?
I forgot that piix4 is uesed by mips as well, it's perfectly fine to add
stub in this case.
Though, I'd add a comment above the stub about why it's there to avoid
questions.
Later comment might make life easier for whoever touches this code
wouldn't have to figure out mips dependency the hard way.

> 
> Thank you!
> 


