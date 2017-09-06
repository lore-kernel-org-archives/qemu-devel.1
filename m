Received: from eggs.gnu.org ([2001:4830:134:3::10]:33793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dpOtO-0001dM-0g
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dpOtM-0006vA-Tq
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:12:33 -0400
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:32941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dpOtM-0006ud-Oq
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:12:32 -0400
Received: by mail-vk0-x234.google.com with SMTP id t10so9775406vke.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 18:12:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMzKsXu29K+b=fGuPLti5if6zj5=pQhpmQz1iei6-hgjbq_41Q@mail.gmail.com>
References: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
	<20170905035457.3753-9-Sergio.G.DelReal@gmail.com>
	<CAMzKsXu29K+b=fGuPLti5if6zj5=pQhpmQz1iei6-hgjbq_41Q@mail.gmail.com>
From: =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_del_Real?=
	<sergio.g.delreal@gmail.com>
Date: Tue, 5 Sep 2017 20:12:31 -0500
Message-ID: <CAMzKsXu0LOR=mzBNq-=sbv3YRBCjKXxx2NjeJya-TPkK6mYT2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/14] hvf: add compilation rules to
 Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Stefan, is this acceptable? I mean delaying the compiling; up until patch 7
no hvf code is compiled. Or should I just squash everything from patch 2 to
7?

El 4/09/2017 23:03, "Sergio Andr=C3=A9s G=C3=B3mez del Real" <
sergio.g.delreal@gmail.com> escribi=C3=B3:

Note that until this patch (8/14) there is no compiling. I tried to put
this patch earlier in the patchset but found difficulties because some
things need to be done before the hvf code compiles well.
Also, the commit message needs to be updated (remove the -enable-hvf part).

On Mon, Sep 4, 2017 at 10:54 PM, Sergio Andres Gomez Del Real <
sergio.g.delreal@gmail.com> wrote:

> This commit adds to target/i386/Makefile.objs the necessary rules so
> that the new files for hvf are compiled by the build system.
> It also adds handling of the -enable-hvf argument in the main function
> in vl.c.
>
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  target/i386/Makefile.objs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 6a26e9d9f0..0bef89c099 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -12,4 +12,5 @@ obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-windows.=
o
>  endif
>  ifdef CONFIG_DARWIN
>  obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-darwin.o
> +obj-$(CONFIG_HVF) +=3D hvf-utils/ hvf-all.o
>  endif
> --
> 2.14.1
>
>
