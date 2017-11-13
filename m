Received: from eggs.gnu.org ([2001:4830:134:3::10]:45585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEKTl-0002nn-CO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEKTg-0003Tl-Fo
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:33:09 -0500
References: <20171113182752.8223-1-googuy@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d22ec102-065f-5570-52f8-f848e5f71640@redhat.com>
Date: Mon, 13 Nov 2017 14:33:00 -0500
MIME-Version: 1.0
In-Reply-To: <20171113182752.8223-1-googuy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Document mon's pretty parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vicente Jimenez Aguilar <googuy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

Vicente,

Thanks for helping to improve our documentation.

On 11/13/2017 01:27 PM, Vicente Jimenez Aguilar wrote:
> ---

This patch is missing a signed-off-by line, which we require for
contributions to the project. If you'd like, you can reply to your patch
email to add said line if further edits to the patch aren't required.

[See https://wiki.qemu.org/Contribute/SubmitAPatch; this page is very
long, so here's the relevant excerpt: "You must provide a Signed-off-by:
line (this is a hard requirement because it's how you say "I'm legally
okay to contribute this and happy for it to go into QEMU", modeled after
the Linux kernel policy.) git commit -s or git format-patch -s will add
one."]

Every patch also needs a commit message of some kind, something akin to:

"Documentation: document pretty parameter for mon option"

>  qemu-options.hx | 7 ++++--->  1 file changed, 4 insertions(+), 3 deletions(-)> > diff --git
a/qemu-options.hx b/qemu-options.hx> index 3728e9b4dd..f06002689d
100644> --- a/qemu-options.hx> +++ b/qemu-options.hx> @@ -3477,11
+3477,12 @@ Like -qmp but uses pretty JSON formatting.>  ETEXI>  >
DEF("mon", HAS_ARG, QEMU_OPTION_mon, \> -    "-mon
[chardev=]name[,mode=readline|control]\n", QEMU_ARCH_ALL)> +    "-mon
[chardev=]name[,mode=readline|control][,pretty[=on|off]]\n",
QEMU_ARCH_ALL)>  STEXI> -@item -mon
[chardev=]name[,mode=readline|control]> +@item -mon
[chardev=]name[,mode=readline|control][,pretty[=on|off]]>  @findex -mon>
-Setup monitor on chardev @var{name}.> +Setup monitor on chardev
@var{name}. @code{pretty} turn on JSON pretty printing> +easing human
reading and debugging.>  ETEXI>  >  DEF("debugcon", HAS_ARG,
QEMU_OPTION_debugcon, \>
I'm not sure if any other changes are needed or not; it looks OK to me
based on vl.c:2522 where the option is added at runtime.

Thanks,
John
