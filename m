Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C2C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A0A206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A0A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIa4H-0000jJ-Qd
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iIa2W-0007LG-0L
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iIa2U-0007vP-NU
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:07:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iIa2U-0007vD-F1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A82F43086E2F;
 Thu, 10 Oct 2019 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72F3D5D713;
 Thu, 10 Oct 2019 15:07:35 +0000 (UTC)
Date: Thu, 10 Oct 2019 17:07:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/2] qapi: Allow introspecting fix for savevm's
 cooperation with blockdev
Message-ID: <20191010150733.GE7616@localhost.localdomain>
References: <cover.1568989362.git.pkrempa@redhat.com>
 <992ea9ca130b4fb6dbf82726aa3b1d8040c16944.1568989362.git.pkrempa@redhat.com>
 <87r23w2rbp.fsf@dusky.pond.sub.org>
 <b15fdae1-1e70-fe13-701e-48a04d56c93f@redhat.com>
 <87a7ajuzpw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7ajuzpw.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 10 Oct 2019 15:07:36 +0000 (UTC)
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.10.2019 um 13:57 hat Markus Armbruster geschrieben:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 10/1/19 2:34 PM, Markus Armbruster wrote:
> >> Peter Krempa <pkrempa@redhat.com> writes:
> >>
> >>> savevm was buggy as it considered all monitor owned block device nodes
> >>
> >> Recommend "monitor-owned block device nodes" or "block device nodes
> >> owned by a monitor"
> >>
> >>> for snapshot. With introduction of -blockdev the common usage made all
> >>> nodes including protocol nodes monitor owned and thus considered for
> >>> snapshot.
> >>
> >> What exactly is / was the problem?
> >
> >
> > Old way: using QMP add_device, you create a drive backend with two BDS
> > (format and protocol) assigned to it; the drive backend has your given
> > name, and both BDS have a generated name (beginning with '#').  The
> > two BDS are not monitor-owned, rather, the drive is.
> >
> > New way: using QMP blockdev_add, you create the two BDS manually with
> > names of your choice, then plug that blockdev into an unnamed
> > blockbackend (the drive no longer needs a name, because you can get at
> > everything through the BDS name).  You _could_ do this in one step
> > (the QAPI allows self-recursion where you can define both the format
> > and protocol in one step), but it is easier to do in two steps (define
> > the protocol BDS first, then define the format BDS using a "string"
> > name of the protocol BDS instead of a { "driver":..., args... } object
> > of the protocol layer.  But by making two calls,  now both BDS are
> > monitor-owned.
> >
> > At snapshot-time, the code currently looks for all monitor-owned nodes
> > when deciding what to snapshot.  In the old way, this finds the named
> > drive, picks up its associated top-most node, and snapshots the format
> > layer.  In the new way, the drive is unnamed so it is skipped, while
> > there are two named BDS, but we don't want a snapshot of the protocol
> > layer.
> 
> So the problem is certain (common & sane) -blockdev use makes savevm
> create additional, unwanted snapshots.

Actually, the most common protocol driver is file-posix, which doesn't
support snapshots, so usually the result was that savevm just fails
because it can't snapshot something that it (incorrectly) thinks it
should snapshot.

Kevin

> Your explanation should be worked into the commit message along with ...
> 
> >>>            This was fixed but clients need to be able to detect whether
> >>> this fix is present.
> >>
> >> Fixed where?  Commit hash, if possible.
> >
> > Pull request:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04773.html
> > (assuming it doesn't need a respin before landing, 8ec72832)
> 
> ... a pointer to this fix.
> 
> Thanks!
> 
> [...]

