Received: from eggs.gnu.org ([2001:4830:134:3::10]:46541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLpXz-0004Ht-IQ
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLpXw-00076c-46
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:13:02 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gLpXq-0006xs-3q
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:12:56 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 40so5662861oth.4
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 05:12:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPFSdq6k=JAv8h1JdrnMgsfRDD9yH7OD5DHTTm7ivjKC04ZrGg@mail.gmail.com>
References: <CAPFSdq6k=JAv8h1JdrnMgsfRDD9yH7OD5DHTTm7ivjKC04ZrGg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Nov 2018 13:12:23 +0000
Message-ID: <CAFEAcA_Y0t1E9fmWe1HJ7xUYFHhnN7et7Vb4XboMaFUm1GccqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] proper-dev dependencies..
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: watkins@hungry.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 November 2018 at 12:07, watkins@hungry.com
<chris.e.watkins@gmail.com> wrote:
> I've been following the list for awhile does anyone have a proper list of
> all the ubuntu dependencies?
> So, one can compile the whole ball of wax properly?

If you're running on Ubuntu and have your apt sources set up
to include source packages, the simplest thing is to run
"apt build-dep qemu", which will install all the packages
that the Ubuntu package of QEMU build-depends on. QEMU's
build-dependencies don't change radically over time, so
that's usually sufficient (even though the Ubuntu package
will be for a QEMU that's a little older than the one you're
going to be building from source).

You can also look at the build page on our wiki which has
a list of required and extra packages:
https://wiki.qemu.org/Hosts/Linux#QEMU_on_Linux_hosts

If there are any missing from the list let us know and we
can update the wiki.

thanks
-- PMM
