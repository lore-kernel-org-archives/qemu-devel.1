Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2A52086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2A52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBO8G-0005n6-8J
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 14:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iBO3n-0001Il-17
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iBO3m-0007Ri-0D
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:55:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iBO3l-0007RD-Q2
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:55:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1EFEB10DCC8B
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 18:55:13 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AA5360C18;
 Fri, 20 Sep 2019 18:55:12 +0000 (UTC)
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
To: Kevin Wolf <kwolf@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920083630.GA5458@localhost.localdomain>
 <566d0d07-35fc-2d66-a47c-00526546b31e@redhat.com>
 <20190920181119.GF5458@localhost.localdomain>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <4d1d6516-fc4a-6258-e993-452f92cdfa28@redhat.com>
Date: Fri, 20 Sep 2019 13:55:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920181119.GF5458@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 20 Sep 2019 18:55:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: tasleson@redhat.com
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 1:11 PM, Kevin Wolf wrote:
> Emitting a QMP event when blkdebug injects an error makes sense to me.
> 
> I wouldn't use it for this case, though, because this would become racy.
> It could happen that the guest writes to the image, which sends a QMP
> event, and then reads before the external program has removed the error.

My POC had a single lock protecting it's shared state.  I'm kind of
surprised no one jumped on that because it's a big point of lock
contention.  One could argue that the state data and associated lock(s)
should be on each device which leads me to the next point.  I think with
careful locking and sequencing we could address this race condition so
that the error was removed before the write completed.  In fact it would
need to work that way to allow the external test code the ability to
perturb the data before it's written if that's what the test wanted to do.

-Tony

