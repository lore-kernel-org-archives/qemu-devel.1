Received: from eggs.gnu.org ([2001:4830:134:3::10]:59086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ87t-0004zG-T7
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ87s-00061h-VA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:19:37 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQ87s-00060z-Ou
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:19:36 -0400
Received: by mail-ot0-x243.google.com with SMTP id w13-v6so1924334ote.11
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 02:19:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605094613.52bcf85d.cohuck@redhat.com>
References: <20180604162140.20688-1-peter.maydell@linaro.org>
	<20180604191756.1ae61871@w520.home>
	<52a5446f-4624-fd45-ce7d-492269aa5c3f@redhat.com>
	<20180605094613.52bcf85d.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 10:19:15 +0100
Message-ID: <CAFEAcA80XzxdxLfwMUYLpHprX8L=AZyNDw1DiJKshhGvbFJLRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 5 June 2018 at 08:46, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, 5 Jun 2018 06:33:22 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>> On 05.06.2018 03:17, Alex Williamson wrote:
>> > On Mon,  4 Jun 2018 17:21:40 +0100
>> > Peter Maydell <peter.maydell@linaro.org> wrote:
>> >> +Multiline comments blocks should have a row of stars on the left
>> >> +and the terminating */ on its own line:
>> >> +    /* like
>> >> +     * this
>> >> +     */
>> >> +Putting the initial /* on its own line is accepted, but not required.
>> >
>> > Could we say "at maintainer discretion", or is that always implied?  The
>> > asymmetry of the proposed standard is not my favorite and a mostly
>> > blank line before and after further supports standing out from
>> > surrounding code.
>> I also don't like the asymmetry. I'd prefer more dense comments, though:
>>
>>   /* like
>>    * this */

Wow, I think that looks terrible :-)

>> Anyway, could we either use that dense format or the kernel-style
>> multi-lines-comment format, please? Mixing it asymmetrically is just ugly.
>
> I'd vote for the kernel style, then.

I don't particularly object to the kernel style (though it's not
how I personally default to writing comments). I just didn't want
to rule a huge chunk of our existing comments as out-of-standard
for what I see as a relatively minor divergence in form --
we do have a lot of no-leading-separate-/* comments. I can live
with mandating kernel-style if it means we can rule out GNU-form
and other weirdnesses though :-)

thanks
-- PMM
