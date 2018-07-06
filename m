Received: from eggs.gnu.org ([2001:4830:134:3::10]:55252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbSO5-0002OG-Sb
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbSO5-00078L-1J
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:11:09 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:36660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbSO4-00078B-SY
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:11:08 -0400
Received: by mail-oi0-x232.google.com with SMTP id r16-v6so24091534oie.3
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 08:11:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706145645.GB3939@localhost.localdomain>
References: <20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 16:10:47 +0100
Message-ID: <CAFEAcA9J=Jmd=+9vEo4LLdk0LcL42fchHcAp3fp_+9q1tsCoNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

On 6 July 2018 at 15:56, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 06.07.2018 um 13:11 hat Cornelia Huck geschrieben:
>> That way, we can still easily remove old cruft (case (a)), but still
>> accommodate cases like this (case (c)). The obvious drawback is that
>> we'd need someone to curate the deprecation watchlist, to poke the
>> users we're waiting for, and probably remove anyway after some time if
>> they don't get their act together.
>
> The problem is that things are only starting to move after two releases
> have passed.

Right, so clearly just "put a note in the documentation" isn't
sufficient advertisement/prodding of things going away. (Also, two
releases is pretty fast. Many of our users will be using distro
packaged versions of QEMU which will lag further behind than
bleeding-edge users. The system version of QEMU on my desktop
machine is 2.5...)

thanks
-- PMM
