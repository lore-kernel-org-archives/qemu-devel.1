Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E61C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93A420673
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93A420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50681 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aOc-0003lX-Va
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1i2aNF-0002nu-K1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1i2aNE-0007RR-9w
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:14:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>)
 id 1i2aNA-0007Q7-8L; Tue, 27 Aug 2019 08:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6A3C2F366C;
 Tue, 27 Aug 2019 12:14:50 +0000 (UTC)
Received: from localhost (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86B381001B11;
 Tue, 27 Aug 2019 12:14:50 +0000 (UTC)
Date: Tue, 27 Aug 2019 13:14:49 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190827121449.GX7304@redhat.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 27 Aug 2019 12:14:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Libguestfs] cross-project patches: Add NBD Fast
 Zero support
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
Cc: libguestfs@redhat.com, QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 09:30:36AM -0500, Eric Blake wrote:
> I've run several tests to demonstrate why this is useful, as well as
> prove that because I have multiple interoperable projects, it is worth
> including in the NBD standard.  The original proposal was here:
> https://lists.debian.org/nbd/2019/03/msg00004.html
> where I stated:
> 
> > I will not push this without both:
> > - a positive review (for example, we may decide that burning another
> > NBD_FLAG_* is undesirable, and that we should instead have some sort
> > of NBD_OPT_ handshake for determining when the server supports
> > NBD_CMF_FLAG_FAST_ZERO)
> > - a reference client and server implementation (probably both via qemu,
> > since it was qemu that raised the problem in the first place)

Is the plan to wait until NBD_CMF_FLAG_FAST_ZERO gets into the NBD
protocol doc before doing the rest?  Also I would like to release both
libnbd 1.0 and nbdkit 1.14 before we introduce any large new features.
Both should be released this week, in fact maybe even today or
tomorrow.

[...]
> First, I had to create a scenario where falling back to writes is
> noticeably slower than performing a zero operation, and where
> pre-zeroing also shows an effect.  My choice: let's test 'qemu-img
> convert' on an image that is half-sparse (every other megabyte is a
> hole) to an in-memory nbd destination.  Then I use a series of nbdkit
> filters to force the destination to behave in various manners:
>  log logfile=>(sed ...|uniq -c) (track how many normal/fast zero
> requests the client makes)
>  nozero $params (fine-tune how zero requests behave - the parameters
> zeromode and fastzeromode are the real drivers of my various tests)
>  blocksize maxdata=256k (allows large zero requests, but forces large
> writes into smaller chunks, to magnify the effects of write delays and
> allow testing to provide obvious results with a smaller image)
>  delay delay-write=20ms delay-zero=5ms (also to magnify the effects on a
> smaller image, with writes penalized more than zeroing)
>  stats statsfile=/dev/stderr (to track overall time and a decent summary
> of how much I/O occurred).
>  noextents (forces the entire image to report that it is allocated,
> which eliminates any testing variability based on whether qemu-img uses
> that to bypass a zeroing operation [1])

I can't help thinking that a sh plugin might have been simpler ...

> I hope you enjoyed reading this far, and agree with my interpretation of
> the numbers about why this feature is useful!

Yes it seems reasonable.

The only thought I had is whether the qemu block layer does or should
combine requests in flight so that a write-zero (offset) followed by a
write-data (same offset) would erase the earlier request.  In some
circumstances that might provide a performance improvement without
needing any changes to protocols.

> - NBD should have a way to advertise (probably via NBD_INFO_ during
> NBD_OPT_GO) if the initial image is known to begin life with all zeroes
> (if that is the case, qemu-img can skip the extents calls and
> pre-zeroing pass altogether)

Yes, I really think we should do this one as well.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

