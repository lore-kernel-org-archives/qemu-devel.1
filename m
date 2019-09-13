Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04057C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCE920830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCE920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ilq-0007nF-1U
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8il1-0007Ec-TL
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8il0-0005Fx-Tf
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:24:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8il0-0005Fa-OT
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:24:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 697B118C8936
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 10:24:49 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FE2A5C219;
 Fri, 13 Sep 2019 10:24:48 +0000 (UTC)
Date: Fri, 13 Sep 2019 11:24:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190913102445.GA2682@work-vm>
References: <20190911190622.7629-1-dgilbert@redhat.com>
 <20190911190622.7629-2-dgilbert@redhat.com>
 <e8802180-3c9a-97b9-dae1-5e07d7843de3@redhat.com>
 <20190912174524.GD2722@work-vm>
 <cfead2da-0ccd-b629-4e5d-05cdffa34698@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfead2da-0ccd-b629-4e5d-05cdffa34698@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 13 Sep 2019 10:24:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/5] rcu: Add automatically released
 rcu_read_lock variant
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
Cc: quintela@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 12/09/19 19:45, Dr. David Alan Gilbert wrote:
> > Do you think it's best to use the block version for all cases
> > or to use the non-block version by taste?
> > The block version is quite nice, but that turns most of the patches
> > into 'indent everything'.
> 
> I don't really know myself.

OK, new version coming up with a mix - the diffs do look a lot more
hectic with the block version.

> On first glance I didn't like too much the non-block version and thought
> it was because our coding standards does not include variables declared
> in the middle of a block.

I took that as being a coding standard to avoid confusing humans and
since it wasn't visible it didn't matter too much.

> However, I think what really bothering me is
> "AUTO" in the name.  What do you think about "RCU_READ_LOCK_GUARD()"?
> The block version would have the additional prefix "WITH_".

Oh well, if it's just the name we can fix that.

> We could also add LOCK_GUARD(lock) and WITH_LOCK_GUARD(lock), using
> QemuLockable for polymorphism.  I even had patches a while ago (though
> they used something like LOCK_GUARD(guard_var, lock).  I think we
> dropped them because of fear that the API was a bit over-engineered.

Probably a separate set.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

