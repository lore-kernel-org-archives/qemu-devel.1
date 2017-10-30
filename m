Received: from eggs.gnu.org ([2001:4830:134:3::10]:54915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9C5D-0004rX-Rl
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9C57-00075H-Ub
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:34:35 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9C57-00074c-Nn
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:34:29 -0400
Received: by mail-wm0-x241.google.com with SMTP id r68so17306406wmr.3
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 08:34:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <676bb129-8e09-1e83-7340-66c770d04537@amsat.org>
References: <20171030040056.11780-1-f4bug@amsat.org>
	<20171030082029.GY2993@localhost.localdomain>
	<676bb129-8e09-1e83-7340-66c770d04537@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 15:34:07 +0000
Message-ID: <CAFEAcA-ceY6g2rWTdLK9VUUTh=ENPcy1CWAZ+xARr9YFva--pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota" <cota@braap.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 30 October 2017 at 15:01, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> On 10/30/2017 05:20 AM, Eduardo Habkost wrote:
>> On Mon, Oct 30, 2017 at 01:00:56AM -0300, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>>     - I don't think this is the nicest way, too much #ifdef'fery in mai=
n()
>>
>> I suggest using object_class_get_list(TYPE_ACCEL, false).
>
> OK, this gives:
>
> $ qemu-system-x86_64 -accel help
> Possible accelerators:
>   xen
>   kvm
>   qtest
>
> I was not aware of the qtest accel :)

We should special-case that one out, as it's only intended to be
used by our test cases. (In an ideal world we'd diagnose "you
used '-accel qtest' but didn't also pass '-qtest something'
to set up the communications channel with the test harness"
better than just SIGTERMing. But it's test code :-))

thanks
-- PMM
