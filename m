Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A056C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31B621883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31B621883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cZW-0001XE-Ca
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5c8A-0004wJ-KD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5c88-0005sU-29
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:43:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1i5c87-0005re-T3; Wed, 04 Sep 2019 16:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0363BC059B6F;
 Wed,  4 Sep 2019 20:43:50 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51C331001281;
 Wed,  4 Sep 2019 20:43:49 +0000 (UTC)
Date: Wed, 4 Sep 2019 17:43:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190904204347.GC4617@habkost.net>
References: <20190805071302.6260-1-tao3.xu@intel.com>
 <20190903175258.GS3694@habkost.net>
 <428a67b2-4bf4-b9ab-b06e-f06bc12e721d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428a67b2-4bf4-b9ab-b06e-f06bc12e721d@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 04 Sep 2019 20:43:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] numa: Introduce
 MachineClass::auto_enable_numa for implicit NUMA node
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 04, 2019 at 02:22:39PM +0800, Tao Xu wrote:
> On 9/4/2019 1:52 AM, Eduardo Habkost wrote:
> > On Mon, Aug 05, 2019 at 03:13:02PM +0800, Tao Xu wrote:
> > > Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
> > > is expected to be created implicitly.
> > > 
> > > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > 
> > This introduces spurious warnings when running qemu-system-ppc64.
> > See: https://lore.kernel.org/qemu-devel/CAFEAcA-AvFS2cbDH-t5SxgY9hA=LGL81_8dn-vh193vtV9W1Lg@mail.gmail.com/
> > 
> > To reproduce it, just run 'qemu-system-ppc64 -machine pseries'
> > without any -numa arguments.
> > 
> > I have removed this patch from machine-next so it won't block the
> > existing pull request.
> > 
> I got it. If default splitting of RAM between nodes is
> deprecated, this patch can't reuse the splitting code. I agree with droping
> this patch.

Probably all we need to fix this issue is to replace
  NumaNodeOptions node = { };
with
  NumaNodeOptions node = { .size = ram_size };
in the auto_enable_numa block.

Do you plan to send v2?

-- 
Eduardo

