Received: from eggs.gnu.org ([2001:4830:134:3::10]:56686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exuhi-0004Mi-PY
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exuhh-0006aL-S4
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:19:58 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:46113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exuhh-0006Za-MJ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:19:57 -0400
Received: by mail-oi0-x231.google.com with SMTP id x12so14234906oie.13
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 06:19:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180221052735.GA2919@localhost.localdomain>
References: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
	<20180221052735.GA2919@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 13:19:36 +0000
Message-ID: <CAFEAcA8AA643WJGwF3fHEOtjw_Sx_1TeOf5UZFg9x_L2Ot6XYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Moving seabios-hppa git submodule to use a
 qemu.org mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, BALATON Zoltan <balaton@eik.bme.hu>

On 21 February 2018 at 05:27, Jeff Cody <jcody@redhat.com> wrote:
> On Tue, Feb 20, 2018 at 06:43:22PM +0000, Peter Maydell wrote:
>> I just noticed that we seem to have acquired another git
>> submodule that isn't pointing to a qemu.org git url:
>>
>> [submodule "roms/seabios-hppa"]
>>         path = roms/seabios-hppa
>>         url = git://github.com/hdeller/seabios-hppa.git
>>
>> Jeff, could we set up so we can mirror this repo on qemu.org?
>> Then we can send a patch to update the .gitmodules to point to it.
>>
>
> Yes, of course... Although Paolo has suggested making it a branch of the
> existing SeaBIOS repo instead.  But I can go ahead and get the clone setup,
> in case we go that route.

Hi; can we get the mirror set up for seabios-hppa, and also for
the other new repo:
 git://github.com/zbalaton/u-boot-sam460ex

please?

(I've just sent a patch which moves the qemu-palcode module
to the already-existing mirror.)

thanks
-- PMM
