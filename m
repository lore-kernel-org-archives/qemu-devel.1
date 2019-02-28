Received: from eggs.gnu.org ([209.51.188.92]:37613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzLuz-0003CV-Cq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzLuy-00038R-D0
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:40:09 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:34525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzLux-00035A-UC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:40:08 -0500
Received: by mail-oi1-x235.google.com with SMTP id g16so16504598oib.1
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 05:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-6-peter.maydell@linaro.org>
	<87imy3v4qo.fsf@zen.linaroharston>
In-Reply-To: <87imy3v4qo.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 13:39:53 +0000
Message-ID: <CAFEAcA-D-3kR+9=k0yLdBA+gRjw+n7tHUyXD5CeJqBt7OO_z6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] docs/conf.py: Configure the
 'alabaster' theme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Fri, 1 Feb 2019 at 16:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Add the 'navigation' bar to the sidebar, which for some
> > reason is not enabled by default. Remove 'relations', which
> > is effectively disabled anyway and isn't useful for us.
>
> I'm not sure what the title means... is the theme a reference to a
> layout? I thought themes were colours and other such visual frippery
> rather than actual content layout. But what do I know as a mere code
> monkey...

Just noticed I never followed up to this. Sphinx themes
allow a bit more customisation than just "colours and fonts":
they can also do layout things like changing up what sorts of
sidebar information is shown, or indeed whether there's any
kind of sidebar at all. Specific themes might expose some
theme-specific config options which allow tweaking of how
they appear.

http://www.sphinx-doc.org/en/stable/theming.html
has a few screenshots and gives more of an idea of what
sort of tweaks the theming system allows.

thanks
-- PMM
