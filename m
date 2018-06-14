Received: from eggs.gnu.org ([2001:4830:134:3::10]:37286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTPm4-0001pM-TF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTPm3-0003Tg-Gt
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:46:40 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:32913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTPm3-0003Sm-29
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:46:39 -0400
Received: by mail-ot0-x242.google.com with SMTP id h6-v6so6541800otj.0
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 03:46:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f9beda14-7c4a-8f89-baf1-5a79e847c4ac@redhat.com>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
	<CAFEAcA-vZH0KUxi+iYP3eYzXeHxNTotNwCMhEPcGhOLksbG71A@mail.gmail.com>
	<f9beda14-7c4a-8f89-baf1-5a79e847c4ac@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 11:46:17 +0100
Message-ID: <CAFEAcA_egToeW7ksTncbFCsW6uTh1FcPSgW6gx+VnjvQpqwWsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13 June 2018 at 17:55, John Snow <jsnow@redhat.com> wrote:
> The same reasoning could be used to justify
>
> /* two
>  * lines */
>
> as it's ... actually just two lines. I think people don't seem to like
> this much either (why? does it look 'naked' on the end?)

I dislike the way it breaks up the line of stars. For me it is the
/*
 *
 */
shape that defines a multiline comment, and where exactly the text is
on the RHS of it is not important to my sense of visual neatness :-)

> It would only begin to matter terribly much if we actually decided we
> wanted to do a doxygen-style doc generation for our internal APIs for
> compatibility with, say, fancier IDEs than vim/emacs.

We ought to do that at some point -- I had some prototype patches
for it. Doc-comment comments always start /** on a line of its own,
though.

> As it stands, we're pretty inconsistent about which exact style we apply
> when we "document" internal functions -- sometimes we document the
> header, sometimes the implementation, sometimes both (but differently!)
> and always with different styles all over the place. That's the real
> problem, IMO.

IMHO -- global functions should always be documented in the header
with the prototype, and any new global function should get a
doc comment (I require this for code I review...) I should be able
to read about the API your code exposes to the rest of QEMU purely
by looking at your headers.

thanks
-- PMM
