Received: from eggs.gnu.org ([2001:4830:134:3::10]:36427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHZvr-0000yx-8T
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHZvq-0004Hl-56
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:35:03 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:53520)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHZvp-0004Fe-UL
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:35:02 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161215164917.2zzkdwxarf4pnfle@grep.be>
Date: Thu, 15 Dec 2016 17:34:48 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <3DDAB833-51BF-4F73-9F08-E50054B01D24@alex.org.uk>
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
	<20161215164917.2zzkdwxarf4pnfle@grep.be>
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
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>


> On 15 Dec 2016, at 16:49, Wouter Verhelst <w@uter.be> wrote:
> 
>> Because the namespaces and leaf-names are already restricted to
>> non-whitespace characters. I thought having tabs, line feeds,
>> returns, em-space, en-space etc. was not particularly useful.
>> I could be persuaded to relent re spaces.
> 
> I could imagine that the context might include as part of its name a
> user-defined bit. If we're going to disallow whitespace, then that would
> mean namespaces would have to do all sorts of escaping etc. I don't
> think that's a good idea.

So to be clear do you want to include all whitespace
everywhere? Or just to the right of the colon in queries?

-- 
Alex Bligh
