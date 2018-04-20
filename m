Received: from eggs.gnu.org ([2001:4830:134:3::10]:44907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f9SK7-0000gf-6t
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f9SK2-0005rg-6a
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:27:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f9SK2-0005pb-1e
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:27:14 -0400
Date: Fri, 20 Apr 2018 10:27:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180420092700.GC2533@work-vm>
References: <20180419223151.623174-1-eblake@redhat.com>
	<20180419223151.623174-3-eblake@redhat.com>
	<87d0yu1dj1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0yu1dj1.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: Rename .json to .qapi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > Our QAPI input files aren't quite true JSON (comments being one obvious
> > difference); naming things .json doesn't make that obvious.  Use a new
> > suffix .qapi that makes it easy to identify our files.
> 
> I agree that .json is sub-optimal.  Evidence: we add Emacs file
> variables to get Python mode, because that's less wrong than JavaScript
> mode.  Except for "trivial" files, where we can't be bothered.
> 
> The rename lessens the human confusion, but increases the Editor
> confusion somewhat: we get Fundamental mode for "trivial" files, which
> is more wrong than JavaScript mode.
> 
> One way to avoid that would be adding file variables to all files.

That depends on your editor;  this rename makes life **much** better
in vim;   with them as .json files they display with white text on
bright red background (I guess because it's upset by syntax somewhere)
but as .qapi files it's readable (I'm not entirely sure which syntax
it's using)

Dave

> Permit me to digress.  I figure the (sane part of the) rationale for
> picking JSON as programming language syntax was "do not invent syntax,
> do profit from existing tooling".  Except JSON is unfit for the purpose
> as is; you need at least comments.  Our "fixes" for "unfit" turned the
> thing into an original work, destroying the "profit" part.  To
> paraphrase a German saying, what we built with our hands we upset with
> the ass.  Too late to correct, I guess, but I'm open to different
> opinions.
> 
> [...]
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
