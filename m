Received: from eggs.gnu.org ([2001:4830:134:3::10]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fTYaT-0005ea-2Y
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fTYaP-0004Zw-2R
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:11:17 -0400
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
	<CAFEAcA-vZH0KUxi+iYP3eYzXeHxNTotNwCMhEPcGhOLksbG71A@mail.gmail.com>
	<f9beda14-7c4a-8f89-baf1-5a79e847c4ac@redhat.com>
	<CAFEAcA_egToeW7ksTncbFCsW6uTh1FcPSgW6gx+VnjvQpqwWsw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ba6b4e80-c31a-6033-ea59-b4c4f1923be7@redhat.com>
Date: Thu, 14 Jun 2018 16:11:11 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_egToeW7ksTncbFCsW6uTh1FcPSgW6gx+VnjvQpqwWsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>



On 06/14/2018 06:46 AM, Peter Maydell wrote:
> On 13 June 2018 at 17:55, John Snow <jsnow@redhat.com> wrote:
>> The same reasoning could be used to justify
>>
>> /* two
>>  * lines */
>>
>> as it's ... actually just two lines. I think people don't seem to like
>> this much either (why? does it look 'naked' on the end?)
> 
> I dislike the way it breaks up the line of stars. For me it is the
> /*
>  *
>  */
> shape that defines a multiline comment, and where exactly the text is
> on the RHS of it is not important to my sense of visual neatness :-)
> 

Yours does look an awful lot more symmetrical once you remove the text,
yeah.

*cough* I hate the way it looks too, but C99 comments have a few things
going for them:

// A multi-line comment block like this has no extra lines and every
// line in the comment is prefaced individually which aids grep
// readability, while maintained good vertical symmetry.

I think we hate C99 comments, though? Certainly we don't use them at all
right now, so it's not a good fit.

>> It would only begin to matter terribly much if we actually decided we
>> wanted to do a doxygen-style doc generation for our internal APIs for
>> compatibility with, say, fancier IDEs than vim/emacs.
> 
> We ought to do that at some point -- I had some prototype patches
> for it. Doc-comment comments always start /** on a line of its own,
> though.
> 

I'd love this! I love vim/emacs, but my usage of it is not wizard-tier
and in the past when working on large C++ projects I have benefited from
the magical refactoring click-buttons, tool-tips and etc. These
operations are infrequent enough that I believe it's reasonable to not
know how to do them in traditional CLI editors. If we want to lure in
new contributors, maybe this could sweeten the pot a bit?

Rigorous, mechanically verifiable function documentation is quite nice
to have in these cases. It'd be nice in general, really. It would go a
long way to help us attract less "hardcore" developers implementing
devices and features for QEMU without such a steep onboarding curve.

Do you have a proposed standard / do we have some consensus on which
generator tool or doc format we'd most like to see in QEMU? I could put
in some elbow grease to shine up the block layer if so...

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
> 

This makes sense, though the way C code is laid out makes it unfortunate
you don't get to see the same comment right beside the implementation if
that's what you're working on -- but I suppose this is why we have tabs,
multi-monitors and IDEs with tooltips.

> thanks
> -- PMM
> 
