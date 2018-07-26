Received: from eggs.gnu.org ([2001:4830:134:3::10]:41315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fifeC-0002QH-Re
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fife9-0005E1-OZ
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:45:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419132026.5494-1-kraxel@redhat.com>
	<20180419132026.5494-2-kraxel@redhat.com>
Date: Thu, 26 Jul 2018 14:45:14 +0200
In-Reply-To: <20180419132026.5494-2-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Thu, 19 Apr 2018 15:20:23 +0200")
Message-ID: <87va92dv39.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: add qapi parser for -display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> writes:

> Add parse_display_qapi() function which parses the -display command line
> using a qapi visitor for DisplayOptions.  Wire up as default catch in
> parse_display().
>
> Improves the error message for unknown display types.
>
> Also enables json as -display argument, i.e. -display "{ 'type': 'gtk' }"

This new option argument syntax is undocumented.  Intentional?

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  vl.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
