Received: from eggs.gnu.org ([2001:4830:134:3::10]:35888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHYxK-0000Tr-9H
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHYxJ-0007KX-Cc
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:32:30 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:51210)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHYxJ-0007JN-67
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:32:29 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161215150312.dmxrxn7ujzq3apy6@grep.be>
Date: Thu, 15 Dec 2016 16:32:23 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <78C8A0CB-717D-4925-8AA8-A085DC1F9FB7@alex.org.uk>
References: <31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
	<20161214201858.lblzw2ayddidxfyp@grep.be>
	<58F412AB-8A4C-403F-AEE2-D2FB958D447A@alex.org.uk>
	<20161215150312.dmxrxn7ujzq3apy6@grep.be>
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
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

Wouter,

> This reads a bit awkward. I would do:
> 
> s/save that:/except as explained below/

Possibly a British English thing. Will fix.

>>    If one or more queries are sent, then the server MUST return
>>    those metadata contexts that are available to the client to
>>    select on the given export with `NBD_OPT_SET_META_CONTEXT`,
>>    and which match one or more of the queries given. The
>>    support of wildcarding within the leaf-name portion of
>>    the query string is dependent upon the namespace.
>> 
>>    In either case, however, for any given namespace the
>>    server MAY, instead of exhaustively listing every
>>    matching context available to select (or every context
>>    available to select where no query is given), send
>>    sufficient context records back to allow a client with
>>    knowledge of the namespace to select any context. Each
>>    namespace returned MUST still satisfy the rules for
>>    namespaces (i.e. they must begin with the relevant
>>    namespace, followed by a colon, then printable non-whitespace
>>    UTF-8 characters,
> 
> Why restrict to non-whitespace characters? (printable makes sense...)

Because the namespaces and leaf-names are already restricted to
non-whitespace characters. I thought having tabs, line feeds,
returns, em-space, en-space etc. was not particularly useful.
I could be persuaded to relent re spaces.

-- 
Alex Bligh
