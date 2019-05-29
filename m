Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E902C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F8A21734
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F8A21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVqVh-00034z-Cp
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 00:48:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqSl-0000mc-M6
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqSk-00005m-Bi
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVqSk-000059-67
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76A78D4E72;
	Wed, 29 May 2019 04:45:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 011A06026C;
	Wed, 29 May 2019 04:45:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3FDAD11AAB; Wed, 29 May 2019 06:45:14 +0200 (CEST)
Date: Wed, 29 May 2019 06:45:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190529044514.ycikti2bj2tem2rb@sirius.home.kraxel.org>
References: <20190528204838.21568-1-kraxel@redhat.com>
	<bf45adf2-1594-89b4-6a4d-9af6d9e8ac6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf45adf2-1594-89b4-6a4d-9af6d9e8ac6e@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 29 May 2019 04:45:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: split memory at 2G
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	=?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 03:21:16AM +0200, Paolo Bonzini wrote:
> On 28/05/19 22:48, Gerd Hoffmann wrote:
> > Original q35 behavior was to split memory 2.75 GB, leaving space for the
> > mmconfig bar at 0xb000000 and pci I/O window starting at 0xc0000000.
> > 
> > Note: Those machine types have been removed from the qemu codebase
> > meanwhile because they could not be live-migrated so there was little
> > value in keeping them around.
> > 
> > With the effort to allow for gigabyte-alignment of guest memory that
> > behavior was changed:  The split was moved to 2G, but only in case the
> > memory didn't fit below 2.75 GB.
> > 
> > So today the address space between 2G and 2,75G is not used for guest
> > memory in typical use cases, where the guest memory sized at a power of
> > two or a gigabyte number.  But if you configure your guest with some odd
> > amout of memory (such as 2.5G) the address space is used.
> 
> Wasn't it done to ensure pre-PAE OSes could use as much memory as
> possible?  (If you run pre-PAE OSes with more RAM than can fit below 4G,
> you can just reduce the amount of memory and get all the 2.75G).

Well, those guests are better served with 'pc' where we don't need
address space for mmconfig and you can get 3.5G with no trouble and even
a bit more with extra tweaks (see longish comment in hw/i386/pc_piix.c
explaining all the memory handling options).

cheers,
  Gerd


