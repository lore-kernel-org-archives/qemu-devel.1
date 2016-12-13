Received: from eggs.gnu.org ([2001:4830:134:3::10]:53608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGo9c-0002js-LG
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGo9Y-0006iT-Nd
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:34:04 -0500
Received: from [2a01:4f8:140:52e5::2] (port=37050 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cGo9Y-0006i5-HT
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:34:00 -0500
Date: Tue, 13 Dec 2016 15:33:44 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161213143344.rgcasv4e3waeha5u@grep.be>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
	<4B4EF198-ABE9-4517-A19D-8058AB117342@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B4EF198-ABE9-4517-A19D-8058AB117342@alex.org.uk>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>

On Tue, Dec 13, 2016 at 02:12:48PM +0000, Alex Bligh wrote:
> 
> > On 12 Dec 2016, at 20:43, Wouter Verhelst <w@uter.be> wrote:
> > 
> > +- `NBD_OPT_SET_META_CONTEXT` (11)
> > +
> > +    Change the set of active metadata contexts. Issuing this command
> > +    replaces all previously-set metadata contexts; clients must ensure
> > +    that all metadata contexts they're interested in are selected with
> > +    the final query that they sent.
> > +
> > +    Data:
> > +    - 32 bits, length of query
> > +    - String, query to select metadata contexts. The syntax of this
> > +      query is implementation-defined, except that it MUST start with a
> > +      namespace. This namespace may be one of the following:
> > +        - `base:`, for metadata contexts defined by this document;
> > +        - `nbd-server:`, for metadata contexts defined by the
> > +          implementation that accompanies this document (none
> > +          currently);
> > +        - `x-*:`, where `*` can be replaced by any random string not
> > +          containing colons, for local experiments. This SHOULD NOT be
> > +          used by metadata contexts that are expected to e widely used.
> > +        - third-party implementations can register additional
> > +          namespaces by simple request to the mailinglist.
> 
> Surely also we need to specify multiple queries?

Yes. See my reply to Stefan's mail ;-)


-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
