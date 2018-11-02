Received: from eggs.gnu.org ([2001:4830:134:3::10]:35140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1gITpv-0007IN-NC
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1gITpr-0007WZ-LP
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:25:43 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1gITpq-0006mE-Dy
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:25:38 -0400
Received: by mail-vk1-f195.google.com with SMTP id j20so224082vke.5
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 00:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181101183705.5422-1-philmd@redhat.com>
	<20181102064829.GB21032@magic>
	<CAAdtpL44dNQLskpUJ=33vF8Kp8jNkFYSDQXyKixvvZFUim1SUw@mail.gmail.com>
In-Reply-To: <CAAdtpL44dNQLskpUJ=33vF8Kp8jNkFYSDQXyKixvvZFUim1SUw@mail.gmail.com>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 2 Nov 2018 15:24:47 +0800
Message-ID: <CAK1Eb9mWQHXY_UEfbvFvtLvM7W3vBboEQZg-mH3-J4YRodziGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Use a stable snapshot for Debian
 Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: philmd@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Nov 2, 2018 at 3:20 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Fam,
>
> Thanks for picking this.
>
> On Fri, Nov 2, 2018 at 7:48 AM Fam Zheng <famz@redhat.com> wrote:
> > On Thu, 11/01 19:37, Philippe Mathieu-Daud=C3=A9 wrote:
> > > The Debian Sid repository is not garanteed to be stable, as his
> > > 'unstable' name suggest :)
>
> There is an error in "my be" -> "might be"...
> Do you mind to update the comment:
>
> > > To allow quick testing, packages are pushed various time a day,
> > > which my be annoying when trying to use it for stable development
> > > (which is not recommended, but Sid provides edge packages we use
> > > for testing).
>
> By:
>
> To allow quick testing, Debian maintainers might push packages
> various time a day. Sometime package dependencies might break,
> which is annoying when using this repository for stable development
> (which is not recommended, but Sid provides edge packages we use
> for testing).

Sure, updated in my queue.

Fam
