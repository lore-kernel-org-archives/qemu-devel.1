Received: from eggs.gnu.org ([2001:4830:134:3::10]:52783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gYhQi-0007jf-G3
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 20:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gYhQh-0003xf-HT
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 20:10:44 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:51165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gYhQh-0003wV-BL
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 20:10:43 -0500
Received: by mail-it1-x141.google.com with SMTP id z7so16633411iti.0
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 17:10:43 -0800 (PST)
MIME-Version: 1.0
References: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 17 Dec 2018 09:10:06 +0800
Message-ID: <CAKXe6SL+aYFgbHDHq2jBogfBDKrO3a1=xaKyqeNV_-f_Gm5DAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] hw: vmmouse: use link property
 instead of DEFINE_PROP_PTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, ehabkost@redhat.com
Cc: Darren Kenny <darren.kenny@oracle.com>, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Ping....Paolo, could these patches go to your misc tree?

Thanks,
Li Qiang

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8829=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8812:53=E5=86=99=E9=81=93=EF=BC=9A

> According https://wiki.qemu.org/Contribute/BiteSizedTasks
> the 'DEFINE_PROP_PTR' should be replaced by QOM link property.
> The first patch replace constant strings with TYPE_XXXX and move some
> definition to pc.h header file so that the second patch can work.
>
> Change since v2: detail commit message
> Change since v1: fix some issues per Markus' review
>
> Li Qiang (2):
>   hw: pc: use TYPE_XXX instead of constant strings
>   hw: vmmouse: Use link instead of pointer property
>
>  hw/i386/pc.c         |  9 +++++----
>  hw/i386/vmmouse.c    | 18 +++++++++++-------
>  include/hw/i386/pc.h |  3 +++
>  3 files changed, 19 insertions(+), 11 deletions(-)
>
> --
> 2.11.0
>
>
