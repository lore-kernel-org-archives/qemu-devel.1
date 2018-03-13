Received: from eggs.gnu.org ([2001:4830:134:3::10]:44536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evod7-0004Z1-S9
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evod7-0006sr-4Z
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:26:33 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evod6-0006sX-V7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:26:33 -0400
Received: by mail-oi0-x241.google.com with SMTP id g5so508321oiy.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 11:26:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313182343.GF3784@redhat.com>
References: <20180312201305.16972-1-berrange@redhat.com>
	<CAFEAcA-AHbzvbaxNeMRakB-gA_w3ZnD1x50dLx_hD+3-L9yuTg@mail.gmail.com>
	<20180313162708.GB3784@redhat.com> <20180313182343.GF3784@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 18:26:11 +0000
Message-ID: <CAFEAcA_G0EH6C8EHspTL2shobaUvVpoK2+qimuSHZNJijMmQBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/9] Socket next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 13 March 2018 at 18:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> On Tue, Mar 13, 2018 at 04:27:08PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> This feels unrelated to the series, so possibly a non-deterministic
>> failure
>
> Looking at the test source code, it has a 60 second wait for the
> emulator to print expected data on the serial port. My guess
> would be that when running with a highly parallel make check
> we're sometimes exceeding that 60 seconds. I don't see a
> reason why my series would have affected this in a way that
> only failed with sparc64 qtest, and none others.

Sounds plausible. Feel free to resubmit the pullreq with the
actual bug fixed, for another spin of the intermittent-failure
roulette wheel :-)

-- PMM
