Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041C2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC558206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpUuv5TH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC558206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWFG-0003cz-SK
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZWCY-0008SB-8P
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:00:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZWCX-0008Ck-3w
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589533216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNcqcJfcxV5rBpnSDRFXoDAA0I/dTgdTYjYIJmWH9UI=;
 b=VpUuv5THfJwxYDOkyj3NGQMCPcs/pDGEDc8/stkExe7K5DOKrPWjfm3PqAaW8mD+UM7FOJ
 RBkkj1CEA9HdIJ0Ys0HRkaeUv8eamN8FAMPVEyfj8OKZX5uNAd9naaLSfkTQj5GKgFnInu
 LWMIRpnYLG1BqeJgiwz0kUkQUv+1BGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-AG4cfmQzNL6i9nRjwQDcZw-1; Fri, 15 May 2020 05:00:14 -0400
X-MC-Unique: AG4cfmQzNL6i9nRjwQDcZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F3E918FF660;
 Fri, 15 May 2020 09:00:13 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8563C2E02F;
 Fri, 15 May 2020 09:00:10 +0000 (UTC)
Date: Fri, 15 May 2020 11:00:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/3] docs/s390x: document 3270
Message-ID: <20200515110007.1676b17d.cohuck@redhat.com>
In-Reply-To: <4ea47ea1-04d5-3073-fef6-5af07f06a4d6@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
 <20200505135025.14614-3-cohuck@redhat.com>
 <4ea47ea1-04d5-3073-fef6-5af07f06a4d6@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 09:29:42 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 05/05/2020 15.50, Cornelia Huck wrote:
> > Add some basic info how to use 3270 devices.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  docs/system/s390x/3270.rst   | 32 ++++++++++++++++++++++++++++++++
> >  docs/system/target-s390x.rst |  1 +
> >  2 files changed, 33 insertions(+)
> >  create mode 100644 docs/system/s390x/3270.rst
> > 
> > diff --git a/docs/system/s390x/3270.rst b/docs/system/s390x/3270.rst
> > new file mode 100644
> > index 000000000000..e367a457e001
> > --- /dev/null
> > +++ b/docs/system/s390x/3270.rst
> > @@ -0,0 +1,32 @@
> > +3270 devices
> > +============
> > +
> > +With the aid of the ``x3270`` emulator, QEMU provides limited support
> > +for making a single 3270 device available to a guest. Note that this
> > +supports basic features only.  
> 
> The first sentence sounds somewhat confusing. Maybe rather something like:
> 
> QEMU can emulate a 3270 device attached to a guest, which then can be
> used with a program like ``x3270`` to get a traditional 3270 terminal
> for your guest.

But QEMU actually relies on x3270 (or a comparable program). It only
emulates the basic ccw plumbing; for the actual protocol (beyond
negotiating tn3270), it relies on the emulation done by x3270.

> 
> ?
> 
> > +To provide a 3270 device to a guest, create a ``x-3270device`` linked to  
> 
> The device is called "x-terminal3270", isn't it?

Yeah, no idea how I manged to mess that up.

> 
> (By the way, why did we never remove the x- prefix here? Is it still
> experimental?)

I'd still consider it experimental: only basic functionality is
supported, and (more importantly), we never came up with a scheme to
properly support more than one 3270 device. The usefulness of it is
quite limited.

> 
> > +a ``tn3270`` chardev. The guest will see a 3270 channel device. In order
> > +to actually be able to use it, attach the ``x3270`` emulator to the chardev.  
> 
> Can the guest only use the 3270 device if there is a x3270 attached to
> it? Or are you talking about the user here?

See above: x3270 does most of the heavy lifting.

> 
> > +Example configuration
> > +---------------------
> > +
> > +* Add a ``tn3270`` chardev and a ``x-3270device`` to the QEMU command line::  
> 
> "x-terminal3270" ?

Nod.

> 
> > +    -chardev socket,id=char_0,host=0.0.0.0,port=23,nowait,server,tn3270
> > +    -device x-terminal3270,chardev=char_0,devno=fe.0.000a,id=terminal_0  
> 
> qemu-system-s390x: -chardev
> socket,id=char_0,host=0.0.0.0,port=23,nowait,server,tn3270: Failed to
> bind socket: Permission denied
> 
> ... maybe better use a non-privileged port in the example?

Makes sense. This example was lifted straight from the wiki page :)


