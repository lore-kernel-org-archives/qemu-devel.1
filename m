Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E53C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED53206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED53206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38791 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpay-000484-SK
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:25:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTpUr-000826-HS
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTpUq-0002Pl-Iw
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:19:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hTpUq-0002PK-Dc
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:19:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD6109FDED
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 15:19:02 +0000 (UTC)
Received: from work-vm (ovpn-117-235.ams2.redhat.com [10.36.117.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A5D31001E82;
	Thu, 23 May 2019 15:18:57 +0000 (UTC)
Date: Thu, 23 May 2019 16:18:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laine Stump <laine@redhat.com>
Message-ID: <20190523151854.GA2995@work-vm>
References: <20190523145840.11774-1-dgilbert@redhat.com>
	<b2b2e120-e350-da29-929c-8695095a5ab1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b2e120-e350-da29-929c-8695095a5ab1@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 23 May 2019 15:19:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] network announce; interface selection
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laine Stump (laine@redhat.com) wrote:
> On 5/23/19 10:58 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Laine asked for some extra features on the network announce support;
> > this is the first one of them.
> > It allows you to send an announce on a subset of the interfaces.
> > 
> > Note since we've still only got one timer, if you start one announce
> > on an interface and then you start a second announce on another
> > interface, the first one gets cancelled even if it's part way through.
> > [That's the other feature Laine would like, but I need to think about
> > that a bit more.
> 
> I have a question without trying to read/understand the code: Does the
> restricted interface list persist to future self-announces? (e.g. one that
> is internally initiated by qemu) Or does it only apply to the current new
> self-announce? (Hopefully the latter)

Only to the manually triggered self-announce, not to the ones
generated by migration.

Dave

> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> > 
> > Dr. David Alan Gilbert (2):
> >    net/announce: Allow optional list of interfaces
> >    net/announce: Add HMP optional interface list
> > 
> >   hmp-commands.hx        |  6 ++++--
> >   hmp.c                  | 38 +++++++++++++++++++++++++++++++++++++-
> >   include/net/announce.h |  2 +-
> >   net/announce.c         | 39 ++++++++++++++++++++++++++++++++-------
> >   net/trace-events       |  2 +-
> >   qapi/net.json          |  8 +++++---
> >   6 files changed, 80 insertions(+), 15 deletions(-)
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

