Received: from eggs.gnu.org ([2001:4830:134:3::10]:33526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d7ojS-0000Ej-On
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d7ojP-0002xf-G1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:54:10 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:48925)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d7ojP-0002wg-9G
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:54:07 -0400
Date: Mon, 8 May 2017 21:54:04 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170508195404.j33kcmqncrb7fziv@var.youpi.perso.aquilenet.fr>
References: <20170420204301.154912-1-lepton@google.com>
	<42f99074-9330-c974-e884-f0a62e63c697@redhat.com>
	<20170427132126.lkdi5owqezvlp6o2@var.youpi.perso.aquilenet.fr>
	<CALqoU4xQPynFnXH86z7+kw9fQ-3zFfesScMRYcK885HXMKKK5w@mail.gmail.com>
	<20170504230520.k4hxva2la45cmuze@var.youpi.perso.aquilenet.fr>
	<CALqoU4wb=sQNQXOKKknpwb2n8Sfm3OZNDHHqaNNduXzp24kVCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALqoU4wb=sQNQXOKKknpwb2n8Sfm3OZNDHHqaNNduXzp24kVCg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: don't zero ti_i since we
 acccess it later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lepton <ytht.net@gmail.com>
Cc: Tao Wu <lepton@google.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Hello,

lepton, on lun. 08 mai 2017 12:08:55 -0700, wrote:
> 1.=C2=A0 For some reason, caller didn't setup anything in tcpiphdr, so =
there is
> random data inside it.
> 2.=C2=A0 For some reason, caller setup correct src/dst address in tcpip=
hdr but don't
> zero ix_h1

> If you still think this doesn't look likely happen,

Well, 1) is very likely to have been spotten another way. And crashing
just because of 2) is harsh on users.

The original code was setting ih_x1 at this point, so that was the
original intent.

> I am fine with your suggestion and will add zero for ih_x1, any
> comments?

Samuel
