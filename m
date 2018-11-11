Received: from eggs.gnu.org ([2001:4830:134:3::10]:48257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLyov-0003Lp-6k
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLyor-00012l-7z
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:07:09 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLyor-000125-3M
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:07:05 -0500
Received: by mail-yw1-f65.google.com with SMTP id c126-v6so3700831ywd.8
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20181111000259.7665-1-f4bug@amsat.org>
	<49746241-61a1-0ac8-8d94-3afeafa6d176@linaro.org>
In-Reply-To: <49746241-61a1-0ac8-8d94-3afeafa6d176@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:06:51 +0100
Message-ID: <CAAdtpL69Guy-gyjYOEBfaZOODjUw236SWOk2XhMkWr_8bohEEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] decodetree: Force Python to print unsigned
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi Richard,

On Sun, Nov 11, 2018 at 12:27 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 11/11/18 1:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Python internal representation is signed, so unsigned values
> > bigger than 31-bit are interpreted as signed (and printed with
> > a '-' signed).
> > Mask out to force unsigned values.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  scripts/decodetree.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Queued, thanks.

Can you drop this from your queue? I'll send a cleaner approach (as
RFC, and I also want to log the error I got in the commit msg).

Thanks,

Phil.
