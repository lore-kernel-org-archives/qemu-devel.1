Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E7C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB992072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="tvRbBzWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB992072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUqf-0001J2-Qq
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isUgh-0002Ql-9p
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isUgd-000702-AG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:41:35 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:36337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1isUgc-0006xT-Rr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=W36LVMa8hB6h1ves+FYFb4CAjmOkRuF2n/Gmph5r97w=; b=tvRbBzWgfUrNp+vtrjS9xXzB6i
 IT+Ni5SjUMKk7VEHSmN5PMdgZoNMbPAZ1BNKY+6CU1AoomwznF+/xi/52Y0kLXYyy314LmsTa9uWg
 6z4LFMSYVli7Uo7hMP6DoQG/ObxmUxnnXkyf7HJZwRD5bxRPAdFuTX+xIIHqYD6yTr4OmFCnImAi0
 VAgFzxuDgvSk1DSO2nr5JdU5FQjQzgjXT/1ORSyDPJmM3axTYxbVxLC6LLL1GEyIlYOj0sG4nRNQc
 Of8108KWe8aKGd/Dkae0XJQqFOECSCdCzmCxWuUAP1lRd72CSq7q2VrDkGKpE/LObXmX8xbKjOC56
 ddMDaP2rjzVsYyfKMtY6bPQyXyB7cOPn8H1J1444oxWmJR5pTUowApR4LIHC8lMdRXqop8oVBO6yM
 z9lngoWmKINd8s20f2eXcmHqaxbRtBayq7OZRz9lQazT5QhgNlqKjSRdr+3YpHAKJ8mIvitdjYF6p
 ui9Bse1xmLcf0k4Zt55P+/d8ZGIE4TDmyDyqApP2vSbAnRGtdOl+z0ovqcCNtntdVqVLUOLKv6Pqv
 37B84iQfE1pcgkbmXOdywmu3I2sL1rAF8MEEKfD9seasLn8FFAn3dZEKYTmo6WWrr1Y82nhNV+Pgm
 XI0rzZ05laFy1heiCq05stYFzK99Airzc09pjQZa0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 02/11] 9pfs: require msize >= 4096
Date: Fri, 17 Jan 2020 17:41:25 +0100
Message-ID: <3116617.WjKBUmTdf3@silver>
In-Reply-To: <20200117161537.14d6aed9@bahia.lan>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
 <5046978.lqI2Hv0RVs@silver> <20200117161537.14d6aed9@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 17. Januar 2020 16:15:37 CET Greg Kurz wrote:
> > > Hmm... this patch does a sanity check on 'count', not on 'msize'...
> > 
> > Yes ... :)
> > 
> > > I mean no matter what msize is, clipping count to msize - 11 gives a
> > > chance to stop processing the entries before overflowing the transport
> > > buffer.
> > 
> > ... and no, this cannot happen if minimum msize of 4096 is forced already
> > by Tversion. Maybe you now get my point -> It is about avoiding exactly
> > such kind
> I'm not sure to see how setting a minimum msize of 4096 at Tversion would
> prevent the client to pass a higher 'count' argument and lure the server
> into generating a bigger than msize response since it does not check
> count < msize - 11 without patch 3.

That's correct, it requires patch 3 as well to prevent that. Without patch 3, 
if a (i.e. bad) client sends a 'count' parameter >> msize then the Treaddir 
request is processed by server to full extent according to 'count' and finally 
aborted by a transport error since server's response would exceed msize.

> > of issues in the first place. Most file systems have a name limit of 255
> > bytes:
> > 
> > https://en.wikipedia.org/wiki/Comparison_of_file_systems#Limits
> > 
> > So by forcing a minimum 'msize' of 4096 you avoid having to deal with this
> > issue (and similar ones) on Treaddir request level (and other request type
> > handlers), including ReiserFS BTW because 4032+35 < 4096.
> 
> Good to know for ReiserFS.
> 
> > If you would allow smaller 'msize' values by Tversion, then you would need
> > to suffer some kind of death when handling Treaddir with certain high
> > file name length. Either a transport error (with an error message that a
> > normal user would not be able to understand at all) or by returning an
> > incomplete Treaddir response sequence with { Rreaddir count=0 }, or ...
> > any other kind of death.
> Ahh I now understand at last your argument about Rreaddir loosing data.
> We may end up sending { Rreaddir count=0 } because the next entry is too
> large... and thus end the readdir sequence.

Yep.

> Mentioning this explicitly
> from the start would have been more clear for me ;-)

Sorry for that. :) I thought I made it clear with the directory entries 
example. I try to be more clear next time.

> This looks like yet another bug to me. It looks wrong to return this
> special response if we have more entries to go. Also this could be the
> client's _fault_ if it provides a ridiculously small value for count.
> The current code will return count=0 all the same.
> 
> In any case, I think v9fs_do_readdir() should only return 0 if there
> are no more entries to read. It should error out otherwise, but I'm
> not sure how...

Patience please. I have to limit the scope of this patch series somewhere. I 
am aware about these issues, but if I add fixes for more and more edge cases 
(which already exist) as part of this patch series, it will become a never 
ending story.

I just added those particular fixes to this series, because they were directly 
related to things I've changed here for the actual purpose of this patch set, 
which was and is: readdir latency optimization.

> > > My point is that we're not going to check msize in Tversion in
> > > order to to avoid multiple checks everywhere. We're going to do
> > > it there because it is the only place where it makes sense to
> > > do it.
> > 
> > Also yes and no. Of course it just makes sense to handle it already at
> > Tversion. But no, you could theoretically also allow much smaller minimum
> > 'msize' value << 4096 (i.e. somewhere closely >7 as we discussed), then
> > you
> > would indeed still need to add msize checks at other places of the code
> > base as you just found out now. So forcing a minimum 'msize' which is
> > high enough, avoids having to add such individual checks and having to
> > deal with them in some kind of unpleasant way.
> 
> We still don't understand each other I'm afraid... we actually have
> implicit 'msize' checks already for every single thing we write on
> the wire: v9fs_packunpack() which detects when we're trying to write
> passed the buffer. When this happens, it is propagated to the transport
> which then disconnects, which is the painful thing you've been
> experiencing with your readdir experiments. In the case of Rreaddir, it
> really does make sense to try to avoid the disconnection like you do in
> patch 3 because the readdir sequence allows _partial_ reads. Same goes
> for Rread. But that's it. No other message in the protocol allows that,
> so I've never thought of adding individual 'msize' checks anywhere else.
> What would they do better than v9fs_packunpack() already does ?

Right, but you realized that a min. msize of 4096 (in combination with
patch 3) prevents the readdir data loss issue we discussed here (provided we 
have a "good" client sending count=msize-11), right?

If so, I suggest I "try" to address your concerns you came up with here in the 
commit log message as far as I can, and would like to ask you to adjust the 
message later on according to your personal preference if required.

Best regards,
Christian Schoenebeck



