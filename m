Received: from eggs.gnu.org ([2001:4830:134:3::10]:45457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9RVv-0005Or-DV
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9RVs-0002US-9B
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:35:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f9RVs-0002U1-4f
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:35:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419223151.623174-1-eblake@redhat.com>
	<20180419223151.623174-3-eblake@redhat.com>
Date: Fri, 20 Apr 2018 10:35:14 +0200
In-Reply-To: <20180419223151.623174-3-eblake@redhat.com> (Eric Blake's message
	of "Thu, 19 Apr 2018 17:31:51 -0500")
Message-ID: <87d0yu1dj1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: Rename .json to .qapi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> Our QAPI input files aren't quite true JSON (comments being one obvious
> difference); naming things .json doesn't make that obvious.  Use a new
> suffix .qapi that makes it easy to identify our files.

I agree that .json is sub-optimal.  Evidence: we add Emacs file
variables to get Python mode, because that's less wrong than JavaScript
mode.  Except for "trivial" files, where we can't be bothered.

The rename lessens the human confusion, but increases the Editor
confusion somewhat: we get Fundamental mode for "trivial" files, which
is more wrong than JavaScript mode.

One way to avoid that would be adding file variables to all files.

Permit me to digress.  I figure the (sane part of the) rationale for
picking JSON as programming language syntax was "do not invent syntax,
do profit from existing tooling".  Except JSON is unfit for the purpose
as is; you need at least comments.  Our "fixes" for "unfit" turned the
thing into an original work, destroying the "profit" part.  To
paraphrase a German saying, what we built with our hands we upset with
the ass.  Too late to correct, I guess, but I'm open to different
opinions.

[...]
