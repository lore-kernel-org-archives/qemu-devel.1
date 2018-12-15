Received: from eggs.gnu.org ([2001:4830:134:3::10]:40598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYAhV-0004dJ-2F
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYAhO-0007TR-AB
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:13:52 -0500
Date: Sat, 15 Dec 2018 14:13:05 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181215141305.GT27120@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215135324.152629-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/22] qemu-nbd: Enhance man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On Sat, Dec 15, 2018 at 07:53:06AM -0600, Eric Blake wrote:
> Document some useful qemu-nbd command lines. Mention some restrictions
> on particular options, like -p being only for MBR images, or -c/-d
> being Linux-only.  Update some text given the recent change to no
> longer serve oldstyle protocol (missed in commit 7f7dfe2a).  Also,
> consistently use trailing '.' in describing options.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: new patch
> ---
>  qemu-nbd.texi | 85 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 66 insertions(+), 19 deletions(-)
> 
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index 9a84e81eed9..0e24c2801ee 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -8,7 +8,10 @@
> 
>  @c man begin DESCRIPTION
> 
> -Export a QEMU disk image using the NBD protocol.
> +Provide access to various QEMU NBD features.  Most commonly used to
> +export a QEMU disk image using the NBD protocol as a server, but can
> +also be used (on Linux) to manage kernel bindings of a /dev/nbdX
> +block device to a QEMU server.

This is only a minor quibble, but I thought the original text was a
good summary, and only needs additional paragraphs describing the more
minor use cases.  Thus the description would become by the end of the
patch series:

  DESCRIPTION

  Export a QEMU disk image using the NBD protocol.

  Other uses:
  * (On Linux) bind /dev/nbdX block device to a QEMU server.
  * As a client to query exports of a remote NBD server.

> +@c man begin EXAMPLES
> +Start a server listening on port 10809 that exposes only the
> +guest-visible contents of a qcow2 file, with no TLS encryption, and
> +with the default export name (an empty string). The command will block
> +until the first successful client disconnects:

TBH I'd always include the -t option in every example.  I don't
understand (except for backwards compatibility) why it isn't the
default since it's something I always trip over when using qemu-nbd.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
