Received: from eggs.gnu.org ([2001:4830:134:3::10]:45091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ft5wh-0003zI-MA
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 02:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ft5we-0004VA-Gx
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 02:51:47 -0400
Date: Fri, 24 Aug 2018 08:51:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180824065141.to374mbp6hho244p@sirius.home.kraxel.org>
References: <20180419132026.5494-1-kraxel@redhat.com>
	<20180419132026.5494-2-kraxel@redhat.com>
	<87va92dv39.fsf@dusky.pond.sub.org>
	<87tvnk6zuo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvnk6zuo.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: add qapi parser for -display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Aug 24, 2018 at 08:30:23AM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Gerd Hoffmann <kraxel@redhat.com> writes:
> >
> >> Add parse_display_qapi() function which parses the -display command line
> >> using a qapi visitor for DisplayOptions.  Wire up as default catch in
> >> parse_display().
> >>
> >> Improves the error message for unknown display types.
> >>
> >> Also enables json as -display argument, i.e. -display "{ 'type': 'gtk' }"
> >
> > This new option argument syntax is undocumented.  Intentional?

No, just -ENOTIME.

> Please advise.

Well, just need to find some time to do it.

In case you want tackle it:  Works simliar to -blockdev, with a few
exceptions.  Some legacy sdl options I plan to deprecate are not
supported via json.

cheers,
  Gerd
