Received: from eggs.gnu.org ([2001:4830:134:3::10]:34389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYCc6-0005cx-Ar
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 11:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYCPG-0007ii-21
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 11:03:10 -0500
Date: Sat, 15 Dec 2018 16:02:47 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181215160247.GE27120@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-21-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215135324.152629-21-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 20/22] qemu-nbd: Add --list option
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

On Sat, Dec 15, 2018 at 07:53:22AM -0600, Eric Blake wrote:
> @@ -557,13 +660,14 @@ int main(int argc, char **argv)
>      Error *local_err = NULL;
>      BlockdevDetectZeroesOptions detect_zeroes = BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
>      QDict *options = NULL;
> -    const char *export_name = ""; /* Default export name */
> +    const char *export_name = NULL;

You might want to comment that export_name is now a tri-state value,
with NULL meaning that it's not set by the user.


Nevertheless the patch looks good, and the addition of the example
(including host name setting) resolves my previous problem with the
new functionality.  Therefore:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
