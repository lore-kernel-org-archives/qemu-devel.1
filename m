Received: from eggs.gnu.org ([2001:4830:134:3::10]:42947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2fW-0003TG-Q4
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2fV-0000nb-T8
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:23:26 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2fV-0000nX-OQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:23:25 -0400
Received: by mail-qt0-x244.google.com with SMTP id l39so2441794qtb.1
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 10:23:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170517124042.1430-1-stefanha@redhat.com>
Message-ID: <1b4d066a-83d5-84ff-9f6c-005713dd6b04@amsat.org>
Date: Wed, 17 May 2017 14:23:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170517124042.1430-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 05/17/2017 09:40 AM, Stefan Hajnoczi wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
