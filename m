Received: from eggs.gnu.org ([2001:4830:134:3::10]:36499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTo7D-0006Ku-1u
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTo78-0004SJ-8i
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:46:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
	<CAFEAcA-vZH0KUxi+iYP3eYzXeHxNTotNwCMhEPcGhOLksbG71A@mail.gmail.com>
	<f9beda14-7c4a-8f89-baf1-5a79e847c4ac@redhat.com>
	<CAFEAcA_egToeW7ksTncbFCsW6uTh1FcPSgW6gx+VnjvQpqwWsw@mail.gmail.com>
Date: Fri, 15 Jun 2018 14:45:53 +0200
In-Reply-To: <CAFEAcA_egToeW7ksTncbFCsW6uTh1FcPSgW6gx+VnjvQpqwWsw@mail.gmail.com>
	(Peter Maydell's message of "Thu, 14 Jun 2018 11:46:17 +0100")
Message-ID: <87k1r01am6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 13 June 2018 at 17:55, John Snow <jsnow@redhat.com> wrote:
[...]
>> It would only begin to matter terribly much if we actually decided we
>> wanted to do a doxygen-style doc generation for our internal APIs for
>> compatibility with, say, fancier IDEs than vim/emacs.
>
> We ought to do that at some point -- I had some prototype patches
> for it. Doc-comment comments always start /** on a line of its own,
> though.
>
>> As it stands, we're pretty inconsistent about which exact style we apply
>> when we "document" internal functions -- sometimes we document the
>> header, sometimes the implementation, sometimes both (but differently!)
>> and always with different styles all over the place. That's the real
>> problem, IMO.
>
> IMHO -- global functions should always be documented in the header
> with the prototype, and any new global function should get a
> doc comment (I require this for code I review...) I should be able
> to read about the API your code exposes to the rest of QEMU purely
> by looking at your headers.

Putting the function contract far from the actual function is a proven
way to end up with a contract that is far from what the function
actually does.

With a documentation generator such as Sphinx, the usual argument for
putting the contracts in headers "I want API documentation in one place,
without clutter" carries a lot less weight: the generated documentation
is exactly that.
