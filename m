Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B19C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FBC2064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FBC2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTN5-0001qv-Sp
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1isTLg-0000rn-VE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1isTLc-0002pk-PB
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:15:48 -0500
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:34535)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1isTLb-0002o7-U4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:15:44 -0500
Received: from player771.ha.ovh.net (unknown [10.109.146.143])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 651691A8720
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 16:15:41 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 59E06E6CA98D;
 Fri, 17 Jan 2020 15:15:39 +0000 (UTC)
Date: Fri, 17 Jan 2020 16:15:37 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 02/11] 9pfs: require msize >= 4096
Message-ID: <20200117161537.14d6aed9@bahia.lan>
In-Reply-To: <5046978.lqI2Hv0RVs@silver>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
 <2330562.Ag4oC6Dxye@silver> <20200117112421.4311c21f@bahia.lan>
 <5046978.lqI2Hv0RVs@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14959832062457059648
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.253.128
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

On Fri, 17 Jan 2020 13:01:30 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Freitag, 17. Januar 2020 11:24:21 CET Greg Kurz wrote:
> > On Thu, 16 Jan 2020 22:39:19 +0100
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Donnerstag, 16. Januar 2020 19:07:48 CET Greg Kurz wrote:
> > > > > The point here was that there must be some kind of absolute minimum
> > > > > msize,
> > > > 
> > > > Then the absolute minimum size is 7, the size of the header part that is
> > > > common to all messages:
> > > > 
> > > > size[4] Message tag[2]
> > > > 
> > > > > even though the protocol specs officially don't mandate one. And if a
> > > > > client choses a msize < P9_IOHDRSZ, what useful actions shall it be
> > > > > able
> > > > > to do?
> > > > 
> > > > I haven't checked but I guess some messages can fit in 24 bytes.
> > > > 
> > > > > That's why I mentioned P9_IOHDRSZ just in case somebody might come up
> > > > > later
> > > > > asking to lower that minimum msize value for whatever reason.
> > > > 
> > > > That's precisely what I want to avoid. The semantic of P9_IOHDRSZ is
> > > > that it is the header size of a Twrite message and as such it is used
> > > > to compute the 'iounit' which the guest later uses to compute a
> > > > suitable 'count' for Tread/Twrite messages only. It shouldn't be
> > > > involved in msize considerations IMHO.
> > > > 
> > > > > But np, IMO this sentence makes the fundamental requirement for this
> > > > > patch
> > > > > more clear, but I have no problem dropping this sentence.
> > > > 
> > > > Then you can mention 7 has the true minimal size.
> > > 
> > > Ok, I'll drop P9_IOHDRSZ completely and mention literal 7 as absolute
> > > theoretical minimum instead.
> > > 
> > > > > > > Furthermore there are some responses which are not allowed by the
> > > > > > > 9p
> > > > > > > protocol to be truncated like e.g. Rreadlink which may yield up to
> > > > > > 
> > > > > > No message may be truncated in any way actually. The spec just
> > > > > > allows
> > > > > > an exception with the string part of Rerror.
> > > > > 
> > > > > Rreaddir, Rread, Twrite, Rerror can be truncated. So I suggest I'll
> > > > > just
> > > > > change that to s/some/most/ semantically.
> > > > 
> > > > I mean truncate with loss of data. Rreaddir can return less than 'count'
> > > > but it won't truncate an individual entry. It rewinds to the previous
> > > > one and returns its offset for the next Treaddir. Same goes with Rread
> > > > and Twrite, we always return a 'count' that can be used by the client
> > > > to continue reading or writing.
> > > 
> > > Individual entries are not truncated, correct, but data loss: Example, you
> > > have this directory and say server's fs would deliver entries by readdir()
> > > in> 
> > > this order (from top down):
> > > 	.
> > > 	..
> > > 	a
> > > 	1234567890
> > > 	b
> > > 	c
> > > 	d
> > > 
> > > and say 37 >= msize < 45, then client would receive 3 entries ".", "..",
> > > "a" and that's it.
> > 
> > Yes msize < 45 isn't enough to send the Rreaddir for "1234567890"
> > and since it is forbidden to truncate, we bail out... but we
> > did not send a truncated message still.
> 
> I really think we're discussing semantical interpretation details here which 
> bring us nowhere.
> 

Agreed.

