Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD28C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 18:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFEA2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 18:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFEA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i87Lb-000869-M5
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 14:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i87Kn-0007ag-4d
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i87Kl-0006uM-GQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i87Kl-0006tO-7a
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:27:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49AED300BEAC
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 18:27:14 +0000 (UTC)
Received: from work-vm (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72EDC60C83;
 Wed, 11 Sep 2019 18:27:11 +0000 (UTC)
Date: Wed, 11 Sep 2019 19:27:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190911182709.GM2894@work-vm>
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
 <1a03f787-5cf8-6b8e-7489-3f90c3311032@redhat.com>
 <4c73915d-c4c8-0829-855b-ab5775d7e6fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c73915d-c4c8-0829-855b-ab5775d7e6fe@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 11 Sep 2019 18:27:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] rcu: Add automatically released
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 9/11/19 12:40 PM, Eric Blake wrote:
> 
> >> +
> >> +#define RCU_READ_LOCK_AUTO g_auto(rcu_read_auto_t) \
> >> +    _rcu_read_auto = 'x'; \
> > 
> > I'm a bit lost at where _rcu_read_auto is declared.  (I could understand
> > if an earlier macro had created that typedef via concatenating _ with
> > rcu_read_auto_t, but making the preprocessor drop _t is not possible. Is
> > this a typo, and if so, why did the compiler not complain?)
> 
> Okay, I read it wrong.  This rendering would be easier for me to
> understand (you are declaring a dummy variable right here):
> 
> #define RCU_READ_LOCK_AUTO \
>     g_auto(rcu_read_auto_t) _rcu_read_auto = 'x'; \
> ...
> 
> In other words, I'm not used to expecting a split between type and
> variable name across two lines, especially when the type is itself a
> macro call, and where my first reading didn't spot that
> (rcu_read_auto_t) was not the name of the argument to a mixed-case macro
> RCU_READ_LOACK_AUTO_g_auto, rather than g_auto(...) being the start of
> the parameter-less macro RCU_READ_LOCK_AUTO definition.

Yep, that's simplified after the rework Dan suggested.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

