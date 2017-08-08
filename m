Received: from eggs.gnu.org ([2001:4830:134:3::10]:59096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df2Lc-0006Gl-6R
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df2Lb-000186-0A
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:06:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170726140218.15904-1-eblake@redhat.com>
	<20170726140218.15904-4-eblake@redhat.com>
Date: Tue, 08 Aug 2017 13:06:42 +0200
In-Reply-To: <20170726140218.15904-4-eblake@redhat.com> (Eric Blake's message
	of "Wed, 26 Jul 2017 09:02:18 -0500")
Message-ID: <877eye48u5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] maint: Include bug-reporting info in
 --help output.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>, pbonzini@redhat.com, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> These days, many programs are including a bug-reporting address,
> or better yet, a link to the project web site, at the tail of
> their --help output.  However, we were not very consistent at
> doing so: only qemu-nbd and qemu-qa mentioned anything, with the
> latter pointing to an individual person instead of the project.
>
> Add a new #define that sets up a uniform string, mentioning both
> bug reporting instructions and overall project details, and which
> a downstream vendor could tweak if they want bugs to go to a
> downstream database.  Then use it in all of our binaries which
> have --help output.
>
> The canned text intentionally references http:// instead of https://
> because our https website currently causes certificate errors in
> some browsers.  That can be tweaked later once we have resolved the
> web site issued.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/qemu-common.h | 5 +++++
>  vl.c                  | 4 +++-
>  bsd-user/main.c       | 2 ++
>  linux-user/main.c     | 4 +++-
>  qemu-img.c            | 2 +-
>  qemu-io.c             | 5 +++--
>  qemu-nbd.c            | 2 +-
>  qga/main.c            | 2 +-
>  8 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index b5adbfa5e9..e751361458 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -22,6 +22,11 @@
>  #define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
>      "Fabrice Bellard and the QEMU Project developers"
>
> +/* Bug reporting information for --help arguments, About dialogs, etc */
> +#define QEMU_BUGREPORTS \
> +    "See <http://qemu.org/contribute/report-a-bug> for bug reports.\n" \

"See ... for bug reports" sounds like it's about browsing existing bugs.
The web page is actually about reporting bugs.  What about "for how to
report bugs"?

Since I'm basically bikeshedding already: the macro expands into more
than just bug reporting.  Call it QEMU_HELP_BOTTOM?  Feel free to ignore
this one.

> +    "More information on the qemu project at <http://qemu.org>"

"QEMU project"

> +
>  /* main function, renamed */
>  #if defined(CONFIG_COCOA)
>  int qemu_main(int argc, char **argv, char **envp);

Getting late for 2.10, but it's such a lovely little improvement...
