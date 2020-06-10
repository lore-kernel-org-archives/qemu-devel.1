Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E36AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682E8204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nfs6Eh/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682E8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiz8T-0000YA-Ko
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiz7I-0007mV-8J
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:42:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiz7F-000878-37
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591789315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=slZb4M68FczoY3PojfOK4fPLrqx0ywhrEPorukHm+KA=;
 b=Nfs6Eh/AAp0fNwNXCLDF3mF83aKZ4mzRUmcK2qpXglYU5g5Lb7FnQ+C7bW9VXovW5zk1m0
 mZnFVZsza4LsjiybcA9q90OBJq3AUQSBClcf0ZCZiAi9OXalCtVlojfAEm/EENuQ89jGp+
 fSiqzvwaqvzXTbmrVOYcI7xPucSUfeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-dk3WO8FXNDmsS7b3h3jacA-1; Wed, 10 Jun 2020 07:41:54 -0400
X-MC-Unique: dk3WO8FXNDmsS7b3h3jacA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DAFE1009600;
 Wed, 10 Jun 2020 11:41:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-151.ams2.redhat.com [10.36.113.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53FF8600F7;
 Wed, 10 Jun 2020 11:41:47 +0000 (UTC)
Date: Wed, 10 Jun 2020 13:41:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] iotests: Fix 291 across more file systems
Message-ID: <20200610114145.GD6947@linux.fritz.box>
References: <20200608195629.3299649-1-eblake@redhat.com>
 <20200609133210.GB11003@linux.fritz.box>
 <84505272-f12f-2493-835f-1f2a815dd573@redhat.com>
MIME-Version: 1.0
In-Reply-To: <84505272-f12f-2493-835f-1f2a815dd573@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.06.2020 um 22:46 hat Eric Blake geschrieben:
> On 6/9/20 8:32 AM, Kevin Wolf wrote:
> > Am 08.06.2020 um 21:56 hat Eric Blake geschrieben:
> > > Depending on the granularity of holes and amount of metadata consumed
> > > by a file, the 'disk size:' number of 'qemu-img info' is not reliable.
> > > Adjust our test to use a different set of filters to avoid spurious
> > > failures.
> > > 
> > > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > > Fixes: cf2d1203dc
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > 
> > Thanks, applied to the block branch.
> 
> It has a conflict with one of Vladimir's bitmaps patches that I'm about to
> send a pull request for; so I'll resolve the conflict and include it in my
> bitmaps tree instead, and you can drop it from yours.  I'm assuming I can
> add your Acked-by since you were willing to stage it.

Ok, no problem.

Kevin


