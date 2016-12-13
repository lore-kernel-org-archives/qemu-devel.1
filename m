Received: from eggs.gnu.org ([2001:4830:134:3::10]:55370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cGv0s-0003Zu-BL
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cGv0p-0000yK-7n
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:53:30 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cGv0p-0000yC-2H
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:53:27 -0500
Received: by mail-io0-f193.google.com with SMTP id y124so913094iof.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 13:53:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c246423e-d62b-1572-341d-3a1933e496fa@weilnetz.de>
References: <CAJSP0QUn4OE3_9foGgktt5O_KzrEzV8uhB1mpoS1q5x4DsPTPQ@mail.gmail.com>
	<CAJSP0QV1S4mohikvxx9OgnsRgMRNmH+a9WjHCeC7gGaeBMyktQ@mail.gmail.com>
	<CAJSP0QUkFjfsQ21i3-qXQL5N3xJd6WnEmy1BewMV3z=VOpr7BQ@mail.gmail.com>
	<c246423e-d62b-1572-341d-3a1933e496fa@weilnetz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 13 Dec 2016 21:52:25 +0000
Message-ID: <CAJSP0QW-Mv8N=aULWeXfMQa08DBEC9GPCOnsw6iPiSF_kb3s+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Any QEMU 2.8 release blockers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Dec 13, 2016 at 9:39 PM, Stefan Weil <sw@weilnetz.de> wrote:
> On 12/13/16 22:04, Stefan Hajnoczi wrote:
>>
>> On Tue, Dec 13, 2016 at 10:01 AM, Stefan Hajnoczi <stefanha@gmail.com>
>> wrote:
>>>
>>> On Fri, Dec 9, 2016 at 3:34 PM, Stefan Hajnoczi <stefanha@gmail.com>
>>> wrote:
>>>>
>>>> Hi folks,
>>>> How is QEMU 2.8.0-rc3 holding up?
>>>>
>>>> I'm not aware of release blockers.  QEMU 2.8.0 will be released on
>>>> Tuesday, December 13th if nothing comes up.  It will be the -rc3
>>>> source tree.
>>>
>>>
>>> There have been no release blockers so I plan to tag QEMU 2.8.0 today
>>> (December 13th at 19:00 UTC).
>>>
>>> If something critical turns up please notify me on IRC (stefanha on
>>> #qemu irc.oftc.net).
>>
>>
>> Mike Roth discovered a migration compatibility bug introduced by
>> commit d1b4259f1ab18af24e6a297edb6a8f71691f3256 ("virtio-bus: Plug
>> devices after features are negotiated").  The release will be delayed
>> until this is resolved.
>>
>> Please check the mailing list for discussion.  Mike is sending out a
>> mail summarizing the bug.
>>
>> Stefan
>>
>
> Maybe you can update the po files before tagging the release.
> They currently no longer match the code (changed line numbers,
> new string "_Copy").
>
> Long way: make install
> Short way: make -C po build

I've sent a patch to the list and CCed you.  I ran make -C po update.

Weird that the line numbers are hardcoded in the .po file format.  An
addr2line type tool would have been better to avoid the constant
outdated line numbers.  That said, I don't know anything about how
gettext is designed...

Stefan
