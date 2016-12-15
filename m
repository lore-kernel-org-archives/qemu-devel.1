Received: from eggs.gnu.org ([2001:4830:134:3::10]:43180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHZDu-0007MV-Bs
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHZDr-0000TC-A9
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:49:38 -0500
Received: from [2a01:4f8:140:52e5::2] (port=40745 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cHZDr-0000S6-3K
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:49:35 -0500
Date: Thu, 15 Dec 2016 17:49:17 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161215164917.2zzkdwxarf4pnfle@grep.be>
References: <5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
	<20161214201858.lblzw2ayddidxfyp@grep.be>
	<58F412AB-8A4C-403F-AEE2-D2FB958D447A@alex.org.uk>
	<20161215150312.dmxrxn7ujzq3apy6@grep.be>
	<78C8A0CB-717D-4925-8AA8-A085DC1F9FB7@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78C8A0CB-717D-4925-8AA8-A085DC1F9FB7@alex.org.uk>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

On Thu, Dec 15, 2016 at 04:32:23PM +0000, Alex Bligh wrote:
> Wouter,
> 
> > This reads a bit awkward. I would do:
> > 
> > s/save that:/except as explained below/
> 
> Possibly a British English thing. Will fix.

It's mostly that the "save that:" suggests to me that the exception
follows immediately (i.e., in the next paragraph). As you wrote it, it
doesn't; it shows up in the paragraph after that, with a "however"
clause. This was very confusing; I had to read it several times before I
understood what you wanted to say.

> >>    If one or more queries are sent, then the server MUST return
> >>    those metadata contexts that are available to the client to
> >>    select on the given export with `NBD_OPT_SET_META_CONTEXT`,
> >>    and which match one or more of the queries given. The
> >>    support of wildcarding within the leaf-name portion of
> >>    the query string is dependent upon the namespace.
> >> 
> >>    In either case, however, for any given namespace the
> >>    server MAY, instead of exhaustively listing every
> >>    matching context available to select (or every context
> >>    available to select where no query is given), send
> >>    sufficient context records back to allow a client with
> >>    knowledge of the namespace to select any context. Each
> >>    namespace returned MUST still satisfy the rules for
> >>    namespaces (i.e. they must begin with the relevant
> >>    namespace, followed by a colon, then printable non-whitespace
> >>    UTF-8 characters,
> > 
> > Why restrict to non-whitespace characters? (printable makes sense...)
> 
> Because the namespaces and leaf-names are already restricted to
> non-whitespace characters. I thought having tabs, line feeds,
> returns, em-space, en-space etc. was not particularly useful.
> I could be persuaded to relent re spaces.

I could imagine that the context might include as part of its name a
user-defined bit. If we're going to disallow whitespace, then that would
mean namespaces would have to do all sorts of escaping etc. I don't
think that's a good idea.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
