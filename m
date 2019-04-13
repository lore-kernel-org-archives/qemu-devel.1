Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7761C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78862171F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78862171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFAlr-0003No-Ir
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 01:00:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFAl3-00033a-FD
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 00:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFAl2-00036c-IL
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 00:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hFAl2-00035d-9Y
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 00:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A47E8666A
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 04:59:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE65A5C206;
	Sat, 13 Apr 2019 04:59:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5EF411138648; Sat, 13 Apr 2019 06:59:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-18-armbru@redhat.com>
	<20190412183946.GS2906@work-vm>
Date: Sat, 13 Apr 2019 06:59:13 +0200
In-Reply-To: <20190412183946.GS2906@work-vm> (David Alan Gilbert's message of
	"Fri, 12 Apr 2019 19:39:47 +0100")
Message-ID: <87wojyh55q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sat, 13 Apr 2019 04:59:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 17/17] include: Move fprintf_function to
 disas/
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413045913.D-20fTgtibF-xxnUZlqqRMCLOOO6K7Ct-OYQAkjdSA4@z>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> The previous commits have eliminated fprintf_function outside
>> disassemblers, simplifying code and cleaning up the ugly type-punning
>> fprintf_function seems to attract.  Move fprintf_function to
>> include/disas/dis-asm.h to reduce the temptation to abuse it.
>> 
>> I considered renaming it to fprintf_ftype (reverting that part of
>> commit 6e2d864edf5, v0.14.0) to get us closer to binutils, but I
>> figure the fork is too distant to make this worthwhile.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> I'm OKish with this - although it's the only place we currently
> use it, it's a fairly common concept, so I'm not sure it's worth
> banishing.

I found 15 uses, ranging from questionable to outright bad.  I
eliminated 14, and cleaned up one.  I guess that has made me skeptical
on the chances of this type getting used sanely.

Banishing the type to where it came from reduces the temptation.

Perhaps that's not actually necessary now we've gotten rid of the bad
examples.

Should a sane use come up, we can simply revert this patch.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

