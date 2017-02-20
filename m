Received: from eggs.gnu.org ([2001:4830:134:3::10]:60808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfnr1-0002JI-Sh
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfnr1-0005za-3L
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:18:11 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfnr0-0005zP-Sn
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:18:11 -0500
Received: by mail-wm0-x236.google.com with SMTP id c85so79003808wmi.1
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:18:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <40fc984e-d9b2-5040-967d-af5bd9f9d032@vivier.eu>
References: <20170219200231.30672-1-laurent@vivier.eu>
	<CAFEAcA-wewMTE0qP1VB1VSTk=mNhZKxpQfrC79twv7iFk+Nedg@mail.gmail.com>
	<cbf02100-fe02-d7cd-e3a7-05149399198e@vivier.eu>
	<CAFEAcA9z_KLEKouw18wwrxm9DCAUz62K1SpADEgoYyWFzVQDgQ@mail.gmail.com>
	<40fc984e-d9b2-5040-967d-af5bd9f9d032@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 13:17:48 +0000
Message-ID: <CAFEAcA8CWU088zLD5H_FRiye3qVoH7n_iRwQnS8KwF5POqM26Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On 20 February 2017 at 13:08, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 20/02/2017 =C3=A0 13:49, Peter Maydell a =C3=A9crit :
>> Oops, that was unintended. We definitely don't want to require
>> decorating all the function calls in the .risu files. Reverting
>> commit 6a3647ae8918 should fix this, but I'll see if there's
>> a way to avoid the code duplication without the problem with
>> evaluation happening in the "wrong" module scope.
>
> Reverting 6a3647ae8918 actually fixes the problem.

I found a better fix (adding a package statement to the eval'd
string) and pushed it to master.

The ideal solution to this problem would be to tighten up the
way we evaluate strings from risu files, so that they're run
in their own package which only has imported into it the specific
functions that we want to give them access to. That's a bit
beyond my somewhat rudimentary Perl skills though, so I've
settled for just adding a comment to that effect.

thanks
-- PMM
