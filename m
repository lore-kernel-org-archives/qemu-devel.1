Received: from eggs.gnu.org ([209.51.188.92]:54735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr12v-0001QX-FS
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr12n-0007JJ-Ll
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:45:50 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr12Z-00079l-JQ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:45:34 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so5658438otk.9
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 05:45:24 -0800 (PST)
MIME-Version: 1.0
References: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
	<CABLmASEAbmGRohbvZag0jWYqvxys=dUiKeTJyN2=CYE+X1JAXQ@mail.gmail.com>
In-Reply-To: <CABLmASEAbmGRohbvZag0jWYqvxys=dUiKeTJyN2=CYE+X1JAXQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 13:45:12 +0000
Message-ID: <CAFEAcA9sLhi__xgQz9xXyyjxyuRN1ayAUykFgTb_rHCfEtVipg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] 2x-3x tcg performance regression on
 ppc64 (maybe others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Tue, 5 Feb 2019 at 08:37, Howard Spoelstra <hsp.cat7@gmail.com> wrote:
>
>
>
>
> On Fri, Feb 1, 2019 at 11:54 PM Cleber Rosa <crosa@redhat.com> wrote:
>>
>> While working on the "boot_linux_console.py" tests, after a given
>> rebase, I noticed that the ppc64 specific test began timing out.  The
>> original timeout set to the test was 60 seconds, and it "always" had
>> room to spare when running either on my system, or on Travis CI.
>>
> Hi,
>
> As reported on IRC on 31-01, performance loss also occurs with qemu-syste=
m-ppc:
> "I noticed a substantial performance loss (~35% in processor benchmark) i=
n qemu-system-ppc running Mac OS 9.2. Bisecting shows that https://github.c=
om/qemu/qemu/commit/f7b78602fdc6c6e4befc90159da8e93900b4bcb1 introduces the=
 issue. Reverting brings performance back."

Yeah; Mark Cave-Ayland did a bit more digging into this last night,
and I have a patch that fixes it. I'll send that in a moment when
I've confirmed that I've caught all the places we need to fold
the cluster index into the hash cflags value.

thanks
-- PMM
