Received: from eggs.gnu.org ([2001:4830:134:3::10]:39495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fETW3-00036j-Kg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fETVy-00080A-Oa
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:44:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fETVy-0007zj-JU
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:44:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<1521515720-612046-22-git-send-email-mst@redhat.com>
	<87d0z37esf.fsf@dusky.pond.sub.org>
	<CAMxuvazEKdmo=AMw0cXGMqvjMsXMxG2121hyDytOZYZ13j1PcA@mail.gmail.com>
	<20180413155001-mutt-send-email-mst@kernel.org>
Date: Fri, 04 May 2018 07:44:10 +0200
In-Reply-To: <20180413155001-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Fri, 13 Apr 2018 15:51:24 +0300")
Message-ID: <87zi1gasb9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 21/50] Makefile: add target to print
 generated files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Apr 13, 2018 at 12:04:20PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>=20
>> On Fri, Apr 13, 2018 at 9:21 AM, Markus Armbruster <armbru@redhat.com> w=
rote:
>> > "Michael S. Tsirkin" <mst@redhat.com> writes:
>> >
>> >> This is helpful for automatic code analysis.
>> >
>> > Out of curiosity: how?
>> >
>> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >> ---
>> >>  Makefile | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >>
>> >> diff --git a/Makefile b/Makefile
>> >> index 677a54b..f799390 100644
>> >> --- a/Makefile
>> >> +++ b/Makefile
>> >> @@ -1045,6 +1045,9 @@ endif
>> >>  include $(SRC_PATH)/tests/docker/Makefile.include
>> >>  include $(SRC_PATH)/tests/vm/Makefile.include
>> >>
>> >> +printgen:
>> >> +     @echo $(GENERATED_FILES)
>> >> +
>> >>  .PHONY: help
>> >>  help:
>> >>       @echo  'Generic targets:'
>> >
>> > I tried to answer my question myself by looking up the thread where th=
is
>> > patch was posted for review.  I can't find any.  Am I blind?
>
> That was a development patch that sneaked in. Sorry. I'll revert.

Since you haven't, I took the liberty to post the revert myself.

>> And you could also "make print-GENERATED_FILES" already
>
> Nice tip, thanks for that.
