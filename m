Received: from eggs.gnu.org ([2001:4830:134:3::10]:35011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVkVG-0000qw-Dz
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVkVF-0005Ka-7Y
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:42:10 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:33484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVkVF-0005KT-3a
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:42:09 -0500
Received: by mail-ua0-x22c.google.com with SMTP id i68so117847976uad.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:42:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAF++6APW69OBEzfUaWXK-kXLY5euu8aJjvFrYzwFT1tes-W=gA@mail.gmail.com>
References: <CAF++6APW69OBEzfUaWXK-kXLY5euu8aJjvFrYzwFT1tes-W=gA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 19:41:48 +0000
Message-ID: <CAFEAcA-aEA9cNzd6cJchrdojyX7xKr4eOKECkMEen=fhGucCPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] changeset b0cb0a66d broken - missing
 QEMU_OPTION_enable_hax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hanley <jhanley@dgtlrift.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Vincent Palatin <vpalatin@chromium.org>

On 23 January 2017 at 19:32, James Hanley <jhanley@dgtlrift.com> wrote:
> Changeset fails to compile:
>
> qemu/vl.c:3683:18: error: =E2=80=98QEMU_OPTION_enable_hax=E2=80=99 undecl=
ared (first use in
> this function)
>              case QEMU_OPTION_enable_hax:
>                   ^
> I assume that there is details in
>
> ./qemu-options.def
> ./qemu-options.hx
>
> that were not included with the commit?

Your source tree probably has a stale qemu-options.def in it
from an attempt to do an in-tree build at some point in the
past (and now you are doing out-of-tree builds). If you do a
'make distclean' in the source tree this will get rid of the
stale junk and the build should work. (Or you can just git
clone a fresh tree; or attempt to more carefully remove
individual stale stuff, but that risks leaving some other
stale file around.)

(The change to qemu-options.hx is sufficient, because we
generate qemu-options.def from it in the build tree; but
if you have a stale .def file in the source tree then
gcc will pick that one up before the one in the build tree;
which works until something requires a change that postdates
the stale stuff.)

thanks
-- PMM
