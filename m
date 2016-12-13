Received: from eggs.gnu.org ([2001:4830:134:3::10]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cGunw-0004oB-1l
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cGuns-0006Dw-Ol
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:40:08 -0500
Received: from [2a03:4000:1::4e2f:c7ac:d] (port=43907 helo=mail.weilnetz.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cGuns-0006Dr-IU
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:40:04 -0500
References: <CAJSP0QUn4OE3_9foGgktt5O_KzrEzV8uhB1mpoS1q5x4DsPTPQ@mail.gmail.com>
	<CAJSP0QV1S4mohikvxx9OgnsRgMRNmH+a9WjHCeC7gGaeBMyktQ@mail.gmail.com>
	<CAJSP0QUkFjfsQ21i3-qXQL5N3xJd6WnEmy1BewMV3z=VOpr7BQ@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <c246423e-d62b-1572-341d-3a1933e496fa@weilnetz.de>
Date: Tue, 13 Dec 2016 22:39:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUkFjfsQ21i3-qXQL5N3xJd6WnEmy1BewMV3z=VOpr7BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Any QEMU 2.8 release blockers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 12/13/16 22:04, Stefan Hajnoczi wrote:
> On Tue, Dec 13, 2016 at 10:01 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Fri, Dec 9, 2016 at 3:34 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> Hi folks,
>>> How is QEMU 2.8.0-rc3 holding up?
>>>
>>> I'm not aware of release blockers.  QEMU 2.8.0 will be released on
>>> Tuesday, December 13th if nothing comes up.  It will be the -rc3
>>> source tree.
>>
>> There have been no release blockers so I plan to tag QEMU 2.8.0 today
>> (December 13th at 19:00 UTC).
>>
>> If something critical turns up please notify me on IRC (stefanha on
>> #qemu irc.oftc.net).
>
> Mike Roth discovered a migration compatibility bug introduced by
> commit d1b4259f1ab18af24e6a297edb6a8f71691f3256 ("virtio-bus: Plug
> devices after features are negotiated").  The release will be delayed
> until this is resolved.
>
> Please check the mailing list for discussion.  Mike is sending out a
> mail summarizing the bug.
>
> Stefan
>

Maybe you can update the po files before tagging the release.
They currently no longer match the code (changed line numbers,
new string "_Copy").

Long way: make install
Short way: make -C po build

Stefan
