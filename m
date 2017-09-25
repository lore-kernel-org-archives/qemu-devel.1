Received: from eggs.gnu.org ([2001:4830:134:3::10]:50453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwSgF-00029S-N5
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwSgE-0002xs-Op
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:40:11 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwSgE-0002wW-Id
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:40:10 -0400
Received: by mail-wm0-x241.google.com with SMTP id r136so7065255wmf.3
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 05:40:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e79f23b-0a09-3d80-b306-a2211e2e83d7@vivier.eu>
References: <20170922140237.10869-1-carenas@gmail.com>
	<20170922140237.10869-2-carenas@gmail.com>
	<4e79f23b-0a09-3d80-b306-a2211e2e83d7@vivier.eu>
From: Carlo Arenas <carenas@gmail.com>
Date: Mon, 25 Sep 2017 05:40:09 -0700
Message-ID: <CAPUEspgr3M8P-9zh3C5COocjLn-ZwpfSiLnU_Ai2Az-p53xEag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/6] linux-user: update hppa sockbits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, riku.voipio@iki.fi

On Fri, Sep 22, 2017 at 9:13 AM, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 22/09/2017 =C3=A0 16:02, Carlo Marcelo Arenas Bel=C3=B3n a =C3=A9crit =
:
> > updated to match arch/parisc/include/uapi/asm/socket.h from linux 4.14
>
> I think it's not a good idea to change indentation, by adding spaces you
> hide the real changes that are in fact simple:
>

would you rather have all reformatting be done in an independent patch on
the series, or maybe even done completely independently after it is merged
as part of the trivial patches flow?

>  /** sock_type - Socket types - default values
> >   *
> > - *
>
> Why do you remove this line?
>

It is just an unnecessary empty line; probably a leftover of the copy/paste
that was done originally (removing the arch specific comment) when this
file got created.  In that same line, probably should have also removed the
"default values" comment.

in a more important note, it adds extra noise when looking for differences
between different archs.

just now made me notice I added an extra line between the comment and the
enum definition for sparc and alpha which is also inconsistent.  any
preference?

Carlo
