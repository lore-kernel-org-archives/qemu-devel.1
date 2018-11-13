Received: from eggs.gnu.org ([2001:4830:134:3::10]:58059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gMdDV-0003E4-1h
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gMd9P-00073R-ID
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:11:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gMd9P-0006v1-9s
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:10:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so5212312wrt.7
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 10:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-3-sameo@linux.intel.com>
	<CAFEAcA-R51dyV7gtS+q-eLNn5LBJbSMKtQu4-N3p0c4mJrU8DA@mail.gmail.com>
	<37b5f17e-50cd-6980-2d42-4e7f4ede2597@redhat.com>
	<CAFEAcA_O5x3QuTnKkupur=iwQaEg-i1z2mWoNCiZt_zM5xi-XA@mail.gmail.com>
In-Reply-To: <CAFEAcA_O5x3QuTnKkupur=iwQaEg-i1z2mWoNCiZt_zM5xi-XA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 13 Nov 2018 19:10:25 +0100
Message-ID: <CAP+75-X-GQFGGNprc5nW96qJanG=h7G9_iT8y9B98EdjNRWhcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/13] target: arm: Remove unused headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Tue, Nov 13, 2018 at 7:08 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On 13 November 2018 at 18:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
> > On 13/11/18 18:01, Peter Maydell wrote:
> >> On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wro=
te:
>
> >>> --- a/target/arm/helper.c
> >>> +++ b/target/arm/helper.c
> >>> @@ -12,13 +12,10 @@
> >>>   #include "internals.h"
> >>>   #include "exec/gdbstub.h"
> >>>   #include "exec/helper-proto.h"
> >>> -#include "qemu/host-utils.h"
> >>
> >>
> >> This is for muldiv64().
> >
> >
> > But it is already included by "cpu.h" -> "exec/cpu-defs.h"
>
> > So they are not "unused" but "unnecessary".
> >
> > I thought this would be better to clean this once, before Samuel split.
>
> Generally I think that if a .c file directly uses function X declared in
> header Y it should #include Y, even if it happens that it already include=
s
> other header Z that includes Y. Otherwise if we refactor Z later such
> that it no longer needs to include Y, it will break compilation of the .c
> file. (That is, Z including Y is a detail of the implementation of Z,
> not a guarantee made by Z to its users.)

Yes, this makes sense now, thanks.

Phil.

> The exception here is where the header guarantees that it's going
> to include certain other things (which is the case for eg our osdep.h).
>
> thanks
> -- PMM