> > > > Rerror is really the only message where we can deliberately drop
> > > > data (but we actually don't do that).
> > > > 
> > > > > > Maybe just mention that and say we choose 4096 to be able to send
> > > > > > big Rreadlink messages.
> > > > > 
> > > > > That's not the point for this patch. The main purpose is to avoid
> > > > > having
> > > > > to
> > > > > maintain individual error prone minimum msize checks all over the code
> > > > > base. If we would allow very small msizes (much smaller than 4096),
> > > > > then
> > > > > we would need to add numerous error handlers all over the code base,
> > > > > each
> > > > > one checking for different values (depending on the specific message
> > > > > type).
> > > > 
> > > > I'm not sure what you mean by 'minimum msize checks all over the code
> > > > base'... Please provide an example.
> > > 
> > > 1. Like done in this patch series: Treaddir has to limit client's 'count'
> > > 
> > >    parameter according to msize (by subtracting with msize).
> > 
> > Hmm... this patch does a sanity check on 'count', not on 'msize'... 
> 
> Yes ... :)
> 
> > I mean no matter what msize is, clipping count to msize - 11 gives a
> > chance to stop processing the entries before overflowing the transport
> > buffer.
> 
> ... and no, this cannot happen if minimum msize of 4096 is forced already by 
> Tversion. Maybe you now get my point -> It is about avoiding exactly such kind 

I'm not sure to see how setting a minimum msize of 4096 at Tversion would
prevent the client to pass a higher 'count' argument and lure the server
into generating a bigger than msize response since it does not check
count < msize - 11 without patch 3.

> of issues in the first place. Most file systems have a name limit of 255 
> bytes:
> 
> https://en.wikipedia.org/wiki/Comparison_of_file_systems#Limits
> 
> So by forcing a minimum 'msize' of 4096 you avoid having to deal with this  
> issue (and similar ones) on Treaddir request level (and other request type 
> handlers), including ReiserFS BTW because 4032+35 < 4096.
> 

Good to know for ReiserFS.

> If you would allow smaller 'msize' values by Tversion, then you would need to 
> suffer some kind of death when handling Treaddir with certain high file name 
> length. Either a transport error (with an error message that a normal user 
> would not be able to understand at all) or by returning an incomplete Treaddir 
> response sequence with { Rreaddir count=0 }, or ... any other kind of death.
> 

Ahh I now understand at last your argument about Rreaddir loosing data.
We may end up sending { Rreaddir count=0 } because the next entry is too
large... and thus end the readdir sequence. Mentioning this explicitly
from the start would have been more clear for me ;-)

This looks like yet another bug to me. It looks wrong to return this
special response if we have more entries to go. Also this could be the
client's _fault_ if it provides a ridiculously small value for count.
The current code will return count=0 all the same.

In any case, I think v9fs_do_readdir() should only return 0 if there
are no more entries to read. It should error out otherwise, but I'm
not sure how...

> No matter which death you would choose here, it would be horrible from 
> usability perspective, because the system would most of the time work 
> flawlessy, and an error case would just be triggered if guest hits a file/dir 
> beyond some certain name length. It is not worth it! Force 4kiB already at 
> Tversion and that's it.
> 
> > > 2. get_iounit() does this:
> > > 		iounit = stbuf.f_bsize;
> > > 		iounit *= (s->msize - P9_IOHDRSZ) / stbuf.f_bsize;
> > > 		
> > >    without checking anywhere for a potential negative outcome
> > >    (i.e. when msize < P9_IOHDRSZ)
> > 
> > This function should even have an assert() for that, just to be
> > sure no one tries to call it before s->msize is even set, which
> > would clearly be a bug in QEMU. But this can be done in a
> > follow-up patch.
> > 
> > > 3. Example of directory entry name length with Rreaddir above.
> > 
> > msize being too small to accommodate an Rreaddir with a single
> > entry is a different problem as we cannot do anything about it
> > at this point but fail... That's why the minimum msize should
> > rather be chosen with file names in mind, which are likely to
> > be longer than any message header. Rreadlink being the one with
> > the higher potential since it will usually return a string
> > containing a path name (while Rreaddir entries only contain
> > a single path element).
> > 
> > > Individual issues that can easily be overlooked but also easily avoided by
> > > not allowing small msizes in the first place.
> > 
> > My point is that we're not going to check msize in Tversion in
> > order to to avoid multiple checks everywhere. We're going to do
> > it there because it is the only place where it makes sense to
> > do it.
> 
> Also yes and no. Of course it just makes sense to handle it already at 
> Tversion. But no, you could theoretically also allow much smaller minimum 
> 'msize' value << 4096 (i.e. somewhere closely >7 as we discussed), then you 
> would indeed still need to add msize checks at other places of the code base 
> as you just found out now. So forcing a minimum 'msize' which is high enough, 
> avoids having to add such individual checks and having to deal with them in 
> some kind of unpleasant way.
> 

We still don't understand each other I'm afraid... we actually have
implicit 'msize' checks already for every single thing we write on
the wire: v9fs_packunpack() which detects when we're trying to write
passed the buffer. When this happens, it is propagated to the transport
which then disconnects, which is the painful thing you've been
experiencing with your readdir experiments. In the case of Rreaddir, it
really does make sense to try to avoid the disconnection like you do in
patch 3 because the readdir sequence allows _partial_ reads. Same goes
for Rread. But that's it. No other message in the protocol allows that,
so I've never thought of adding individual 'msize' checks anywhere else.
What would they do better than v9fs_packunpack() already does ?

> I hope this makes it more clear now.
> 
> Best regards,
> Christian Schoenebeck
> 
> 


