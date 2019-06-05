Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD233C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9310206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9310206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40461 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUnn-0001q0-UC
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 08:13:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYUn0-0001XF-Rg
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYUmz-0002qC-ST
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hYUmz-00022E-Mg
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:13:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FEC6309266A;
	Wed,  5 Jun 2019 12:12:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9256A1001E79;
	Wed,  5 Jun 2019 12:12:31 +0000 (UTC)
Date: Wed, 5 Jun 2019 14:12:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190605140841.63e8aa85@redhat.com>
In-Reply-To: <729bde4a-bcb9-dac5-3a8a-04cc5f4d2bf9@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-8-tao3.xu@intel.com>
	<20190604170456.5b3c198e@redhat.com>
	<729bde4a-bcb9-dac5-3a8a-04cc5f4d2bf9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 05 Jun 2019 12:12:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 07/11] hmat acpi: Build Memory Side
 Cache Information Structure(s) in ACPI HMAT
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
	qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
	ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Jun 2019 14:04:10 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 6/4/2019 11:04 PM, Igor Mammedov wrote:
> > On Wed,  8 May 2019 14:17:22 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >   
> >> From: Liu Jingqi <jingqi.liu@intel.com>
> >>
> >> This structure describes memory side cache information for memory
> >> proximity domains if the memory side cache is present and the
> >> physical device(SMBIOS handle) forms the memory side cache.
> >> The software could use this information to effectively place
> >> the data in memory to maximize the performance of the system
> >> memory that use the memory side cache.
> >>
> >> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> >> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >> ---
> >>  
> ...
> >> +
> >> +                /* SMBIOS Handles */
> >> +                /* TBD: set smbios handles */
> >> +                build_append_int_noprefix(table_data, 0, 2 * n);  
> > Is memory side cache structure useful at all without pointing to SMBIOS entries?
> >   
> They are not useful yet, and the kernel 5.1 HMAT sysfs doesn't show 
> SMBIOS entries. We can update it if it useful in the future.

In that case I'd suggest to drop it for now until this table is properly
populated and ready for consumption. (i.e. drop this patch and corresponding
CLI 9/11 patch).

