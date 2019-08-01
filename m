Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF89C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6125206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6125206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGZS-0005dt-2m
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1htGY5-0005As-W4
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1htGY4-0005hU-JW
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:15:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1htGY4-0005hB-Ep
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:15:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so66494420qtp.12
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 12:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CbHsRifZcP4KVzzUpZ4Tb5jMR01LF3DSH9W0kIoflvE=;
 b=JoRHnNp9slbPAMvNewarYGv7dICk3oGc7GqyFKu1P8cVykiFluz1zUrcRZkinTGlEw
 VXiH6FIT8pZ/Zxt2hi38aONgRiIo8AbXn9GbcTHdD+RklM/NiIZQhbSFa01zAtSP2Pfo
 Q7tSDZ0kD7UW5EronO9Ffd7IW94ZphVQ09C75SMB1NdyjFsWYNn/QVPUDcXqinsI7Rpd
 MNzJpinLXbIKzpMFeeBOTJzrcRVP2ZR20/khjwEyW2LiRV+frgw1kqEdJnEwxn7iSZ5P
 MNiRM5/RBOCvxDDNkIs8VbchgvkoyM8TfmRtYc7ipBxDpWqKjQ1A7Ern2UJqEABvYBvU
 SNTw==
X-Gm-Message-State: APjAAAX8buMtG3T0OZJa7QexM5uZP62S5eLp4/aMaeehFNrylDlxrKlO
 WLgPiXrgeABTEuvxqng8Ne+rQA==
X-Google-Smtp-Source: APXvYqzkSqxuM4WATxS9kS4yPG9LbfV3xiBgVmrnoIunfgFOA5RhGdGZ64LOiBEIljcsD+AsyyYifg==
X-Received: by 2002:ac8:3233:: with SMTP id x48mr94258980qta.159.1564686935163; 
 Thu, 01 Aug 2019 12:15:35 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 z21sm28717857qto.48.2019.08.01.12.15.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 12:15:34 -0700 (PDT)
Date: Thu, 1 Aug 2019 15:15:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190801151258-mutt-send-email-mst@kernel.org>
References: <1564644533-28850-1-git-send-email-ning.bo9@zte.com.cn>
 <87v9vgoqlr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9vgoqlr.fsf@dusky.pond.sub.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH] vhost-vsock: report QMP event when set
 running
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
Cc: Ning Bo <ning.bo9@zte.com.cn>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 01, 2019 at 05:25:04PM +0200, Markus Armbruster wrote:
> Ning Bo <ning.bo9@zte.com.cn> writes:
> 
> > Report vsock running event so that the upper application can
> > control boot sequence.
> > see https://github.com/kata-containers/runtime/pull/1918
> 
> Please provide a more complete summary of the use case in the commit
> message.  What exactly is the problem?  What is the proposed solution,
> and how does it make use of the new event?
> 
> > Signed-off-by: Ning Bo <ning.bo9@zte.com.cn>


Also it would seem that it should be possible to detect
port listen state change just by trying to connect to it.
Why isn't that an option?



> > ---
> >  hw/virtio/vhost-vsock.c |  3 +++
> >  qapi/char.json          | 22 ++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> > index 0371493..a5920fd 100644
> > --- a/hw/virtio/vhost-vsock.c
> > +++ b/hw/virtio/vhost-vsock.c
> > @@ -22,6 +22,7 @@
> >  #include "qemu/iov.h"
> >  #include "qemu/module.h"
> >  #include "monitor/monitor.h"
> > +#include "qapi/qapi-events-char.h"
> >  
> >  enum {
> >      VHOST_VSOCK_SAVEVM_VERSION = 0,
> > @@ -68,6 +69,8 @@ static int vhost_vsock_set_running(VHostVSock *vsock, int start)
> >      if (ret < 0) {
> >          return -errno;
> >      }
> > +    qapi_event_send_vsock_running(vsock->conf.guest_cid, start != 0);
> > +
> >      return 0;
> >  }
> >  
> > diff --git a/qapi/char.json b/qapi/char.json
> > index a6e81ac..7b746e3 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -570,3 +570,25 @@
> >  { 'event': 'VSERPORT_CHANGE',
> >    'data': { 'id': 'str',
> >              'open': 'bool' } }
> > +
> > +##
> > +# @VSOCK_RUNNING:
> > +#
> > +# Emitted when the guest changes the vsock status.
> > +#
> > +# @cid: guest context ID
> > +#
> > +# @running: true if the vsock is running
> > +#
> > +# Since: v4.2
> > +#
> > +# Example:
> > +#
> > +# <- { "event": "VSOCK_RUNNING",
> > +#      "data": { "cid": "123456", "running": true },
> > +#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
> > +#
> > +##
> > +{ 'event': 'VSOCK_RUNNING',
> > +  'data': { 'cid': 'uint64',
> > +            'running': 'bool' } }
> 
> Can you explain why you put this into char.json?
> 
> The event traces successful calls of vhost_vsock_set_running().  I have
> no idea what vhost_vsock_set_running() does (pardon my ignorance).  Can
> you point me to a specification?
> 
> Its @start parameter is int.  The event's @running is bool.  Zero gets
> mapped to false, non-zero to true.  Are you sure all non-zero values are
> equivalent, and will remain equivalent?


Allowing guest to emit events at a high speed 


