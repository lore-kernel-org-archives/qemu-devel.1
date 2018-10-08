Received: from eggs.gnu.org ([2001:4830:134:3::10]:55033)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9XKs-00024K-P1
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9XKn-0006b6-Kg
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:20:42 -0400
Received: from mail2.static.mailgun.info ([104.130.122.2]:32847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9XKn-0006af-Eb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:20:37 -0400
Sender: cst=tolva.net@mg-relay.tolva.net
Received: by mail-wm1-f48.google.com with SMTP id y144-v6so4211874wmd.4
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 08:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181008042747.10130-1-cst@tolva.net>
	<b1b48975-36e3-baf6-c2b2-8cc1b7fa4986@vivier.eu>
In-Reply-To: <b1b48975-36e3-baf6-c2b2-8cc1b7fa4986@vivier.eu>
From: =?UTF-8?Q?Cortland_Setlow_T=C3=B6lva?= <cst@tolva.net>
Date: Mon, 8 Oct 2018 08:20:22 -0700
Message-ID: <CALQmfgMzO5gv80LYyaAwz_NOoLw52LVMcZHx0DDC9nzE16uH2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: usbfs improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Cortland_T=C3=B6lva?= <cst@tolva.net>, qemu-devel@nongnu.org

On Sun, Oct 7, 2018 at 11:59 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 08/10/2018 =C3=A0 06:27, Cortland T=C3=B6lva a =C3=A9crit :
> > From: Cortland Setlow T=C3=B6lva <cst@tolva.net>
> >
> > This patch series enables programs running under QEMU Linux user mode
> > emulation to implement user-space USB drivers via the USBFS ioctl()s.
> > Support is limited to control, bulk, and possibly interrupt transfers.
> >
> > Usbfs ioctl codes were incorrect whenever host and target disagreed on
> > struct size.  The submit, discard, and reap usbfs ioctls require specia=
l
> > memory buffer handling and the second commit implements this but not fo=
r
> > USB3 streams or isochronous transfers.
> >
> > Cortland T=C3=B6lva (2):
> >   linux-user: Use calculated sizes for usbfs ioctls.
> >   linux-user: Implement special usbfs ioctls.
> >
> >  linux-user/ioctls.h        |   8 ++
> >  linux-user/syscall.c       | 177 +++++++++++++++++++++++++++++++++++++
> >  linux-user/syscall_defs.h  |  42 ++++-----
> >  linux-user/syscall_types.h |  20 +++++
> >  4 files changed, 227 insertions(+), 20 deletions(-)
> >
>
> As I didn't push the previous series, could you merge the both in one on
> top of master?

Yes, I will do this as a v2 of this patch series.  The version here is
based on your
linux user tree as of last night.

>
> I think it would be clearer.
>
> Thanks,
> Laurent
