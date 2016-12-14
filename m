Received: from eggs.gnu.org ([2001:4830:134:3::10]:52679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHE8u-0007Jt-1H
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHE8p-0004jN-V2
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:19:04 -0500
Received: from mail.avalus.com ([89.16.176.221]:42064)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHE8p-0004jI-PI
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:18:59 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161214181323.mehzfmlf6z4pyajp@grep.be>
Date: Wed, 14 Dec 2016 18:18:58 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>


> On 14 Dec 2016, at 18:13, Wouter Verhelst <w@uter.be> wrote:
> 
> Instead, I would suggest that the spec leave it up to the namespace spec
> to define what gets listed when. The namespace should still give some
> indication that a particular *type* of context is available, though;
> e.g., _LIST_ could return 'backup:snapshot-diff{*}' as well as a list of
> 'backup:snapshot{snapshot-X}' contexts, where the latter are all
> available snapshots, and the 'snapshot-diff' bit implies that the whole
> cartesian product of all possible diffs between snapshots is possible in
> a format of 'backup:snapshot-diff{snapshot-X:snapshot-Y}', or some such
> (you get the idea).
> 
> The spec currently says that a server SHOULD allow choosing exports by
> simply naming them, but doesn't make that a MUST; and it also says that
> the query format is defined by the namespace. If we simply clarify that
> the output of _LIST_ doesn't necessarily need to be a full list of all
> that's available (that it may be symbolic in the case of namespaces that
> allow things to be dynamically defined), we should be good.

Let me have a go at a change.

However, note that Vladimir was answering a slightly different question.
I was asking about listing ALL contexts (previously an empty query
string, now a zero length list of queries), not a 'backup:*' type
thing.

-- 
Alex Bligh
