Received: from eggs.gnu.org ([2001:4830:134:3::10]:45621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyH1L-0007v9-RW
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyH1G-0000wV-6D
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:41:59 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyH1C-0000nK-EC
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:41:52 -0400
Received: by mail-wm0-x242.google.com with SMTP id y2-v6so14806738wma.1
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 06:41:49 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819518295.30857.8519946393746431063.stgit@pasha-ThinkPad-T60>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152819518295.30857.8519946393746431063.stgit@pasha-ThinkPad-T60>
Date: Fri, 07 Sep 2018 14:41:47 +0100
Message-ID: <87sh2lzap0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/7] plugins: add plugin template
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu


Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>
> This is a template of the QEMU plugin. It includes empty functions that
> plugins may implement.
>

I'm not sure it's worth having a null-template plugin if we can have one
or two well documented example plugins. It just runs the risk of
bitrot....

> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  plugins/template/Makefile   |   19 +++++++++++++++++++
>  plugins/template/template.c |   19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 plugins/template/Makefile
>  create mode 100644 plugins/template/template.c
>
> diff --git a/plugins/template/Makefile b/plugins/template/Makefile
> new file mode 100644
> index 0000000..b9d10da
> --- /dev/null
> +++ b/plugins/template/Makefile
> @@ -0,0 +1,19 @@
> +CFLAGS +=3D -I../include -fno-PIE -fPIC -O3
> +LDFLAGS +=3D -shared
> +# TODO: Windows
> +DSOSUF :=3D .so
> +
> +NAME:=3D template
> +BIN :=3D $(NAME)$(DSOSUF)
> +
> +FILES :=3D template.o
> +
> +%.o: %.c
> +	$(CC) -c -o $@ $< $(CFLAGS)
> +
> +all: $(FILES)
> +	$(CC) $(LDFLAGS) -o $(BIN) $(FILES)
> +
> +clean:
> +	rm $(FILES)
> +	rm $(BIN)
> diff --git a/plugins/template/template.c b/plugins/template/template.c
> new file mode 100644
> index 0000000..fed1053
> --- /dev/null
> +++ b/plugins/template/template.c
> @@ -0,0 +1,19 @@
> +#include <stdint.h>
> +#include <stdio.h>
> +#include "plugins.h"
> +
> +bool plugin_init(const char *args)
> +{
> +    printf("template plugin loaded successfully\n");
> +    return true;
> +}
> +
> +bool plugin_needs_before_insn(uint64_t pc, void *cpu)
> +{
> +    return true;
> +}
> +
> +void plugin_before_insn(uint64_t pc, void *cpu)
> +{
> +    printf("executing instruction at %lx\n", pc);
> +}


--
Alex Benn=C3=A9e
