Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF938C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB37214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB37214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH0QF-0002aY-3g
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 02:21:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH0PT-0002CQ-8w
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH0PS-0004a9-9c
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH0PO-0004Qj-W5
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B06353002725
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 06:20:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F677608C9;
	Thu, 18 Apr 2019 06:20:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 55FC01138648; Thu, 18 Apr 2019 08:20:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190417191805.28198-1-armbru@redhat.com>
	<20190417191805.28198-16-armbru@redhat.com>
	<73b3a105-a554-484b-1ba2-4107f3538584@redhat.com>
Date: Thu, 18 Apr 2019 08:20:26 +0200
In-Reply-To: <73b3a105-a554-484b-1ba2-4107f3538584@redhat.com> (Eric Blake's
	message of "Wed, 17 Apr 2019 14:35:34 -0500")
Message-ID: <874l6vrg0l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 18 Apr 2019 06:20:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 15/17] monitor: Clean up how
 monitor_disas() funnels output to monitor
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418062026.ppBBhRJsCnCbXDdJBBlNiKsRRkjkS_0vEAIymFT4eXc@z>

Eric Blake <eblake@redhat.com> writes:

> On 4/17/19 2:18 PM, Markus Armbruster wrote:
>> INIT_DISASSEMBLE_INFO() takes an fprintf()-like callback and a FILE *
>> to pass to it.  monitor_disas() passes monitor_fprintf() and the
>> current monitor cast to FILE *.  monitor_fprintf() casts it right
>> back, and is otherwise identical to monitor_printf().  The
>> type-pinning is ugly.
>
> For consistency with other patches in the series, s/pinning/punning/

Typo, will fix.  Thanks!

>> 
>> Pass qemu_fprintf() and NULL instead.
>> 
>> monitor_fprintf() is now unused; delete it.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---

