Received: from eggs.gnu.org ([2001:4830:134:3::10]:45058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5uJ6-00045o-4x
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5uJ5-0003pl-AD
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:31:36 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:38383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5uJ5-0003pM-3p
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:31:35 -0400
Received: by mail-ot0-x231.google.com with SMTP id o9-v6so12965137otj.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 07:31:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152337021185.15508.13282518954009351050@sif>
References: <20180410005724.10059-1-mdroth@linux.vnet.ibm.com>
	<CAFEAcA-_CW1w+XXAxWo93t8L+5zAcBRM6v7wF9xw1_EBd5FibA@mail.gmail.com>
	<152337021185.15508.13282518954009351050@sif>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 15:31:13 +0100
Message-ID: <CAFEAcA8KS2rVuMakDjW9buCG4=4pmL7J1_kfsF9P9PpbV-tzdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] make-release: add skiboot
 .version file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, qemu-stable <qemu-stable@nongnu.org>

On 10 April 2018 at 15:23, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Quoting Peter Maydell (2018-04-10 02:31:04)
>> On 10 April 2018 at 01:57, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>> >  # FIXME: The following line is a workaround for avoiding filename collisions
>> >  # when unpacking u-boot sources on case-insensitive filesystems. Once we
>> >  # update to something with u-boot commit 610eec7f0 we can drop this line.
>>
>> Seeing this comment in the context part of this patch reminds me:
>> have we updated to a u-boot that lets us drop the workaround yet?
>
> Not yet, we need:
>
>   https://github.com/u-boot/u-boot/commit/610eec7f0
>
> which was committed Oct 2017, but QEMU master is still using the
> v2017.07 July release, via:
>
>   https://github.com/qemu/qemu/commit/73663d71

I guess it's too late in the 2.12 release cycle to update our
u-boot binary, but we should remember to do it at the start of 2.13...

thanks
-- PMM
