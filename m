Received: from eggs.gnu.org ([2001:4830:134:3::10]:51816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfnPN-0004gW-DA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfnPJ-0002KR-G2
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:49:37 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfnPJ-0002Jw-91
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:49:33 -0500
Received: by mail-wm0-x235.google.com with SMTP id v186so78259344wmd.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:49:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cbf02100-fe02-d7cd-e3a7-05149399198e@vivier.eu>
References: <20170219200231.30672-1-laurent@vivier.eu>
	<CAFEAcA-wewMTE0qP1VB1VSTk=mNhZKxpQfrC79twv7iFk+Nedg@mail.gmail.com>
	<cbf02100-fe02-d7cd-e3a7-05149399198e@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 12:49:11 +0000
Message-ID: <CAFEAcA9z_KLEKouw18wwrxm9DCAUz62K1SpADEgoYyWFzVQDgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] risu-m68k: update fpregs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 February 2017 at 12:41, Laurent Vivier <laurent@vivier.eu> wrote:
> I have some problems with risugen since some functions have been moved
> to common:
>
> $ ./risugen --numinsns 10000 --pattern ABCD m68k.risu ABCD.out
> Generating code using patterns: ABCD M68000...
> Syntax error detected evaluating ABCD M68000 constraints string:
>     ]
> {                         write_movb_di($Dx, rand(10) | (rand(10) <<
> 4));                         write_movb_di($Dy, rand(10) | (rand(10) <<
> 4));                         1;                      }
> Undefined subroutine &risugen_common::write_movb_di called at (eval 5)
> line 1.
>
> If I add "risugen_m68k::" to the function name, it works. But is there
> better solution to fix that instead of updating all the calls in
> m68k.risu for functions found in risugen_m68k.pm?

Oops, that was unintended. We definitely don't want to require
decorating all the function calls in the .risu files. Reverting
commit 6a3647ae8918 should fix this, but I'll see if there's
a way to avoid the code duplication without the problem with
evaluation happening in the "wrong" module scope.

thanks
-- PMM
