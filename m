Received: from eggs.gnu.org ([2001:4830:134:3::10]:52524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHvK6-0000DQ-RN
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHvK5-0006ey-TA
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:25:30 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:51720)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHvK5-0006di-Ll
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:25:29 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161216155248.2r2yzthuvn76nprq@grep.be>
Date: Fri, 16 Dec 2016 16:25:27 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <82CDF60E-994F-453F-8B34-181C86001A82@alex.org.uk>
References: <94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
	<20161214201858.lblzw2ayddidxfyp@grep.be>
	<58F412AB-8A4C-403F-AEE2-D2FB958D447A@alex.org.uk>
	<20161215150312.dmxrxn7ujzq3apy6@grep.be>
	<78C8A0CB-717D-4925-8AA8-A085DC1F9FB7@alex.org.uk>
	<20161215164917.2zzkdwxarf4pnfle@grep.be>
	<3DDAB833-51BF-4F73-9F08-E50054B01D24@alex.org.uk>
	<20161216155248.2r2yzthuvn76nprq@grep.be>
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


> On 16 Dec 2016, at 15:52, Wouter Verhelst <w@uter.be> wrote:
> 
> On Thu, Dec 15, 2016 at 05:34:48PM +0000, Alex Bligh wrote:
>> 
>>> On 15 Dec 2016, at 16:49, Wouter Verhelst <w@uter.be> wrote:
>>> 
>>>> Because the namespaces and leaf-names are already restricted to
>>>> non-whitespace characters. I thought having tabs, line feeds,
>>>> returns, em-space, en-space etc. was not particularly useful.
>>>> I could be persuaded to relent re spaces.
>>> 
>>> I could imagine that the context might include as part of its name a
>>> user-defined bit. If we're going to disallow whitespace, then that would
>>> mean namespaces would have to do all sorts of escaping etc. I don't
>>> think that's a good idea.
>> 
>> So to be clear do you want to include all whitespace
>> everywhere? Or just to the right of the colon in queries?
> 
> Just in queries. I agree that in namespace names, it doesn't make much
> sense.

I've changed it so the returns from queries can now have spaces to
the right of the colon if they aren't returning complete context names.
Obviously if they are returning context names, by the definition of
leaf-names they can't have spaces in the leaf-name.

The queries themselves can consist of anything (currently),
save that they must begin with a namespace and a colon.

-- 
Alex Bligh
