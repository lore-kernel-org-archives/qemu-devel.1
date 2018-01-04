Received: from eggs.gnu.org ([2001:4830:134:3::10]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8Am-0007Sb-An
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8Ag-0003Lu-5T
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:15:16 -0500
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:34112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8Ag-0003LB-0d
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:15:10 -0500
Received: by mail-qt0-x231.google.com with SMTP id 33so2453844qtv.1
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 08:15:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d4ff0eb-a064-d4f5-39a3-4d622d54ff16@amsat.org>
Date: Thu, 4 Jan 2018 13:15:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180104160523.22995-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/18] build-sys: add a rule to print a
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

Hi Marc-André,

On 01/04/2018 01:05 PM, Marc-André Lureau wrote:
> $ make print-CFLAGS
> CFLAGS=-fsanitize=address -Og -g

smiley mode:

$ make print-*
*=*

I didn't understood this one:

$ make print-\$
  CC      tests/qemu-iotests/socket_scm_helper.o
  LINK    tests/qemu-iotests/socket_scm_helper
  GEN     qga/qapi-generated/qga-qapi-types.h
  GEN     qga/qapi-generated/qga-qapi-visit.h
  GEN     qga/qapi-generated/qga-qmp-commands.h
  CC      qga/commands.o
  ...


> Trick from various sources:
> https://stackoverflow.com/questions/16467718/how-to-print-out-a-variable-in-makefile
> https://www.cmcrossroads.com/article/printing-value-makefile-variable
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  Makefile                    |  5 ++++-
>  docs/devel/build-system.txt | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 1671db3bdd..f26ef1b1df 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -8,9 +8,12 @@ SRC_PATH=.
>  
>  UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
>      html info pdf txt \
> -    help check-help \
> +    help check-help print-% \
>      docker docker-% vm-test vm-build-%
>  
> +print-%:
> +	@echo '$*=$($*)'
> +
>  # All following code might depend on configuration variables
>  ifneq ($(wildcard config-host.mak),)
>  # Put the all: rule here so that config-host.mak can contain dependencies.
> diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
> index 386ef36ee3..52501f2ad9 100644
> --- a/docs/devel/build-system.txt
> +++ b/docs/devel/build-system.txt
> @@ -510,3 +510,16 @@ default-configs/$TARGET-NAME file as input.
>  This is the entrypoint used when make recurses to build a single system
>  or userspace emulator target. It is merely a symlink back to the
>  Makefile.target in the top level.
> +
> +
> +Useful make targets
> +===================
> +
> +- help
> +
> +  Print a help message for the most common build targets.
> +
> +- print-VAR
> +
> +  Print the value of the variable VAR. Useful for debugging the build
> +  system.
> 
