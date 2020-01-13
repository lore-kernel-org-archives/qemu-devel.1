Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D01C33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23296214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fuqbt0ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23296214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir4vq-0006w4-6M
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 13:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ir4vB-0006Jm-U6
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ir4v9-0001OD-Bx
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:58:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52660
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ir4v9-0001NS-7a
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578941918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fYWnDvGFIQofaUmvhfPoFbPHu75rO+XWf8ERb9batA=;
 b=Fuqbt0ixykuS/Ibg5ZoKNybxBbm1jrDahRolhX6dtHSUJv53AJuap3K3xUyn3nAZkjLaWY
 gQkj/jpU+YNXsqT+LHDZGa//Vxw/5/pQXtV41aDqEGy9JXlQc6Aqmq+gu/qbVofeibiWTg
 EfeGBeB5Dxyn/tLLcaXYa2XZQWvVY6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-YjlPkxiKM_iZgoq0Of8udQ-1; Mon, 13 Jan 2020 13:58:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42033106B72F
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 18:58:36 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A77EC60BF1;
 Mon, 13 Jan 2020 18:58:32 +0000 (UTC)
Date: Mon, 13 Jan 2020 18:58:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/3] exclude hyperv synic sections from vhost
Message-ID: <20200113184931.GB3155@work-vm>
References: <20200113173647.84842-1-dgilbert@redhat.com>
 <1bab529a-8655-ee28-f137-0311fb7839ff@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1bab529a-8655-ee28-f137-0311fb7839ff@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YjlPkxiKM_iZgoq0Of8udQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: jasowang@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 13/01/20 18:36, Dr. David Alan Gilbert (git) wrote:
> >=20
> > Hyperv's synic (that we emulate) is a feature that allows the guest
> > to place some magic (4k) pages of RAM anywhere it likes in GPA.
> > This confuses vhost's RAM section merging when these pages
> > land over the top of hugepages.
>=20
> Can you explain what is the confusion like?  The memory API should just
> tell vhost to treat it as three sections (RAM before synIC, synIC
> region, RAM after synIC) and it's not clear to me why postcopy breaks
> either.

There's two separate problems:
  a) For vhost-user there's a limited size for the 'mem table' message
     containing the number of regions to send; that's small - so an
     attempt is made to coalesce regions that all refer to the same
     underlying RAMblock.  If things split the region up you use more
     slots. (it's why the coalescing code was originally there.)

  b) With postcopy + vhost-user life gets more complex because of
     userfault.  We require that the vhost-user client can mmap the
     memory areas on host page granularity (i.e. hugepage granularity
     if it's hugepage backed).  To do that we tweak the aggregation code
     to align the blocks to page size boundaries and then perform
     aggregation - as long as nothing else important gets in the way
     we're OK.
     In this case the guest is programming synic to land at the 512k
     boundary (in 16 separate 4k pages next to each other).  So we end
     up with 0-512k (stretched to 0..2MB alignment) - then we see
     synic (512k-+4k ...) then we see RAM at 640k - and when we try
     to align that we error because we realise the synic mapping is in
     the way and we can't merge the 640k ram chunk with the base 0-512k
     aligned chunk.

Note the reported failure here is kernel vhost, not vhost-user;
so actually it probably doesn't need the alignment, and vhost-user would
probably filter out the synic mappings anyway due to the fact they've
not got an fd ( vhost_user_mem_section_filter ).  But the alignment
code always runs.

Dave



> Paolo
>=20
> > Since they're not normal RAM, and they shouldn't have vhost DMAing
> > into them, exclude them from the vhost set.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


