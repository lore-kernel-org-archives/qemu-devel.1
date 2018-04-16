Received: from eggs.gnu.org ([2001:4830:134:3::10]:50636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f80aB-0004sL-Mv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f80a6-0001E9-Qo
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:37:55 -0400
References: <20180414142739.23375-1-mjt@msgid.tls.msk.ru>
	<CAFEAcA_isnmigyPV=bZtyJ3r++8pc__7b9z12FEtd6SHJum9mg@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <08cf4157-d63f-a407-933d-56d6f34724ac@msgid.tls.msk.ru>
Date: Mon, 16 Apr 2018 12:37:49 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_isnmigyPV=bZtyJ3r++8pc__7b9z12FEtd6SHJum9mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH trivial for-2.12] Makefile: install gtk
 message catalogs if CONFIG_GTK=y too, not only =m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

16.04.2018 12:26, Peter Maydell wrote:
> On 14 April 2018 at 15:27, Michael Tokarev <mjt@tls.msk.ru> wrote:

>> -ifeq ($(CONFIG_GTK),m)
>> +ifneq ($(filter $(CONFIG_GTK),y m),)
>>         $(MAKE) -C po $@
>>  endif

> "trivial" and "for 2.12" don't make much sense together at this point in
> the release cycle. Is this important enough to go into rc4, or not?

Well, without this, gtk translations wont be installed. Not a huge issue,
especially for the languages where qemu lacks translations, but I still
think it is important enough to go to 2.12, or else it'll be a regression.

I've just sent another, simpler version of the same thing.

Thanks,

/mjt
