Received: from eggs.gnu.org ([2001:4830:134:3::10]:38909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fx8gX-0004h3-CD
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fx8gW-0008MZ-IS
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:35:49 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fx8gW-0008Ly-3H
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:35:48 -0400
Received: by mail-oi0-x242.google.com with SMTP id r69-v6so5765921oie.3
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 03:35:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1536044538-22507-1-git-send-email-thuth@redhat.com>
References: <1536044538-22507-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Sep 2018 11:35:26 +0100
Message-ID: <CAFEAcA8uVksn0w5Z6WBS8jXc8KtZjMgNuTk+TOPtsVgnXK4C0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Save PKG_CONFIG_LIBDIR and
 WINDRES in config.status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On 4 September 2018 at 08:02, Thomas Huth <thuth@redhat.com> wrote:
> When cross-compiling QEMU for a target that significantly differs from
> the host, the current information in config.status is not enough to
> properly re-create the configuration. For example when I try to test
> my build with the mingw32 cross-compiler, I regularly get this error
> after the build system tried to re-create the configuration with the
> config.status file:
>
> ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
>        You probably need to set PKG_CONFIG_LIBDIR
>        to point to the right pkg-config files for your
>        build target
>RAND
> A similar problem exists for the "windres" tool, where you have to
> set the WINDRES variable in case it has a different name.
> So let's fix these issues by storing the configuration for theseq
> variables in the config.status file, too.

This is also true if the user set CC or RANLIB or any of a bunch
of other environment variables that configure uses. If we're going
to store those settings in config.status we should consistently
do it for all environment variables we care about, I think.

What does autoconf do for the equivalent situation?

thanks
-- PMM
