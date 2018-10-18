Received: from eggs.gnu.org ([2001:4830:134:3::10]:39219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1gDAaX-0002Wk-9C
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1gDAaR-0004g9-M8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:51:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38980 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
	id 1gDAaR-00044L-Dq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:51:47 -0400
in-reply-to: <CAFEAcA93VVqL7V4kq6zGOq-DuuZ_0=h28hEvEH1sVjCeuo9+Jw@mail.gmail.com>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <6991-5bc8ac00-3-72599000@58175523>
date: Thu, 18 Oct 2018 17:50:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?Pz09P3V0Zi04P3E/IFtQVUxMPz09P3V0Zi04P3E/?=
 =?utf-8?q?_00/27=5DMIPS_pull_request_for_October_2018_-_part_1?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> > ----------------------------------------------------------------
> > MIPS queue October 2018, part 1
> >
> > Variety of MIPS fixes and improvements.
> > ----------------------------------------------------------------
> 
> Hi; I get a build failure for mips linux-user with clang:
> 
> 
> /home/petmay01/linaro/qemu-for-merges/target/mips/translate.c:2486:20=
:
> error: unused function 'check=5Fpw' [-Werror,-Wunused-function]
> static inline void check=5Fpw(DisasContext *ctx)
> ^
> 1 error generated.
> 
> check=5Fpw() is defined unconditionally but only used
> inside ifndef CONFIG=5FUSER=5FONLY guards.
> 
> thanks
> -- PMM

Sorry, and thanks, I am going to send v2, hopefully before the end of t=
he day.

Aleksandar
