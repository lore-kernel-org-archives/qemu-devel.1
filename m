Received: from eggs.gnu.org ([2001:4830:134:3::10]:57598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePYWu-0005XQ-OJ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePYWt-0002Fx-Mb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:46:48 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171214171810.GA18098@stefanha-x1.localdomain>
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<7bc179c8-5699-98b0-8a5b-b4d8e6843b25@amsat.org>
	<20171214171810.GA18098@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 15:46:46 -0300
Message-ID: <CAAdtpL7_tHk3GUep8r-cFc6fVS8Pj42DYbZQuY_CkKGoiU6V4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/6] QTests: use Python to run complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

>> > Is there a specific reason why adding SD Card support to libqos is not
>> > possible in C?
>>
>> Short (joking) answer: Would you write tests/qemu-iotests/041 in C? ;)
>
> 041 is not a device-level test.  It doesn't poke device registers, it's
> a functional test.  In my email I said I support using Python for those
> types of tests.
>
>> Now thinking about the specific reasons...
>>
>> What I intend to do is add qtests for the SDHCI implementation.
>> There are different revisions of the standard specs.
>
> It would be great to have SDHCI support in libqos.  PCI and virtio are
> covered today and support for more busses will help reach that critical
> mass where tests can be written for most QEMU device models without
> first writing a new device driver framework.
>
> Please post your SDHCI test code, so we can discuss the details and
> consider whether it's more like 041 or more like tests/ide-test.c.

The SDHCI test is like ide-test, poking register.

Being not a 'generic' series but only SDHCI I didn't Cc'd you,
you can find the test here:

http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02391.html

and the SDCard python test here (you got this one):

http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02350.html
