Received: from eggs.gnu.org ([2001:4830:134:3::10]:49827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWJRn-0007Vy-3E
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWJRm-0003Xk-EE
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:09:59 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWJRm-0003XU-7X
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:09:58 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so8653956oif.2
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 03:09:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qhe0ZemTkc2jkEO=_hu6PhvKUKGHC9QYTj2j+QHhNf8g@mail.gmail.com>
	<CAFEAcA8fYaKTZkLR8Ja3P590bSWy1cu61-gSxyf6+wXCfCLoxA@mail.gmail.com>
	<CAHmME9qQo4XfRgZUZDt3xbx=5KmRoYbO3N0+3m9gdKi9hvnZQA@mail.gmail.com>
	<96301756-f879-84d1-f5ef-d2615257d309@redhat.com>
In-Reply-To: <96301756-f879-84d1-f5ef-d2615257d309@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 11:09:44 +0000
Message-ID: <CAFEAcA-J8gWONJye0JvuwG5warWKZD1MX-GW8=BPuCo9wF5ziQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] more serial ports on arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 10 Dec 2018 at 11:00, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Jason,
>
> On 12/7/18 5:42 AM, Jason A. Donenfeld wrote:
> > On Tue, Nov 20, 2018 at 11:08 AM Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> >> It's still stuck, because unconditionally adding a second serial
> >> port to the virt board breaks some commonly used existing guest
> >> code (UEFI + Linux), and it's not clear to me what the best
> >> command line UI is for allowing the user to request the second
> >> serial port.
> >
> > Can the UI be the same more or less as for x86? Specify a second
> > -serial, and then the machine gets one added? If it's in secure mode,
> > then it's added as serial 3 instead of 2, to remain backwards
> > compatible.
>
> You can use various -serial arguments.
>
> If a board supports 4 serials and you only want to see the 3rd (secure
> mode as your example) you could use:
>
> ./qemu -serial null -serial null -serial stdio

That's the opposite of Jason's issue, which is that the 'virt'
board only supports 1 serial port but he would like 2...

thanks
-- PMM
