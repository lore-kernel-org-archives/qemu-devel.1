Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDEFC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56672082C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56672082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Ls7-0005LL-HD
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i7LrJ-0004tK-19
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i7LrD-0000Kn-Nw
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59270)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i7LrD-0000KW-G1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:45:35 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4E3B2A09B7
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 15:45:34 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id l23so16243787qtp.4
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 08:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8Q4Bbw2MyR7i9cJ6p/SpfkyD4T/m2n0HtnfyD30O0EA=;
 b=VG7walZnGDRDMrwo4AQmCuWQuUIeKUDSjNWikQtPMPcB0tDFQXUjb8OPndm+vuaB4r
 Mpju+LKpuB1gMSjICF71TF1B7k4YyRJ93CZaYi10NgAb6i3kyAhgTplHbDrrd1AjPe4u
 f7xUWW5cqDNTT2L776w1ZOBG+DIFf4iRSfAtBO/B47vJVmAZoFH/eAlqMjrJgDsl07zs
 1BgBVjp1vYE5dLoeYo0YYSVKX1VeUksXHd0ou3nr1bc0rO2ZZUU85IZy9sLXRy9/XQY4
 ufHdrGSRkyJ3csvIMEkZM0J5PJt8F/We70i7kv41/W5gjYqkcb1QprefIVmh9GJHQevf
 01Hg==
X-Gm-Message-State: APjAAAVdIHg7kYDjcO3ilisnRtYtCK1SR84rfaj6Cly5M22224TqZTHA
 /DOB+vXu4mP426X7MwS3RiD8wdY1oYdm+LN/6KhYa+Tt0wSYKiqnOuwUhoKLWIombApmqB++NtV
 CWWrx3tpA2F6YmAc=
X-Received: by 2002:ae9:e88a:: with SMTP id
 a132mr24047478qkg.120.1568043933528; 
 Mon, 09 Sep 2019 08:45:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNWwt6MkUgB9IpskbQPcp+NW9CsQuQyoIj3WgRYlq3KtUWXbLtH0dwrfJLC3n7fqhC/XKQLA==
X-Received: by 2002:ae9:e88a:: with SMTP id
 a132mr24047458qkg.120.1568043933332; 
 Mon, 09 Sep 2019 08:45:33 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id o127sm7044388qkd.104.2019.09.09.08.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 08:45:32 -0700 (PDT)
Date: Mon, 9 Sep 2019 11:45:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190909114358-mutt-send-email-mst@kernel.org>
References: <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
 <20190908091207-mutt-send-email-mst@kernel.org>
 <8a9cf8a1726afce7fed8992a4f19fc808004ef88.camel@sipsolutions.net>
 <20190909083902-mutt-send-email-mst@kernel.org>
 <89f25546ffa71c799c533e50658a3a58e066f436.camel@sipsolutions.net>
 <20190909094609-mutt-send-email-mst@kernel.org>
 <d2e750aaec396bd0aa7ea8c05ef5705567d16595.camel@sipsolutions.net>
 <20190909105057-mutt-send-email-mst@kernel.org>
 <49378faefb98abafb64ff105a7941c47395426e7.camel@sipsolutions.net>
 <f97477a5b16e69a4891c8da542f5002fe4cf2548.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97477a5b16e69a4891c8da542f5002fe4cf2548.camel@sipsolutions.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 09, 2019 at 05:34:13PM +0200, Johannes Berg wrote:
> On Mon, 2019-09-09 at 17:26 +0200, Johannes Berg wrote:
> > 
> > Maybe instead we should just add a "VHOST_USER_REPLY_ERROR" bit (e.g.
> > bit 4 after NEED_REPLY). Qemu in vhost_user_read_header() validates that
> > it received REPLY_MASK | VERSION, so it would reject the message at that
> > point.
> > 
> > Another possibility would be to define the highest bit of the 'request'
> > field to indicate an error, so for GET_FEATURES we'd return the value
> > 0x80000000 | GET_FEATURES.
> 
> However, one way or another, that basically leaves us with three
> different ways of indicating an error:
> 
>  1) already defined errors in existing messages - we can't change them
>     since those are handled at runtime now, e.g. VHOST_USER_POSTCOPY_END
>     returns a u64 value with an error status, and current code cannot
>     deal with an error flag in the 'request' or 'flags' field
>  2) F_REPLY_ACK errors to messages that do not specify a response at all
>  3) this new way of indicating an error back from messages that specify
>     a response, but the response has no inherent way of returning an
>     error
> 
> To me that really feels a bit too complex from the spec POV. But I don't
> see a way to generalize this without another extension, and again the
> device cannot choose which extensions it supports since the master
> chooses them and just sets them.
> 
> Perhaps I really should just stick a "g_assert()" into the code at that
> point,

There's the old way: close the socket.
This will make reads fail gracefully.
If we don't want complexity right now, I'd go with that.


> and have it crash, since it's likely that F_KICK_CALL_MSGS isn't
> even going to be implemented in qemu (unless it grows simulation support
> and then it'd all be conditional on some simulation command-line option)
> 
> 
> 
> And actually ... you got the order wrong:
> 
> > > Next command is GET_FEATURES. Return an error response from that
> > > and device init will fail.
> 
> That's not the case. We *start* with GET_FEATURES, if that includes
> protocol features then we do GET_PROTOCOL_FEATURES next, and then we get
> the # of queues next ...
> 
> Though the whole discussion pretty much applies equivalently to
> GET_QUEUES_NUM instead of GET_FEATURES.
> 
> johannes

