Received: from eggs.gnu.org ([2001:4830:134:3::10]:51418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1djjdK-0004Jz-2a
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1djjdI-0005Sb-EN
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:08:33 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:38370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1djjdI-0005Rz-8G
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:08:32 -0400
Received: by mail-wr0-x22a.google.com with SMTP id p8so30474639wrf.5
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 03:08:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874lt16zdl.fsf@dusky.pond.sub.org>
References: <20170818222313.13391-1-eblake@redhat.com>
	<874lt16zdl.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2017 11:08:08 +0100
Message-ID: <CAFEAcA-8XL_YA7rDpyW6ZU5_R7jv2ZAnF92EoeRL-Y7C1z3EpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 21 August 2017 at 10:31, Markus Armbruster <armbru@redhat.com> wrote:
> I'm fine with project-wide, but does it have to be a hard error?  Can we
> make it a warning?  Same effect by default, but it lets people
> experiment more easily with --disable-werror.

It won't be the same effect by default for our releases, which
don't use -Werror.

I don't think we want to make it easy for people to turn this
off -- and it's only commenting out a single #error line if
anybody really does want to mess about with it.

thanks
-- PMM
