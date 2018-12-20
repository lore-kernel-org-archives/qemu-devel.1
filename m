Received: from eggs.gnu.org ([2001:4830:134:3::10]:54703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ga0CO-0000Tx-99
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ga0CK-0002rR-Ec
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:25:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ga0CG-0002hM-Mz
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:25:12 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so1189641qkj.8
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 07:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20181122141741.11108-1-marcandre.lureau@redhat.com>
	<CAL1e-=h_YXP8Y-narAHaoB5GU9s3U8ehEO+mqQUAbuqFjGp6Kw@mail.gmail.com>
In-Reply-To: <CAL1e-=h_YXP8Y-narAHaoB5GU9s3U8ehEO+mqQUAbuqFjGp6Kw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 19:24:56 +0400
Message-ID: <CAMxuvazCTcnV1bkmk3HCe1ufD9HSAQh_0=hkFAwXTkQqdcK6TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: apply some qemu.org-like CSS style
 to HTML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aleksandar.m.mail@gmail.com
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>

Hi

On Wed, Dec 19, 2018 at 7:17 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
> On Nov 22, 2018 3:18 PM, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redha=
t.com> wrote:
> >
> > Style a bit the HTML documents, to make them look like qemu.org pages.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  Makefile                     |   2 +
> >  docs/texinfo-extra-head.html |   7 ++
> >  docs/texinfo.css             | 226 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 235 insertions(+)
> >  create mode 100644 docs/texinfo-extra-head.html
> >  create mode 100644 docs/texinfo.css
> >
>
> Marc-Andr=C3=A9,
>
> I salute these effort, and also my eyes say thank you to you.
>
> I just have a suggestion that command line examples, like this one:
>
> qemu-system-i386 [options] [disk_image]
>
> have a little larger letters. (maybe it is just my system, I see them as =
if their size is almost twice smaller than regular text size)

Easy, change
pre.verbatim {
font-size: smaller
}

to larger.

>
> Thanks again!

Note that there is an alternative proposal that looks more interesting
in "[qemu-web PATCH] Import historical documentation"
I don't know what's the status about it.
