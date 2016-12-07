Received: from eggs.gnu.org ([2001:4830:134:3::10]:56743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEdI7-0008Sg-M5
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEdI1-0005To-QW
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:33:51 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEdI1-0005TU-ER
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:33:45 -0500
Received: by mail-ua0-f181.google.com with SMTP id 12so416880454uas.2
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 06:33:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161207142449.GC1476@redhat.com>
References: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
	<20161207120419.GA1476@redhat.com>
	<CAFEAcA8UofRa9Yo93vsFYDqJaW5YuKKF68X+2ae=GKdp8w9HWg@mail.gmail.com>
	<20161207140715.GB1476@redhat.com>
	<CAFEAcA-8P3cv=ce_jjQRAa5Oh-1EDUByuJq-tX2sX29vVm-5mQ@mail.gmail.com>
	<20161207142449.GC1476@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Dec 2016 14:32:24 +0000
Message-ID: <CAFEAcA-riLzPyfT+CSbEgLzRoJiGVRByk7Ft7EdDqhVcOH4vHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu -netdev tun/tap support can't handle macvtap
 type devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On 7 December 2016 at 14:24, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Dec 07, 2016 at 02:21:24PM +0000, Peter Maydell wrote:
>> On 7 December 2016 at 14:07, Daniel P. Berrange <berrange@redhat.com> wrote:
>> > On Wed, Dec 07, 2016 at 12:30:31PM +0000, Peter Maydell wrote:
>> >> On 7 December 2016 at 12:04, Daniel P. Berrange <berrange@redhat.com> wrote:
>> >> > note 'fds' plural, instead of 'fd'
>> >>
>> >> What's the difference between that and the "usual suggested workaround"
>> >> I described above that doesn't work with queues=... ?
>> >
>> > It just seems the 'queues' param always wants you to use 'fds' instead
>> > of 'fd' - 'fds' takes a comma-separated list of FDs - one per queue
>> > and 'fd' only takes a single FD.
>>
>> Oh, I see. That seems a bit obscure :-)
>
> And pointless, because QemuOpts would have allowed use of 'fd' multiple
> times instead of inventing a new arg.  fd=1,fd=3,fd=6 could have worked
> fine with multi-queue :-(

I guess the best we could do now would be to make fd= and fds= synonyms
with both supporting either comma-separated or being specified
multiple times ?

It's particularly confusing in this case that fd= doesn't work with
queues=, because the user isn't trying to pass multiple fds, just
the one is fine.

thanks
-- PMM
