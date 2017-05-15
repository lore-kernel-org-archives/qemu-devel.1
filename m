Received: from eggs.gnu.org ([2001:4830:134:3::10]:56132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dAGnk-0004Me-M9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dAGng-00019x-5d
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:16:44 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dAGnf-00017g-Td
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:16:40 -0400
Received: by mail-wm0-x22a.google.com with SMTP id u65so83171306wmu.1
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:16:39 -0700 (PDT)
References: <20170515134753.28412-1-stefanha@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170515134753.28412-1-stefanha@redhat.com>
Date: Mon, 15 May 2017 15:17:28 +0100
Message-ID: <87a86erypz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] .gdbinit: load QEMU sub-commands when gdb
 starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org


Stefan Hajnoczi <stefanha@redhat.com> writes:

> The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbinit
> file so GDB either loads qemu-gdb.py automatically or prints a message
> informing the user how to enable them (some systems disable ./.gdbinit
> loading for security reasons).
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  .gdbinit | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 .gdbinit
>
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

While this works well enough you might as well just comment the helper
script itself. Would this script take precedence over a users
~/.gdbinit? How would it work for out-of-tree builds?

GDB does have a mechanism for autoloading extensions by way of adding
ELF sections:

  https://sourceware.org/gdb/current/onlinedocs/gdb/dotdebug_005fgdb_005fscripts-section.html#dotdebug_005fgdb_005fscripts-section

--
Alex Bennée
