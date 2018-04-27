Received: from eggs.gnu.org ([2001:4830:134:3::10]:43818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0GP-00021T-LL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0GO-0005s7-Ot
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:06:01 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:39149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC0GO-0005rx-JJ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:06:00 -0400
Received: by mail-ot0-x22d.google.com with SMTP id l12-v6so1409113oth.6
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 03:06:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANCZdfo+da8TRAxz=-69r-ert5b83FaXL=zkBWJGZ_w3n0oZeg@mail.gmail.com>
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
	<CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
	<CANCZdfo+da8TRAxz=-69r-ert5b83FaXL=zkBWJGZ_w3n0oZeg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 11:05:39 +0100
Message-ID: <CAFEAcA-C=QqEV0KJvHft4+iO8fYfiHhibG9SLH97iqdk9EP6FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Large patch set advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 April 2018 at 20:51, Warner Losh <imp@bsdimp.com> wrote:
> On Thu, Apr 26, 2018 at 2:11 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>> One question I do have is about the other BSDs: bsd-user at least
>> in theory is supposed to support freebsd, netbsd and openbsd.
>> Your patchsets should fix freebsd, but do you know what the status
>> is of netbsd and openbsd? Upstream we do compiletest but no runtime
>> testing; I think last time I tried it they didn't work very well,
>> but it would be worth checking with the other BSDs downstream to
>> see if they're using bsd-user and to make sure we don't break anything
>> that is currently working for netbsd/openbsd...
>
>
> I thought that was the empty set: I was under the impression that bsd-user
> in upstream was basically totally broken and nothing non-trivial worked.
> Since nothing is working, I'd posit that it follows that nobody could be
> currently using it. I've certainly heard of no parallel efforts to make
> similar changes for NetBSD/OpenBSD.

Well, I'm basically just asking you to reach out and check with
the other *BSD folks that they agree with that "it's totally broken"
analysis (which I guess they would). I see Kamil has given the
answer for NetBSD already.

thanks
-- PMM
