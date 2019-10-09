Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1610ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8768520679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8768520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGPt-00067f-8V
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iIA07-00076x-Fu
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iIA06-00012o-Bb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:19:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iIA06-00012I-5E; Wed, 09 Oct 2019 07:19:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2DF5AC057F2E;
 Wed,  9 Oct 2019 11:19:25 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D56A60C18;
 Wed,  9 Oct 2019 11:19:23 +0000 (UTC)
Date: Wed, 9 Oct 2019 13:19:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/3] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
Message-ID: <20191009131921.6423f00d@redhat.com>
In-Reply-To: <20191009012106.GB14281@umbus.fritz.box>
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191008113318.7012-3-imammedo@redhat.com>
 <20191009012106.GB14281@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 09 Oct 2019 11:19:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hpoussin@reactos.org, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Oct 2019 12:21:06 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Oct 08, 2019 at 07:33:17AM -0400, Igor Mammedov wrote:
> > rs6000mc_realize() violates memory_region_allocate_system_memory() contract
> > by calling it multiple times which could break -mem-path. Replace it with
> > plain memory_region_init_ram() instead.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Or would you like me to merge this through my tree?


(since it doesn't belong to a particular tree, I'd need find
some to take in in)

Since you volunteered :),
please merge this series via your tree.

Thanks!

