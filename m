Received: from eggs.gnu.org ([2001:4830:134:3::10]:34624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1froU8-0007FQ-I3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1froU4-00076D-OO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:00:58 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1froU0-00073p-VO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:00:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id n21-v6so27390207oig.3
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 11:00:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820174310.17450-1-marcandre.lureau@redhat.com>
References: <20180820174310.17450-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 19:00:31 +0100
Message-ID: <CAFEAcA_hyByeMb5fK88nHO2JVc9CkWc-sYQDjYoh9MfqHJnF5w@mail.gmail.com>
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
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 20 August 2018 at 18:43, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Some time ago, I proposed to use an (eval) in .dir-locals.el to set
> the mode for all json files and Makefile. Unfortunately, this isn't
> safe, and emacs will prompt the user, which isn't very friendly.
>
> Fortunately, editorconfig provides a special config key which does
> allow to set the emacs mode. Set the emacs mode for JSON, GLSL and
> extra makefiles that are not yet covered. Drop modeline from JSON
> files.

Does emacs apply info from the the editorconfig file by default, though?

thanks
-- PMM
