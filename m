Received: from eggs.gnu.org ([2001:4830:134:3::10]:39682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYAh3-0003ol-0P
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYAWr-0004Xf-SR
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:02:55 -0500
Date: Sat, 15 Dec 2018 14:02:37 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181215140237.GR27120@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215135324.152629-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/22] nbd: Document timeline of various
 features
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

On Sat, Dec 15, 2018 at 07:53:04AM -0600, Eric Blake wrote:
> It can be useful to figure out which NBD protocol features are
> exposed by a server, as well as what features a client will
> take advantage of if available, for a given qemu release.  It's
> not always precise to base features on version numbers (thanks
> to downstream backports), but any documentation is better than
> making users search through git logs themselves.
> 
> This patch originally stemmed from a request to document that
> pristine 3.0 has a known bug where NBD_OPT_LIST_META_CONTEXT
> with 0 queries forgot to advertise an available
> "qemu:dirty-bitmap" context, but documenting bugs like this (or
> the fact that 3.0 also botched NBD_CMD_CACHE) gets to be too
> much details, especially since buggy releases will be less
> likely connection targets over time.  Instead, I chose to just
> remind users to check stable release branches.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: new patch
> ---
>  docs/interop/nbd.txt | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
> index 77b5f459111..2b25f871e7c 100644
> --- a/docs/interop/nbd.txt
> +++ b/docs/interop/nbd.txt
> @@ -15,7 +15,6 @@ Qemu supports the "base:allocation" metadata context as defined in the
>  NBD protocol specification, and also defines an additional metadata
>  namespace "qemu".
> 
> -
>  == "qemu" namespace ==
> 
>  The "qemu" namespace currently contains only one type of context,
> @@ -36,3 +35,21 @@ in addition to "qemu:dirty-bitmap:<dirty-bitmap-export-name>":
>              namespace.
>  * "qemu:dirty-bitmap:" - returns list of all available dirty-bitmap
>                           metadata contexts.
> +
> += Features by version =
> +
> +The following list documents which qemu version first implemented
> +various features (both as a server exposing the feature, and as a
> +client taking advantage of the feature when present), to make it
> +easier to plan for cross-version interoperability.  Note that in
> +several cases, the initial release containing a feature may require
> +additional patches from the corresponding stable branch to fix bugs in
> +the operation of that feature.
> +
> +* 2.6: NBD_OPT_STARTTLS with TLS X.509 Certificates
> +* 2.8: NBD_CMD_WRITE_ZEROES
> +* 2.10: NBD_OPT_GO, NBD_INFO_BLOCK
> +* 2.11: NBD_OPT_STRUCTURED_READ
> +* 2.12: NBD_CMD_BLOCK_STATUS for "base:allocation"
> +* 3.0: NBD_OPT_STARTTLS with TLS Pre-Shared Keys (PSK),
> +NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE

Sensible documentation change.

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
