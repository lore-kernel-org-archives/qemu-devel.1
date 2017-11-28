Received: from eggs.gnu.org ([2001:4830:134:3::10]:36897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJeiX-0005bl-8p
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJeiU-0004ap-4O
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:10:25 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJeiU-0004aI-06
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:10:22 -0500
Received: by mail-vk0-f65.google.com with SMTP id o70so68452vkc.9
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 04:10:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151127324158.6888.17818677336117525693.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127324158.6888.17818677336117525693.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 28 Nov 2017 13:10:20 +0100
Message-ID: <CABdb734zmV6pyiaBNqN_cDpERMX-i4RiiAzNK5vfjvcFbDtXHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 01/45] windbg: added empty windbgstub
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Tue, Nov 21, 2017 at 3:07 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  Makefile.target                 |    7 +++++++
>  include/exec/windbgstub-utils.h |   18 ++++++++++++++++++
>  include/exec/windbgstub.h       |   17 +++++++++++++++++
>  stubs/Makefile.objs             |    1 +
>  stubs/windbgstub.c              |   18 ++++++++++++++++++
>  target/i386/Makefile.objs       |    2 +-
>  target/i386/windbgstub.c        |   12 ++++++++++++
>  windbgstub-utils.c              |   12 ++++++++++++
>  windbgstub.c                    |   19 +++++++++++++++++++
>  9 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100755 include/exec/windbgstub-utils.h
>  create mode 100755 include/exec/windbgstub.h
>  create mode 100755 stubs/windbgstub.c
>  create mode 100755 target/i386/windbgstub.c
>  create mode 100755 windbgstub-utils.c
>  create mode 100755 windbgstub.c
>
> diff --git a/Makefile.target b/Makefile.target
> index 7f42c45db8..6df0836509 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -148,6 +148,13 @@ obj-y += dump.o
>  obj-y += migration/ram.o
>  LIBS := $(libs_softmmu) $(LIBS)
>
> +# WinDbg support
> +ifeq ($(TARGET_NAME), i386)
> +ifneq ($(TARGET_NAME), x86_64)

This is odd. Did you add the second by mistake? Thanks!
