Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF61AC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6ECA21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6ECA21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5Zq-0008Fj-M3
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:17:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hT5YG-0007Wv-1T
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hT5YE-0007Vs-2n
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:15:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hT5Y4-0006tg-Ip; Tue, 21 May 2019 10:15:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F25FC3098557;
	Tue, 21 May 2019 14:15:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1974C4387;
	Tue, 21 May 2019 14:15:08 +0000 (UTC)
Date: Tue, 21 May 2019 16:15:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190521161504.75ca268c@redhat.com>
In-Reply-To: <20190520233730-mutt-send-email-mst@kernel.org>
References: <20190521033249.1960-1-richardw.yang@linux.intel.com>
	<20190521033249.1960-2-richardw.yang@linux.intel.com>
	<20190520233730-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 21 May 2019 14:15:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/2] hw/acpi: Consolidate build_mcfg to
 pci.c
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 23:37:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, May 21, 2019 at 11:32:48AM +0800, Wei Yang wrote:
> > Now we have two identical build_mcfg functions.
> > 
> > Consolidate them in acpi/pci.c.
> > 
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > 
> > ---
> > v5:
> >   * ACPI_PCI depends on both ACPI and PCI
> >   * rebase on latest master, adjust arm Kconfig
> > v3:
> >   * adjust changelog based on Igor's suggestion
> > ---  
> 
> 
> same as 2/2 - do not use two --- separators pls.

I don't really get this requirement, it's common practice on
list(s) and used to work just fine.

The 1st separator is added by hand when editing commit message
to separate change log from main commit message so that 'git am'
would drop change log. While the second separator is added
automatically by git when patch is created.

