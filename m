Received: from eggs.gnu.org ([2001:4830:134:3::10]:48303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAGNh-0006V7-Qe
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAGNc-0004rl-T6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:49:49 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAGNc-0004rZ-P2
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:49:44 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so17174318qkh.0
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:49:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170515134753.28412-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <513789c8-f1e4-54b9-c52b-89891171864b@amsat.org>
Date: Mon, 15 May 2017 10:49:29 -0300
MIME-Version: 1.0
In-Reply-To: <20170515134753.28412-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On 05/15/2017 10:47 AM, Stefan Hajnoczi wrote:
> The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbinit
> file so GDB either loads qemu-gdb.py automatically or prints a message
> informing the user how to enable them (some systems disable ./.gdbinit
> loading for security reasons).
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
