Received: from eggs.gnu.org ([209.51.188.92]:45980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0UsK-0006ht-CM
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0UsJ-00037G-KD
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:26:08 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:48406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h0UsJ-00036J-Bm
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:26:07 -0500
Date: Sun, 3 Mar 2019 18:26:02 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190303172602.4ceyyf4734teu4xg@function>
References: <20190303061406.7631-1-samuel.thibault@ens-lyon.org>
	<CANCZdfpiyw32LGt5A5=V59nv3xFiVT8o1xPf6aDt3oEgPeJUmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCZdfpiyw32LGt5A5=V59nv3xFiVT8o1xPf6aDt3oEgPeJUmw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Reduce curses escdelay from 1s to 0.2s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Warner Losh, le dim. 03 mars 2019 10:11:52 -0700, a ecrit:
> On Sun, Mar 3, 2019, 12:45 AM Samuel Thibault <[1]samuel.thibault@ens-lyon.org>
> wrote:
> 
>     By default, curses will only report single ESC key event after 1s delay,
>     since ESC is also used for keypad escape sequences. This however makes
>     users
>     believe that ESC is not working. Reducing to 0.2s provides good enough user
>     experience, while still allowing 200ms for keypad sequences to get in,
>     which
>     should be more than enough.
> 
> How did you come up with this number?

Since the default was very long, I chose a value that felt fast enough
for the user.

> Still seems a bit long for the ESC ESC case where the user hits ESC
> twice in quick succession.

Right, there might be such double-press.

> Even back in the day, terminals would send the characters back to back
> at 1200 baud, which is 8ms per character. 32ms is 4x that, 32x 9600
> baud rates. 25 or 50ms is suggested from these figures.

Alright, let's try 25 then.

Samuel
