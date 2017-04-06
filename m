Received: from eggs.gnu.org ([2001:4830:134:3::10]:41509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwCHQ-00069r-1N
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwCHO-0002fW-Ow
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:37:12 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cwCHO-0002fA-IS
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:37:10 -0400
Received: by mail-wr0-x22f.google.com with SMTP id o21so47548738wrb.2
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 11:37:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <oc60j5$ceq$1@blaine.gmane.org>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
	<CAFEAcA-3TkmaJXpG2RpzBPKmj+JKGK5EBwPvXWkwR=Qkobq-Sg@mail.gmail.com>
	<7c4d6c25-3b1c-61ec-1eda-6c5e7cee8755@redhat.com>
	<CAFEAcA_3jE9F92F6+p6eDfmPwV2LL=fKV-htfTHpCoCOAgJAMg@mail.gmail.com>
	<oc60j5$ceq$1@blaine.gmane.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Apr 2017 19:36:48 +0100
Message-ID: <CAFEAcA-yPTxSB90zUg2Mn6s=HdXshWyZ9z7HrF+6+3hD6manoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Rainer_M=C3=BCller?= <raimue@codingfarm.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 April 2017 at 19:15, Rainer M=C3=BCller <raimue@codingfarm.de> wrote:
> A bit late to this thread, but the original problem was also reported
> for Mac OS X with --enable-curses in MacPorts. The build fails with the
> same symptoms as in the original report.
>
> https://trac.macports.org/ticket/53929
>
> As you identified, the problem is that ncurses expects the define
> _XOPEN_SOURCE >=3D 500 to enable the wide-char function declarations.
>
> The solution to retain access to non-standard API on Mac OS X would be
> to also define _DARWIN_C_SOURCE which enables extensions.

Thanks for the report. I have a feeling that fixing this bug
got lost somewhere -- there was a long thread about it but I
don't think an actual patch ever came out of it :-(

At this point (very near to release of 2.9) I think I'd rather
postpone fixing this until after release. It should be possible
to work around it with an --extra-cflags configure setting,
and our current behaviour is something we've had for many
releases now.

thanks
-- PMM
