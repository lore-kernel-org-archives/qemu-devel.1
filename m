Received: from eggs.gnu.org ([2001:4830:134:3::10]:34216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gToXX-0006Q7-Vj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gToXS-0004yB-60
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:45:35 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:34330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gToXS-0004xm-06
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:45:30 -0500
Received: by mail-oi1-x22a.google.com with SMTP id h25so10938404oig.1
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 05:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20181203125250.11195-1-minyard@acm.org>
In-Reply-To: <20181203125250.11195-1-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 13:45:17 +0000
Message-ID: <CAFEAcA8C4EJU0tN10yv+KiF3JJu+tHgFXhgrBjwm6is1YEjxTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i2c: Add a length check to the SMBus write
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, qemu-stable <qemu-stable@nongnu.org>

On Mon, 3 Dec 2018 at 12:53, <minyard@acm.org> wrote:
>
> From: Corey Minyard <cminyard@mvista.com>
>
> Avoid an overflow.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: QEMU Stable <qemu-stable@nongnu.org>

Applied to master for rc4, thanks.

-- PMM
