Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B5BC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB89A2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB89A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvKN-00075D-Pe
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:30:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEvBc-0006fT-0q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEvBZ-0007PA-Pk
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hEvBZ-0007Or-I9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:21:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFFF0307EAA9;
	Fri, 12 Apr 2019 12:21:36 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A925D9CC;
	Fri, 12 Apr 2019 12:21:34 +0000 (UTC)
Date: Fri, 12 Apr 2019 14:21:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190412122133.GG4522@linux.fritz.box>
References: <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
	<4aee66fd-1cfa-a935-daa6-6f221af42095@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <4aee66fd-1cfa-a935-daa6-6f221af42095@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 12 Apr 2019 12:21:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0?] hmp: delvm: use hmp_handle_error
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	dgilbert@redhat.com, Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412122133.jVt7oCHSoO9Ibv_T6ykMNhNgSYupz6SzjjoGPfEQXJQ@z>

Am 10.04.2019 um 20:27 hat Eric Blake geschrieben:
> On 4/10/19 1:03 PM, Cole Robinson wrote:
> > This gives us the consistent 'Error:' prefix added in 66363e9a43f,
> > which helps users like libvirt who still need to scrape hmp error
> > messages to detect failure.
> > 
> > Signed-off-by: Cole Robinson <crobinso@redhat.com>
> > ---
> >  hmp.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Not enough to drive -rc4 on its own, but worth adding to our wishlist of
> potential easy patches if we do have a release blocker surface.

As we are going to have an -rc4, I had a look at this.

Commit 66363e9a43f was in February and explicitly says "Note: Some
places don't use hmp_handle_error". So this doesn't seem to be a
regression and even if it's fixed, it's likely not the last place that
doesn't use the "Error:" prefix. This would suggest that this isn't for
-rc4.

Am I misunderstanding the situation?

Kevin

> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> > 
> > diff --git a/hmp.c b/hmp.c
> > index 8eec768088..74a4bfc1f9 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -1481,10 +1481,11 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
> >      const char *name = qdict_get_str(qdict, "name");
> >  
> >      if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
> > -        error_reportf_err(err,
> > -                          "Error while deleting snapshot on device '%s': ",
> > -                          bdrv_get_device_name(bs));
> > +        error_prepend(&err,
> > +                      "Error while deleting snapshot on device '%s': ",
> 
> Do we want to reword the message (maybe s/Error while //) to avoid the
> word "Error" twice in the same line?
> 
> > +                      bdrv_get_device_name(bs));
> >      }
> > +    hmp_handle_error(mon, &err);
> >  }
> >  
> >  void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 

