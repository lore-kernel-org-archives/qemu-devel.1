Received: from eggs.gnu.org ([209.51.188.92]:55544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guIsy-0000wB-Op
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guIsw-0004dk-9z
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:25:12 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guIsu-0004Xr-BL
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:25:08 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so11090256otl.6
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<CAFEAcA89HnCL11_N9oXqwQZf=TFJdHzONg6jxy9FORNwK85OZA@mail.gmail.com>
	<CAMxuvax=wO+dGTcgxV5L0CLf9nOozgNCM7TdqPeyj09=th0Jgw@mail.gmail.com>
In-Reply-To: <CAMxuvax=wO+dGTcgxV5L0CLf9nOozgNCM7TdqPeyj09=th0Jgw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 15:24:52 +0000
Message-ID: <CAFEAcA9m9CgfOsE5hVcQpWFvX7Pq9wVWiC3jf2Yr0SrXQPnTKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] Enable build and install of our rST
 docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Thu, 14 Feb 2019 at 14:56, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Feb 14, 2019 at 12:30 PM Peter Maydell <peter.maydell@linaro.org>=
 wrote:
> >
> > Ping! Thanks to Alex for doing low-level review of this patchset.
>
> Overall, looks good to me too.
>
> Minor nit: configure doesn't check presence of sphinx-build, and on my
> fc29, it's sphinx-build-3 :)

It does check, but I forgot to make the makefiles pay attention
to the check.

That's very irritating that Fedora is using a weird filename for
the tool -- what is their justification for doing that?
I suppose we'll have to make configure cope :-(

>
> CI files will probably need to be updated.
>
> > I'm particularly interested in high-level review:
> >  * is this the right way to be going?
> >  * if we committed this and then did a release with the
> >    docs as they are like this, would that be ok?
>
> Certainly, it can improve over time imho.
>
> >  * what's the most important next step after this?
> >
>
> For me the next steps are:
>
> - merge your series! :)
>
> - integrate the texi doc somehow (apparently Paolo had some solution),
> or convert the texi doc to rst (modiy texi2any to do that?)
>
> - have the docs hosted on www.qemu.org, with some stability (ideally,
> we could share links to a specific doc, say a QMP command or an
> internal API, that would remain stable).
>
>   I wonder why Daniel qemu-web patches aren't yet merged. I remember
> some questions regarding doc import and automation. There will be a
> similar problem with sphinx doc.
>
>   (gitlab makes this fairly easy with CI artifcats, fwiw ;-)
>
> - convert more of our doc to rst
>
> - add kerneldoc
>
> - improve the style, for consistency with qemu.org style

Thanks for the suggestions.

-- PMM
