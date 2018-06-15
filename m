Received: from eggs.gnu.org ([2001:4830:134:3::10]:51145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTgal-000062-2K
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 00:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTgah-0004X2-4B
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 00:44:07 -0400
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
	<CAFEAcA-vZH0KUxi+iYP3eYzXeHxNTotNwCMhEPcGhOLksbG71A@mail.gmail.com>
	<f9beda14-7c4a-8f89-baf1-5a79e847c4ac@redhat.com>
	<CAFEAcA_egToeW7ksTncbFCsW6uTh1FcPSgW6gx+VnjvQpqwWsw@mail.gmail.com>
	<ba6b4e80-c31a-6033-ea59-b4c4f1923be7@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ddf0a4cf-2286-9d3d-ea18-f61865f40fa9@redhat.com>
Date: Fri, 15 Jun 2018 06:43:50 +0200
MIME-Version: 1.0
In-Reply-To: <ba6b4e80-c31a-6033-ea59-b4c4f1923be7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On 14.06.2018 22:11, John Snow wrote:
>=20
> On 06/14/2018 06:46 AM, Peter Maydell wrote:
[...]
>=20
> *cough* I hate the way it looks too, but C99 comments have a few things
> going for them:
>=20
> // A multi-line comment block like this has no extra lines and every
> // line in the comment is prefaced individually which aids grep
> // readability, while maintained good vertical symmetry.
>=20
> I think we hate C99 comments, though? Certainly we don't use them at al=
l
> right now, so it's not a good fit.

But why do we hate them? I remember there were some reasons for not
using them 10 or 15 years ago (some old C-compilers still did not
support them yet), but today? ... it's likely just a legacy feeling.
Maybe it's time to get over that feeling now?

>>> It would only begin to matter terribly much if we actually decided we
>>> wanted to do a doxygen-style doc generation for our internal APIs for
>>> compatibility with, say, fancier IDEs than vim/emacs.
[...]
> Do you have a proposed standard / do we have some consensus on which
> generator tool or doc format we'd most like to see in QEMU? I could put
> in some elbow grease to shine up the block layer if so...

I remember that some years ago, somebody (I forgot who it was, sorry)
once told me that we should use the same format in QEMU as in glib, i.e.
GTK-Doc. But citing the GTK-Doc homepage: "For a more polished
general-purpose documentation tool you may want to look at Doxygen" - so
maybe that's the better choice instead.

 Thomas
