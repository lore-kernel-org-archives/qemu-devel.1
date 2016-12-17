Received: from eggs.gnu.org ([2001:4830:134:3::10]:53903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cIASG-0005Jx-Od
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 03:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cIASD-0006XL-Kk
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 03:34:56 -0500
Received: from [2a01:4f8:140:52e5::2] (port=43532 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cIASD-0006Wg-Ep
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 03:34:53 -0500
Date: Sat, 17 Dec 2016 09:34:36 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161217083436.paqqlsbkjl66frfr@grep.be>
References: <D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
	<20161214201858.lblzw2ayddidxfyp@grep.be>
	<58F412AB-8A4C-403F-AEE2-D2FB958D447A@alex.org.uk>
	<20161215150312.dmxrxn7ujzq3apy6@grep.be>
	<78C8A0CB-717D-4925-8AA8-A085DC1F9FB7@alex.org.uk>
	<20161215164917.2zzkdwxarf4pnfle@grep.be>
	<3DDAB833-51BF-4F73-9F08-E50054B01D24@alex.org.uk>
	<20161216155248.2r2yzthuvn76nprq@grep.be>
	<82CDF60E-994F-453F-8B34-181C86001A82@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82CDF60E-994F-453F-8B34-181C86001A82@alex.org.uk>
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

On Fri, Dec 16, 2016 at 04:25:27PM +0000, Alex Bligh wrote:
> 
> > On 16 Dec 2016, at 15:52, Wouter Verhelst <w@uter.be> wrote:
> > 
> > On Thu, Dec 15, 2016 at 05:34:48PM +0000, Alex Bligh wrote:
> >> 
> >>> On 15 Dec 2016, at 16:49, Wouter Verhelst <w@uter.be> wrote:
> >>> 
> >>>> Because the namespaces and leaf-names are already restricted to
> >>>> non-whitespace characters. I thought having tabs, line feeds,
> >>>> returns, em-space, en-space etc. was not particularly useful.
> >>>> I could be persuaded to relent re spaces.
> >>> 
> >>> I could imagine that the context might include as part of its name a
> >>> user-defined bit. If we're going to disallow whitespace, then that would
> >>> mean namespaces would have to do all sorts of escaping etc. I don't
> >>> think that's a good idea.
> >> 
> >> So to be clear do you want to include all whitespace
> >> everywhere? Or just to the right of the colon in queries?
> > 
> > Just in queries. I agree that in namespace names, it doesn't make much
> > sense.
> 
> I've changed it so the returns from queries can now have spaces to
> the right of the colon if they aren't returning complete context names.
> Obviously if they are returning context names, by the definition of
> leaf-names they can't have spaces in the leaf-name.

Sorry, that still doesn't alleviate my concerns.

Why are we restricting what metadata contexts can use for their names?
We don't restrict what export names can use either, and I could imagine
a metadata context wanting to use an export name as a metadata context
name (e.g., "provide a bitmap on the diff between this export and the
export defined by name XYZ").

As soon as we get to the right of the colon, what sits there is defined
by the namespace, not by us. It doesn't feel right to add too many
restrictions.

I think the whole query string should be a "string" as laid out earlier
in the document. Here, it actually *does* make sense for a string to be
very long, because it's not meant to be human-readable.

I've therefore removed that restriction as well as the "255 bytes max"
one that you added, since I don't think they make much sense. That
doesn't mean I can't be convinced otherwise by good arguments, but
they'd have to be very good ones ;-)

> The queries themselves can consist of anything (currently),
> save that they must begin with a namespace and a colon.

Sure.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
