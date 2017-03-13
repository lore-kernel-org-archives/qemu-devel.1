Received: from eggs.gnu.org ([2001:4830:134:3::10]:52762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnUv5-0000c3-BE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnUv4-00021K-Jz
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:42:11 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnUv4-00020x-CV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:42:10 -0400
Received: by mail-wm0-x22c.google.com with SMTP id v186so47538891wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 11:42:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2e5c8c2d-35a7-a26a-bd80-379479125d9c@redhat.com>
References: <20170210061200.15373-1-vapier@gentoo.org>
	<CAFEAcA9rYHgR39tbmvJtQ+m01eok1QT7+K-Wpk_ykFDyqfFNNQ@mail.gmail.com>
	<20170215030211.GL28432@vapier>
	<CAFEAcA9CX2uVsK0qOM0K+y9JxQ+Nk=GMUp5M4xrMsqGg=fE4nQ@mail.gmail.com>
	<2e5c8c2d-35a7-a26a-bd80-379479125d9c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 19:41:48 +0100
Message-ID: <CAFEAcA8oFwTh1HQGZJ1uoHBzU9JcNEQKHVJAeSTNUMsZeD6vYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] osdep.h: pull in sys/sysmacros.h for
 major/minor/makedev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 March 2017 at 19:31, Eric Blake <eblake@redhat.com> wrote:
> Whether or not you think glibc broke things, the fact remains that the
> build is broken on current Fedora rawhide if we don't apply either this
> or the other proposed patch (the one by Christopher Covington, which
> I've now pinged)

Yes, I'm not opposed to qemu having a patch to work around this
mess. I'm just irritated that glibc makes it necessary.

thanks
-- PMM
