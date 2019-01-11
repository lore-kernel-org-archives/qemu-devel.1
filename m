Received: from eggs.gnu.org ([209.51.188.92]:39427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghwyN-0004LY-9H
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghwyM-00036j-58
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:35:43 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:34430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghwyL-00033S-TW
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:35:42 -0500
Received: by mail-oi1-x230.google.com with SMTP id r62so12218154oie.1
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20190110134917.16425-1-anthony.perard@citrix.com>
In-Reply-To: <20190110134917.16425-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 13:35:29 +0000
Message-ID: <CAFEAcA-RQkXCvijrDkQY=QADq4O6c60ab1d-9oeq+vdObtQiUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] xen queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Thu, 10 Jan 2019 at 13:52, Anthony PERARD <anthony.perard@citrix.com> wr=
ote:
>
> The following changes since commit 8ae951fbc1068308313b2c57a4fc3c68451641=
f4:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190109=
' into staging (2019-01-09 16:08:31 +0000)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-x=
en-20190110
>
> for you to fetch changes up to 24edb91f5009fa941e1294aaf4bb2103d9ad077e:
>
>   xen-block: avoid repeated memory allocation (2019-01-10 11:25:17 +0000)
>
> ----------------------------------------------------------------
> xen queue
>
> * Xen PV backend 'qdevification'.
>   Starting with xen_disk.
> * Performance improvements for xen-block.
> * Remove of the Xen PV domain builder.
> * bug fixes.
>
> ----------------------------------------------------------------

Hi. This fails to compile for me (x86-64 Linux host):

  CC      hw/block/xen-block.o
In file included from
/home/petmay01/linaro/qemu-for-merges/include/hw/xen/xen-block.h:11:0,
                 from
/home/petmay01/linaro/qemu-for-merges/hw/block/xen-block.c:22:
/home/petmay01/linaro/qemu-for-merges/include/hw/xen/xen-bus.h:32:5:
error: unknown type name =E2=80=98xenevtchn_port_or_error_t=E2=80=99
     xenevtchn_port_or_error_t local_port;
     ^
/home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
'hw/block/xen-block.o' failed

Probably the code is accidentally assuming a newer version
of the Xen headers than this system has installed? This
is Ubuntu 16.04.5 with libxen-dev  4.6.5-0ubuntu1.4.

thanks
-- PMM
