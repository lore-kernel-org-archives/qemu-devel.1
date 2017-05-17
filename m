Received: from eggs.gnu.org ([2001:4830:134:3::10]:34357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dAzPR-0007MB-AT
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dAzPL-0000Qa-K1
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:54:37 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dAzPL-0000QJ-BS
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:54:31 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l50so10587041wrc.3
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 06:54:30 -0700 (PDT)
References: <20170517124042.1430-1-stefanha@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170517124042.1430-1-stefanha@redhat.com>
Date: Wed, 17 May 2017 14:55:24 +0100
Message-ID: <87lgpv37w3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] .gdbinit: load QEMU sub-commands when
 gdb starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbinit
> file so GDB either loads qemu-gdb.py automatically or prints a message
> informing the user how to enable them (some systems disable ./.gdbinit
> loading for security reasons).
>
> Symlink .gdbinit and the scripts directory in order to make out-of-tree
> builds work.  The scripts directory is used to find the qemu-gdb.py file
> specified by a relative path in .gdbinit.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
> v2:
>  * Support out-of-tree builds [Daniel, Markus]
>
>  configure | 1 +
>  .gdbinit  | 8 ++++++++
>  2 files changed, 9 insertions(+)
>  create mode 100644 .gdbinit
>
> diff --git a/configure b/configure
> index 57b5ae6..04f7272 100755
> --- a/configure
> +++ b/configure
> @@ -6382,6 +6382,7 @@ FILES="$FILES pc-bios/spapr-rtas/Makefile"
>  FILES="$FILES pc-bios/s390-ccw/Makefile"
>  FILES="$FILES roms/seabios/Makefile roms/vgabios/Makefile"
>  FILES="$FILES pc-bios/qemu-icon.bmp"
> +FILES="$FILES .gdbinit scripts" # scripts needed by relative path in .gdbinit
>  for bios_file in \
>      $source_path/pc-bios/*.bin \
>      $source_path/pc-bios/*.lid \
> diff --git a/.gdbinit b/.gdbinit
> new file mode 100644
> index 0000000..9d322fc
> --- /dev/null
> +++ b/.gdbinit
> @@ -0,0 +1,8 @@
> +# GDB may have ./.gdbinit loading disabled by default.  In that case you can
> +# follow the instructions it prints.  They boil down to adding the following to
> +# your home directory's ~/.gdbinit file:
> +#
> +#   add-auto-load-safe-path /path/to/qemu/.gdbinit
> +
> +# Load QEMU-specific sub-commands and settings
> +source scripts/qemu-gdb.py


--
Alex Bennée
