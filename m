Received: from eggs.gnu.org ([2001:4830:134:3::10]:60606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f9FgM-0001F9-QN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f9FgI-0003Ah-RR
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:57:26 -0400
Date: Thu, 19 Apr 2018 21:57:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180419195721.r3salb5hd3w2plr4@sirius.home.kraxel.org>
References: <20180419132026.5494-1-kraxel@redhat.com>
	<20180419132026.5494-2-kraxel@redhat.com>
	<8fc65111-4c2f-9e07-3e4a-c95a6d52b29f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc65111-4c2f-9e07-3e4a-c95a6d52b29f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: add qapi parser for -display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

> > +    /*
> > +     * We don't have any dynamically allocated stuff inside
> > +     * DisplayOptions, so we can simply copy the struct content and
> > +     * free opts without ending up with pointers pointing into
> > +     * nowhere.
> > +     */
> > +    dpy = *opts;
> > +    qapi_free_DisplayOptions(opts);
> 
> That's risky; would it be better to use QAPI_CLONE_MEMBERS() to not have
> to worry about if we add a pointer in the future?

Didn't know QAPI_CLONE_MEMBERS() exists.  Yes, probably more
future-proof to just use that instead of adding that comment.
Will look into that for v2.

cheers,
  Gerd
