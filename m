Received: from eggs.gnu.org ([2001:4830:134:3::10]:37823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1frr7L-0005SV-LO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1frr7K-0003Nn-JS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:49:39 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1frr7K-0003NF-76
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:49:38 -0400
Received: by mail-wm0-x244.google.com with SMTP id i134-v6so7976353wmf.0
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180820174310.17450-1-marcandre.lureau@redhat.com>
	<CAFEAcA_hyByeMb5fK88nHO2JVc9CkWc-sYQDjYoh9MfqHJnF5w@mail.gmail.com>
	<f3bc790e-bcc2-5273-7825-313f2a72f168@redhat.com>
In-Reply-To: <f3bc790e-bcc2-5273-7825-313f2a72f168@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Aug 2018 22:49:24 +0200
Message-ID: <CAJ+F1CLvnFD-TSEw8pxhFW=cgTKY0hqjbaMCRFYqbgpkmyqchg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] editorconfig: set emacs mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Aug 20, 2018 at 9:55 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 08/20/2018 01:00 PM, Peter Maydell wrote:
> > On 20 August 2018 at 18:43, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> >> Some time ago, I proposed to use an (eval) in .dir-locals.el to set
> >> the mode for all json files and Makefile. Unfortunately, this isn't
> >> safe, and emacs will prompt the user, which isn't very friendly.
> >>
> >> Fortunately, editorconfig provides a special config key which does
> >> allow to set the emacs mode. Set the emacs mode for JSON, GLSL and
> >> extra makefiles that are not yet covered. Drop modeline from JSON
> >> files.
> >
> > Does emacs apply info from the the editorconfig file by default, though=
?
>
> Per https://editorconfig.org/, no, you have to first install an emacs
> plugin to get editorconfig files to have any effect.  So this patch is a
> non-starter unless distros start patching emacs to install that plugin
> by default.

But .editorconfing is already present in qemu source tree. (and fwiw,
it's installed by default with some starter kits, like prelude).

What's the issue adding the emacs mode in the config file?

Let's keep the modeline in existing files if you prefer, but it's
still very limited (a majority of files are not covered). And I would
rather see it gone, than having editor-specific lines in our source
files.

thanks
