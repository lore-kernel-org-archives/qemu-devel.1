Received: from eggs.gnu.org ([208.118.235.92]:39722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gfMrL-0000xA-U7
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gfMrI-0008N8-M1
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:37:47 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gfMrI-0008Mz-I8
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:37:44 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so3795260ywa.6
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 02:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20190103093704.32635-1-ppandit@redhat.com>
	<cd325b25-15ee-46e4-896e-e5904340b1bf@ilande.co.uk>
	<nycvar.YSQ.7.76.1901041111410.31402@xnncv>
	<fcb58ca9-5019-5c46-24f8-3c09961ddd56@ilande.co.uk>
	<nycvar.YSQ.7.76.1901041521590.2878@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.1901041521590.2878@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 4 Jan 2019 11:37:33 +0100
Message-ID: <CAAdtpL6ro6XTQvkVAaPDJVOv4wJcG3vZTtUdEKVXw-PqneNVjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sun4u: add power_mem_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>

Le ven. 4 janv. 2019 10:55, P J P <ppandit@redhat.com> a =C3=A9crit :

> +-- On Fri, 4 Jan 2019, Mark Cave-Ayland wrote --+
> | I asked someone with real Ultra-5 hardware to check this for me, and
> they've
> | sent me back the following output:
> |
> | ok .properties
> | address                  fffb8000
> | button
> | interrupts               00000001
> | reg                      00000014 00724000 00000004
> | name                     power
> | ok fffb8000 l@ u.
> | 0
> |
> | Looks like the read value should be all 0s rather than all 1s. Can you
> resubmit the
> | patch with this change?
>
> Done. Sent patch v1.
>

The first patch is assumed to be v1, the second v2 and so on ;)
