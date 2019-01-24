Received: from eggs.gnu.org ([209.51.188.92]:35740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gmh9s-0002uT-IX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gmh2t-0003Il-3X
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:35:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gmh2s-0003H6-U5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:35:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so6974988wrb.2
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 07:35:57 -0800 (PST)
MIME-Version: 1.0
References: <20190121171543.32422-1-alex.bennee@linaro.org>
	<20190121171543.32422-2-alex.bennee@linaro.org>
	<b98226b0-a598-e04c-0d75-67ca2cb6a34d@redhat.com>
In-Reply-To: <b98226b0-a598-e04c-0d75-67ca2cb6a34d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 24 Jan 2019 16:35:45 +0100
Message-ID: <CAP+75-UpY7X2=MjNEX601NB4bHfQ+fWyPCo7Zbic5TguRjjRWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tests/vm: call make check directly
 for netbsd/freebsd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: kamil@netbsd.org, Brad Smith <brad@comstyle.com>, Fam Zheng <fam@euphon.net>

On Mon, Jan 21, 2019 at 11:53 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/21/19 6:15 PM, Alex Benn=C3=A9e wrote:
> > The "make check" target calls check-qtest which has the appropriate
> > system binaries as dependencies so we shouldn't need to do two steps
> > of make invocation.

Now I remember, this was necessary to do this in 2 steps before
ebb61f804d6, build threaded and test not threaded.
Maybe worth adding a comment referencing this commit?

> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  tests/vm/freebsd | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> > index 19a3729172..a85c866c30 100755
> > --- a/tests/vm/freebsd
> > +++ b/tests/vm/freebsd
> > @@ -25,7 +25,6 @@ class FreeBSDVM(basevm.BaseVM):
> >          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> >          tar -xf /dev/vtbd1;
> >          ./configure {configure_opts};
> > -        gmake --output-sync -j{jobs} {verbose};
> >          gmake --output-sync -j{jobs} check {verbose};
> >      """
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
