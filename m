Received: from eggs.gnu.org ([209.51.188.92]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqb2o-00052C-JF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqb2n-0005ao-Mq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:00:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqb2n-0005Yd-7u
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:00:01 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so11959321oth.7
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 02:00:00 -0800 (PST)
MIME-Version: 1.0
References: <mhng-99c129ef-4e70-4840-b80f-7b3c6b806083@palmer-si-x1c4>
	<01c75f94-26ae-ffa4-dd46-4dd019702fa0@redhat.com>
In-Reply-To: <01c75f94-26ae-ffa4-dd46-4dd019702fa0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 09:59:48 +0000
Message-ID: <CAFEAcA9JXK5O5tSvBD17CM3Eb132EWuub9VvOJWaAKUOu8KA5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Feb 2019 at 09:05, Thomas Huth <thuth@redhat.com> wrote:
> On 2019-02-02 09:41, Palmer Dabbelt wrote:
> >> My mail filter finds these RFC pullrequests, yes. I'm then
> >> relying on my manual brain to not actually apply them.
> >> (If it's a slow day I might do a test merge on them, but
> >> usually my queue is full enough that I don't get to them
> >> before the real PR appears.)
> >
> > Ah, OK -- do you want me to do something else?
>
> At least I got a little bit confused by "PR RFC" ... I think some other
> maintainers rather send out patch series marked with "PATCH" first, and
> add some non-pull-request cover letter with a text like "I'm intending
> to send a pull request for this soon, please review one more time...".
> Then after a day or two, once Patchew checked the series and nobody else
> complained, they send a real "PULL" request.

Yeah, generally nobody else sends RFC pull requests, they just
send the actual pulls. I don't object if Palmer finds them
useful, though.

For what it's worth, my filter for finding pull requests is emails
containing "for you to fetch changes up to" but not either of
"not for master" or "PULL SUBSYSTEM". So if you want to specifically
keep out of the filters you can add "not for master" in the cover
letter. But as I say it's not a big deal for me to sort things out
manually -- the filter has the odd false positive anyway.

thanks
-- PMM
